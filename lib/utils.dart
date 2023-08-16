import 'package:simpsonsviewer/types.dart';

String getFirstAndLastName(Map<String, dynamic> rawData) {
  final url = rawData['FirstURL'] as String;
  
  // Split on '/' and '_'
  final parts = url.split('/').last.split('_');

  // First part is first name
  final firstName = parts.first;

  // Last part is last name
  final lastName = parts.last;

  return '$firstName $lastName'; 
}