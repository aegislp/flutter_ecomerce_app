import 'package:flutter/material.dart';

class SlideLeftBackgroundWidget extends StatelessWidget {

  final Color color;
  final IconData icon;

  SlideLeftBackgroundWidget({this.color, this.icon});
  
  @override
  Widget build(BuildContext context) {
    return Container(
    color: this.color,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          
          Icon(
            this.icon,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
           
        ],
      ),
      alignment: Alignment.centerRight,
    ),
  );
  }
}