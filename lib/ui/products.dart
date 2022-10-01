import 'dart:convert';

import 'package:debbi/core/endpoints.dart' as endpoints;
import 'package:debbi/core/models/product.dart';
import 'package:debbi/core/repository.dart';
import 'package:debbi/ui/extensions/currency.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  State<ProductsView> createState() => ProductsViewState();
}

class ProductsViewState extends State<ProductsView> {
  List<Product> products = [];
  @override
  void initState() {
    super.initState();
    getAccounts();
  }

  void getAccounts() async {
    Response? response = await Repository.instance.request(
      path: endpoints.getProducts,
      method: HttpMethod.GET,
    );
    List<dynamic> listdynamic = jsonDecode(response!.body)['accounts'];
    var productsList =
        List<Product>.from((listdynamic).map((e) => Product.fromJson(e)));
    setState(() => products = productsList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Cuentas',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (products.isNotEmpty)
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: products.length,
                itemBuilder: (BuildContext context, index) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(products[index].name),
                      Row(
                        children: [
                          Text(products[index].category.contains('CARD')
                              ? 'Utilizado:'
                              : 'Saldo:'),
                          Text(formatPriceFromDouble(
                              products[index].balance.current)),
                        ],
                      ),
                    ],
                  ),
                ),
                shrinkWrap: true,
              )
            else
              const CircularProgressIndicator(),
          ],
        )),
      ),
    );
  }
}
