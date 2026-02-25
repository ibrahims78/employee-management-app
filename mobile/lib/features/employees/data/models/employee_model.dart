import 'package:json_annotation/json_annotation.dart';

part 'employee_model.g.dart';

@JsonSerializable()
class EmployeeModel {
  final int id;
  final String fullName;
  final String fatherName;
  final String motherName;
  final String placeOfBirth;
  final String? dateOfBirth;
  final String registryPlaceAndNumber;
  final String nationalId;
  final String? shamCashNumber;
  final String gender;
  final String certificateType;
  final String specialization;
  final String jobTitle;
  final String category;
  final String employmentStatus;
  final String appointmentDecisionNumber;
  final String? appointmentDecisionDate;
  final String? firstStateStart;
  final String? firstDirectorateStart;
  final String? firstDepartmentStart;
  final String currentStatus;
  final String assignedWork;
  final String mobile;
  final String address;
  final List<String>? documentPaths;
  final String? notes;

  EmployeeModel({
    required this.id,
    required this.fullName,
    required this.fatherName,
    required this.motherName,
    required this.placeOfBirth,
    this.dateOfBirth,
    required this.registryPlaceAndNumber,
    required this.nationalId,
    this.shamCashNumber,
    required this.gender,
    required this.certificateType,
    required this.specialization,
    required this.jobTitle,
    required this.category,
    required this.employmentStatus,
    required this.appointmentDecisionNumber,
    this.appointmentDecisionDate,
    this.firstStateStart,
    this.firstDirectorateStart,
    this.firstDepartmentStart,
    required this.currentStatus,
    required this.assignedWork,
    required this.mobile,
    required this.address,
    this.documentPaths,
    this.notes,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => _$EmployeeModelFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);
}
