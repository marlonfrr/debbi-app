import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:debbi/core/products/state.dart';

class ProductsViewModel extends StateNotifier<ProductsState> {
  ProductsViewModel() : super(ProductsState());
}
