import 'package:remicare/reminder/medicine.dart';

late AppData appVar;
class AppData{
   Medicine currentMedicine = Medicine();
  List<Medicine> reminderHistory = []; // NOT IN USE
}