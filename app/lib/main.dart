

import 'package:app/model/chat_model.dart';
import 'package:app/provider/Api_provider.dart';
import 'package:app/provider/apiroute.dart';
import 'package:app/provider/home_screen_provide.dart';
import 'package:app/screen/entery_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main( ) async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ChatModelAdapter()); //! rejester th  model of  chat

  await Hive.openBox<ChatModel>('chats');

  runApp(

    //! all provider  list  
    MultiProvider(

      providers: [
           ChangeNotifierProvider(create: (_) => HomeProvide()),
           ChangeNotifierProvider(create: (_)  => commands()),
           ChangeNotifierProvider(create: (_)  => VoiceAssistant()),

          
      ],

      child: MyApp(),
    )
    
    
    
     
     );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1280, 720), // base size (Figma/XD design size)
      minTextAdapt: true,               // <--- this avoids your error
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home:EnteryScreen(),
        );
      },
    );
  }
}
