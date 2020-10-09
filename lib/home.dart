import 'package:flutter/material.dart';
import 'package:search_app/brands.dart';
import 'package:search_app/search.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SearchPage()));
          },
          child: Text("See Brands"),
        ),
      ),
    );
  }
}
