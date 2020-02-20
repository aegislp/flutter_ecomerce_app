import 'package:flutter/material.dart';

class SlideRightBackgroundWidget extends StatelessWidget {

  final Color color;
  final IconData icon;

  SlideRightBackgroundWidget({this.color, this.icon});
  
  @override
  Widget build(BuildContext context) {
    return Container(
    color: this.color,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(
            this.icon,
            color: Colors.white,
          ),
           
        ],
      ),
      alignment: Alignment.centerLeft,
    ),
  );
  }
}