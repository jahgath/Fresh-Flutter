import 'package:flutter/material.dart';
import 'package:prototype/Main.dart';
import 'package:prototype/counter.dart';

class DetailsScreen extends StatefulWidget {
  final GetUsers data;

  const DetailsScreen({Key key, @required this.data}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(2, -1),
                                color: Colors.black12,
                                blurRadius: 9),
                          ],
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            Center(
                              child: Hero(
                                tag: widget.data.id,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    widget.data.image_url,
                                  ),
                                  radius: MediaQuery.of(context).size.width / 4,
                                ),
                              ),
                            ),
                            SizedBox(height: 11),
                            Text(
                              "${widget.data.price}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(color: Colors.red[400]),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${widget.data.name}",
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 9),
                            Text(
                              "${widget.data.description}",
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {

                        },
//                        child: Container(
//                          margin: const EdgeInsets.all(25),
//                          padding: const EdgeInsets.all(11.0),
//                          decoration: BoxDecoration(
//                            color: Colors.pink,
//                            borderRadius: BorderRadius.only(
//                              topRight: Radius.circular(15.0),
//                              bottomLeft: Radius.circular(15.0),
//                            ),
//                          ),
////                          child: Icon(
////                            Icons.favorite,
////                            size: 13,
////                            color: widget.data.isFavorite
////                                ? Colors.orange
////                                : Colors.white,
////                          ),
//                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 71,
                width: double.infinity,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        color: Colors.red[400],
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("Quantity"),
                            Counter(
                              count: widget.data.quantity,
                              add: () {
                                setState(() {
                                  widget.data.quantity += 1;
                                });
                              },
                              reduce: () {
                                setState(() {
                                  widget.data.quantity -= 1;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.red[400],
                child: FlatButton(
                  child: Text(
                    "Add to cart",
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
