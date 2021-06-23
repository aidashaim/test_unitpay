import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:test_unitpay/catalog.dart';
import 'package:test_unitpay/product_model.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int productCount;
  List<Product> productList;

  void addProduct() {
    Product _prod = Product(brands[Random().nextInt(brands.length)],
        images[Random().nextInt(images.length)]);
    productList.insert(0, _prod);
    setState(() {});
  }

  void deleteProduct(int index) {
    productList.removeAt(index);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Random random = new Random();
    productCount = random.nextInt(90000) + 10000;
    productList = List<Product>.generate(productCount,
        (int index) => Product(brands[index % 5], images[index % 5]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: GridView.builder(
          padding: EdgeInsets.all(20.0),
          itemCount: productList.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemBuilder: (BuildContext context, index) {
            return productWidget(productList[index], index);
          }),
    );
  }

  productWidget(Product product, int index) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Expanded(child: Image.network(product.image)),
              SizedBox(
                height: 10.0,
              ),
              Text(
                product.brand,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black.withOpacity(0.8)),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
        Positioned(
            right: 0.0,
            child: IconButton(
              onPressed: () => deleteProduct(index),
              icon: Icon(
                Icons.restore_from_trash,
                color: Colors.blue,
                size: 30.0,
              ),
            ))
      ],
    );
  }

  Widget appBarWidget() {
    return AppBar(
      title: Text('Unitpay Test'),
      actions: <Widget>[
        InkWell(
          onTap: () => addProduct(),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Center(
              child: Icon(
                Icons.add,
                size: 25.0,
                color: Colors.blue,
              ),
            ),
          ),
        )
      ],
    );
  }
}
