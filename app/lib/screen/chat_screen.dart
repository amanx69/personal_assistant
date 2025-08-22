import 'package:app/helper/fonts.dart';
import 'package:app/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
     var  box = Hive.box<ChatModel>('chats').listenable();

  @override
  // void initState() {
  //   super.initState();
  //   chatBox = Hive.box<ChatModel>('chats');
  // }

  // // void _sendMessage(String text) {
  //   if (text.isEmpty) return;

  //   // Save user message
  //   chatBox.add(ChatModel(
  //     sender: "user",
  //     message: text,
  //     time: DateTime.now(),
  //   ));

  //   // Save bot reply (dummy for now)
  //   chatBox.add(ChatModel(
  //     sender: "bot",
  //     message: "You said: $text",
  //     time: DateTime.now(),
  //   ));

  //   _controller.clear();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.black, //! black  colors  
      appBar: AppBar(title:  Text("History",style: CustomFonts.title,),
      centerTitle: true,
        automaticallyImplyLeading: false,
      
      backgroundColor: Colors.black,),
      body: Column(
        children: [
     
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: box,
              builder: (context, Box<ChatModel> box, _) {
                var messages = box.values.toList();

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var msg = messages[index];
                           
                       

                    return ListTile(
                      title: Text("q:=>${msg.oredr.toString()}" ,style:GoogleFonts.inter(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.blue),),
                      subtitle: Text("Ans>${msg.answer.toString()}",style: CustomFonts.ui,),
                    );
                  },
                );
              },
            ),
          ),

 
      
        ],
      ),
    );
  }
}
