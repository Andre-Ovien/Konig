import 'package:flutter/material.dart';
import 'signin_screen.dart';
import '../services/auth_service.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;
  const VerifyEmailScreen({super.key, required this.email});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  // One controller per box
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isLoading = false;

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      // Auto-advance to next box
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      // Auto-back on delete
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _verify() async {
  final code = _controllers.map((c) => c.text).join();

  if (code.length < 6) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter the full 6-digit code')),
    );
    return;
  }

  setState(() => _isLoading = true);

  final result = await AuthService.verifyEmail(
    email: widget.email,
    code: code,
  );

  setState(() => _isLoading = false);

  if (result['success']) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SignInScreen()),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result['message'])),
    );
    // Clear the boxes so user can re-enter
    for (final c in _controllers) c.clear();
    _focusNodes[0].requestFocus();
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Verify Email',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Enter the code sent to your email address',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 40),

              // OTP boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 48,
                    height: 56,
                    child: TextFormField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      onChanged: (val) => _onChanged(val, index),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        counterText: '',   // hides the "0/1" counter
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),

              // Resend
              Row(
                children: [
                  const Text("Didn't get the code? "),
                  GestureDetector(
                    onTap: () {
                      // TODO: call your resend API
                    },
                    child: const Text(
                      'Resend Code',
                      style: TextStyle(
                        color: Color(0xFF2D5A27),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Verify button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null: _verify,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D5A27),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Verify',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}