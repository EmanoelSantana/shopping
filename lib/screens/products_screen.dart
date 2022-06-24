import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/components/app_drawer.dart';
import 'package:shopping/components/product_item.dart';
import 'package:shopping/models/product_list.dart';
import 'package:shopping/utils/app_routes.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  Future<void> _refreshProduct(BuildContext context) {
    return Provider.of<ProductList>(
      context,
      listen: false,
    ).loadProduct();
  }

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCT_FORM,
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProduct(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder: (ctx, i) => Column(
              children: [
                ProductItem(product: products.items[i]),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
