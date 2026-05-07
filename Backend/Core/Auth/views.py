from django.shortcuts import render
from rest_framework.views import APIView
from .serializers import RegisterSerializer, VerifyEmailSerializer, UserSerializer, LoginSerializer, ResendVerificationCodeSerializer, SetNewPasswordSerializer, RequestPasswordResetSerializer
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.response import Response
from rest_framework import status
from rest_framework import throttling
from .models import User

# Create your views here.

def get_tokens_for_user(user):
    refresh = RefreshToken.for_user(user)
    return {
        'refresh': str(refresh),
        'access': str(refresh.access_token),
    }

class BaseRegisterView(APIView):
    role = None

    def post(self, request):
        serializer = RegisterSerializer(
            data=request.data,
            context={"role": self.role}
        )
        serializer.is_valid(raise_exception=True)
        user = serializer.save()

        return Response(
            {
                "user": RegisterSerializer(user).data,
                "message": "Account successfully created, kindly verify your email address to log in."
            },
            status=status.HTTP_201_CREATED
        )


class RiderRegisterView(BaseRegisterView):
    role = User.Role.RIDER


class VendorRegisterView(BaseRegisterView):
    role = User.Role.VENDOR


class CustomerRegisterView(BaseRegisterView):
    role = User.Role.CUSTOMER

    
class VerifyEmailView(APIView):
    def post(self, request):
        serializer = VerifyEmailSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        tokens = serializer.save()

        return Response(
            {
                "message": "Email verified successfully.",
                "tokens": tokens, 
            },
            status=status.HTTP_200_OK
        )

class ResendVerificationThrottle(throttling.UserRateThrottle):
    scope = 'resend_verification'   

class ResendVerificationCodeView(APIView):
    throttle_classes = [ResendVerificationThrottle]

    def post(self, request):
        serializer = ResendVerificationCodeSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(
            {
                "message": "Verification code has been resent successfully."
            },
            status=status.HTTP_200_OK
        )


class RequestPasswordResetView(APIView):
    def post(self, request):
        serializer = RequestPasswordResetSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(
            {
                "message": "Password Reset Code sent successfully"
            },
            status=status.HTTP_200_OK
        )

class SetNewPassword(APIView):
    def post(self, request):
        serializer = SetNewPasswordSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(
            {
                "message": "Password reset successful"
            },
            status=status.HTTP_200_OK
        )

class LoginView(APIView):
    def post(self, request):
        serializer = LoginSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        tokens = get_tokens_for_user(user)

        return Response(
            {
                "user": UserSerializer(user).data,
                "tokens": tokens,
                "message": "Logged in successfully"
            },
            status=status.HTTP_200_OK
        )