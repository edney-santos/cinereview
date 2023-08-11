import 'package:cinereview/app/components/custom_form_field.dart';
import 'package:cinereview/app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderSection extends StatelessWidget {
  final search = TextEditingController();

  HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SvgPicture.asset('assets/images/short_logo.svg', height: 58),
        Container(width: 12),
        Flexible(
          child: CustomFormField(
            controller: search,
            label: '',
            color: ProjectColors.orange,
            keyType: TextInputType.text,
            obscureText: false,
            placeholder: 'Pesquise pelo nome do filme',
          ),
        ),
      ],
    );
  }
}
