from celery import shared_task
from django.core.mail import get_connection, EmailMessage
from django.conf import settings

@shared_task
def send_verification_email(email, code):
    subject = "Verify your Venra account"
    message = f"Your Venra verification code is: {code}"
    sender = settings.DEFAULT_FROM_EMAIL
    connection = get_connection()
    connection.open()

    try:
        email_msg = EmailMessage(
            subject=subject,
            body=message,
            from_email=sender,
            to=[email],
            connection=connection
        )
        email_msg.send()
    finally:
        connection.close()

    return f"Verification email sent to {email}"