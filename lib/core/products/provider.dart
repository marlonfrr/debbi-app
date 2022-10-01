import 'package:debbi/core/products/state.dart';
import 'package:debbi/core/products/viewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

StateNotifierProvider<ProductsViewModel, ProductsState> productsViewModel =
    StateNotifierProvider<ProductsViewModel, ProductsState>(
  (ref) => ProductsViewModel(),
);
