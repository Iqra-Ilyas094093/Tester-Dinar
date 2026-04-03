import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'card_model.dart';

class CardNotifier extends StateNotifier<List<CardModel>> {
  CardNotifier()
      : super([
          // Default pre-loaded card
          const CardModel(
            id: 'default_1',
            cardHolderName: 'John Smith',
            cardNumber: '4242',
            expiry: '08/27',
            cardType: 'Visa',
            isDefault: true,
          ),
        ]);

  void addCard(CardModel card) {
    // If this is first card or marked default, update others
    final updatedList = state.map((c) => c.copyWith(isDefault: false)).toList();
    state = [...updatedList, card];
  }

  void setDefault(String id) {
    state = state.map((c) => c.copyWith(isDefault: c.id == id)).toList();
  }

  void removeCard(String id) {
    final remaining = state.where((c) => c.id != id).toList();
    // If removed card was default, make first card default
    if (remaining.isNotEmpty && !remaining.any((c) => c.isDefault)) {
      remaining[0] = remaining[0].copyWith(isDefault: true);
    }
    state = remaining;
  }

  CardModel? get defaultCard {
    try {
      return state.firstWhere((c) => c.isDefault);
    } catch (_) {
      return state.isNotEmpty ? state.first : null;
    }
  }
}

final cardProvider = StateNotifierProvider<CardNotifier, List<CardModel>>(
  (ref) => CardNotifier(),
);
