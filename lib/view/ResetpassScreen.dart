import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/auth_viewmodel.dart';

class ResetPassScreen extends StatefulWidget{
  const ResetPassScreen({super.key});

  @override
  State<ResetPassScreen> createState () => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen>{
  final _emailController = TextEditingController();

  @override
  Widget build (BuildContext context) {
    final viewmodel = Provider.of<AuthViewModel> (context);
    return Scaffold(
      appBar: AppBar(title: Text("Reset password")),
      body: Padding(
          padding: EdgeInsets.all(16),
        child: Column(
          children: [
            if (viewmodel.errorMessage != null)
              Text(
                viewmodel.errorMessage!,
                style: const TextStyle (color: Colors.red),
              ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              onChanged: (_) => viewmodel.clearError(),
            ),
            const SizedBox(height: 20),
            viewmodel.isLoading
            ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async{
                final success = await viewmodel.resetPassword(
                  _emailController.text.trim(),
                );
                if(success){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Password reset email sent. check your inbox.")
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: Text("Send reset email"),
            )
          ],
        ),
      ),
    );
  }
}