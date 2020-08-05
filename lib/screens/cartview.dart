import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providercart/models/cart.dart';

class Cartview extends StatefulWidget {
  @override
  _CartviewState createState() => _CartviewState();
}

class _CartviewState extends State<Cartview> {
  @override
  Widget build(BuildContext context) {
    var ccart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart View [\$ ${ccart.totalPrice}]'),
        ),
        body: ccart.cartItems.length == 0
            ? Text('no items in your cart')
            : ListView.builder(
                itemCount: ccart.cartItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(ccart.cartItems[index].title),
                      subtitle: Text(ccart.cartItems[index].price.toString()),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          ccart.remove(ccart.cartItems[index]);
                        },
                      ),
                    ),
                  );
                },
              ));
  }
}
