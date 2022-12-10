import 'package:flutter/material.dart';
import 'package:imdb/components/snack_bar.dart';
import 'package:imdb/helper/shared_preferences_helper.dart';
import 'package:imdb/screen/home/home_widget.dart';
import 'package:imdb/screen/signup/signup.dart';
import 'package:imdb/services/firebase_services.dart';
import 'package:imdb/theme/colors/colors.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _controllerEMail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Login"),
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
                      "Login",
                      style: TextStyle(fontSize: 50),
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
                    onSubmitted: (String text) => _login,
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
                      onPressed: _login,
                      child: const Text("Login"),
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
                            builder: (context) => const SignUpWidget(),
                          )),
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(purpleColor),
                      ),
                      child: const Text("Sign Up"),
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

  _login() async {
    String eMail = _controllerEMail.text.trim();
    String password = _controllerPassword.text.trim();

    if (eMail.isEmpty || password.isEmpty) {
      ShowSnackBar(
          context: context, content: "Please fill every area!", isOkey: false);
    } else {
      String result = await FirebaseServices.getUserId(
        eMail: eMail,
        password: password,
      );

      if (result.isNotEmpty) {
        await SharedPreferencesHelper.setSharedPreferences("id", result);
        router();
      } else {
        ShowSnackBar(
            context: context, content: "Error! Try again", isOkey: false);
      }
    }
  }

  void router() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeWidget(),
      ),
    );
  }
}
