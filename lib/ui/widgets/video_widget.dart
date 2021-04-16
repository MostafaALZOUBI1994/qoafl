import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:qawafel/models/product.dart';


class VideoWidget extends StatefulWidget {
  final String link;

  const VideoWidget({Key key, this.link}) : super(key: key);


  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  String link;
  @override
  void initState() {
    link=widget.link;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("No videos"));
  }
}