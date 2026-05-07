from django.urls import path
from . import views

urlpatterns = [
    path('register/customer/', views.CustomerRegisterView.as_view()),
    path('register/rider/', views.RiderRegisterView.as_view()),
    path('register/vendor/', views.VendorRegisterView.as_view()),
    path('verify-email/', views.VerifyEmailView.as_view()),
    path('log-in/', views.LoginView.as_view()),
    path('resend-code/', views.ResendVerificationCodeView.as_view()),
    path('password-reset/', views.RequestPasswordResetView.as_view()),
    path('set-new-password/', views.SetNewPassword.as_view()),
]