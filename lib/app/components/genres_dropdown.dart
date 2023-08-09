import 'package:cinereview/app/styles/colors.dart';
import 'package:cinereview/app/styles/text.dart';
import 'package:cinereview/app/utils/genres_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class GenresDropdown extends StatelessWidget {
  final String? selected;
  final String label;
  final Function(String?)? onChange;

  const GenresDropdown({
    super.key,
    required this.label,
    required this.onChange,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: ProjectText.label,
            ),
          ],
        ),
        Container(height: 4),
        Stack(
          children: [
            Container(
              height: 58,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.01),
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                border: Border.all(
                  color: Colors.white.withOpacity(0.55),
                  width: 1.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 4.0,
              ),
              child: DropdownButton(
                value: selected,
                icon: const Icon(PhosphorIcons.caret_down),
                isExpanded: true,
                underline: Container(),
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                style: ProjectText.bold,
                dropdownColor: ProjectColors.gray,
                items: GenresList.menuItems
                    .map<DropdownMenuItem<String>>(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      ),
                    )
                    .toList(),
                onChanged: onChange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
