class Products {
  final String? name;
  final int? price;
  final String? image;
  final String? description;

  Products({
    this.name,
    this.price,
    this.image,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description':description,
      'price': price,
      'image': image,
    };
  }

  factory Products.fromMap(Map<String, dynamic> map,) {
    return Products(
      name: map['name'] as String,
      price: map['price'] as int,
      image: map['image'] as String,
      description: map['description'] as String,

    );
  }
}