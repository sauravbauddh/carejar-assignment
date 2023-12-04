import 'package:hive/hive.dart';
import 'package:intern_assignment/model/Category.dart';

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 1; // You can use any positive integer here

  @override
  Category read(BinaryReader reader) {
    return Category(
      id: reader.readInt(),
      categoryName: reader.readString(),
      description: reader.readString(),
      qualification: reader.readString(),
      code: reader.readString(),
      imageUrl: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.categoryName);
    writer.writeString(obj.description);
    writer.writeString(obj.qualification);
    writer.writeString(obj.code);
    writer.writeString(obj.imageUrl!);
  }
}
