import 'package:flutter/material.dart';
import 'package:productos_app/models/product.dart';
import 'package:productos_app/services/product_service.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Productos')),
      ),
      body: products.isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.indigo,
            ))
          : ListView.builder(
              itemCount: products.products.length,
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    products.selectedProduct = products.products[index].copy();
                    Navigator.pushNamed(context, 'product');
                  },
                  child: CardProduct(
                    product: products.products[index],
                  ))),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          products.selectedProduct = Product(
            available: true,
            name: '',
            price: 0,
          );
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}
