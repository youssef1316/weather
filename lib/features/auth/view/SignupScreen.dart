import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/Routing/routing.dart';
import '../viewmodel/auth_viewmodel.dart';


class SignupScreen extends StatefulWidget{
  const SignupScreen({super.key});
  @override
  State <SignupScreen> createState () => _SignupScreenState();
}

class _SignupScreenState extends State <SignupScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build (BuildContext context) {
    final viewmodel = Provider.of<AuthViewModel> (context);
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (viewmodel.errorMessage != null)
                Text(viewmodel.errorMessage!, style: const TextStyle(color: Colors.red)),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefix: Icon(Icons.email)
                ),
                onChanged: (_) => viewmodel.clearError(),
              ),
              TextField(
                controller: _passController,
                decoration: const InputDecoration(
                    labelText: 'Password',
                    prefix: Icon(Icons.lock)
                ),
                obscureText: true,
                onChanged: (_) => viewmodel.clearError(),
              ),
              const SizedBox(height: 20),
              viewmodel.isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async{
                    final user = await viewmodel.signup(
                      _emailController.text.trim(),
                      _passController.text.trim(),
                    );
                    if (user != null) {
                      Navigator.pushReplacementNamed(context, AppRoutes.home);
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(viewmodel.errorMessage ?? "Sign Up failed"))
                      );
                    }
                  },
                  child : Text ("Sign up"),
              ),
            ],
          )
      ),
    );
  }
}