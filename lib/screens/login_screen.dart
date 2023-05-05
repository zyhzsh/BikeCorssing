import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key, required this.onSuccessfulLogIn})
      : super(key: key);

  final Function onSuccessfulLogIn;

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // void _logIn() async {
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (context) => const Center(child: CircularProgressIndicator()),
  //   );
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       await Supabase.instance.client.auth.signInWithPassword(
  //           email: _emailController.text, password: _passwordController.text);
  //       widget.onSuccessfulLogIn();
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //           content: Text(
  //               'Invalid login credentials or something goes wrong. Please try again.')));
  //     } finally {
  //       Navigator.of(context).pop();
  //     }
  //   }
  // }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                Row(
                  children: [
                    Text(
                      'Start your journey',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  height: 260,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/gifs/bike_rolling.gif'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await Supabase.instance.client.auth.signInWithOAuth(
                              Provider.google,
                              redirectTo: kIsWeb
                                  ? null
                                  : 'io.supabase.flutterquickstart://login-callback/');
                          print('success');
                        } catch (e) {
                          print('eeee');
                        } finally {
                          print('finally');
                        }
                      },
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      )),
                ),
                SupaSocialsAuth(
                  colored: true,
                  redirectUrl: kIsWeb
                      ? null
                      : 'io.supabase.flutterquickstart://login-callback/',
                  socialProviders: [
                    SocialProviders.google,
                  ],
                  onSuccess: (Session response) {
                    widget.onSuccessfulLogIn();
                  },
                  onError: (error) {
                    print(error);
                    // do something, for example: navigate("wait_for_email");
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
