import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista/data/theme.dart';
import 'package:lista/models/categories_data.dart';
import 'package:lista/models/category.dart';
import 'package:provider/provider.dart';

class CatigorySelector extends StatefulWidget {
  CatigorySelector({super.key, required this.category});
  String category;

  @override
  State<CatigorySelector> createState() => _CatigorySelectorState();
}

class _CatigorySelectorState extends State<CatigorySelector> {

  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.textColorLowEmphacy),
      ),
      child: ChangeNotifierProvider(
        create: (context) => CategoriesData(),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            buttonDecoration:
                BoxDecoration(borderRadius: BorderRadius.circular(15)),
            items: Provider.of<CategoriesData>(context)
                .categories
                .map(buildMenuItem)
                .toList(),
            customButton: Row(
              children: [
                Icon(
                  CupertinoIcons.largecircle_fill_circle,
                  color: widget.category != ''
                      ? catColors[widget.category]
                      : Colors.blue,
                ),
                Text(
                  widget.category != '' ? ' ${widget.category}' : ' category',
                  style: TextStyle(
                    color: widget.category != ''
                        ? catColors[widget.category]
                        : Colors.blue,
                  ),
                ),
              ],
            ),
            onChanged: (value) {
              setState(() {
                print('${widget.category}');

                widget.category = value!;
                Provider.of<CategoriesData>(context, listen: false)
                    .setColor(catColors[widget.category]!);

                print('${widget.category}');
              });
            },
            itemHeight: 48,
            itemPadding: const EdgeInsets.only(left: 16, right: 16),
            dropdownWidth: 100,
            dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: widget.category != ''
                  ? catColors[widget.category]
                  : Colors.blue,
            ),
            dropdownElevation: 8,
            offset: const Offset(0, 8),
          ),
        ),
      ),
    );
  }
}

DropdownMenuItem<String> buildMenuItem(Category category) {
  return DropdownMenuItem(
      value: category.category,
      child: Text(
        category.category,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ));
}
