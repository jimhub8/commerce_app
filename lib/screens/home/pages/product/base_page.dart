import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/loader_provider.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/utils/ProgressHUD.dart';

import '../../../../constants.dart';

class BasePage extends StatefulWidget {
  BasePage({Key key}) : super(key: key);

  @override
  BasePageState createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  bool isApiCallProcess = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(builder: (context, loadModel, child) {
      return Scaffold(
        appBar: buildAppBar(),
        body: ProgressHUD(
            child: pageUI(),
            inAsyncCall: loadModel.isApiCallProcess,
            opacity: 0.3),
      );
    });
  }

  Widget pageUI() {
    return null;
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      brightness: Brightness.dark,
      elevation: 0,
      backgroundColor: Colors.redAccent,
      // backgroundColor: kBacgroundColor,
      automaticallyImplyLeading: false,
      leading: Icon(Icons.arrow_back),
      title: Column(
        children: [
          Text(
            "Products",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),

      actions: [
        IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
        IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
        Provider.of<CartProvider>(context, listen: false).CartItems.length == 0 ? new Container() : 
        new Positioned(
            child: new Stack(
          children: <Widget>[
            new Icon(
              Icons.brightness_1,
              size: 20.0,
              color: Colors.green[800],
            ),
            new Positioned(
                top: 5.0,
                right: 7.0,
                child: Center(
                  child: new Text(
                    "10",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500),
                  ),
                ))
          ],
        ))
      ],
    );
  }
}
