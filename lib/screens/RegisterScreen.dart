import 'package:translator_app/widgets/Languages/LanguagesList.dart';

import '/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String selectedLanguageName = "Set Your Language";
  String selectedLanguagePar = "";
  bool _passwordVisible = true;
  bool isLanguageSet = true;
  @override
  Widget build(BuildContext context) {
    void languageValidate() {
      if (selectedLanguagePar != "") {
        isLanguageSet = true;
      } else {
        isLanguageSet = false;
      }
    }

    void trySubmit() {
      setState(() {
        languageValidate();
      });
      final isValid = _formKey.currentState.validate();
      FocusScope.of(context).unfocus();
      if (isValid && selectedLanguagePar != "") {
        _formKey.currentState.save();
        context.read<AuthenticationService>().signUp(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
              nickname: nicknameController.text.trim(),
              nativeLanguage: selectedLanguageName,
              ctx: context,
            );
        // Navigator.of(context).pop();
      }
    }

    final Size _size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Giulio',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(_size.width * 0.05),
          child: Container(
            width: _size.width,
            height: _size.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Create your account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: _size.width * 0.1,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(117, 117, 117, 1)),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Center(
                    child: Column(
                      children: [
                        _buildTextInputWidget(
                          key: 'nickname',
                          labelText: 'Nickname',
                          icon: Icon(Icons.person),
                          controller: nicknameController,
                          size: _size,
                          isLast: false,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Nickname must be set';
                            }
                            return null;
                          },
                        ),
                        _buildTextInputWidget(
                          key: 'email',
                          labelText: 'E-mail address',
                          icon: Icon(Icons.email_outlined),
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          size: _size,
                          validator: (String value) {
                            if (!RegExp(
                                    r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                                .hasMatch(value)) {
                              return "Please enter a valid email.";
                            }
                            return null;
                          },
                        ),
                        _buildTextInputWidget(
                          key: 'password',
                          labelText: 'Password',
                          icon: Icon(Icons.lock_outline_rounded),
                          controller: passwordController,
                          size: _size,
                          isPassword: _passwordVisible,
                          isLast: true,
                          fieldSubmit: trySubmit,
                          validator: (String value) {
                            if (value.isEmpty || value.length < 7) {
                              return 'Password must be at least 7 characters long.';
                            }
                            return null;
                          },
                          showPass: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: ElevatedButton(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    (selectedLanguageName ==
                                            "Set Your Language")
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 15),
                                            child: Icon(
                                              Icons.flag_outlined,
                                              color:
                                                  Theme.of(context).hintColor,
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 15),
                                            child: Icon(
                                              Icons.flag,
                                              color:
                                                  Theme.of(context).hintColor,
                                            ),
                                          ),
                                    (selectedLanguageName ==
                                            "Set Your Language")
                                        ? Text(selectedLanguageName,
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Theme.of(context)
                                                    .hintColor))
                                        : Text(selectedLanguageName,
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black)),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Theme.of(context).hintColor,
                                    )
                                  ],
                                ),
                                (!isLanguageSet)
                                    ? Divider(
                                        color: Colors.red[600],
                                        thickness: 1,
                                      )
                                    : Container(),
                                (!isLanguageSet)
                                    ? Text(
                                        "Please set your native language",
                                        style:
                                            TextStyle(color: Colors.red[700]),
                                      )
                                    : Container(),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 6,
                                primary: Colors.white,
                                minimumSize: Size(_size.width * .9, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                    appBar: AppBar(
                                      title: Text("Set your native language"),
                                    ),
                                    body: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: languages.length - 1,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(
                                              //+1 to skip automatically
                                              languages[index + 1]["name"]),
                                          trailing: (selectedLanguageName ==
                                                  languages[index + 1]["name"])
                                              ? Icon(Icons.done)
                                              : Text(''),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            setState(
                                              () {
                                                selectedLanguageName =
                                                    languages[index + 1]
                                                        ["name"];
                                                selectedLanguagePar =
                                                    languages[index + 1]["par"];
                                                languageValidate();
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        trySubmit();
                      },
                      child: Text("Create"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple[400],
                          fixedSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
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
}

Container _buildTextInputWidget({
  @required Size size,
  @required Function validator,
  @required TextEditingController controller,
  @required String labelText,
  @required String key,
  @required Icon icon,
  Function fieldSubmit,
  IconButton showPass,
  // Function submitForm,
  TextInputType keyboardType = TextInputType.text,
  bool isPassword = false,
  bool isLast = false,
}) {
  return Container(
    width: size.width * .9,
    padding: const EdgeInsets.only(top: 15.0),
    child: Material(
      borderRadius: BorderRadius.circular(25),
      elevation: 6,
      child: TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            icon: Padding(padding: EdgeInsets.only(left: 20), child: icon),
            hintText: labelText,
            suffixIcon: showPass,
          ),
          style: TextStyle(fontSize: 17),
          obscureText: isPassword ? true : false,
          textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
          onFieldSubmitted: (_) {
            if (isLast) fieldSubmit();
          }),
    ),
  );
}
