import 'dart:async';

import 'package:customer/models/user_info.dart';
import 'package:customer/network/network_call.dart';
import 'package:customer/utils/hex_to_color.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => new _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<UserInfo> userData;
  List<Customers> _allUsers = [];
  TextEditingController controller = new TextEditingController();
  List<Customers> _searchResult = [];

  @override
  void initState() {
    super.initState();
    userData = getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: new Text(
          'কাস্টমার তালিকা',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1.0,
      ),
      body: Column(
        children: <Widget>[
          createSearchField(),
          SizedBox(
            height: 8.0,
          ),
          new Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? createUsersListView(_searchResult, context)
                : Container(
                    //height: MediaQuery.of(context).size.height * 0.9,
                    child: FutureBuilder(
                        future: userData,
                        builder: (context, AsyncSnapshot<UserInfo> snapshot) {
                          if (snapshot.hasData) {
                            // WidgetsBinding.instance!.addPostFrameCallback((_) {
                            //   setState(() {
                            _allUsers = snapshot.data!.customers;
                            //   });
                            // });
                            return createUsersListView(_allUsers, context);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                  ),
          ),
        ],
      ),
    );
  }

  // Search Field
  Widget createSearchField() {
    return new Container(
      color: Colors.white,
      child: Card(
        elevation: 1.0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: new ListTile(
          leading: new Icon(Icons.search),
          title: new TextField(
            controller: controller,
            decoration: new InputDecoration(
                hintText: 'সার্চ করুন', border: InputBorder.none),
            onChanged: onSearchTextChanged,
          ),
          trailing: new IconButton(
            icon: new Icon(Icons.cancel),
            onPressed: () {
              controller.clear();
              onSearchTextChanged('');
            },
          ),
        ),
      ),
    );
  }

  //Users ListView
  Widget createUsersListView(List<Customers> data, BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      // physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return createUsersListItem(data, index, context);
      },
    );
  }

  Widget createUsersListItem(
      List<Customers> data, int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => UserDetails(
        //               userData: data[index],
        //             )));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 0.0, bottom: 8.0),
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 6.0,
                    height: MediaQuery.of(context).size.width / 6.0,
                    padding: EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 4.0, color: HexToColor("#003300"))),
                    child: new CircleAvatar(
                      backgroundImage: new NetworkImage(
                        data[index].image != null
                            ? data[index].image.toString()
                            : "https://picsum.photos/250",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index].name != null
                            ? data[index].name.toString()
                            : "Name not found",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        data[index].phone != null
                            ? data[index].phone.toString()
                            : "Phone not found",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              indent: MediaQuery.of(context).size.width / 6.0,
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _allUsers.forEach((userDetail) {
      if (userDetail.name!.contains(text) || userDetail.phone!.contains(text))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }

  Future<UserInfo> getUsers() => new NetworkCall().getAllUsers();
}
