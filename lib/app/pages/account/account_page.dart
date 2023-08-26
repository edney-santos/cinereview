import 'package:cinereview/app/components/block_button.dart';
import 'package:cinereview/app/components/custom_form_field.dart';
import 'package:cinereview/app/components/genres_dropdown.dart';
import 'package:cinereview/app/components/nav_bar.dart';
import 'package:cinereview/app/data/genres_list.dart';
import 'package:cinereview/app/data/models/info_model.dart';
import 'package:cinereview/app/data/repositories/users_repository.dart';
import 'package:cinereview/app/services/auth_service.dart';
import 'package:cinereview/app/styles/colors.dart';
import 'package:cinereview/app/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  TextEditingController name = TextEditingController();
  String favGenre = GenresList.menuItens[0].id.toString();
  bool isFormChanged = false;
  UsersInfo userInfo = UsersInfo(name: '', favGenre: '');

  void updateInfo() async {
    if (name.text != userInfo.name || favGenre != userInfo.favGenre) {
      await UsersRepository(auth: context.read<AuthService>()).saveInfo(
        UsersInfo(name: name.text, favGenre: favGenre),
      );
      showSnack('Informações atualizadas com sucesso!', false);
    } else {
      showSnack('As informações não foram alteradas', true);
    }
    getInfo();
  }

  void showSnack(String message, bool erro) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: erro ? ProjectColors.pink : Colors.green[800],
      ),
    );
  }

  void logout() async {
    await context.read<AuthService>().logout();
    authCheck();
  }

  void authCheck() {
    Navigator.pushNamed(context, '/');
  }

  void getInfo() async {
    userInfo = (await UsersRepository(
      auth: context.read<AuthService>(),
    ).readInfo())!;
    setState(() {
      name.text = userInfo.name;
      favGenre = userInfo.favGenre;
    });
  }

  void goToHome() {
    Navigator.popAndPushNamed(context, '/home');
  }

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, top: 64, right: 24),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: goToHome,
                    icon: const Icon(PhosphorIcons.arrow_left, size: 32),
                  ),
                  Container(width: 12),
                  const Text('Sua conta', style: ProjectText.tittle)
                ],
              ),
              Container(height: 32),
              CustomFormField(
                controller: name,
                label: 'Nome de usuário',
                color: ProjectColors.orange,
                keyType: TextInputType.text,
                obscureText: false,
                placeholder: '',
                onChanged: (String a) {},
              ),
              Container(height: 16),
              GenresDropdown(
                label: 'Gênero favorito',
                onChange: (value) {
                  setState(() {
                    favGenre = value!.toString();
                  });
                },
                selected: favGenre,
              ),
              Container(height: 32),
              BlockButton(
                label: 'Salvar informações',
                onPressed: updateInfo,
              ),
              Container(height: 260),
              OutlinedButton(
                onPressed: logout,
                style: ButtonStyle(
                  side: MaterialStateProperty.resolveWith<BorderSide>(
                    (states) {
                      return const BorderSide(
                        color: ProjectColors.orange,
                        width: 1.5,
                      );
                    },
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 56,
                  child: const Text(
                    'Sair',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: ProjectColors.orange,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(context, 3),
    );
  }
}
