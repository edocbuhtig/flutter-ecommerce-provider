import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:providercart/models/product.dart';
import 'package:providercart/models/cart.dart';

class ProductListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _getProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> data = snapshot.data;
          return _productListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<Product>> _getProducts() async {
    final productURL = 'https://fakestoreapi.com/products';
    final response = await http.get(productURL);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((product) => new Product.fromJson(product))
          .toList();
    } else {
      throw Exception('Failed to load products from fake API');
    }
  }

  ListView _productListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          var ccart = Provider.of<Cart>(context);
          return ListTile(
            title: Text(data[index].title),
            subtitle: Text(data[index].price.toString()),
            trailing: Icon(Icons.add),
            onTap: () {
              ccart.add(data[index]);
            },
          );
        });
  }
}
