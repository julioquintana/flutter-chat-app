import 'package:chat_app/helpers/show_alert.dart';
import 'package:chat_app/pages/chat_list_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/providers/AuthProvider.dart';
import 'package:chat_app/widget/button_blue.dart';
import 'package:chat_app/widget/custom_input.dart';
import 'package:chat_app/widget/label_login_widget.dart';
import 'package:chat_app/widget/logo_login_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  static const String ROUTE = 'register';

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
                    title: "Register",
                  ),
                  _Form(),
                  LabelLoginWidget(
                    question: '¿Ya tienes cuenta?',
                    textAction: 'Ingresa ahora!',
                    route: LoginPage.ROUTE,
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
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.perm_identity,
            placeHolder: 'Name',
            textEditingController: nameController,
          ),
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
                    final isProcessed = await authProvider.register(
                        nameController.text,
                        emailController.text,
                        passController.text);
                    if (isProcessed) {
                      Navigator.pushReplacementNamed(
                          context, ChatListPage.ROUTE);
                    } else {
                      showAlert(
                          context,
                          'Error',
                          authProvider.errorResponse.errors
                              .map((e) => '${e.msg}')
                              .join('\n'));
                    }
                  },
            texto: 'Ingrese',
          ),
        ],
      ),
    );
  }
}
