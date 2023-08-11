import 'package:cinereview/app/components/block_button.dart';
import 'package:cinereview/app/components/custom_form_field.dart';
import 'package:cinereview/app/components/genres_dropdown.dart';
import 'package:cinereview/app/data/genres_list.dart';
import 'package:cinereview/app/data/models/info_model.dart';
import 'package:cinereview/app/data/repositories/users_repository.dart';
import 'package:cinereview/app/services/auth_service.dart';
import 'package:cinereview/app/styles/colors.dart';
import 'package:cinereview/app/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  String favGenre = GenresList.menuItens[0].id.toString();

  register() async {
    try {
      await context.read<AuthService>().register(email.text, password.text);
      await saveInfo();
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
    }
  }

  saveInfo() async {
    await UsersRepository(auth: context.read<AuthService>()).saveInfo(
      UsersInfo(name: name.text, favGenre: favGenre),
    );
    authCheck();
  }

  authCheck() {
    Navigator.pushNamed(context, '/');
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
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/login',
                    ),
                    icon: const Icon(
                      PhosphorIcons.arrow_left,
                      size: 32,
                    ),
                  ),
                  Container(width: 12),
                  const Text('Cadastro', style: ProjectText.tittle),
                ],
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(height: 32),
                    CustomFormField(
                      controller: name,
                      label: 'Nome',
                      color: ProjectColors.orange,
                      keyType: TextInputType.name,
                      obscureText: false,
                      placeholder: 'Nome e sobrenome',
                      validators: (value) {
                        if (value!.isEmpty) {
                          return 'Informe seu nome';
                        } else if (value.length < 5) {
                          return 'Nome deve ter ao menos 5 caracteres';
                        }
                        return null;
                      },
                    ),
                    Container(height: 16),
                    CustomFormField(
                        controller: email,
                        label: 'E-mail',
                        color: ProjectColors.orange,
                        keyType: TextInputType.emailAddress,
                        obscureText: false,
                        placeholder: 'exemplo@gmail.com',
                        validators: (value) {
                          if (value!.isEmpty) {
                            return 'Informe o e-mail';
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'E-mail invalido';
                          }
                          return null;
                        }),
                    Container(height: 16),
                    CustomFormField(
                      controller: password,
                      label: 'Senha',
                      color: ProjectColors.orange,
                      keyType: TextInputType.text,
                      obscureText: true,
                      placeholder: '************',
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
                    GenresDropdown(
                      label: 'Qual seu gênero de filme favorito?',
                      selected: favGenre,
                      onChange: (String? value) {
                        setState(() {
                          favGenre = value!;
                        });
                      },
                    ),
                    Container(height: 120),
                    BlockButton(
                      label: 'Cadastrar-se',
                      onPressed: () => {
                        if (formKey.currentState!.validate()) {register()}
                      },
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
