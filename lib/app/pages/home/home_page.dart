import 'package:cinereview/app/components/block_button.dart';
import 'package:cinereview/app/components/nav_bar.dart';
import 'package:cinereview/app/services/auth_service.dart';
import 'package:cinereview/app/styles/colors.dart';
import 'package:cinereview/app/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  logout() async {
    await context.read<AuthService>().logout();
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
              const Text(
                'Homepage',
                style: ProjectText.tittle,
              ),
              BlockButton(
                label: 'Sair',
                onPressed: () => {logout()},
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(context, 0),
    );
  }
}
