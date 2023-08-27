import 'package:cinereview/app/components/block_button.dart';
import 'package:cinereview/app/components/custom_outlined_button.dart';
import 'package:cinereview/app/data/models/movie_model.dart';
import 'package:cinereview/app/data/repositories/reviews_repository.dart';
import 'package:cinereview/app/data/repositories/users_repository.dart';
import 'package:cinereview/app/styles/colors.dart';
import 'package:cinereview/app/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:provider/provider.dart';

class AddReviewDialog extends StatefulWidget {
  final MovieModel movie;

  const AddReviewDialog({super.key, required this.movie});

  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  double _currentValue = 0;
  late String username;
  final TextEditingController _review = TextEditingController();
  late ReviewsRepository reviewsRepository;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    username = Provider.of<UsersRepository>(context).userInfo.name;
    reviewsRepository = Provider.of<ReviewsRepository>(context);
  }

  Future<void> addReview() async {
    try {
      await reviewsRepository.addReviews(
          widget.movie, username, _currentValue, _review.text);
      showSnack('Review adicionado com sucesso', false);
      closeDialog();
    } catch (e) {
      showSnack('Não foi possível adiciona o review', true);
      closeDialog();
    }
  }

  void showSnack(String message, bool erro) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: erro ? ProjectColors.pink : Colors.green[800],
      ),
    );
  }

  void closeDialog() {
    Navigator.of(context).pop();
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
              closeDialog();
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
                      onPressed: () {
                        addReview();
                      },
                    ),
                    Container(height: 16),
                    CustomOutlinedButton(
                      onPressed: () {
                        closeDialog();
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
