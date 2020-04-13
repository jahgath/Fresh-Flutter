import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListViewJsonapi extends StatefulWidget {
  _ListViewJsonapiState createState() => _ListViewJsonapiState();
}

class _ListViewJsonapiState extends State<ListViewJsonapi> {
  final String uri = 'http://127.0.0.1:8000/products/?format=json';

  Future<List<Users>> _fetchUsers() async {
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Users> listOfUsers = items.map<Users>((json) {
        return Users.fromJson(json);
      }).toList();

      return listOfUsers;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetching data from JSON - ListView'),
      ),
      body: FutureBuilder<List<Users>>(
        future: _fetchUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          return ListView(
            children: snapshot.data
                .map((user) => ListTile(
              title: Text(user.name),
              leading: Image.network(user.img),
              subtitle: Text('${user.desc} , price:  ${user.price}'),
            ))
                .toList(),
          );
        },
      ),
    );
  }
}

class Users {
  var id;
  var name;
  var price;
  var desc;
  var img;

  Users({
    this.id,
    this.name,
    this.price,
    this.desc,
    this.img,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      name: json['name'],
      desc: json['description'],
      price: json['price'],
      img: json['image_url']
    );
  }
}