import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to SignUpPage when anywhere on the screen is tapped
        Navigator.pushNamed(context, '/signin');
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF000033),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/cafeatLOGO.png',
                height: 200,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
