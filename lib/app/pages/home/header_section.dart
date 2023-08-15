import 'package:cinereview/app/components/custom_form_field.dart';
import 'package:cinereview/app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  final search = TextEditingController();

  goToSearch() {
    Navigator.pushNamed(context, '/search');
  }

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
            onChanged: (String a) {},
            onTap: () {
              goToSearch();
            },
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
