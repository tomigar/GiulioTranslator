import '/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void trySubmit() {
      context.read<AuthenticationService>().signIn(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
    }

    final Size _size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Hello",
          style: Theme.of(context)
              .textTheme
              .headline1
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          "Login to your account please",
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Color.fromRGBO(0, 0, 0, 0.4),
              ),
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
                  isPassword: true,
                  isLast: true,
                  fieldSubmit: trySubmit,
                  validator: (String value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'Password must be at least 7 characters long.';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () => trySubmit(),
                  child: Text("Sign in"),
                )
              ],
            ),
          ),
        )
      ],
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
  //Function submitForm,
  TextInputType keyboardType = TextInputType.text,
  bool isPassword = false,
  bool isLast = false,
}) {
  return Container(
    width: size.width * .9,
    padding: const EdgeInsets.only(bottom: 15.0),
    child: Material(
      borderRadius: BorderRadius.circular(25),
      elevation: 6,
      child: TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 12, right: 12),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: InputBorder.none,
            icon: Padding(padding: EdgeInsets.only(left: 20), child: icon),
            hintText: labelText,
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
