import 'package:flutter/material.dart';
import 'brands.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isSearching = false;
  List listData = new List();
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < brands.length; i++) {
      listData.add(brands[i]['name']);
    }
    textEditingController.addListener(search);
  }

  Widget get appBar => AppBar(
        title: appBarTitle,
        leading: appBarBack,
        actions: actions(context),
      );

  Widget get appBarTitle => isSearching
      ? searchBar
      : Text(
          "Brands",
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .body1
              .copyWith(fontWeight: FontWeight.bold),
        );

  void onAppBarBack() {
    if (isSearching) {
      isSearching = false;
      textEditingController.clear();
      setState(() {});
      return;
    }
    Navigator.of(context).pop();
  }

  Widget get appBarBack => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: onAppBarBack,
      );

  List<Widget> actions(BuildContext context) {
    if (isSearching) {
      return [
        cancelSearchAction,
        SizedBox(width: 8.0),
      ];
    } else {
      return [
        searchAction,
        SizedBox(width: 8.0),
      ];
    }
  }

  Widget get searchAction => IconButton(
        icon: Icon(Icons.search),
        tooltip: "search",
        onPressed: () {
          isSearching = true;
          setState(() {});
        },
      );

  Widget get cancelSearchAction => IconButton(
        icon: Icon(Icons.clear),
        tooltip: "cancel",
        onPressed: () {
          if (textEditingController.text.isEmpty) {
            isSearching = false;
          }
          textEditingController.clear();
          search();
          setState(() {});
        },
      );

  Widget get searchBar {
    return TextField(
      decoration: InputDecoration(hintText: "Search", border: InputBorder.none),
      autofocus: true,
      autocorrect: false,
      cursorColor: Colors.black,
      controller: textEditingController,
    );
  }

  void search() {
    listData.clear();
    for (int i = 0; i < brands.length; i++) {
      String data = brands[i]["name"];
      if (data
          .toLowerCase()
          .contains(textEditingController.text.trim().toLowerCase())) {
        listData.add(data);
      }
    }
    setState(() {});
  }

  Widget buildItem(BuildContext context, int index) {
    return ListTile(
      title: Text(listData[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        child: ListView.separated(
            itemBuilder: buildItem,
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.black26,
              );
            },
            itemCount: listData.length),
      ),
    );
  }
}
