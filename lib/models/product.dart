class Product {
  final int id;
  final String title;
  final dynamic price;
  final String description;
  final String category;
  final String image;

  Product(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        description: json['description'],
        category: json['category'],
        image: json['image']);
  }
}
