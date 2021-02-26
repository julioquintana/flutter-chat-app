import 'package:chat_app/helpers/show_alert.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/pages/user_page.dart';
import 'package:chat_app/providers/AuthProvider.dart';
import 'package:chat_app/widget/button_blue.dart';
import 'package:chat_app/widget/custom_input.dart';
import 'package:chat_app/widget/label_login_widget.dart';
import 'package:chat_app/widget/logo_login_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static const String ROUTE = 'login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * .9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LogoLoginWidget(
                    title: 'Messenger',
                  ),
                  _Form(),
                  LabelLoginWidget(
                    question: '¿No tienes cuenta?',
                    textAction: 'Crea una ahora!',
                    route: RegisterPage.ROUTE,
                  ),
                  Text(
                    'Terminos y condiciones de uso',
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.alternate_email_outlined,
            placeHolder: 'Mail',
            keyboardType: TextInputType.emailAddress,
            textEditingController: emailController,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeHolder: 'Password',
            textEditingController: passController,
            isPassword: true,
          ),
          ButtonBlue(
            onTabFunction: authProvider.authenticating
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final isAuthenticated = await authProvider.login(
                        emailController.text, passController.text);
                    if (isAuthenticated) {
                      Navigator.pushReplacementNamed(context, UserPage.ROUTE);
                    } else {
                      showAlert(context, 'Login Incorrecto',
                          'Revise sus credenciales e intente  nuevamente');
                    }
                  },
            texto: 'Ingrese',
          ),
        ],
      ),
    );
  }
}
