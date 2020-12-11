import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart_request_model.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/loader_provider.dart';
import 'package:shop_app/screens/home/pages/product/base_page.dart';
import 'package:shop_app/screens/home/pages/product/widget/related_products_widget.dart';
import 'package:shop_app/utils/custom_stepper.dart';
import 'package:shop_app/utils/expand_text.dart';

import '../../../../../constants.dart';

class ProductDetailsWidget extends StatelessWidget {
  ProductDetailsWidget({Key key, this.data}) : super(key: key);

  Product data;
  int qty = 0;
  CartProducts cartProducts = new CartProducts();

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    // print(data.images);

    // print("*******************");
    // print(data.images[0].src);
    // print("*******************");
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _productImages(data.images, context),
                // SizedBox(
                //   height: 10,
                // ),
                Visibility(
                  visible: true,
                  // visible: data.calculateDiscount() > 0,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('${data.calculateDiscount()}%OFF',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),

                SizedBox(
                  height: 15,
                ),
                Text(
                  data.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(data.attributes != null && data.attributes.length > 0
                        ? data.attributes[0].options.join("-").toString() +
                            "" +
                            data.attributes[0].name
                        : "no attribute"),
                    Text(
                      "KSH ${data.salePrice}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomStepper(
                      lowerLimit: 0,
                      upperLimit: 20,
                      stepValue: 1,
                      iconSize: 22.0,
                      value: this.qty,
                      onChange: (value) {
                        cartProducts.quantity = value;
                        // print('eee');
                      },
                    ),
                    FlatButton(
                      onPressed: () {
                        // Provider.of<LoaderProvider>(context, listen: false)
                        //     .setLoadingStatus(true);
                        var cartProvider =
                            Provider.of<CartProvider>(context, listen: false);
                        cartProducts.productId = data.id;
                        cartProducts.quantity = 4;
                        print(json.encode(cartProducts));
                        cartProvider.addToCart(cartProducts, (val) {
                          // Provider.of<LoaderProvider>(context, listen: false)
                          //     .setLoadingStatus(false);
                        });
                      },
                      child: Text(
                        "Add to cart",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: kPrimaryColor,
                    )
                  ],
                ),

                SizedBox(),

                ExpandText(
                    labelHeader: "Product Details",
                    desc: data.description,
                    shortDesc: data.shortDescription),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                RelatedProductsWidget(
                    labelName: "Related Products",
                    products: this.data.relatedIds)
                // ExpandText(labelHeader: "Product Details",shortDesc: data.shortDescription, desc: desc.description)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _productImages(List<Images> images, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                // print("*******************");
                // print(images[0].src);
                // print("*******************");
                return Container(
                  child: Center(
                    child: Image.network(
                      images[index].src,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  aspectRatio: 1.0),
              carouselController: _controller,
            ),
          ),
          Positioned(
            top: 100,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                _controller.previousPage();
              },
            ),
          ),
          Positioned(
            top: 100,
            left: MediaQuery.of(context).size.width - 80,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                _controller.nextPage();
              },
            ),
          ),
        ],
      ),
    );
  }
}
