class VehicleModel {
  final String id;
  final String name;
  final String classLabel;
  final String emoji;
  final int pax;
  final int bags;
  final int etaMinutes;
  final double oneWayPrice;
  final double returnPrice;
  final bool isStandard;

  const VehicleModel({
    required this.id,
    required this.name,
    required this.classLabel,
    required this.emoji,
    required this.pax,
    required this.bags,
    required this.etaMinutes,
    required this.oneWayPrice,
    required this.returnPrice,
    required this.isStandard,
  });
}

const List<VehicleModel> kVehicles = [
  VehicleModel(
    id: 'executive_saloon',
    name: 'Executive Saloon',
    classLabel: 'STANDARD CLASS',
    emoji: '🚗',
    pax: 4,
    bags: 3,
    etaMinutes: 45,
    oneWayPrice: 52,
    returnPrice: 94,
    isStandard: true,
  ),
  VehicleModel(
    id: 'business_mpv',
    name: 'Business MPV',
    classLabel: 'PREMIUM CLASS',
    emoji: '🚙',
    pax: 6,
    bags: 5,
    etaMinutes: 50,
    oneWayPrice: 78,
    returnPrice: 142,
    isStandard: false,
  ),
  VehicleModel(
    id: 'luxury_vip',
    name: 'Luxury VIP',
    classLabel: 'VIP CLASS',
    emoji: '🚐',
    pax: 7,
    bags: 7,
    etaMinutes: 55,
    oneWayPrice: 120,
    returnPrice: 220,
    isStandard: false,
  ),
];
