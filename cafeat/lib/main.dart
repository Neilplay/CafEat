import 'dart:convert'; // For json encoding
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'landing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(), // The first screen (LandingPage)
        '/signin': (context) => const SignInPage(), // Signin page
        '/auth': (context) => const SignUpPage(), // Signup page
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
                const CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('assets/cafeatLOGO.png'),
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
                const SignUpForm(),
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
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  String _userType = 'Customer'; // Default value

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullnameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
      var url = Uri.parse('http://localhost/cafeat/register.php');
      var response = await http.post(
        url,
        body: {
          'fullname': _fullnameController.text,
          'email': _emailController.text,
          'contact': _contactController.text,
          'role': _userType,
          'password': _passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['message'] == 'User registered successfully') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User registered successfully')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to register user')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Error: Unable to connect to the server')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildTextField(
            controller: _fullnameController,
            icon: Icons.person,
            labelText: 'FULL NAME',
            hintText: 'Full Name',
          ),
          const SizedBox(height: 20),
          buildTextField(
            controller: _emailController,
            icon: Icons.email,
            labelText: 'EMAIL',
            hintText: 'Email',
            inputType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          buildTextField(
            controller: _contactController,
            icon: Icons.phone,
            labelText: 'CONTACT NUMBER',
            hintText: 'Contact Number',
            inputType: TextInputType.phone,
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            value: _userType,
            items: ['Customer', 'Courier'].map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(
                  category,
                  style: TextStyle(color: Colors.yellow[500]!),
                ),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'USER TYPE',
              labelStyle: TextStyle(color: Colors.yellow[500]!),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow[500]!),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow[500]!),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _userType = value!;
              });
            },
          ),
          const SizedBox(height: 20),
          buildPasswordField(),
          const SizedBox(height: 20),
          buildConfirmPasswordField(),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: signUp,
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
    required TextEditingController controller,
    required IconData icon,
    required String labelText,
    required String hintText,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
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

  Widget buildPasswordField() {
    return TextFormField(
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
    );
  }

  Widget buildConfirmPasswordField() {
    return TextFormField(
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
            _isConfirmPasswordHidden ? Icons.visibility : Icons.visibility_off,
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
                const CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('assets/cafeatLOGO.png'),
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
        buildPasswordField(context),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            // Handle sign-in logic
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

  Widget buildPasswordField(BuildContext context) {
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
}
