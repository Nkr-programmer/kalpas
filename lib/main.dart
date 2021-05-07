import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kalpas/web.dart';

void main() {
  runApp(new MaterialApp(
    home: new HomeScreen(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {

  List data;

  Future<String> getData() async {
    var response = await http.get(
      Uri.encodeFull("https://api.first.org/data/v1/news"),
      headers: {
        "Accept": "application/json"
      }
    );
    data = json.decode(response.body);
    print(data[3]["title"]);
    
    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new RaisedButton(
          child: new Text("Get data"),
          onPressed: getData,
        ),
      ),
    );
  }
}


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int choose=1;
  ScrollController controller = ScrollController();
 static Map<String, dynamic> data;
  List<Widget> itemsData = [];
 
    static List<dynamic> responseList = data["data"];
    static List<dynamic> favItems = []; Future<String> getData() async {
    var response = await http.get(
      Uri.encodeFull("https://api.first.org/data/v1/news"),
      headers: {
        "Accept": "application/json"
      }
    );
    data = json.decode(response.body);
    print(data["data"][3]["title"]);
    getPostsData(context);
    return "Success!";
  }
  void getPostsData(BuildContext context) {
 
    List<Widget> listItems = [];
     List<dynamic>temp=choose==1?responseList:favItems;
    temp.forEach((post) {
      listItems.add(Container(
          
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), 
          color: Colors.black54, boxShadow: [
            BoxShadow(color: Colors.white.withAlpha(100), blurRadius: 10.0),
          ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(alignment: Alignment.bottomLeft,
child:
 Text( post["published"],
                        style: const TextStyle(fontSize: 10, color: Colors.amberAccent,fontWeight: FontWeight.w500),
                      ),
                ),
                          Container(alignment:Alignment.bottomRight,
                            child: Text(
                              "\ ${post["id"]}",
                              style: const TextStyle(
                                fontSize:12, color: Colors.amberAccent,fontWeight: FontWeight.w100),
                            ),
                          ),

                        ],
                      ),
                      Container(alignment:Alignment.center,
                        child: Text(
                          post["title"],
                          style: const TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                                                      child: Text(
                              post["summary"]==null?"NO SUMMARY JUST BREIF INFORMATION":
                            post["summary"],
                              style: const 
                              TextStyle(fontSize: 15, color: Colors.blueGrey, fontWeight: FontWeight.w300),
                            ),
                          ),
          //                 Expanded(
          //                                             child: WebView(
          //                                              initialUrl: 'https://stackoverflow.com',
          //                                              javascriptMode: JavascriptMode.unrestricted,
          //                                              onWebViewCreated: (WebViewController c) {
          //                                                _controllers.complete(c);
          //                                              },
                                                      
          // ),
          //                 )
                
                        ],
                      ),
                      SizedBox(height: 20,),
   GestureDetector(onTap:(){
     choose==1?favItems.add(post):favItems.remove(post);
     choose==1?responseList.remove(post):responseList.add(post);print(responseList.length);
   setState(() {getPostsData(context);});},
        child: Container(color:Colors.white,child:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: <Widget>[
        choose==1?Icon(Icons.thumb_up,color: Colors.red,):Icon(Icons.thumb_up,color: Colors.black,),
         Text(choose==1?"Like":"UnLike", style:  TextStyle(fontSize: 20, color: choose==1?Colors.black:Colors.red, fontWeight: FontWeight.w900))
       ],
     )),
   ),
   SizedBox(height:10),
   GestureDetector(onTap: 
   (){ Navigator.push(context, MaterialPageRoute(builder: (context) {return Web(posts:post["link"]);},));},
     child: Container(alignment: Alignment.center,
       child: Text("Media",style:  TextStyle(fontSize: 25, color:Colors.blue, fontWeight: FontWeight.bold))))
   
                    ],
                  ),
                ),
              ],
            ),
          )));
    });
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    controller.addListener(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
         title: Text("NEWS UPDATES"),
        ),
        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
             
              const SizedBox(
                height: 10,
              ),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                                      child: Column(
                                        children: <Widget>[
                                          Icon(Icons.home,color: choose==1?Colors.white:Colors.grey,),
                                          Text(
                      "Home",
                      style: TextStyle(color: choose==1?Colors.white:Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                                        ],
                                      ),
                                      onTap: (){setState(() {
                                        choose=1;getPostsData(context);
                                      });},
                  ),
                  GestureDetector(
                                      child: Column(
                                        children: <Widget>[
                                         Icon(Icons.favorite,color: choose==2?Colors.white:Colors.grey,),
                                          Text(
                      "Favorites",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: choose==2?Colors.white:Colors.grey,),
                    ),
                                        ],
                                      ),
                    onTap: () {
setState(() {
  choose=2;getPostsData(context);
});
                    }                  
                    ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                    controller: controller,
                      itemCount: itemsData.length,
                      itemBuilder: (context, index) {
                        return   Container(
                                alignment: Alignment.topCenter,
                                child: itemsData[index]);
                      })),
            ],
          ),
        ),
      ),
    );
  }
}

