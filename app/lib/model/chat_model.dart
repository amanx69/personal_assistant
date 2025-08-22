import 'package:hive/hive.dart';

part 'chat_model.g.dart';


@HiveType(typeId: 0)

class  ChatModel {
@HiveField(0)
String ?oredr;


@HiveField(1)
String ?answer;


@HiveField(2)
DateTime ?time;


  ChatModel({required this.oredr,required this.answer,required this.time});


}