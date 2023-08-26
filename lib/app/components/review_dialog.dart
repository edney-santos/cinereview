import 'package:cinereview/app/components/block_button.dart';
import 'package:cinereview/app/components/custom_outlined_button.dart';
import 'package:cinereview/app/data/repositories/users_repository.dart';
import 'package:cinereview/app/styles/colors.dart';
import 'package:cinereview/app/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:provider/provider.dart';

class AddReviewDialog extends StatefulWidget {
  final int movieId;

  const AddReviewDialog({super.key, required this.movieId});

  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  double _currentValue = 0;
  late String username;
  final TextEditingController _review = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    username = Provider.of<UsersRepository>(context).userInfo.name;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ProjectColors.background,
      elevation: 0.0,
      alignment: Alignment.center,
      shadowColor: Colors.black,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Adicionar\nReview',
            style: ProjectText.tittle,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              PhosphorIcons.x,
              color: Colors.white,
              size: 32,
            ),
          )
        ],
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 334,
          child: Column(
            children: [
              Form(
                child: Column(
                  children: [
                    Container(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          PhosphorIcons.star_fill,
                          color: Colors.amber[600],
                        ),
                        Container(width: 8),
                        Text(
                          _currentValue.toStringAsFixed(1),
                          style: ProjectText.tittle,
                        ),
                      ],
                    ),
                    Slider(
                      activeColor: ProjectColors.orange,
                      value: _currentValue,
                      min: 0,
                      max: 10,
                      divisions: 100,
                      onChanged: (value) {
                        setState(() {
                          _currentValue = value;
                        });
                      },
                    ),
                    Container(height: 24),
                    TextField(
                      maxLength: 500,
                      maxLines: null,
                      controller: _review,
                      cursorColor: ProjectColors.orange,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.01),
                        labelText: 'Digite o seu review...',
                        labelStyle:
                            const TextStyle(color: ProjectColors.lightGray),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: ProjectColors.orange,
                            width: 1.0,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 16.0,
                        ),
                      ),
                    ),
                    Container(height: 96),
                    BlockButton(
                      label: 'Postar Review',
                      onPressed: () {},
                    ),
                    Container(height: 16),
                    CustomOutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      label: 'Cancelar',
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
