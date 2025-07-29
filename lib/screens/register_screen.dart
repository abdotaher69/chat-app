import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/custom_button.dart';
import '../components/text_field.dart';
import '../constants/Constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'chat_screen.dart';

class RegisterScreen extends StatefulWidget {
   RegisterScreen({super.key});
  static String id = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall:showSpinner ,
      child: Scaffold(
          backgroundColor: kPrimaryColor,

          body:Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
             child: Form(
               key: formKey,
               child: ListView(children: [
                    Image.asset("assets/images/scholar.png",height: 100,),
                    Align(
                        alignment: Alignment.center,
                        child: Text("Scholar chat",style: TextStyle(color: Colors.white,fontSize:30,fontFamily: 'pacifico'))),

                 SizedBox(height: 100,),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text("REGISTER",style: TextStyle(color: Colors.white,fontSize:24))),
                    TextFieldWidget(hintText: "Email",
                    onChanged: (value){
                      email = value;
                    }),
                    SizedBox(height: 20,),
                    TextFieldWidget(hintText: " password ",issecure: true,
                        onChanged: (value){
                          password = value;
                        }),
                    SizedBox(height: 20,),
                    CustomButton(text: "Register",
                    ontap: ()async{
                      if(formKey.currentState!.validate()){
                        showSpinner = true;
                        setState(() {});
                        try{
                          await register();
                          Navigator.pushNamed(context, ChatScreen.id,arguments: email);
                        }on FirebaseAuthException catch(e){
                          if (e.code == 'weak-password') {
                            shoeSnakBar(context,"Weak password");
                          } else if (e.code == 'email-already-in-use') {
                            shoeSnakBar(context,"Email already in use");
                          }else{
                            shoeSnakBar(context,"Something went wrong");
                          }
                        }catch(e){
                          shoeSnakBar(context,"Something went wrong");
                        }
                        showSpinner = false;
                        setState(() {});

                      }


                    }),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("already have an account?",style: TextStyle(color: Colors.white),),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Text("   Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                      ],),
                  ]),
             ),

            ),
          )

      ),
    );
  }

  void shoeSnakBar(BuildContext context,String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message,style: TextStyle(fontSize: 20),),));
  }

  Future<void> register() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!);
  }
}
