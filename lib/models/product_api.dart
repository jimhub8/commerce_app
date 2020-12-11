import 'package:shop_app/models/tetet.dart';
import 'package:woocommerce/woocommerce.dart';

String baseUrl = "https://swapstore.co.ke";
String consumerKey = "ck_11f7cb142327520f9757a978835c4a17791aa19f";
String consumerSecret = "cs_44b0d26c4e4e73fee6830a74d6aaa21ba2b780ae";

class ProductApi {
  // Future<List<Product>> fetchAllCategories() async {
  //   String allCategories = ApiUtility.MAIN_API_URL + ApiUtility.ALL_CATEGORIES;
  //   Map<String, String> headers = {'Accept': 'application/json'};
  //   var response = await http.get(allCategories, headers: headers);

  //   List<Product> categories = [];

  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> body = jsonDecode(response.body);
  //     for (var item in body['data']) {

  //       Product category = Product.fromJson(item);
  //       categories.add(category);
  //       // print('***************************************');
  //       // print(item);
  //       // print('***************************************');
  //     }
  //   }
  //   return categories;
  // }

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
    // setState(() {});
    print("@@@@@@@@@@@@@@@@@@@@@@@");
    print(products.toString());
    print("@@@@@@@@@@@@@@@@@@@@@@@");

    return products;
  }
}
