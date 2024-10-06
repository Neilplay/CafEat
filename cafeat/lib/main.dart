import 'package:flutter/material.dart';
import 'landing.dart'; // Import the new landing page file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(), // The first screen (LandingPage)
        '/signin': (context) => SignInPage(), // Signin page
        '/auth': (context) => SignUpPage(), // Signup page
      },
    );
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000033),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: const AssetImage(
                    'assets/cafeatLOGO.png',
                  ),
                  backgroundColor: Color(0xFF000033),
                ),
                const SizedBox(height: 20),
                Text(
                  'Create an account',
                  style: TextStyle(
                    color: Colors.yellow[500]!,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SignUpForm(),
                const SizedBox(height: 20),
                // Removed the redundant button
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(color: Colors.yellow[500]),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signin');
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: Colors.yellow[500],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildTextField(
            icon: Icons.person,
            labelText: 'FULL NAME',
            hintText: 'Full Name',
          ),
          const SizedBox(height: 20),
          buildTextField(
            icon: Icons.email,
            labelText: 'EMAIL',
            hintText: 'Email',
            inputType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            obscureText: _isPasswordHidden,
            style: TextStyle(color: Colors.yellow[500]!),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock, color: Colors.yellow[500]!),
              labelText: 'PASSWORD',
              labelStyle: TextStyle(color: Colors.yellow[500]!),
              hintText: 'Password',
              hintStyle: TextStyle(color: Colors.yellow[500]!),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow[500]!),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow[500]!),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                  color: Colors.yellow[500]!,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordHidden = !_isPasswordHidden;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _isConfirmPasswordHidden,
            style: TextStyle(color: Colors.yellow[500]!),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock, color: Colors.yellow[500]!),
              labelText: 'CONFIRM PASSWORD',
              labelStyle: TextStyle(color: Colors.yellow[500]!),
              hintText: 'Confirm Password',
              hintStyle: TextStyle(color: Colors.yellow[500]!),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow[500]!),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow[500]!),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isConfirmPasswordHidden
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.yellow[500]!,
                ),
                onPressed: () {
                  setState(() {
                    _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              } else if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Signing up...')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow[500]!,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            child: const Text(
              'SIGN UP',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF000033),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField({
    required IconData icon,
    required String labelText,
    required String hintText,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      keyboardType: inputType,
      style: TextStyle(color: Colors.yellow[500]!),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.yellow[500]!),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.yellow[500]!),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.yellow[500]!),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.yellow[500]!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.yellow[500]!),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $labelText';
        }
        return null;
      },
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000033),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: const AssetImage(
                    'assets/cafeatLOGO.png',
                  ),
                  backgroundColor: Color(0xFF000033),
                ),
                const SizedBox(height: 20),
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.yellow[500]!,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SignInForm(),
                const SizedBox(height: 20),
                // Removed the redundant button
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.yellow[500]),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/auth');
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.yellow[500],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  bool _isPasswordHidden = true;

  SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildTextField(
          icon: Icons.email,
          labelText: 'EMAIL',
          hintText: 'Email',
          inputType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        buildPasswordField(),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            // Handle sign in logic
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow[500]!,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          child: const Text(
            'LOGIN',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF000033),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPasswordField() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return TextFormField(
          obscureText: _isPasswordHidden,
          style: TextStyle(color: Colors.yellow[500]!),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock, color: Colors.yellow[500]!),
            labelText: 'PASSWORD',
            labelStyle: TextStyle(color: Colors.yellow[500]!),
            hintText: 'Password',
            hintStyle: TextStyle(color: Colors.yellow[500]!),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow[500]!),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow[500]!),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                color: Colors.yellow[500]!,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordHidden = !_isPasswordHidden;
                });
              },
            ),
          ),
        );
      },
    );
  }

  Widget buildTextField({
    required IconData icon,
    required String labelText,
    required String hintText,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      keyboardType: inputType,
      style: TextStyle(color: Colors.yellow[500]!),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.yellow[500]!),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.yellow[500]!),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.yellow[500]!),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.yellow[500]!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.yellow[500]!),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $labelText';
        }
        return null;
      },
    );
  }
}
