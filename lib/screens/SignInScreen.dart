import 'package:translator_app/widgets/Login/OrDIvider.dart';

import '/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    void trySubmit() {
      context.read<AuthenticationService>().signIn(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
    }

    final Size _size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(_size.width * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Hello",
            style: TextStyle(
                fontSize: _size.width * 0.20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(117, 117, 117, 1)),
          ),
          Text(
            "Login to your account",
            style: Theme.of(context).textTheme.headline6.copyWith(
                color: Color.fromRGBO(0, 0, 0, 0.4),
                letterSpacing: -1,
                fontWeight: FontWeight.bold),
          ),
          Padding(padding: EdgeInsets.all(20)),
          Form(
            child: Center(
              child: Column(
                children: [
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyle(color: Colors.deepPurple[400]),
                        )),
                  ),
                  SizedBox(
                    height: _size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => trySubmit(),
                      child: Text("Log In"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple[400],
                          fixedSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                  ),
                  OrDivider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        ElevatedButton(onPressed: () {}, child: Text('Google')),
                  ),
                  SizedBox(
                    height: _size.height * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account yet?"),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/register");
                          },
                          child: Text(
                            "Create",
                            style: TextStyle(color: Colors.deepPurple[400]),
                          )),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
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
  //Function submitForm,
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
