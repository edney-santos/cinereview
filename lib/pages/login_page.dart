import 'package:cinereview/components/block_button.dart';
import 'package:cinereview/components/custom_form_field.dart';
import 'package:cinereview/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  bool isLogin = true;
  late String tittle;
  late String actionButton;
  late String toggleButton;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool action) {
    setState(() {
      isLogin = action;

      if (isLogin) {
        tittle = 'Login';
        actionButton = 'Entrar';
        toggleButton = 'Ainda não possui conta? Cadastre-se';
      } else {
        tittle = 'Cadastro';
        actionButton = 'Cadastrar-se';
        toggleButton = 'Já possuo conta';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.background,
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 100, left: 24, right: 24),
            child: Column(
              children: [
                SvgPicture.asset('assets/images/full_logo.svg'),
                Container(height: 120),
                Row(
                  children: [
                    Text(
                      tittle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
                Container(height: 32),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            'E-mail',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      Container(height: 4),
                      CustomFormField(
                        controller: email,
                        labelText: 'exemplo@gmail.com',
                        color: ProjectColors.orange,
                        keyType: TextInputType.emailAddress,
                        obscureText: false,
                      ),
                      Container(height: 16),
                      const Row(
                        children: [
                          Text(
                            'Senha',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      Container(height: 4),
                      CustomFormField(
                        controller: password,
                        labelText: '************',
                        color: ProjectColors.orange,
                        keyType: TextInputType.text,
                        obscureText: true,
                      ),
                      Container(height: 16),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Esqueceu a senha?',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Container(height: 140),
                      BlockButton(
                        label: 'Entrar',
                        onPressed: () => {},
                      ),
                      Container(height: 32),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ainda não possui conta? ',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Cadastre-se',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
