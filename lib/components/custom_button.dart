import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({super.key, required this.text,this.ontap});
    String text;
   VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 50,
        child: Center(child: Text(text,style: TextStyle(color: Colors.black,fontSize:24))),
      ),
    );
  }
}
