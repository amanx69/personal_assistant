import 'dart:developer';
import 'package:app/provider/Api_provider.dart';
import 'package:app/provider/apiroute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeProvide with ChangeNotifier {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _finaltext= "";


 
  //! Text-to-Speech
  /// Speaks the given text using the Text-to-Speech engine. The language
  /// is set to English (India), pitch to 1.0 and volume to 1.0. The
  /// method waits for the speech to complete.
  ///
  /// [text] The text to be spoken.
  Future<void> textToSpeak(String text) async {
    final flutterTts = FlutterTts();
    await flutterTts.setLanguage("en-IN");
    await flutterTts.setPitch(1.0);
    await flutterTts.setVolume(1.0);
    await flutterTts.awaitSpeakCompletion(true);

    await flutterTts.speak(text);
  }

  bool get isListening => _isListening;
  String get text => _finaltext;
  

  //! Stop microphone
  void stopListening() {
    _speech.stop();
    _isListening = false;
    notifyListeners();
  }

  //! Text-to-Speech
  Future<String> speak(String text  ,  BuildContext context) async {
    if (text.isNotEmpty) {
         text= text.toLowerCase();  //! add in final text for  show  in home page
          
      await textToSpeak(text);
    }
    return  text; //! return text for  voice assistence 
  }


  /// Listens for speech for 5 seconds and speaks the recognized text.
  ///
  /// If speech recognition is available, it starts listening for 5 seconds.
  /// When speech is recognized, it stores the recognized text in the
  /// `_finaltext` variable and calls the `textToSpeak` method to speak the
  /// recognized text. It then stops listening and notifies all listeners
  /// of the `ChangeNotifier` that the state has changed.
  ///
  /// If speech recognition is not available, it logs an error message.
  ///
  /// [context] is the BuildContext of the widget that calls this function.
  Future<void> listenAndSpeak( BuildContext context) async {
     var Fortextcommand= Provider.of<VoiceAssistant>(context, listen: false);

     var api = Provider.of<commands>(context, listen: false);
    bool available = await _speech.initialize();
    if (available) {
      _isListening= true;
      notifyListeners();
      _speech.listen(
        
        listenFor: const Duration(seconds: 5), 
        onResult: (result) async {
          String text = result.recognizedWords.toLowerCase();  //! store the recognized text
          log("Heard: $text");

          // !Speak the recognized text

              
        // api.openewb(text);
                Fortextcommand.handleCommand(text, context); //! call the function for choose  command
          //! Stop listening after first result
           Future.delayed(  Duration(seconds: 5), () => stopListening());
           _speech.stop();
         
          _isListening = false;               
          notifyListeners();
        },
      );
    } else {
      log("Speech recognition not available");
          
    }

  }

}
