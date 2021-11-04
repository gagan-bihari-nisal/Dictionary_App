import 'dart:convert';

import 'package:http/http.dart'as http;
String? error="";
class GetResult{
  static final url=("https://api.dictionaryapi.dev/api/v2/entries/en_US/");
  static Future getResult(String word)async{
    try {
      var response=await http.get(Uri.parse("$url"+word));
      if(response.statusCode==200){
        var decode=json.decode(response.body);
        print(response.statusCode);
      return decode;
      }else{
        error="";
        print(response.statusCode);
        var decode=json.decode(response.body);
        error=(decode["message"]);
        return null;

      }
    } on Exception catch (e) {
      // TODO
      print(e.toString());
      return null;
    }
    return null;
  }
}