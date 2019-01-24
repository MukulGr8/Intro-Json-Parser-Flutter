import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List _data = await fetchPost();

  //showing only the title for first index of array
//  print(_data[0]['title']);

//  //showing only the title for all the arrays
//  for(int i=0;i<_data.length;i++){
//    print("Title: ${_data[i]['title']}");
//    print("Body: ${_data[i]['body']}");
//  }

  runApp(new MaterialApp(
    home:new Scaffold(
      appBar: new AppBar(
        title: new Text("Parse Json"),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: new Center(
        child: new ListView.builder(itemCount: _data.length,padding: EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context,int position){
          if(position.isOdd) return new Divider();
          //dividing by 2 because there are 2 list items in every row
          final index = position ~/ 2;
            return new ListTile(
              //main title of our listview
              title: new Text("${_data[index]['title']}",style: new TextStyle(fontSize: 14.0),),
              //Sub title of our listview
              subtitle: new Text("${_data[index]['body']}",style: new TextStyle(fontSize: 13.4
              ,fontStyle: FontStyle.italic,color: Colors.grey),),
              //the first images which is also represented by leading in a listview it will fetch
              // title first text letter and show it in the circle using the circle avtaar
              leading: new CircleAvatar(
                backgroundColor: Colors.green,
                child: new Text("${_data[index]['title'][0]}",style: new TextStyle(fontSize: 20.4,
                color: Colors.orangeAccent),),
              ),
              onTap: () {_showOnTapMessage(context, "${_data[index]['title']}");},
            );
        },),
      ),
    )
  ));
}

void _showOnTapMessage(BuildContext context,String message){
  var alert = new AlertDialog(
    title: new Text('App'),
    content: new Text(message),
    actions: <Widget>[
      new FlatButton(onPressed: (){Navigator.pop(context);}, child: new Text('ok')),
    ],
  );
  showDialog(context: context,builder: (context) => alert);
}

Future<List> fetchPost() async {
  String apiUrl = 'https://jsonplaceholder.typicode.com/posts';
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}