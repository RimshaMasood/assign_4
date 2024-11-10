import 'package:assignment4/modal/product_modal.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  int _selectedIndex = 0; 

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (quantity > 1) quantity--;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.product.image, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            _buildProductInfo(),
            const Spacer(),
            _buildPriceAndCartButton(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: _decrementQuantity,
                  icon: const Icon(Icons.remove),
                ),
                Text('$quantity', style: const TextStyle(fontSize: 18)),
                IconButton(
                  onPressed: _incrementQuantity,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),

        Row(
          children: List.generate(
            5,
            (index) => const Icon(
              Icons.star,
              color: Colors.yellow,
              size: 20,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Product size
        const Text('Size: S, M, L, XL', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),

        // Product description
        Text(widget.product.description, style: const TextStyle(fontSize: 16)),

        // Reviews
        const SizedBox(height: 10),
        const Text('(270 Reviews)', style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildPriceAndCartButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$${widget.product.price.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart),
          label: const Text('Add to Cart'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        ),
      ],
    );
  }
}
