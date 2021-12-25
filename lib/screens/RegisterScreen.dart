import 'package:translator_app/widgets/Login/OrDIvider.dart';

import '/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Giulio',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Create your account",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: _size.width * 0.1,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(117, 117, 117, 1)),
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
                    ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: () => trySubmit(),
                      child: Text("Log in"),
                    ),
                    OrDivider(),
                  ],
                ),
              ),
            )
          ],
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
