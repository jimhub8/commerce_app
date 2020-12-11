import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/tetet.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../../size_config.dart';
import 'section_title.dart';

String baseUrl = "https://swapstore.co.ke";
String consumerKey = "ck_11f7cb142327520f9757a978835c4a17791aa19f";
String consumerSecret = "cs_44b0d26c4e4e73fee6830a74d6aaa21ba2b780ae";

class PopularProducts extends StatelessWidget {
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

    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Popular Products", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                products.length,
                (index) {
                  // if (products[index].isPopular)
                  // return ProductCard(product: products[index]);

                  // return SizedBox
                  //     .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product(this.id, this.title, this.description, this.images, this.colors,
      this.rating, this.price, this.isFavourite, this.isPopular);
}
