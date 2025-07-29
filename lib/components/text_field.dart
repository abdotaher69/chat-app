import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
   TextFieldWidget({super.key,this.hintText,this.onChanged,this.issecure = false});
  String? hintText;
  Function(String)? onChanged;
  bool issecure ;

  @override
  Widget  build(BuildContext context) {
    return TextFormField(
      obscureText:issecure,
      validator: (value){
        if(value!.isEmpty){
          return "Field can't be empty";
        }
      },
          onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white,width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white,width: 3),
          ),
        )
    );
  }
}
