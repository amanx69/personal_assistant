import 'dart:async';
import 'dart:developer';


import 'package:speech_to_text/speech_to_text.dart' as stt;

class MicService {
  late stt.SpeechToText _speech;
  bool _isListening = false;

  MicService() {
    _speech = stt.SpeechToText();
  }

  /// Listens once and returns the recognized text
  Future<String> listenOnce() async {
    String recognizedText = "";

    bool available = await _speech.initialize(
      onStatus: (status) => print("Mic status: $status"),
      onError: (error) => print("Mic error: ${error.errorMsg}"),

    );

    if (!available) return recognizedText;

    _isListening = true;

    final completer = Completer<String>();

    _speech.listen(
      listenFor: const Duration(seconds: 5),
      onResult: (result) {
        recognizedText = result.recognizedWords;
         log(recognizedText.toString());
        completer.complete(recognizedText);
        stopListening(); // stop after first result
      },
    );

    return recognizedText.toString();       
  }

  void stopListening() {
    if (_isListening) {
      _speech.stop();
      _isListening = false;
    }
  }
}
