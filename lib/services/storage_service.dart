import 'package:hive_flutter/hive_flutter.dart';
import 'package:mock_plant_care_app/model/plant_model.dart';

class StorageService {
  static const String plantsBoxName = 'plants_box';
  static const String settingsBoxName = 'settings_box';
  static const String themeKey = 'theme_mode';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<Map>(plantsBoxName);
    await Hive.openBox(settingsBoxName);
  }

  Box<Map> get _plantsBox => Hive.box<Map>(plantsBoxName);
  Box get _settingsBox => Hive.box(settingsBoxName);

  List<PlantModel> getPlants() {
    return _plantsBox.values
        .map((Map raw) => PlantModel.fromMap(raw))
        .toList(growable: false);
  }

  Future<void> savePlant(PlantModel plant) async {
    await _plantsBox.put(plant.id, plant.toMap());
  }

  Future<void> deletePlant(String plantId) async {
    await _plantsBox.delete(plantId);
  }

  String? getThemeMode() => _settingsBox.get(themeKey) as String?;

  Future<void> saveThemeMode(String modeName) async {
    await _settingsBox.put(themeKey, modeName);
  }
}
