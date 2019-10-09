import 'package:flutter/material.dart';
import 'package:tanken/src/models/api_sort.dart';

Future<SortOption> asyncSimpleDialog(BuildContext context) async {
  return await showDialog<SortOption>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select Sort Order:'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, SortPrice()),
              child: Text(SortPrice().sortName),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, SortDistance()),
              child: Text(SortDistance().sortName),
            ),
          ],
        );
      });
}
