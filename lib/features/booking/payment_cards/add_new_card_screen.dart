import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';
import 'package:dinar_app/model/card_provider.dart';
import 'package:dinar_app/model/card_model.dart';

class AddNewCardScreen extends ConsumerStatefulWidget {
  const AddNewCardScreen({super.key});

  @override
  ConsumerState<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends ConsumerState<AddNewCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _numberCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _expiryCtrl = TextEditingController();

  String _detectedType = 'Card';
  bool _isSaving = false;

  @override
  void dispose() {
    _numberCtrl.dispose();
    _nameCtrl.dispose();
    _expiryCtrl.dispose();
    super.dispose();
  }

  void _onNumberChanged(String value) {
    final formatted = CardValidator.formatNumber(value
        .replaceAll(' ', '')
        .substring(0, value.replaceAll(' ', '').length.clamp(0, 16)));
    if (formatted != value) {
      _numberCtrl.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
    setState(() {
      _detectedType = CardValidator.detectType(value);
    });
  }

  void _onExpiryChanged(String value) {
    final digits = value.replaceAll('/', '');
    if (digits.length <= 4) {
      String formatted = digits;
      if (digits.length >= 2) {
        formatted = '${digits.substring(0, 2)}/${digits.substring(2)}';
      }
      if (formatted != value) {
        _expiryCtrl.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
    }
  }

  Future<void> _saveCard(WidgetRef ref) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(milliseconds: 500));

    final rawNumber = _numberCtrl.text.replaceAll(' ', '');
    final last4 = rawNumber.substring(rawNumber.length - 4);

    final card = CardModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      cardHolderName: _nameCtrl.text.trim(),
      cardNumber: last4,
      expiry: _expiryCtrl.text.trim(),
      cardType: _detectedType,
      isDefault: ref.read(cardProvider).isEmpty,
    );

    ref.read(cardProvider.notifier).addCard(card);
    setState(() => _isSaving = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$_detectedType card added successfully!'),
          backgroundColor: AppColors.brandGold,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 2),
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      final cardBg = isDark ? AppColors.darkCard : Colors.white;
      final textColor = isDark ? Colors.white : AppColors.nearBlack;
      final subColor = isDark ? AppColors.mutedBlue : AppColors.darkGray;

      // Live card preview values
      final rawNumber = _numberCtrl.text.replaceAll(' ', '');
      final displayNumber = rawNumber.isEmpty
          ? '•••• •••• •••• ••••'
          : CardValidator.formatNumber(rawNumber).padRight(19, '•');
      final displayName =
          _nameCtrl.text.isEmpty ? 'CARDHOLDER' : _nameCtrl.text.toUpperCase();
      final displayExpiry =
          _expiryCtrl.text.isEmpty ? 'MM/YY' : _expiryCtrl.text;

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightGray,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.arrow_back_rounded, size: 20, color: textColor),
            ),
            onPressed: () => context.pop(),
          ),
          title: Text('Add New Card', style: TextStyle(color: textColor)),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ── Live Card Preview ──
              _LiveCardPreview(
                displayNumber: displayNumber,
                displayName: displayName,
                displayExpiry: displayExpiry,
                cardType: _detectedType,
              ),
              const SizedBox(height: 24),

              // ── Card Number ──
              _FieldLabel(label: 'CARD NUMBER', isDark: isDark),
              const SizedBox(height: 6),
              _buildField(
                controller: _numberCtrl,
                hint: '1234 5678 9012 3456',
                isDark: isDark,
                cardBg: cardBg,
                textColor: textColor,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(19),
                ],
                onChanged: _onNumberChanged,
                suffixIcon: _detectedType != 'Card'
                    ? Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(_detectedType,
                            style: const TextStyle(
                                color: AppColors.brandGold,
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      )
                    : null,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Enter card number';
                  if (!CardValidator.isValidLuhn(v)) {
                    return 'Invalid card number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // ── Cardholder Name ──
              _FieldLabel(label: 'CARDHOLDER NAME', isDark: isDark),
              const SizedBox(height: 6),
              _buildField(
                controller: _nameCtrl,
                hint: 'John Smith',
                isDark: isDark,
                cardBg: cardBg,
                textColor: textColor,
                keyboardType: TextInputType.name,
                onChanged: (_) => setState(() {}),
                validator: (v) {
                  if (v == null || v.trim().isEmpty)
                    return 'Enter cardholder name';
                  if (v.trim().length < 2) return 'Name too short';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // ── Expiry ──
              _FieldLabel(label: 'EXPIRY DATE', isDark: isDark),
              const SizedBox(height: 6),
              _buildField(
                controller: _expiryCtrl,
                hint: 'MM/YY',
                isDark: isDark,
                cardBg: cardBg,
                textColor: textColor,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                onChanged: _onExpiryChanged,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Enter expiry date';
                  if (!CardValidator.isValidExpiry(v)) {
                    return 'Invalid or expired date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),

              // ── Security note ──
              Row(
                children: const [
                  Icon(Icons.lock_outline_rounded,
                      size: 13, color: AppColors.mutedBlue),
                  SizedBox(width: 4),
                  Text(
                    'Secured by Stripe · PCI DSS Compliant',
                    style: TextStyle(fontSize: 11, color: AppColors.mutedBlue),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // ── Save Button ──
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : () => _saveCard(ref),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brandGold,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28)),
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                      : const Text('Save Card',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required bool isDark,
    required Color cardBg,
    required Color textColor,
    required TextInputType keyboardType,
    List<TextInputFormatter>? inputFormatters,
    void Function(String)? onChanged,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        validator: validator,
        style: TextStyle(fontSize: 15, color: textColor),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.mutedBlue, fontSize: 14),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

// ── Field Label ───────────────────────────────────────────────────────────────
class _FieldLabel extends StatelessWidget {
  final String label;
  final bool isDark;
  const _FieldLabel({required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Text(label,
        style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.mutedBlue,
            letterSpacing: 1.2));
  }
}

// ── Live Card Preview ─────────────────────────────────────────────────────────
class _LiveCardPreview extends StatelessWidget {
  final String displayNumber;
  final String displayName;
  final String displayExpiry;
  final String cardType;

  const _LiveCardPreview({
    required this.displayNumber,
    required this.displayName,
    required this.displayExpiry,
    required this.cardType,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 180,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E2D50), Color(0xFF2C3E6B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.navyDark.withOpacity(0.5),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chip
          Container(
            width: 36,
            height: 26,
            decoration: BoxDecoration(
              color: AppColors.brandGold,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const Spacer(),
          // Number
          Text(
            displayNumber,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          // Bottom row
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('CARDHOLDER',
                      style: TextStyle(
                          fontSize: 9,
                          color: AppColors.mutedBlue,
                          letterSpacing: 1)),
                  Text(displayName,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ],
              ),
              const SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('EXPIRES',
                      style: TextStyle(
                          fontSize: 9,
                          color: AppColors.mutedBlue,
                          letterSpacing: 1)),
                  Text(displayExpiry,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ],
              ),
              const Spacer(),
              Text(
                cardType.toUpperCase(),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
