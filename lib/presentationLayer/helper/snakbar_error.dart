import 'package:flutter/material.dart';

void showCustomErrorSnackbar({
  required BuildContext context,
  required String? message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(Icons.error, color: Colors.white),
          SizedBox(width: 8),
          Expanded(
            child: Text(message ?? '', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.fromLTRB(15, 60, 15, 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      duration: Duration(seconds: 4),
      action: SnackBarAction(
        label: 'Ok',
        textColor: Colors.white,
        onPressed: () {},
      ),
    ),
  );
}
