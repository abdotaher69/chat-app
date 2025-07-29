import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/Constants.dart';

class ChatBundleFrind extends StatelessWidget {
  ChatBundleFrind({super.key,required this.message});
  String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          padding: EdgeInsets.only(left: 10,top: 32,right: 32,bottom: 32),


          margin: EdgeInsets.all(8),
          child: Text(message,
            style:
            TextStyle(color: Colors.white,fontSize: 20),),
          decoration: BoxDecoration(
            color: Color(0xff006d84),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32)
                ,bottomLeft: Radius.circular(32)),

          )
      ),
    );
  }
}
