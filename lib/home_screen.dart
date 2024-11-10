import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'product_screen.dart';
import 'modal/product_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Product> products = [
    Product(
      image: 'assets/images/blackbag.jpeg',
      name: 'Classic Black Bag',
      description: 'Stylish and spacious',
      price: 89.99,
      rating: 4.7,
      stock: 10,
      discount: '40% off',
      promoCode: 'FSCREATION',
    ),
    Product(
      image: 'assets/images/shoe.jpeg',
      name: 'Axel Arigato',
      description: 'Clean 90 Triple Sneakers',
      price: 195.00,
      rating: 4.5,
      stock: 20,
      discount: '70% off',
      promoCode: 'FSCREATION',
    ),
       Product(
      image: 'assets/images/sandal.jpeg',
      name: 'Gia Borghini',
      description: 'RHW Rosie 1 sandals',
      price: 740.00,
      rating: 4.5,
      stock: 20,
      discount: '70% off',
      promoCode: 'FSCREATION',
    ),
    Product(
      image: 'assets/images/bluebag.jpeg',
      name: 'The Marc Jacobs',
      description: 'The Traveler Tate',
      price: 99.99,
      rating: 4.5,
      stock: 20,
      discount: '50% off',
      promoCode: 'FSCREATION',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildCarousel(),
          _buildSectionHeader('New Arrival', onViewMore: () {}),
          _buildProductGrid(),
          _buildSectionHeader('Popular'),
          _buildPopularList(),
        ],
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

  Widget _buildCarousel() {
    return SizedBox(
      height: 200,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200,
          enlargeCenterPage: true,
          viewportFraction: 0.7,
          autoPlay: true,
        ),
        items: products.map((product) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product: product),
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(product.image, fit: BoxFit.cover),
                Container(color: Colors.black.withOpacity(0.3)),
                _buildCarouselText(product),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCarouselText(Product product) {
    return Positioned(
      left: 10,
      bottom: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.discount,
            style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const Text('on everything today', style: TextStyle(fontSize: 18, color: Colors.white)),
          Text('with code: ${product.promoCode}', style: const TextStyle(fontSize: 16, color: Colors.white70)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: const Text('Get More', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onViewMore}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          if (onViewMore != null)
            TextButton(onPressed: onViewMore, child: const Text('View More')),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 3 / 4,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product: product),
              ),
            ),
            child: Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Image.asset(product.image, fit: BoxFit.cover)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(product.name),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('\$${product.price.toStringAsFixed(2)}'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPopularList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(product.image, width: 80, height: 80, fit: BoxFit.cover),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(product.description),
                      Row(
                        children: List.generate(
                          5,
                          (starIndex) => Icon(
                            Icons.star,
                            color: starIndex < product.rating ? Colors.yellow : Colors.grey,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text('\$${product.price.toStringAsFixed(2)}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
