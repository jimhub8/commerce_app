import 'package:flutter/material.dart';
import 'package:shop_app/api/api_service.dart';
import 'package:shop_app/models/product.dart';

import '../../../constants.dart';
import '../../../constants.dart';

class ProductHome extends StatefulWidget {
  ProductHome({Key key, this.labelName, this.tagId}) : super(key: key);
  String labelName;
  String tagId;
  @override
  _ProductHomeState createState() => _ProductHomeState();
}

class _ProductHomeState extends State<ProductHome> {
  ApiService apiService;

  void initState() {
    apiService = new ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF4F7FA),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, top: 4),
                child: Text(
                  this.widget.labelName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 4),
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    'View all',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              )
            ],
          ),
          _productsList()
        ],
      ),
    );
  }

  Widget _productsList() {
    return new FutureBuilder(
      future: apiService.getProducts(sortOrder: 'asc', tagId: '33'),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> model) {
        if (model.hasData) {
          return _buildList(model.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildList(List<Product> products) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 350,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          var data = products[index];

          // return Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Container(
          //       margin: EdgeInsets.all(10),
          //       width: 130,
          //       height: 110,
          //       alignment: Alignment.center,
          //       child: Image.network(
          //         data.images[0].src != null
          //             ? data.images[0].src
          //             :   'https://swapstore.co.ke/wp-content/uploads/2020/08/enamel.jpg',
          //         height: 110,
          //       ),

          //       // child: ClipRRect(
          //       //   borderRadius: BorderRadius.circular(50.0),
          //       //   child: Image.network(
          //       //     data.image.url != null
          //       //         ? data.image.url
          //       //         : 'https://swapstore.co.ke/wp-content/uploads/2020/08/enamel.jpg',
          //       //     height: 80.0,
          //       //     width: 80.0,
          //       //   ),
          //       // ),
          //       decoration: BoxDecoration(
          //           shape: BoxShape.rectangle,
          //           color: Colors.white,
          //           boxShadow: [
          //             BoxShadow(
          //                 color: Colors.black12,
          //                 offset: Offset(0, 5),
          //                 blurRadius: 15)
          //           ]),
          //     ),
          //     Container(
          //       width: 130,
          //       alignment: Alignment.centerLeft,
          //       child: Text(
          //         data.name,
          //         style: TextStyle(fontSize: 14, color: Colors.black),
          //       ),
          //     ),
          //     Container(
          //       margin: EdgeInsets.only(top: 4, left: 4),
          //       width: 130,
          //       alignment: Alignment.centerLeft,
          //       child: Row(
          //         children: [
          //           Text(
          //             // 'Ksh 1000',
          //             'KSH ${data.regularPrice}',
          //             style: TextStyle(
          //                 fontSize: 14,
          //                 decoration: TextDecoration.lineThrough,
          //                 color: Colors.redAccent,
          //                 fontWeight: FontWeight.bold),
          //           ),
          //           Text(
          //             'KSH ${data.regularPrice}',
          //             style: TextStyle(
          //                 fontSize: 14,
          //                 color: Colors.black,
          //                 fontWeight: FontWeight.bold),
          //           ),
          //         ],
          //       ),
          //     )
          //   ],
          // );

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  // height: 400,
                  margin: EdgeInsets.only(
                    left: kDefaultPadding,
                    top: kDefaultPadding / 2,
                    bottom: kDefaultPadding * 2.5,
                  ),
                  width: size.width * 0.4,
                  child: Column(
                    children: <Widget>[
                      Image.network(
                        data.images[0].src,
                        height: 160,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(kDefaultPadding / 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 50,
                                  color: kPrimaryColor.withOpacity(0.23)),
                            ],
                          ),
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 130,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      data.name,
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black),
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 4, left: 4),
                                    width: 130,
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Text(
                                          // 'Ksh 1000',
                                          'KSH ${data.regularPrice}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.redAccent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(
                                          'KSH ${data.regularPrice}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                              // RichText(
                              //   overflow: TextOverflow.ellipsis,
                              //   text: TextSpan(
                              //     children: [
                              //       TextSpan(

                              //           text: "${data.name}\n",
                              //           style:
                              //               Theme.of(context).textTheme.button),
                              //       TextSpan(
                              //           text: "Kenya".toUpperCase(),
                              //           style: TextStyle(
                              //               color:
                              //                   kTextColor.withOpacity(0.5))),
                              //     ],
                              //   ),
                              // ),
                              // Spacer(),
                              // Text(
                              //   "\$$data.price",
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .button
                              //       .copyWith(color: kPrimaryColor),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
