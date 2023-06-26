import 'dart:convert';
import 'package:apitest/details.dart';
import 'package:apitest/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const Home());

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  DataModel? dataFromAPI;
  _getData() async {
    try {
      String url = "https://dummyjson.com/products";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        dataFromAPI = DataModel.fromJson(json.decode(res.body));
        _isLoading = false;
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

/* Widget build goes after this */
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
          title: const Text("REST API Example"),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => detailsPage(
                                prodData: dataFromAPI!.products[index]),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                            dataFromAPI!.products[index].thumbnail,
                            width: 100,
                          ),
                          Text(dataFromAPI!.products[index].title.toString()),
                          Text(dataFromAPI!.products[index].brand.toString()),
                          Text(
                              "\$${dataFromAPI!.products[index].price.toString()}"),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: dataFromAPI!.products.length,
              ),
      ),
    );
  }
}
