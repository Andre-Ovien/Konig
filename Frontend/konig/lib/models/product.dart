class Product {
  final String name;
  final String category;
  final double? price;
  final double? oldPrice;
  final String imageUrl;
  final bool isFavorite;
  final String description;

  const Product({
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.price,
    this.oldPrice,
    this.isFavorite = false,
  });
}

final List<Product> products = [
  const Product(
    category: 'Fruits',
    description: 'description of product A',
    imageUrl: 'assets/images/apple.jpg',
    name: 'Apple',
    price: 69.00,
    oldPrice: 189.00,
    ),
  const Product(
    category: 'Food',
    description: 'description of product A',
    imageUrl: 'assets/images/beans.jpg',
    name: 'Beans',
    price: 69.00,
    oldPrice: 189.00,
    ),
  const Product(
    category: 'Food',
    description: 'description of product A',
    imageUrl: 'assets/images/garri.jpg',
    name: 'Garri',
    price: 69.00,
    oldPrice: 189.00,
    ),
  const Product(
    category: 'Fruits',
    description: 'description of product A',
    imageUrl: 'assets/images/orange.jpg',
    name: 'Orange',
    price: 69.00,
    oldPrice: 189.00,
    ),
  const Product(
    category: 'Fruits',
    description: 'description of product A',
    imageUrl: 'assets/images/pineapple.jpg',
    name: 'Pineapple',
    price: 69.00,
    oldPrice: 189.00,
    ),  
  const Product(
    category: 'Food',
    description: 'description of product A',
    imageUrl: 'assets/images/potato.jpg',
    name: 'Potato',
    price: 69.00,
    oldPrice: 189.00,
    ),  
];