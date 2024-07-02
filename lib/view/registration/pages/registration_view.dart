import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../config/constants.dart';
import 'package:animate_do/animate_do.dart';
import '../../../view_model/firebase_utils.dart';
import 'package:weather/config/extenions/padding.dart';
import '../../../config/widgets/custom_form_field.dart';
import 'package:weather/view/login/pages/login_view.dart';
import '../../../config/widgets/border_rounded_button.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    return Scaffold(
      backgroundColor: Color(0xFF0085FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInDown(
                delay: Duration(milliseconds: 50),
                child: Text("Sign Up",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 30))
                    .setOnlyPadding(context, 0, 25, 0, 0,
                        enableMediaQuery: false),
              ),
              FadeInUp(
                delay: Duration(milliseconds: 120),
                child: Text("E-mail Address",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 20)),
              ),
              SizedBox(
                height: 10,
              ),
              FadeInUp(
                delay: Duration(milliseconds: 130),
                child: CustomTextField(
                  controller: emailController,
                  hint: "enter your e-mail address",
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  onValidate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "you must enter E-mail";
                    }

                    var regex = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                    if (!regex.hasMatch(value)) {
                      return "invalid Email";
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FadeInUp(
                delay: Duration(milliseconds: 140),
                child: Text("Password",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 20)),
              ),
              SizedBox(
                height: 10,
              ),
              FadeInUp(
                delay: Duration(milliseconds: 150),
                child: CustomTextField(
                  controller: passwordController,
                  hint: "enter your password",
                  maxLines: 1,
                  isPassword: true,
                  onValidate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "you must enter your password !";
                    }

                    var regex = RegExp(
                        r"(?=^.{8,}$)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$");

                    if (!regex.hasMatch(value)) {
                      return "The password must include at least \n* one lowercase letter, \n* one uppercase letter, \n* one digit, \n* one special character,\n* at least 6 characters long.";
                    }

                    return null;
                  },
                ),
              ),
              FadeInLeft(
                delay: Duration(milliseconds: 160),
                child: BorderRoundedButton(
                  title: "Sign up",
                  color: Constants.theme.primaryColor,
                  fontSize: 20,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FirebaseUtils()
                          .createAccount(
                              emailController.text, passwordController.text)
                          .then((value) {
                        if (value == true) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginView(),
                              ),
                              (route) => false);
                        }
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('This email is used '),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      });
                    }
                  },
                ).setVerticalPadding(context, 0.095),
              ),
            ],
          ).setHorizontalPadding(context, 20, enableMediaQuery: false),
        ),
      ),
    );
  }
}
