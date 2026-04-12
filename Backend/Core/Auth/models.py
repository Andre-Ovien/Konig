from django.db import models
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin, BaseUserManager
from django.utils.translation import gettext_lazy
import secrets
from django.utils import timezone
from datetime import timedelta

# Create your models here.

class CustomUserManager(BaseUserManager):
    def create_user(self, email, password, **extra_fields):
        if not email:
            raise ValueError("The Email must be set")
        email = self.normalize_email(email).lower()
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user
    
    def create_superuser(self, email, password, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        extra_fields.setdefault('is_active', True)

        if extra_fields.get('is_staff') is not True:
            raise ValueError('Superuser must be a staff')
        if extra_fields.get('is_superuser') is not True:
            raise ValueError('Must be a Superuser')
        return self.create_user(email, password, **extra_fields)
    
class User(AbstractBaseUser, PermissionsMixin):
    email = models.EmailField(unique=True, null=False)
    name = models.CharField(max_length=253, blank=True, null=True)

    is_staff = models.BooleanField(
        gettext_lazy('Staff Status'), default=False,
        help_text= gettext_lazy('Designates whether the user can log in the site')
    )
    is_active = models.BooleanField(
        gettext_lazy('Active Status'), default=True,
        help_text= gettext_lazy('Designates whether this user should be treated as active')
    )
    

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []
    objects = CustomUserManager()

    def __str__(self):
        return self.email


class EmailVerification(models.Model):
    PURPOSE = [
        ('email_verification', 'Email Verification'),
        ('password_reset', 'Password Reset'),
        ('two_factor', 'Two Factor'),
    ]

    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="verification")
    code = models.CharField(max_length=6)
    purpose = models.CharField(max_length=32, choices=PURPOSE, default='email_verification')
    is_used = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        indexes = [
            models.Index(fields=['user','purpose','-created_at'])
        ]

    def generate_code(self):
        self.code = ''.join(secrets.choice("0123456789") for _ in range(6))
        self.is_used = False
        self.save()

    def is_expired(self, expiry_minutes=10):
        return timezone.now() > self.created_at + timedelta(minutes=expiry_minutes)
    
    @classmethod
    def create_for_user(cls, user, purpose):
        cls.objects.filter(user=user, purpose=purpose, is_used=False).delete()
        instance = cls.objects.create(user=user, purpose=purpose)
        instance.generate_code()
        return instance
    
    @classmethod
    def validate_code(cls, user, code, purpose):
        try:
            verification = cls.objects.get(
                user=user,
                code=code,
                purpose=purpose,
                is_used=False
            )
        except cls.DoesNotExist:
            raise ValueError("Invalid or expired validation code.")
        
        if verification.is_expired():
            raise ValueError("Verification code has expired.")
        
        return verification