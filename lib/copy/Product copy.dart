import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';

String baseUrl = "https://swapstore.co.ke";
String consumerKey = "ck_11f7cb142327520f9757a978835c4a17791aa19f";
String consumerSecret = "cs_44b0d26c4e4e73fee6830a74d6aaa21ba2b780ae";

class Product extends StatefulWidget {
  const Product(
      {Key key,
      this.id,
      this.title,
      this.description,
      this.images,
      this.colors,
      this.rating,
      this.price,
      this.isFavourite,
      this.isPopular})
      : super(key: key);

  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    List<WooProduct> products = [];
    List<WooProduct> featuredProducts = [];
    WooCommerce wooCommerce = WooCommerce(
      baseUrl: baseUrl,
      consumerKey: consumerKey,
      consumerSecret: consumerSecret,
      isDebug: true,
    );

    getProducts() async {
      products = await wooCommerce.getProducts();
      setState(() {});
      print("@@@@@@@@@@@@@@@@@@@@@@@");
      print(products.toString());
      print("@@@@@@@@@@@@@@@@@@@@@@@");

      return products;
    }

    @override
    void initState() {
      super.initState();
      //You would want to use a feature builder instead.
      getProducts();
    }
  }
}
