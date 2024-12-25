import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:storedgev2/features/authentication/data/firebase_auth_service.dart';

import '../../../core/constants/constants.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  BuildContext? _progressIndicatorContext;

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      final auth = ref.read(firebaseAuthServiceProvider.notifier);

      await auth.createUserWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    if (_progressIndicatorContext != null &&
        _progressIndicatorContext!.mounted) {
      Navigator.of(_progressIndicatorContext!).pop();
      _progressIndicatorContext = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(firebaseAuthServiceProvider, (prev, state) async {
      if (state.isLoading) {
        await showDialog(
          context: context,
          builder: (ctx) {
            _progressIndicatorContext = ctx;
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
        return;
      }

      // close circular progress indicator after rebuild
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (_progressIndicatorContext != null &&
            _progressIndicatorContext!.mounted) {
          Navigator.of(_progressIndicatorContext!).pop();
          _progressIndicatorContext = null;
        }
      });

      if (state.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Error: ${state.error}'),
          ),
        );
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Form(
                  key: _formKey,
                  child: Column(
                    spacing: 20,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Email is required'
                            : null,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: InkWell(
                              child: Icon(!_passwordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onTap: () => setState(
                                  () => _passwordVisible = !_passwordVisible)),
                        ),
                        obscureText: !_passwordVisible,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Password is required'
                            : null,
                      ),
                      TextFormField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            suffixIcon: InkWell(
                                child: Icon(!_confirmPasswordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined),
                                onTap: () => setState(() =>
                                _confirmPasswordVisible = !_confirmPasswordVisible)),
                          ),
                          obscureText: !_confirmPasswordVisible,
                        validator: (value) {
                          if (value?.isEmpty ?? true) return 'Password Confirmation is required';
                          if (value != _passwordController.text) return 'Password does not match';
                          return null;
                        }),
                      SizedBox(
                        height: 10,
                      ),
                      FilledButton(
                        onPressed: _signup,
                        child: Text('Sign Up'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: defaultPadding / 2,
                        children: [
                          Text('Already have an account?',
                              style: TextStyle(fontSize: 13)),
                          TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child:
                                Text('Sign In', style: TextStyle(fontSize: 13)),
                          ),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding * 2),
                        child: Column(
                          children: [
                            Text("We respect Your Privacy.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    height: 1.5,
                                    color: onSurfaceColor.withAlpha(192),
                                    fontSize: 12)),
                            Text(
                              "By signing up, You agree to our Terms and Privacy Policy",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.5,
                                  color: onSurfaceColor.withAlpha(192),
                                  fontSize: 12),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
