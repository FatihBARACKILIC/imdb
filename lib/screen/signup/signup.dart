import 'package:flutter/material.dart';
import 'package:imdb/components/snack_bar.dart';
import 'package:imdb/helper/shared_preferences_helper.dart';
import 'package:imdb/screen/home/home_widget.dart';
import 'package:imdb/screen/login/login_widget.dart';
import 'package:imdb/services/firebase_services.dart';
import 'package:imdb/theme/colors/colors.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final TextEditingController _controllerUserName = TextEditingController();
  final TextEditingController _controllerEMail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Sign Up"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: FittedBox(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TextField(
                    controller: _controllerUserName,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      label: Text("User Name"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _controllerEMail,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      label: Text("E-Mail"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TextField(
                    obscureText: true,
                    controller: _controllerPassword,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (String text) => _signUp(),
                    decoration: const InputDecoration(
                      label: Text("Password"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _signUp,
                      child: const Text("Sign Up"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginWidget(),
                        ),
                      ),
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(purpleColor),
                      ),
                      child: const Text("Login"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signUp() async {
    String userName = _controllerUserName.text.trim();
    String eMail = _controllerEMail.text.trim();
    String password = _controllerPassword.text.trim();

    if (userName.isEmpty || eMail.isEmpty || password.isEmpty) {
      ShowSnackBar(
          context: context, content: "Please fill every area!", isOkey: false);
    } else if (password.length < 8) {
      ShowSnackBar(
          context: context,
          content: "Password length must be 8 character!",
          isOkey: false);
    } else {
      String result = await FirebaseServices.registerUser(
        userName: userName,
        eMail: eMail,
        password: password,
      );

      if (result == "registered") {
        ShowSnackBar(context: context, content: "Email used", isOkey: false);
      } else if (result.isNotEmpty) {
        // ShowSnackBar(context: context, content: "Register", isOkey: true);
        await SharedPreferencesHelper.setSharedPreferences("id", result);
        _router();
      } else {
        ShowSnackBar(
            context: context, content: "Error! Try again", isOkey: false);
      }
    }
  }

  void _router() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeWidget(),
      ),
    );
  }
}
