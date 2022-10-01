import 'dart:convert';

import 'package:debbi/core/models/transaction.dart';
import 'package:debbi/core/repository.dart';
import 'package:debbi/ui/products.dart';
import 'package:debbi/ui/link_webview.dart';
import 'package:debbi/ui/widgets/widgets.dart';
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

class BanksList extends ConsumerStatefulWidget {
  const BanksList({Key? key}) : super(key: key);

  @override
  ConsumerState<BanksList> createState() => _BanksListState();
}

class _BanksListState extends ConsumerState<BanksList> {
  List<Transaction>? transactions;
  String? accessToken;
  @override
  void initState() {
    super.initState();
    getAccessToken();
    getTransactions();
  }

  Future<void> getAccessToken() async {
    Response? response = await Repository.instance.request(
      path: 'https://evening-journey-83850.herokuapp.com/api/v1/links/token',
      method: HttpMethod.GET,
    );
    final res = jsonDecode(response!.body);
    setState(() => accessToken = res['token']);
  }

  Future<void> getTransactions() async {
    Response? response = await Repository.instance.request(
      path:
          'https://evening-journey-83850.herokuapp.com/api/v1/transactions/asd',
      method: HttpMethod.GET,
    );
    List<dynamic> listdynamic = jsonDecode(response!.body)['transactions'];
    print(listdynamic);
    var transactionsList = List<Transaction>.from(
        (listdynamic).map((e) => Transaction.fromJson(e)));
    setState(() => transactions = transactionsList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ElevatedButton(
                onPressed: accessToken == null
                    ? null
                    : () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => LinkWebView(accessToken!)));
                      },
                child: const Text('Go nav'),
              ),
              ElevatedButton(
                onPressed: accessToken == null
                    ? null
                    : () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const ProductsView()));
                      },
                child: const Text('Go accounts'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Últimas transacciones',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: transactions?.length ?? 0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) =>
                    TransactionTile(transactions!.elementAt(index)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
