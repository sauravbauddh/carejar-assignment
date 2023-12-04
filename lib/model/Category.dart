class Category {
  int id;
  String categoryName;
  String description;
  String qualification;
  String code;
  String? imageUrl;

  Category({
    required this.id,
    required this.categoryName,
    required this.description,
    required this.qualification,
    required this.code,
    this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      categoryName: json['categoryName'],
      description: json['description'],
      qualification: json['qualification'],
      code: json['code'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryName': categoryName,
      'description': description,
      'qualification': qualification,
      'code': code,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }

  int get getId => id;
  set setId(int id) => this.id = id;

  String get getCategoryName => categoryName;
  set setCategoryName(String categoryName) => this.categoryName = categoryName;

  String get getDescription => description;
  set setDescription(String description) => this.description = description;

  String get getQualification => qualification;
  set setQualification(String qualification) => this.qualification = qualification;

  String get getCode => code;
  set setCode(String code) => this.code = code;

  String? get getImageUrl => imageUrl;
  set setImageUrl(String? imageUrl) => this.imageUrl = imageUrl;
}
