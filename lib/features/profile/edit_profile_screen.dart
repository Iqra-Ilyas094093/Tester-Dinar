import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class EditProfilescreen extends StatefulWidget {
  const EditProfilescreen({super.key});

  @override
  State<EditProfilescreen> createState() => _EditProfilescreenState();
}

class _EditProfilescreenState extends State<EditProfilescreen> {
  final _nameController = TextEditingController(text: 'John Smith');
  final _emailController = TextEditingController(text: 'john@email.com');
  final _phoneController = TextEditingController(text: '7700 000000');
  final _currentPassController = TextEditingController();
  final _newPassController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _isSaving = false;

  File? _pickedImage;
  final _picker = ImagePicker();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _currentPassController.dispose();
    _newPassController.dispose();
    super.dispose();
  }

  // ── Pick image ──────────────────────────────────────────────────────────────
  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkCard
          : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.mutedBlue.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.camera_alt_rounded,
                  color: AppColors.brandGold),
              title: const Text('Take a Photo'),
              onTap: () async {
                Navigator.pop(context);
                final xfile = await _picker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 80,
                );
                if (xfile != null) {
                  setState(() => _pickedImage = File(xfile.path));
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_rounded,
                  color: AppColors.brandGold),
              title: const Text('Choose from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final xfile = await _picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 80,
                );
                if (xfile != null) {
                  setState(() => _pickedImage = File(xfile.path));
                }
              },
            ),
            if (_pickedImage != null)
              ListTile(
                leading: const Icon(Icons.delete_outline_rounded,
                    color: AppColors.error),
                title: const Text('Remove Photo',
                    style: TextStyle(color: AppColors.error)),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _pickedImage = null);
                },
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ── Save ────────────────────────────────────────────────────────────────────
  Future<void> _save() async {
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(seconds: 1)); // replace with API
    setState(() => _isSaving = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profile updated successfully!'),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkCard : Colors.white;
    final subColor = isDark ? AppColors.mutedBlue : AppColors.darkGray;
    final textColor = isDark ? Colors.white : AppColors.nearBlack;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color:
                  isDark ? AppColors.darkCard : Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.arrow_back_rounded, size: 20),
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _save,
            child: const Text('Save',
                style: TextStyle(
                    color: AppColors.brandGold,
                    fontWeight: FontWeight.w600,
                    fontSize: 15)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ── Avatar with picker ──
          Center(
            child: GestureDetector(
              onTap: _pickImage,
              child: Stack(
                children: [
                  // Avatar circle
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      gradient:
                          _pickedImage == null ? AppColors.goldGradient : null,
                      borderRadius: BorderRadius.circular(22),
                      image: _pickedImage != null
                          ? DecorationImage(
                              image: FileImage(_pickedImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _pickedImage == null
                        ? const Icon(Icons.person_rounded,
                            size: 50, color: Colors.white)
                        : null,
                  ),

                  // Camera badge
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.navyDark,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColors.brandGold, width: 1.5),
                      ),
                      child: const Icon(Icons.camera_alt_rounded,
                          size: 14, color: AppColors.brandGold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: GestureDetector(
              onTap: _pickImage,
              child: const Text(
                'Change Photo',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.brandGold,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),

          // ── Full Name ──
          _FieldLabel(label: 'FULL NAME'),
          const SizedBox(height: 6),
          _InputField(
            controller: _nameController,
            hint: 'Full name',
            isDark: isDark,
            cardBg: cardBg,
            textColor: textColor,
          ),
          const SizedBox(height: 16),

          // ── Email ──
          _FieldLabel(label: 'EMAIL ADDRESS'),
          const SizedBox(height: 6),
          _InputField(
            controller: _emailController,
            hint: 'Email address',
            isDark: isDark,
            cardBg: cardBg,
            textColor: textColor,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),

          // ── Phone ──
          _FieldLabel(label: 'PHONE NUMBER'),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: isDark
                            ? AppColors.dividerDark
                            : AppColors.dividerLight,
                      ),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Text('🇬🇧', style: TextStyle(fontSize: 18)),
                      SizedBox(width: 6),
                      Text('+44',
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.mutedBlue,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(fontSize: 14, color: textColor),
                    decoration: InputDecoration(
                      hintText: '7700 000000',
                      hintStyle: TextStyle(color: subColor),
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Current Password ──
          _FieldLabel(label: 'CURRENT PASSWORD'),
          const SizedBox(height: 6),
          _PasswordField(
            controller: _currentPassController,
            hint: 'Enter to change password',
            obscure: _obscureCurrent,
            isDark: isDark,
            cardBg: cardBg,
            textColor: textColor,
            subColor: subColor,
            onToggle: () => setState(() => _obscureCurrent = !_obscureCurrent),
          ),
          const SizedBox(height: 16),

          // ── New Password ──
          _FieldLabel(label: 'NEW PASSWORD'),
          const SizedBox(height: 6),
          _PasswordField(
            controller: _newPassController,
            hint: 'Leave blank to keep current',
            obscure: _obscureNew,
            isDark: isDark,
            cardBg: cardBg,
            textColor: textColor,
            subColor: subColor,
            onToggle: () => setState(() => _obscureNew = !_obscureNew),
          ),
          const SizedBox(height: 32),

          // ── Save button ──
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: _isSaving ? null : _save,
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
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('Save Changes',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ── Field label ───────────────────────────────────────────────────────────────
class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});

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

// ── Input field ───────────────────────────────────────────────────────────────
class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isDark;
  final Color cardBg;
  final Color textColor;
  final TextInputType keyboardType;

  const _InputField({
    required this.controller,
    required this.hint,
    required this.isDark,
    required this.cardBg,
    required this.textColor,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(12)),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 14, color: textColor),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.mutedBlue),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}

// ── Password field ────────────────────────────────────────────────────────────
class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final bool isDark;
  final Color cardBg;
  final Color textColor;
  final Color subColor;
  final VoidCallback onToggle;

  const _PasswordField({
    required this.controller,
    required this.hint,
    required this.obscure,
    required this.isDark,
    required this.cardBg,
    required this.textColor,
    required this.subColor,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(12)),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(fontSize: 14, color: textColor),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: subColor, fontSize: 14),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          suffixIcon: IconButton(
            icon: Icon(
              obscure ? Icons.lock_outline_rounded : Icons.lock_open_outlined,
              color: AppColors.brandGold,
              size: 20,
            ),
            onPressed: onToggle,
          ),
        ),
      ),
    );
  }
}
