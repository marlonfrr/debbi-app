import 'package:debbi/core/models/product.dart';

class ProductsState {
  List<Product>? products;

  ProductsState({this.products});

  ProductsState copyWith({
    List<Product>? newProducts,
  }) =>
      ProductsState(
        products: newProducts ?? products,
      );
}
