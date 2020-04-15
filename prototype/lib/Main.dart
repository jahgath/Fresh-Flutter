import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prototype/DetailsScreen.dart';
import 'package:prototype/Cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Center(
              child: JSONListView()
          ),
        ));
  }
}

class GetUsers {
  int id;
  String name;
  String description;
  String image_url;
  var price;
  int quantity;

  GetUsers({
    this.id,
    this.name,
    this.description,
    this.image_url,
    this.price,
    this.quantity
  });

  factory GetUsers.fromJson(Map<String, dynamic> json) {
    return GetUsers(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        image_url: json['image_url'],
        price: json['price'],
        quantity: 00
    );
  }
}


class JSONListView extends StatefulWidget {
  CustomJSONListView createState() => CustomJSONListView();
}

class CustomJSONListView extends State {

  final String apiURL = 'http://10.0.2.2:8000/products/?format=json';

  Future<List<GetUsers>> fetchJSONData() async {

    var jsonResponse = await http.get(apiURL);

    if (jsonResponse.statusCode == 200) {

      final jsonItems = json.decode(jsonResponse.body).cast<Map<String, dynamic>>();

      List<GetUsers> usersList = jsonItems.map<GetUsers>((json) {
        return GetUsers.fromJson(json);
      }).toList();

      return usersList;

    } else {
      throw Exception('Failed to load data from internet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.red[400],
      ),
      body: FutureBuilder<List<GetUsers>>(
        future: fetchJSONData(),
        builder: (context, snapshot) {

          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          return ListView(
            children: snapshot.data.map((user) => ListTile(
              title: Text(user.name),
              onTap: (){ Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(data: user),
                ),
              ); },
             subtitle: Text('${user.description} price: ${user.price}'),
              leading: CircleAvatar(
                radius: 50,
                backgroundImage:  NetworkImage(user.image_url),
                backgroundColor: Colors.green,
//                child: Text(user.name[0],
//                    style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 20.0,
//                    )),
              ),
            ),
            ).toList(),

          );
        },
      ),
    );
  }
}