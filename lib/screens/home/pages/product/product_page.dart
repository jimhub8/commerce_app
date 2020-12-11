import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/screens/home/pages/product/base_page.dart';
import 'product_card.dart';

class ProductPage extends BasePage {
  ProductPage(this.categoryId, {Key key}) : super(key: key);

  int categoryId;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends BasePageState<ProductPage> {
  // ApiService apiService;

  int _page = 1;
  ScrollController _scrollController = new ScrollController();

  final _searchQuery = new TextEditingController();
  Timer _debounce;

  final _sortByOptions = [
    SortBy("populality", "populality", 'asc'),
    SortBy("modified", "Latest", 'asc'),
    SortBy("price", "Price: High to Low", 'desc'),
    SortBy("price", "Price: Low to High", 'asc'),
  ];

  void initState() {
    // apiService = new ApiService();
    var productList = Provider.of<ProductProvider>(context, listen: false);
    productList.resetStreams();
    productList.setLoadingState(LoadMoreStatus.INITIAL);
    productList.fetchProducts(_page);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        productList.setLoadingState(LoadMoreStatus.LOADING);
        productList.fetchProducts(++_page);
      }
    });

    _searchQuery.addListener(_onSearchChanege);

    super.initState();
  }

  _onSearchChanege() {
    var productsList = Provider.of<ProductProvider>(context, listen: false);
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(microseconds: 500), () {
      productsList.resetStreams();
      // productsList.setLoadingState(LoadMoreStatus.INITIAL);
      productsList.fetchProducts(_page, strSearch: _searchQuery.text);
    });
  }

  @override
  Widget pageUI() {
    return _productsList();
  }

  Widget _productsList() {
    return new Consumer<ProductProvider>(
      // future: apiService.getProducts(
      // null, null, null, null, null, null, 'asc', '416'),
      builder: (context, productsModel, child) {
        // print('*********************************');
        // print(productsModel.allProducts.length > 0);
        // print('££££££££££££££££££££££££££££££££££££££££');
        if (productsModel.allProducts != null &&
            productsModel.allProducts.length > 0 &&
            productsModel.getLoadMoreStatus() != LoadMoreStatus.INITIAL) {
          return _buildList(productsModel.allProducts,
              productsModel.getLoadMoreStatus() == LoadMoreStatus.LOADING);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildList(List<Product> items, bool isLoadingMore) {
    return Column(
      children: [
        _productFilter(),
        Flexible(
          child: GridView.count(
            shrinkWrap: true,
            controller: _scrollController,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,
            children: items.map((Product item) {
              return ProductCard(data: item);
            }).toList(),
          ),
        ),
        Visibility(
          child: Container(
            padding: EdgeInsets.all(5),
            height: 35,
            width: 35,
            child: CircularProgressIndicator(),
          ),
          visible: isLoadingMore,
        ),
      ],
    );
  }

  Widget _productFilter() {
    return Container(
      height: 51,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _searchQuery,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'search',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none),
                  fillColor: Color(0xffe6e6ec),
                  filled: true),
            ),
          ),
          SizedBox(width: 15),
          Container(
            decoration: BoxDecoration(
                color: Color(0xffe6e6ec),
                borderRadius: BorderRadius.circular(9)),
            child: PopupMenuButton(
              onSelected: (sortBy) {
                var productList =
                    Provider.of<ProductProvider>(context, listen: false);
                productList.resetStreams();
                productList.setSortOrder(sortBy);
                productList.fetchProducts(_page);
              },
              itemBuilder: (BuildContext context) {
                return _sortByOptions.map((item) {
                  return PopupMenuItem(
                      value: item,
                      child: Container(
                        child: Text(item.text),
                      ));
                }).toList();
              },
              icon: Icon(Icons.tune),
            ),
          )
        ],
      ),
    );
  }
}
