import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/Routing/routing.dart';
import '../viewmodel/auth_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context){
    final viewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (viewModel.errorMessage != null)
              Text(viewModel.errorMessage!, style: const TextStyle(color: Colors.red)),

            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
              onChanged: (_) => viewModel.clearError(),
            ),
            TextField(
              controller: _passController,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
              onChanged: (_) => viewModel.clearError(),
            ),
            const SizedBox(height: 20),
            viewModel.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                final user = await viewModel.login(
                  _emailController.text.trim(),
                  _passController.text.trim(),
                );
                if (user != null) {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                }
              },
              child: const Text("Login"),
            ),
            TextButton(
                onPressed: (){
                  Navigator.pushNamed(context, AppRoutes.resetpass);
                },
              child: const Text("Forgot password ?")
            ),
            TextButton(
                onPressed: (){
                  Navigator.pushNamed(context, AppRoutes.signup);
                },
                child: const Text("Sign Up")
            )
          ],
        ),
      ),
    );
  }
}