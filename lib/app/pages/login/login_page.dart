import 'package:cinereview/app/components/block_button.dart';
import 'package:cinereview/app/components/custom_form_field.dart';
import 'package:cinereview/app/services/auth_service.dart';
import 'package:cinereview/app/styles/colors.dart';
import 'package:cinereview/app/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  login() async {
    try {
      await context.read<AuthService>().login(email.text, password.text);
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
    }
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
              const Row(
                children: [
                  Text('Login', style: ProjectText.tittle),
                ],
              ),
              Container(height: 32),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomFormField(
                      controller: email,
                      label: 'E-mail',
                      placeholder: 'exemplo@gmail.com',
                      color: ProjectColors.orange,
                      keyType: TextInputType.emailAddress,
                      obscureText: false,
                      validators: (value) {
                        if (value!.isEmpty) {
                          return 'Informe um e-mail';
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'E-mail invalido';
                        }
                        return null;
                      },
                    ),
                    Container(height: 16),
                    CustomFormField(
                      controller: password,
                      label: 'Senha',
                      placeholder: '************',
                      color: ProjectColors.orange,
                      keyType: TextInputType.text,
                      obscureText: true,
                      validators: (value) {
                        if (value!.isEmpty) {
                          return 'Informe sua senha';
                        }
                        if (value.length < 6) {
                          return 'A senha deve ter ao menos 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    Container(height: 16),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Esqueceu a senha?', style: ProjectText.bold),
                      ],
                    ),
                    Container(height: 100),
                    BlockButton(
                      label: 'Entrar',
                      onPressed: () => {
                        if (formKey.currentState!.validate()) {login()}
                      },
                    ),
                    Container(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pushNamed(
                            context,
                            '/register',
                          ),
                          child: const Row(
                            children: [
                              Text(
                                'Ainda não possui conta? ',
                                style: ProjectText.regular,
                              ),
                              Text(
                                'Cadastre-se!',
                                style: ProjectText.boldUnderline,
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
