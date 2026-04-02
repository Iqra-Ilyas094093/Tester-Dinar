class TrackingData {
  final String driverName;
  final String vehicleInfo;
  final String licensePlate;
  final double rating;
  final String driverPhone;
  final int etaMinutes;
  final String driverEmoji;
  final double carRelX;
  final double carRelY;
  final double destRelX;
  final double destRelY;

  const TrackingData({
    required this.driverName,
    required this.vehicleInfo,
    required this.licensePlate,
    required this.rating,
    required this.driverPhone,
    required this.etaMinutes,
    this.driverEmoji = '👨',
    this.carRelX = 0.28,
    this.carRelY = 0.52,
    this.destRelX = 0.72,
    this.destRelY = 0.65,
  });
}

const dummyTrackingData = TrackingData(
  driverName: 'Mohammed Al-Rashid',
  vehicleInfo: 'BMW 5 Series · Executive Saloon',
  licensePlate: 'LN21 DXR',
  rating: 4.9,
  driverPhone: '+447700900000',
  etaMinutes: 8,
);
