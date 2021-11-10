import 'package:customer/models/user_info.dart';
import 'package:customer/utils/hex_to_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetailView extends StatefulWidget {
  Customers userData;
  UserDetailView({required this.userData});

  @override
  _UserDetailViewState createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailView> {
  static const platform = const MethodChannel('myChannel');
  String _responseFromNativeCode = 'Waiting..';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: new Text(
          "কাস্টমার বিবরণী",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 1.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: <Widget>[
            topView(context, widget.userData),
            bottomView(context, widget.userData),
          ],
        ),
      ),
    );
  }

  // User Details with Call, Mail and Messaging functionality
  Widget topView(BuildContext context, Customers data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 12.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 6.0,
                  height: MediaQuery.of(context).size.width / 6.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black38, width: 1.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          data.image != null
                              ? data.image.toString()
                              : "https://picsum.photos/250",
                        ),
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name != null
                          ? data.name.toString()
                          : "Name not found",
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      data.phone != null
                          ? data.phone.toString()
                          : "Phone not found",
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.black54,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            responseFromNativeCode(data.phone.toString());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 1.0, color: HexToColor("#00a24a"))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Image.asset(
                                  "lib/assets/images/call.png",
                                  height: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        GestureDetector(
                          onTap: () {
                            launch('mailto:' +
                                data.email.toString() +
                                '?subject=This is Subject Title&body=This is Body of Email');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 1.0, color: HexToColor("#00a24a"))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Image.asset(
                                  "lib/assets/images/mail.png",
                                  height: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        GestureDetector(
                          onTap: () {
                            launch('sms:' +
                                data.phone.toString() +
                                '?body=Hi Welcome to Proto Coders Point');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 1.0, color: HexToColor("#00a24a"))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Image.asset(
                                  "lib/assets/images/message.png",
                                  height: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // User History
  Widget bottomView(BuildContext context, Customers data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 12.0),
            Text(
              '১ বছর ৬ মাস ৭ দিন যাবত কাস্টমার',
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              data.name != null
                  ? "Mr. " +
                      data.name.toString() +
                      " is our most trusted customer and have been ordering our service since 2019"
                  : "Name not found",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 24.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "২৬ মার্চ, ২০২০, দুপুর ১২ঃ৩০ কিনেছেন",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      "৳৫০.০০",
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Divider(color: Colors.black26),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "২৭ ডিসেম্বর, ২০১৯, রাত ১০ঃ৩০ বাকি করেছেন",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      "৳৫০.০০",
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.green,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Divider(color: Colors.black26),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "০২ ফেব্রুয়ারি, ২০২০, সকাল ১০ঃ০০ জমা করেছেন",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      "৳৫০.০০",
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.red,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Divider(color: Colors.black26),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "২৯ এপ্রিল, ২০২০, দুপুর ০৩ঃ৩০ কিনেছেন",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      "৳১০০০.০০",
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Get response from method channel
  Future<void> responseFromNativeCode(String phone) async {
    String response = "";
    try {
      final String result =
          await platform.invokeMethod('callPhone', {"phone": phone});
      response = result;
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }
    setState(() {
      _responseFromNativeCode = response;
    });
  }
}
