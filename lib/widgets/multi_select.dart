import 'package:flutter/material.dart';

class MultiSelect extends StatefulWidget {
  final List<String> items;
  final String? title;
  MultiSelect({Key? key, required this.items, this.title}) : super(key: key);

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  final List<String> _selectedItems = [];

  void _itemChange(String itemVal, bool isChecked) {
    setState(() {
      (isChecked)
          ? _selectedItems.add(itemVal)
          : _selectedItems.remove(itemVal);
    });
  }

  void _cancel() => Navigator.pop(context);
  void _submit() {
    print(_selectedItems);
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(widget.title ?? "Select Items"),
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.items
                .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!)))
                .toList(),
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: _cancel, child: Text('Cancel')),
        TextButton(onPressed: _submit, child: Text('Submit'))
      ],
    );
  }
}
