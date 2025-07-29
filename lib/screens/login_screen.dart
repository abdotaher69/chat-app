import 'package:charapp/components/text_field.dart';
import 'package:charapp/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/custom_button.dart';
import '../constants/Constants.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  String? email;
  String? password;

   GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                    child: Text("LOGIN",style: TextStyle(color: Colors.white,fontSize:24))),
                 TextFieldWidget(hintText: "Email",
                 onChanged: (value){
                   email = value;
                 }),
                SizedBox(height: 20,),
                TextFieldWidget(hintText: " password ",issecure: true,
                onChanged: (value){
                  password = value;
                }
                ),
                SizedBox(height: 20,),
                CustomButton(text: "Login",
                    ontap: ()async{
                      if(formKey.currentState!.validate()){
                        showSpinner = true;
                        setState(() {});
                        try{
                          await login();
                          Navigator.pushNamed(context, ChatScreen.id,arguments: email);
                         }on FirebaseAuthException catch(e){
                          if (e.code == 'user-not-found') {
                            shoeSnakBar(context,"user not found");
                          } else if (e.code == 'wrong-password') {
                            shoeSnakBar(context,"wrong password");
                          }else{
                            shoeSnakBar(context,e.message.toString());
                            print(e.message);
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
                  Text("Dont have an account?",style: TextStyle(color: Colors.white),),
                  InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, RegisterScreen.id);
                      },
                      child: Text("   Register",
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                ],),
              ],),
            ),
          ),
        )

      ),
    );
  }

   void shoeSnakBar(BuildContext context,String message) {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message,style: TextStyle(fontSize: 20),),));
   }

   Future<void> login() async {
     var auth = FirebaseAuth.instance;
     UserCredential user = await auth.signInWithEmailAndPassword(
         email: email!,
         password: password!);
   }
}
