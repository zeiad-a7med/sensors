import '../../home/home_screen.dart';
import 'package:flutter/material.dart';
import '../../../config/constants.dart';
import 'package:animate_do/animate_do.dart';
import '../../../view_model/firebase_utils.dart';
import 'package:weather/config/extenions/padding.dart';
import '../../../config/widgets/custom_form_field.dart';
import '../../registration/pages/registration_view.dart';
import '../../../config/widgets/border_rounded_button.dart';
// import 'package:flutter/cupertino.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF0085FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  // height: 90,
                  ),
              FadeInDown(
                delay: Duration(milliseconds: 50),
                child: Text("Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 30))
                    .setOnlyPadding(context, 0, 25, 0, 0,
                        enableMediaQuery: false),
              ),
              FadeInRight(
                  delay: Duration(milliseconds: 60),
                  child: Text("Welcome Back...",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 25))),
              FadeInRight(
                delay: Duration(milliseconds: 70),
                child: Text("Please sign in with your mail",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 18))
                    .setOnlyPadding(context, 0, 25, 0, 0,
                        enableMediaQuery: false),
              ),
              FadeInUp(
                delay: Duration(milliseconds: 80),
                child: Text("E-mail",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 15)),
              ),
              SizedBox(
                height: 15,
              ),
              FadeInUp(
                delay: Duration(milliseconds: 90),
                child: CustomTextField(
                  controller: emailController,
                  hint: "enter your e-mail",
                  keyboardType: TextInputType.emailAddress,
                  onValidate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "you must enter your E-mail";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 25,
              ),
              FadeInUp(
                delay: Duration(milliseconds: 100),
                child: Text("Password",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 15)),
              ),
              SizedBox(
                height: 15,
              ),
              FadeInUp(
                delay: Duration(milliseconds: 110),
                child: CustomTextField(
                  controller: passwordController,
                  hint: "enter your password",
                  maxLines: 1,
                  isPassword: true,
                  onValidate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "you must enter your password !";
                    }

                    // var regex = RegExp(
                    //     r"(?=^.{8,}$)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$");

                    // if (!regex.hasMatch(value)) {
                    //  return "The password must include at least \n* one lowercase letter, \n* one uppercase letter, \n* one digit, \n* one special character,\n* at least 6 characters long.";
                    // }
                    return null;
                  },
                ),
              ),
              FadeInUp(
                delay: Duration(milliseconds: 130),
                child: BorderRoundedButton(
                  title: "Login",
                  color: Constants.theme.primaryColor,
                  fontSize: 20,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FirebaseUtils()
                          .loginUser(
                              emailController.text, passwordController.text)
                          .then((value) {
                        if (value == true) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ));
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Opps'),
                                content: Text(
                                    'Please Check Your Email And Password'),
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
                        }
                      });
                    }
                  },
                ).setVerticalPadding(context, 0.1),
              ),
              FadeInRight(
                delay: Duration(milliseconds: 140),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationView(),
                      )),
                  child: Text("Don’t have an account? Create Account?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 15)),
                ),
              ),
            ],
          ).setHorizontalPadding(context, 20, enableMediaQuery: false),
        ),
      ),
    );
  }
}
