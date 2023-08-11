import 'package:cinereview/app/components/block_button.dart';
import 'package:cinereview/app/components/nav_bar.dart';
import 'package:cinereview/app/services/auth_service.dart';
import 'package:cinereview/app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  logout() async {
    await context.read<AuthService>().logout();
    authCheck();
  }

  authCheck() {
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.background,
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            Center(
              child: BlockButton(
                label: 'Sair',
                onPressed: () => {logout()},
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: NavBar(context, 3),
    );
  }
}
