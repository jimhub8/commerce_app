import 'package:flutter/cupertino.dart';
import 'package:shop_app/api/api_service.dart';
import 'package:shop_app/models/product.dart';

class SortBy {
  String value;
  String text;
  String sortOrder;

  SortBy(this.value, this.text, this.sortOrder);
}

enum LoadMoreStatus { INITIAL, LOADING, STABLE }

class ProductProvider with ChangeNotifier {
  ApiService _apiService;

  List<Product> _productList;
  SortBy _sortBy;
  int pageSize = 10;

  List<Product> get allProducts => _productList;
  double get totalRecords => _productList.length.toDouble();
  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.STABLE;
  getLoadMoreStatus() => _loadMoreStatus;
  ProductProvider() {
    resetStreams();
    _sortBy = SortBy('modified', 'Latest', 'asc');
  }

  void resetStreams() {
    _apiService = ApiService();
    _productList = List<Product>();
  }

  setLoadingState(LoadMoreStatus loadMoreStatus) {
    _loadMoreStatus = loadMoreStatus;
    notifyListeners();
  }

  setSortOrder(SortBy sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }

  fetchProducts(
    int pageNumber, {
    String strSearch,
    String tagName,
    String categoryId,
    String sortBy,
    String sortOrder = "asc",
  }) async {
    List<Product> itemModel = await _apiService
        // .getProducts(
        //     null, null, null, null, null, null, 'asc', '33');
        .getProducts(pageNumber: pageNumber, pageSize: this.pageSize, strSearch:strSearch, tagName: tagName, categoryId: categoryId, sortBy: this._sortBy.value, sortOrder: this._sortBy.sortOrder, tagId: '416');

    if (itemModel.length > 0) {
      _productList.addAll(itemModel);
    }
    setLoadingState(LoadMoreStatus.STABLE);
    notifyListeners();
  }
}
