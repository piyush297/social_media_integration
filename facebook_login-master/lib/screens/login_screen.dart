import 'dart:developer';

import 'package:facebook_login/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool loggedIn = false;

  AccessToken? _accessToken;

  UserModel? _currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facebook Login'),
      ),
      body: Center(
        child: Container(child: _buildWidget()),
      ),
    );
  }

  Widget _buildWidget() {
    UserModel? user = _currentUser;
    if (user != null) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: user.pictureModel!.width! / 6,
                backgroundImage: NetworkImage(user.pictureModel!.url!),
              ),
              title: Text(user.name!),
              subtitle: Text(user.email!),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Signed in successfully',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: signOut, child: const Text('Sign out'))
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'You are not signed in',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: signIn, child: const Text('Sign in')),
          ],
        ),
      );
    }
  }

  Future<void> signIn() async {
    final LoginResult result =
        await FacebookAuth.i.login(loginBehavior: LoginBehavior.webOnly);

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final data = await FacebookAuth.i.getUserData();
      // log(data.toString());
      UserModel model = UserModel.fromJson(data);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "Logged in Succesfully",
        style: TextStyle(color: Colors.green),
      )));
      _currentUser = model;
      setState(() {});
    }
  }

  Future<void> signOut() async {
    await FacebookAuth.i.logOut();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      "Logged out Succesfully",
      style: TextStyle(color: Colors.red),
    )));
    _currentUser = null;
    _accessToken = null;
    setState(() {});
  }
}
