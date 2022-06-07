import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_gest_event_slama_best_choice_app/models/event.dart';
import 'package:flutter_gest_event_slama_best_choice_app/services/auth.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class remoteServices {
  final auth = Auth();

  Future<List<Event>?> getEvents() async {
    //nhathro l clien taana
    var client = http.Client();
    //naamlo parse ll url taa lapi
    var uri = Uri.parse('http://10.0.2.2:8000/api/events');
    //kil aada npingiw lapi
    
    //await bch mataada ila ma yakho response maykamlch l code
    var response = await client
        .get(uri, headers:  
       {'Authorization': 'Bearer ' + this.auth.getToken(),
       "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=5, max=1000"
       },
       
       );
        
    //chek kan response ok
    if (response.statusCode == 200) {
      //naktho data mil body
      var json = response.body;
      //baed naabiw lmodel taana
      return eventFromJson(json);
    }

  
    }

    var a = Uri.parse('http://10.0.2.2:8000/storage/');
      String formatter(String url)  {
      return '$a'+url;
    }

    NetworkImage getImage(String label) {
      String url = formatter('$label');
      return NetworkImage(url);


      // final String url = 'http://192.168.1.3:8000/api/events';
//   List<dynamic> _events = [];
//   bool loading = true;

// Future<void> getEvents() async  {
//     var response = await http.get(Uri.parse(url));
//     if(response.statusCode == 200) {
//       final parsedData = jsonDecode(response.body).cast<Map<String, dynamic>>();
//       _events = parsedData.map<Event>((json) => Event.fromJson(json)).toList();
     
//     } else {
//       throw Exception('Failed to load courses');
//     }
//   }
  

  }
}
