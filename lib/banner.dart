import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:starslive/constant/contant.dart';
//import 'package:starslive/model/bannerModel.dart';

class Banner{

  String? status;
//  Data? data;
  String? msg;
  List<dynamic>? errors;
  int? id;
  String? name;
  String? title;
  String? description;
  String? type;
  String? place;
  int? duration;
  int? ordering;
  String? image;
  dynamic video;
  DateTime? createdAt;
  DateTime? updatedAt;

  Future<void> getBanners() async {
    // https://test.the-link.site/public/api/banners/get;
//    var url="https://test.the-link.site/public/api/banners/get?type=home";
    var url="https://test.the-link.site/public/api/banners/get?type=banner&place=trend";


//    String url = "https://test.the-link.site/public/api/banners/get?fbclid=IwAR0nSUZ-_C87e4_c41Mn_Rw5yUpkZfKLfzKQcQ8mE0GEBYCrlmGsBrouKK4&type=home";
//    String url = '${baseLinkApi}';
    var response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'}
    );
    try{
      if(response.statusCode == 200)
      {
        var body = jsonDecode(response.body);
        var s = json.decode(body);
        print("body");
        print(body);
        print("s");
        print(s);
        fromJson(s);
      }
      else
      {
        print("response.statusCode :${response.statusCode}");
        print("response.statusCode :${response.body.toString()}");
      }
    }catch(e){
      print('Errrorr : ${e}');
    }
  }


  void fromJson(Map<String, dynamic> json) {
    this.status=json["status"];
//    data: json["data"];
    this.msg= json["msg"];
    errors= List<dynamic>.from(json["errors"].map((x) => x));
    id= json["data"]["voice"][0]["id"];
    name= json["data"]["voice"][0]["name"];
    title= json["data"]["voice"][0]["title"];
    description= json["data"]["voice"][0]["description"];
    status= json["data"]["voice"][0]["status"];
    type= json["data"]["voice"][0]["type"];
    place= json["data"]["voice"][0]["place"];
    duration= json["data"]["voice"][0]["duration"];
    ordering= json["data"]["voice"][0]["ordering"];
    image= json["data"]["voice"][0]["image"];
    video= json["data"]["voice"][0]["video"];
    createdAt= DateTime.parse(json["data"]["voice"][0]["created_at"]);
    updatedAt= DateTime.parse(json["data"]["voice"][0]["updated_at"]);
  }

  Map<String, dynamic> toJson() => {
    "status": status,
//    "data": data.toJson(),
    "msg": msg,
    "errors": List<dynamic>.from(errors!.map((x) => x)),
    "id": id,
    "name": name,
    "title": title,
    "description": description,
    "status": status,
    "type": type,
    "place": place,
    "duration": duration,
    "ordering": ordering,
    "image": image,
    "video": video,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
//      headers:
//      {
//        "accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
//        "accept-encoding":"gzip",
//        "accept-language":"en-US,en;q=0.9",
//        "connection":"Keep-Alive",
//        //"cookie":"XSRF-TOKEN=eyJpdiI6Ikx6UGxReUVYVGx3ZDVCaFZHMTlEakE9PSIsInZhbHVlIjoiSlorL0VmakwvQ2NnTGlpQVhZL1daVVovZ2l6YndZaksvcndRdkJ0QVlkVUtBMng4ODRzbFFobUUrcHVLS0o1WktUdmlpZnlxOVAwcEdMUkNNQlVzRGVoNWh6Y0JwbTdpMjZyT052VzVDTXVxTHg2TWozRlkwK0NTYWNlelJoOGYiLCJtYWMiOiIxNWExMmE2N2FiMjMwZWE2ZTFkMTI2ODk5ZmFlM2QxMTQxYzkzZjI5ZWIzY2RiNDVjZTZkOGU2YTQ3OGQ0MDVlIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6Imp5eUJtRHRrOUt4eHNyWWRwdHk0Unc9PSIsInZhbHVlIjoieTlCdENtWWdqUmtuTDI5aWJ6ZGl6MXNkQmgvTGkyVkM4Si80UEEzTSt2c3N0OWg1SGkzeUtrSVFhQlFNRktTcFlEVEpEbXJiSnBid3Z1M2tXYkVBejg5bFJ1WXRPWWNWY3JyQVZZSzQ1RGZCZlI0emJ1dW5ZVGVYdGJkUnlCTFUiLCJtYWMiOiI0N2MwM2RmNDY5NDFlNWM2NDhmY2ZkNTRkYTQ5ZDNmNDNmMjllMzM1OGIyYTdjMjliZjhlNTc1OTY5ZTk0YzcwIiwidGFnIjoiIn0%3D",
//        "host":"test.the-link.site",
//        "user-agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36",
//        "x-forwarded-for":"41.237.158.118",
////        "cache-control":"max-age=0",
//        "cf-ipcountry":"EG",
//        "cf-ray":"6ba0009679fa3b25-CDG",
//        "x-forwarded-proto":"https",
//        "cf-visitor":"{\"scheme\":\"https\"}",
//      "sec-ch-ua":""""" Not A;Brand";v="99", "Chromium";v="96", "Google Chrome";v="96""",
//      "sec-ch-ua-mobile":""""?0""",
//      "sec-ch-ua-platform": "\"Windows\"",
//      "upgrade-insecure-requests": "1",
//      "sec-fetch-site":"none",
//      "sec-fetch-mode":"navigate",
//      "sec-fetch-user":"?1",
//      "sec-fetch-dest":"document",
//      "cf-connecting-ip":"41.237.158.118",
//      "cdn-loop":"cloudflare"
//      },