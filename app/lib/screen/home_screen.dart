import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app/helper/customMic.dart';
import 'package:app/helper/fonts.dart';
import 'package:app/model/chat_model.dart';
import 'package:app/provider/apiroute.dart';
import 'package:app/provider/home_screen_provide.dart';
import 'package:app/screen/chat_screen.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool isListening = false;
  TextEditingController search = TextEditingController();
  final FlutterTts flutterTts = FlutterTts(); //! TEXT TO SPEACH
  var  box = Hive.box<ChatModel>('chats').listenable();

   final mic= MicService();

  @override
  Widget build(BuildContext context) {
    //!  provider

    var provider = Provider.of<HomeProvide>(context);
    var calls=  Provider.of<VoiceAssistant>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), //! of  un focuse
      child: Scaffold(
        backgroundColor: Colors.black,

        appBar: AppBar(
          leading: Builder(
            builder:
                (context) => IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
          ),

          backgroundColor: Colors.black,
          title: Text("Ashu", style: CustomFonts.title),
          centerTitle: true,
        ),

        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (provider.isListening)
                Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        "Hello i am Ashu......",
                        textStyle: CustomFonts.ui,
                        speed: Duration(milliseconds: 70),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),

        //!  mic button
        floatingActionButton: AvatarGlow(
          animate: isListening ? true : false,
          glowColor: Colors.blue,
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            backgroundColor: Colors.blue,
            onPressed: () {
              if (provider.isListening) {
                provider.stopListening();
                isListening = false;
              } else {
                provider.listenAndSpeak(context);
                isListening = true;
              }
           
            },
            child: Icon(isListening ? Icons.mic : Icons.mic_off),
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

        drawer: Drawer(
          backgroundColor: Colors.black,

          child: Column(
        
            children: [
               DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    image: AssetImage("images/girl.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              
             child:null

              ),
            Expanded(
                child: ValueListenableBuilder(
                valueListenable:box,
                builder: (context, Box<ChatModel> box, _) {
                  var messages = box.values.toList();
                
                  if (messages.isEmpty) {
                    return const Center(child: Text("No chat history yet"));
                  }
                
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var msg = messages[index];
                     
                      return ListTile(
                        
                        title: Text(msg.oredr.toString() ,style: CustomFonts.title,),

                        onTap: (){
                             
                          Navigator.push(context, CupertinoPageRoute(builder: (_)=> ChatScreen()));
                        },
                        
                        
                      );
                    },
                  );
                },
                            ),
              ),


                 
            ],
          ),
        ),
      ),
    );
  }
}
