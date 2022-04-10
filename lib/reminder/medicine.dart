// ignore_for_file: unnecessary_this

class Medicine {
   String? medicineName;
   String? dosage;
   String? medicineType;
   int? interval;
   String? startTime;

  Medicine({
     this.medicineName,
     this.dosage,
     this.medicineType,
     this.startTime,
     this.interval,
  });

  String get getName => medicineName ?? "";
  String get getDosage => dosage ?? "";
  String get getType => medicineType ?? "";
  int get getInterval => interval ?? 0;
  String get getStartTime => startTime ?? "";

  Map<String, dynamic> toJson() {
    return {
      "name": this.medicineName,
      "dosage": this.dosage,
      "type": this.medicineType,
      "interval": this.interval,
      "start": this.startTime,
    };
  }

  factory Medicine.fromJson(Map<String, dynamic> parsedJson) {
    return Medicine(
      medicineName: parsedJson['name'],
      dosage: parsedJson['dosage'],
      medicineType: parsedJson['type'],
      interval: parsedJson['interval'],
      startTime: parsedJson['start'],
    );
  }
}