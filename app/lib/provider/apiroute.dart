import 'dart:developer';
import 'package:app/helper/customMic.dart';
import 'package:app/provider/Api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VoiceAssistant with ChangeNotifier {
  final MicService _micService = MicService(); // mic service


  //! Route command to appropriate function
  Future<void> handleCommand(String command, BuildContext context) async {
    final api = Provider.of<commands>(context, listen: false);

    switch (command) {
      case "ai":
        String query = await _listenForQuery();
        if (query.isNotEmpty) {
          api.Searchwithai(query, context);
        }
        break;

      case "wikipedia":
        String wikiQuery = await _listenForQuery();
        if (wikiQuery.isNotEmpty) {
          api.searchwikiPidea(wikiQuery, context);
        }
        break;

      case "open app":
        String appName = await _listenForQuery();
        if (appName.isNotEmpty) {
          api.openappliction(appName,);
        }
        break;

      case "open":
        String webName = await _micService.listenOnce();
         log("webName: $webName");
        if (webName.isNotEmpty) {
          api.openewb(webName, );
        }
        break;

      case "stop":
        _micService.stopListening();
        break;

      default:
        log("Command not recognized: $command");
    }
  }

  //!Helper to listen for a single query after command
  Future<String> _listenForQuery() async {
    log("Listening for query...");
    String result = await _micService.listenOnce();
    result = result.toLowerCase().trim();
    log("Query recognized: $result");
    return result.toString();
  }
}
