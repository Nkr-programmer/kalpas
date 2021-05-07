import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Web extends StatefulWidget {
  Web({Key key, this.posts}) : super(key: key);

  final String posts;

  @override
  _WebState createState() => _WebState();
}

class _WebState extends State<Web> {
   Future<void> launchinApp(String url) async{
   if(await canLaunch(url))
   {await 
   launch(url,forceSafariVC: true,
   forceWebView: true,
   headers: <String,String>{'header_key':'header_value'},);}
   else{
     throw'could not resolve $url';
   }
 }
  @override
  Widget build(BuildContext context) {
    const String toLaunch = 'https://www.cylog.org/headers/';
    return Scaffold(
      appBar: AppBar(
        title: Text("Media"),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            RaisedButton(
              onPressed: (){launchinApp(widget.posts);},
              child: Text('Show Flutter homepage'),
            ),
            ],
          ),
        ],
      ),
    );
  }
}