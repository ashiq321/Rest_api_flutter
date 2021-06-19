import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/SelectProductCard.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_app_test/repository/model/DatumProduct.dart';
import 'package:flutter_app_test/repository/model/ProductData.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int page = 2;
  ScrollController _sccontroller = new ScrollController();

  bool isLoading = false;
  ProductData products;
  List<DatumProduct> search_result_list = List<DatumProduct>();
  DatumProduct datumProduct;

  @override
  void initState() {
    super.initState();
    getSearchResult(1);
  }

  Future<void> getSearchResult(int index) async {
    var endpointUrl = 'https://halalbari.com/api/home-products';
    Map<String, String> queryParams = {
      'page': index.toString(),
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = endpointUrl + '?' + queryString;
    var response = await http.get(requestUrl);

    var data = json.decode(response.body);

    products = ProductData.fromJson(data);

    for (int i = 0; i < products.data.length; i++) {
      datumProduct = DatumProduct();
      datumProduct.id = products.data[i].id;
      datumProduct.title = products.data[i].title;
      datumProduct.featureImg = products.data[i].featureImg;
      datumProduct.finalPrice = products.data[i].finalPrice;
      datumProduct.salePrice = products.data[i].salePrice;
      datumProduct.rating = products.data[i].rating;
      datumProduct.totalrating = products.data[i].totalrating;
      search_result_list.add(datumProduct);

      changeStateList();
      isLoading = false;
    }
  }

  changeStateList() {
    if (mounted) {
      setState(() {

      });
    }
  }

  @override
  void dispose() {
    _sccontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: search_result_list != null ?
      buildSteggerGrid(context) :
      Container(),
    );
  }

  buildSteggerGrid(BuildContext context) {
    return NotificationListener(
      onNotification: onNotification,
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        shrinkWrap: true,
        controller: _sccontroller,
        itemCount: search_result_list.length,
        physics: ScrollPhysics(),
        staggeredTileBuilder: (int index) =>
        new StaggeredTile.fit(1),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        itemBuilder:
            (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {},
            child: SelectProductCard(
              choice: search_result_list[index],
            ),
          );
        },
      ), // GridView.builder
    ); //
  }

  bool onNotification(ScrollNotification notification) {
    if (!isLoading && notification.metrics.pixels ==
        notification.metrics.maxScrollExtent) {
     _loadData(page);
      // start loading data
      setState(() {
        isLoading = true;
      });
    }
    return true;
  }

  Future<List> getHomePageProduct(int currentPage) async {
    print('currentPageProduct: ${currentPage.toString()}');
    var endpointUrl = 'https://halalbari.com/api/home-products';
    Map<String, String> queryParams = {
      'page': currentPage.toString(),
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = endpointUrl + '?' + queryString;
    var response = await http.get(requestUrl);

    var data = json.decode(response.body);

    products = ProductData.fromJson(data);

    print(response.body);
    ChangeProducts_State();
  }

  ChangeProducts_State() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _loadData(int index) async {
    print('page :  ${index}');
    var endpointUrl = 'https://halalbari.com/api/home-products';
    Map<String, String> queryParams = {
      'page': index.toString(),
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = endpointUrl + '?' + queryString;
    var response = await http.get(requestUrl);

    var data = json.decode(response.body);

    products = ProductData.fromJson(data);

    if(response.statusCode == 200){
      if(products.data.length > 0){
        for (int i = 0; i < products.data.length; i++) {
          datumProduct = DatumProduct();
          datumProduct.id = products.data[i].id;
          datumProduct.title = products.data[i].title;
          datumProduct.featureImg = products.data[i].featureImg;
          datumProduct.finalPrice = products.data[i].finalPrice;
          datumProduct.salePrice = products.data[i].salePrice;
          datumProduct.rating = products.data[i].rating;
          datumProduct.totalrating = products.data[i].totalrating;
          search_result_list.add(datumProduct);

          changeStateListMore();

          isLoading = false;
          page = page + 1;
        }
      }else{
        isLoading = false;
        print('No more data1');
      }
    }else{
      print('No more data');
      isLoading = false;
    }

  }

  changeStateListMore() {
    if (mounted) {
      setState(() {

      });
    }
  }
}