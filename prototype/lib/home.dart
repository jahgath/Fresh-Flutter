import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:prototype/network.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var data;
  var id;
  var name;
  var desc;
  var img;
  var price;
  void dataCollector() async{
    Network network = Network();
    data = await network.getData();
    await dataInit();
  }
  Future dataInit() {
    id = data[0]['id'];
    name = data[0]['name'];
    desc = data[0]['description'];
    img = data[0]['image_url'];
    price = data[0]['price'];
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    dataCollector();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.green[400],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('$name'),
              leading: Image.network('$img'),
              subtitle: Text('$desc, price: $price'),
            ),
          ],
        ),
      ),
    );
  }

}
