import 'package:apitest/product.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore_for_file: sort_child_properties_last, use_build_context_synchronously

class detailsPage extends StatefulWidget {
  final Product prodData;

  const detailsPage({super.key, required this.prodData});

  @override
  detailsPageState createState() => detailsPageState();
}

class detailsPageState extends State<detailsPage> {
  @override
  void initState() {
    super.initState();
  }

  void buy() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congrats'),
          content: Text('thanks for buying $_fullname'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _fullname = "";
  int _phone = 0;

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Add MaterialApp as the root widget
      title: 'Product List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Details"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: TextField(
                    controller: _fullNameController,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    onChanged: (value) {
                      _fullname = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: TextField(
                    controller: _phoneController,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .digitsOnly, // Allow only numeric input
                    ],
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _phone = int.parse(value);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: MaterialButton(
                    onPressed: buy,
                    color: Color(0xff3a57e8),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Buy",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    textColor: Color(0xffffffff),
                    height: 45,
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
