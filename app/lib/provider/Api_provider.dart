import 'dart:convert';
import 'dart:developer';
import 'package:app/model/chat_model.dart';
import 'package:app/provider/home_screen_provide.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class commands with ChangeNotifier {
  var prov = HomeProvide(); //! impoet  of  text  to speak

  String result = "";
  var chatBox = Hive.box<ChatModel>('chats');



  /// Search the given text with the AI server and store the result in the local database.
  ///
  /// This function takes a text and a BuildContext as parameters. It sends an HTTP GET
  /// request to the AI server with the given text and waits for the response. If the
  /// response is successful, it decodes the JSON response and stores the answer in the
  /// `result` variable. It then calls the `textToSpeak` method of the `HomeProvide`
  /// instance to speak the result. If the response is not successful, it sets the
  /// `result` variable to an error message and logs the error.
  ///
  /// After the request is completed, it notifies all listeners of the `ChangeNotifier`
  /// that the state has changed.
  ///
  /// It also stores the given text and the result in the local database if the result
  /// is not empty and the text is not empty.
  ///
  /// Finally, it prints all the data in the local database to the console for debugging
  /// purposes.
  ///
  /// [text] is the text to search on the AI server.
  /// [context] is the BuildContext of the widget that calls this function.
  void Searchwithai(String text, BuildContext context) async {
    final prov = Provider.of<HomeProvide>(context, listen: false);
     

    try {
      final url = Uri.parse("http://10.89.189.251:8000/ai?text=$text");
      final resposce = await http.get(url);

      if (resposce.statusCode == 200) {
        var data = jsonDecode(resposce.body);
        result = data["answer"];
        prov.textToSpeak(result); //! text to speech 
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      result = "Error: $e";
      log(e.toString());
    }
    notifyListeners();

 //! store the data  in  local 
 
      if(result !=""&& result.isNotEmpty && text.isNotEmpty){
         chatBox.add(ChatModel(
         oredr: text,
           answer: result,
           time: DateTime.now(),
            ));
        
      }

             //! print the data
            for(var msg in chatBox.values){
              log(msg.oredr.toString());
              log(msg.answer.toString());
              log(msg.time.toString());

        
            }
   

  }

   //! function  of  search ikipedia

    /// Search wikipedia with given text
    ///
    /// This function is used to search wikipedia with given text
    ///
    /// It will return a string of the search result
    ///
    /// [text] is the text to search on wikipedia
    ///
    /// Example:
    /// 
    void searchwikiPidea(String text,BuildContext context)async{
         try{
       
       final Wikiurl= Uri.parse("http://10.89.189.251:8000/research?text=$text");
        
        final response= await http.get(Wikiurl);

        if(response.statusCode==200){
            
            var data= jsonDecode(response.body);
            var Wikiresult= data["wikianswer"];
            //! speak the result
              prov.textToSpeak(Wikiresult);//! text to  speech 
        }else{
           
            throw Exception("Failed to load data");
        }
    }
    catch(e){
       
        log(e.toString());
    }
    }

    //! function  for open  web appliction \

  /// Open a web application with the given text
  ///
  /// This function will make a GET request to the following url:
  /// [http://10.217.101.251:8000/openweb?text=$text]
  ///
  /// It does not return anything, but will throw an exception if the
  /// request is not successful.
  ///
  /// [text] is the text to open on web application
  ///
  /// Example:
  /// 
  ///
       void  openewb(String  text )async{

          try{
              final  url= Uri.parse("http://10.89.189.251:8000/openweb?text=$text");
               await http.get(url);
          }catch(e){
              log(e.toString());
          }
        

      
       }

       
  /// Open a windows application with the given text
  ///
  /// This function will make a GET request to the following url:
  /// [http://10.217.101.251:8000/openappliction?text=$text]
  ///
  /// It does not return anything, but will log an error if the
  /// request is not successful.
  ///
  /// [text] is the text to open on windows application
  ///
        void openappliction(String text){
           
           try{
            
               final  url = Uri.parse("http://10.89.189.251:8000/openappliction?text=$text");
               http.get(url);
             
           }catch(e){
             
              log(e.toString());
           }
           
            
        }

    


}
