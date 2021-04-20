


import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void showSnackBar(BuildContext context,String message) {
  showTopSnackBar(
    context,
    CustomSnackBar.success(backgroundColor: Theme.of(context).primaryColor,iconRotationAngle: 0,icon: Icon(Icons.eighteen_mp,color: Colors.transparent,),
      message:
      message,
    ),
  );
}
void showToast(BuildContext context,String messege) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content:  Text(messege.toString()),
    ),
  );
}