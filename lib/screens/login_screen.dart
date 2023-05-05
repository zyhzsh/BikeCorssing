import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState()  {
    super.initState();
  }

  void testcall() async{
    final x = await Supabase.instance.client.from('test_table').select();
    print(x);
  }


  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: testcall, child: Text('Login'));
  }
}
