import 'package:hive/hive.dart';

part 'hive_database.g.dart';

@HiveType(typeId: 1)
class HiveDatabase {
  HiveDatabase({
    required this.date,
    required this.consoleName,
    required this.consoleData,
  });

  @HiveField(0)
  DateTime date;

  @HiveField(1)
  String consoleName;

  @HiveField(2)
  Map<String, dynamic> consoleData;

  @override
  String toString() {
    return '$consoleName: dar zaman $date karkadesh : $consoleData';
  }
}
