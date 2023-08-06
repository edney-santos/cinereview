import 'package:cinereview/components/block_button.dart';
import 'package:cinereview/components/custom_form_field.dart';
import 'package:cinereview/styles/colors.dart';
import 'package:cinereview/styles/text.dart';
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

  login() {

  }

  register() {

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
                  Text(tittle, style: ProjectText.tittle),
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
                          return 'Informe o e-mail corretamente';
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
                        } else if (value.length < 6) {
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
                    Container(height: 140),
                    BlockButton(
                      label: actionButton,
                      onPressed: () => {
                        if (formKey.currentState!.validate()) {
                          if (isLogin) {
                            login()
                          } else {
                            register()
                          }
                        }
                      },
                    ),
                    Container(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => setFormAction(!isLogin),
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
