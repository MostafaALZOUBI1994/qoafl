import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

import '../../constants.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool passfield;

  const TextFieldWidget({Key key, this.controller,this.hint, this.passfield}) : super(key: key);
  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return  Container(height: ScreenUtil().setHeight(44),
      child: TextField(
obscureText: widget.passfield,
controller: widget.controller,
        decoration: InputDecoration(fillColor: Colors.white,hintText: widget.hint,hintStyle:TextStyle(fontSize: ScreenUtil().setSp(8),color: grey) ,filled: true,border: new OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),borderSide: new BorderSide(
            width: 0.1,color: grey
        )
        )),
      ),
    );
  }
}
