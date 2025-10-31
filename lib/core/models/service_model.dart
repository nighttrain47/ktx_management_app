enum ServiceStatus { Available, Registered, Pending }

class ServiceModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String unit; // e.g., 'per month', 'per kg'
  final ServiceStatus status;

  ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.unit,
    this.status = ServiceStatus.Available,
  });

  ServiceModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? unit,
    ServiceStatus? status,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      status: status ?? this.status,
    );
  }
}
