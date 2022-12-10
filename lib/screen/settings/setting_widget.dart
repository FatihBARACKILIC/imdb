import 'package:flutter/material.dart';
import 'package:imdb/components/snack_bar.dart';
import 'package:imdb/constant/languages.dart';
import 'package:imdb/helper/shared_preferences_helper.dart';
import 'package:imdb/main.dart';
import 'package:imdb/screen/home/home_widget.dart';
import 'package:imdb/services/firebase_services.dart';
import 'package:imdb/theme/colors/colors.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  final TextEditingController _controllerUserName = TextEditingController();
  final TextEditingController _controllerEMail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  String _id = "";
  final List _userInfo = ["", "", ""];
  bool _darkMode = true;
  List _language = [];
  String _selectedLanguage = "en";

  @override
  void initState() {
    super.initState();
    _getUserId();
    _checkDarkMode();
    _getLanguage();
  }

  _getLanguage() async {
    String defaultLang = await SharedPreferencesHelper.selectedLanguage();
    setState(() {
      _selectedLanguage = defaultLang;
      _language = Languages.languages;
    });
  }

  _checkDarkMode() async {
    bool result = await SharedPreferencesHelper.darkMode();

    setState(() {
      _darkMode = result;
    });
  }

  _getUserId() async {
    String result = await SharedPreferencesHelper.getLoginRegister();
    setState(() {
      _id = result;
      if (_id.isNotEmpty) {
        _getUserInfo();
      }
    });
  }

  _getUserInfo() async {
    List result = await FirebaseServices.getUserInfo(_id);
    setState(() {
      _userInfo[0] = result[0];
      _userInfo[1] = result[1];
      _userInfo[2] = result[2];

      _setTextFieldUserInfos();
    });
  }

  _setTextFieldUserInfos() {
    setState(() {
      _controllerUserName.text = _userInfo[0];
      _controllerEMail.text = _userInfo[1];
      _controllerPassword.text = _userInfo[2];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
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
                      "Settings",
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
                    onSubmitted: (String text) => _update(),
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
                      onPressed: _update,
                      child: const Text("Update"),
                    ),
                  ),
                ),
                const Divider(),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Text("Dark Mode"),
                    ),
                    Switch(
                      activeColor: imdbYellowColor,
                      value: _darkMode,
                      onChanged: (value) => _setDarkMode(),
                    ),
                  ],
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: DropdownButton<String>(
                    value: _selectedLanguage,
                    isExpanded: true,
                    menuMaxHeight: MediaQuery.of(context).size.height * .2,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedLanguage = value ?? "en";
                        SharedPreferencesHelper.setSharedPreferences(
                            "selectedLanguage", _selectedLanguage);
                      });

                      ShowSnackBar(
                          context: context,
                          content: "Language Changed!",
                          isOkey: true);
                    },
                    items: _language.map<DropdownMenuItem<String>>(
                      (value) {
                        return DropdownMenuItem<String>(
                          value: value[0],
                          child: Text(value[1]),
                        );
                      },
                    ).toList(),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(purpleColor),
                      ),
                      onPressed: _logout,
                      child: const Text("Logout"),
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

  _update() async {
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
      String result = await FirebaseServices.updateUser(
        id: _id,
        userName: userName,
        eMail: eMail,
        password: password,
      );

      if (result == "registered") {
        ShowSnackBar(context: context, content: "Used email", isOkey: false);
      } else if (result.isNotEmpty) {
        await SharedPreferencesHelper.setSharedPreferences("id", result);
        ShowSnackBar(context: context, content: "Updated", isOkey: true);
      } else {
        ShowSnackBar(
            context: context, content: "Error! Try again", isOkey: false);
      }
    }
  }

  _logout() async {
    try {
      await SharedPreferencesHelper.removeSharedPreferences("id");
      _routerLogout();
    } catch (e) {
      ShowSnackBar(
          context: context, content: "Error! Try again", isOkey: false);
    }
  }

  void _routerLogout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeWidget(),
      ),
    );
  }

  _setDarkMode() async {
    setState(() {
      _darkMode = !_darkMode;
    });
    try {
      await SharedPreferencesHelper.setSharedPreferences("darkMode", _darkMode);
      IMDbApp.themeNotifier.value =
          _darkMode ? ThemeMode.dark : ThemeMode.light;
      // HomeWidget.restart();
    } catch (e) {
      ShowSnackBar(
          context: context, content: "Error! Try again", isOkey: false);
    }
  }
}
