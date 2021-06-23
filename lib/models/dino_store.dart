import 'package:hive/hive.dart';

part 'dino_store.g.dart';

@HiveType(typeId: 0)
class DinoStore extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String asset;

  @HiveField(2)
  String id;

  @HiveField(3)
  bool isSelected;

  @HiveField(4)
  bool isPurchased;

  @HiveField(5)
  int price;

  @HiveField(6)
  int dinoType;

  DinoStore(
      {required this.name,
      required this.asset,
      required this.id,
      required this.isSelected,
      required this.isPurchased,
      required this.price,
      required this.dinoType});
}
