enum IncidentStatus { Submitted, InProgress, Completed }

enum IncidentType {
  Electricity,
  Water,
  Internet,
  Furniture,
  Other,
}

class IncidentModel {
  final String id;
  final IncidentType type;
  final String description;
  final List<String> imageUrls; // List of image URLs
  final DateTime reportedDate;
  final IncidentStatus status;
  final String? room; // Add room property

  IncidentModel({
    required this.id,
    required this.type,
    required this.description,
    required this.reportedDate,
    this.imageUrls = const [],
    this.status = IncidentStatus.Submitted,
    this.room, // Add to constructor
  });

  IncidentModel copyWith({
    String? id,
    IncidentType? type,
    String? description,
    List<String>? imageUrls,
    DateTime? reportedDate,
    IncidentStatus? status,
    String? room,
  }) {
    return IncidentModel(
      id: id ?? this.id,
      type: type ?? this.type,
      description: description ?? this.description,
      imageUrls: imageUrls ?? this.imageUrls,
      reportedDate: reportedDate ?? this.reportedDate,
      status: status ?? this.status,
      room: room ?? this.room,
    );
  }
}
