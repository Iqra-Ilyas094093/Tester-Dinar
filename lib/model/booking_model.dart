class BookingModel {
  final String id;
  final String reference;
  final String pickup;
  final String dropoff;
  final String date;
  final double amount;
  final String status; // upcoming | completed | cancelled

  const BookingModel({
    required this.id,
    required this.reference,
    required this.pickup,
    required this.dropoff,
    required this.date,
    required this.amount,
    required this.status,
  });
}

const List<BookingModel> kMockBookings = [
  BookingModel(
    id: '7841',
    reference: 'DNA-2025-7841',
    pickup: 'Heathrow T5, London',
    dropoff: 'Mayfair, W1K',
    date: '15 Aug 2025 · 09:30',
    amount: 59.00,
    status: 'upcoming',
  ),
  BookingModel(
    id: '6210',
    reference: 'DNA-2025-6210',
    pickup: 'Gatwick Airport North',
    dropoff: 'Chelsea, SW3',
    date: '2 Aug 2025 · 14:15',
    amount: 87.00,
    status: 'Past',
  ),
  BookingModel(
    id: '5100',
    reference: 'DNA-2025-5100',
    pickup: 'Stansted Airport',
    dropoff: 'Kensington, W8',
    date: '10 Jul 2025 · 07:00',
    amount: 72.00,
    status: 'cancelled',
  ),
];
