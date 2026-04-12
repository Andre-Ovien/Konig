from rest_framework import serializers
from .models import User, EmailVerification
from .tasks import send_verification_email
from django.contrib.auth import authenticate
from django.contrib.auth.password_validation import validate_password
import random
from datetime import timedelta
from django.utils import timezone
from rest_framework_simplejwt.tokens import RefreshToken


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['email']

class RegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = (
            'email',
            'password',
        )

        extra_kwargs = {
            'password': ('write_only: True'),
            'email': {'required: True'}
        }

        def validate_password(self, value):
            validate_password(value)
            return value
        
        def create(self, validated_data):
            user = User.objects.create_user(**validated_data)
            user.is_active = False
            user.save()

            verification = EmailVerification.objects.create(user=user, purpose='email_verification')
            verification.generate_code()
            send_verification_email.delay(user.email, verification.code)

            return user
        

class VerifyEmailSerializer(serializers.Serializer):
    email = serializers.EmailField()
    code = serializers.CharField(max_length=6)

    def validate(self, data):
        email = data.get("email")
        code = data.get("code")

        try:
            user = User.objects.get(email=email)
        except User.DoesNotExist:
            raise serializers.ValidationError("User with this email does not exist.")
        
        try:
            verification = EmailVerification.objects.get(user=user, code=code, purpose='email_verification', is_used=False)
        except EmailVerification.DoesNotExist:
            raise serializers.ValidationError("Invalid or expired verification code.")
        
        if verification.is_expired():
            raise serializers.ValidationError("Verification code has expired.")
        
        data["user"] = user
        data["verification"] = verification
        return data
    
    def save(self):
        user = self.validated_data["user"]
        verification = self.validated_data["verification"]

        user.is_active = True
        user.save()

        verification.is_used = True
        verification.save()

        refresh = RefreshToken.for_user(user)
        return {
            "refresh": str(refresh),
            "access": str(refresh.access_token),
        }


class ResendVerificationCodeSerializer(serializers.Serializer):
    email = serializers.EmailField()

    def validate(self, data):
        email = data.get('email')

        try:
            user = User.objects.get(email=email)
        except User.DoesNotExist:
            raise serializers.ValidationError(
                "User with this email does not exist"
            )
        if user.is_active:
            raise serializers.ValidationError(
                "Account already verified, please log in to proceed"
            )
        
        data['user'] = user
        return data
    
    def create(self, validated_data):
        user = validated_data['user']
        verification = EmailVerification.create_for_user(user, 'email_verification')
        send_verification_email.delay(user.email, verification.code)
        return user
    

class RequestPasswordResetSerializer(serializers.Serializer):
    email = serializers.EmailField()

    def validate(self, data):
        email = data.get('email')

        try:
            user = User.objects.get(email=email)
        except User.DoesNotExist:
            raise serializers.ValidationError("User with this email does not exist.")
        
        if not user.is_active:
            raise serializers.ValidationError("Account is not active.")
        
        data["user"] = user
        return data
    
    def create(self, validated_data):
        user = validated_data["user"]
        verification = EmailVerification.create_for_user(user, "password_reset")
        send_verification_email.delay(user.email, verification.code)
        return validated_data
    

class SetNewPasswordSerializer(serializers.Serializer):
    email = serializers.EmailField()
    code = serializers.CharField(write_only=True)
    new_password = serializers.CharField(write_only=True)

    def validate_new_password(self, value):
        validate_password(value)
        return value
    
    def validate(self, data):
        email = data.get('email')
        code = data.get('code')

        try:
            user = user.objects.get(email=email)
        except User.DoesNotExist:
            raise serializers.ValidationError(
                "User with this email does not exist."
            )
        
        try:
            verification = EmailVerification.validate_code(user, code, 'password_reset')
        except ValueError as e:
            raise serializers.ValidationError(str(e))
        
        data['user'] = user
        data['verification'] = verification
        return data
    
    def save(self):
        user = self.validated_data['user']
        new_password = self.validated_data['new_password']
        verification = self.validated_data['verification']

        user.set_password(new_password)
        user.save()

        verification.is_used = True
        verification.save()

        return user
    
class LoginSerializer(serializers.Serializer):
    email = serializers.EmailField()
    password = serializers.CharField(write_only=True)

    def validate(self, attrs):
        email = attrs.get('email')
        password = attrs.get('password')

        user = authenticate(email=email, password=password)

        if not user:
            raise serializers.ValidationError(
                "invalid login credentials"
            )
        
        attrs['user'] = user
        return attrs