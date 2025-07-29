import 'package:charapp/components/chat_bundle.dart';
import 'package:charapp/components/chat_bundle_frind.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message.dart';

class ChatScreen extends StatefulWidget {
   ChatScreen({super.key});
static String id = 'chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
   CollectionReference messages1 = FirebaseFirestore.instance.collection(kMessageCollection);

  TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
    stream: messages1.orderBy('created_at').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        List<Message> messageslist=[];
        for(var message in snapshot.data!.docs){
          messageslist.add(Message.fromJson(message));
        }


          return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/scholar.png",height: 50,),
            Text(" Scholar Chat"),
          ],
        ),

      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(

                controller: _scrollController,
                itemCount: messageslist.length,
                itemBuilder: (context,i){
              return messageslist[i].id == email?ChatBundle(message: messageslist[i].message):ChatBundleFrind(message: messageslist[i].message);
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50,left: 10,right: 10,top: 10),
            child: TextField(
                controller: controller,

                onSubmitted: (value){
                  messages1.add({
                    'message':value,
                    'created_at':DateTime.now(),
                    'id':email,


                  });
                  controller.clear();
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: Duration(seconds: 1),
                    curve: Curves.easeOut,
                  );
                },


                decoration: InputDecoration(
                    hintText: "Type a message",
                    hintStyle: TextStyle(color: kPrimaryColor),
                    suffix: Icon(Icons.send,color: kPrimaryColor,),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: kPrimaryColor,width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.blue,width: 2),

                    )
                )

            ),
          ),
        ],
      ),


    );
      }else if(snapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(),);
      }else{
        return Center(child: Text("Something went wrong"));
      }

    }

    ); ;
  }
}
