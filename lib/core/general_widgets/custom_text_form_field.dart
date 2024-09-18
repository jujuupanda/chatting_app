import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.fieldName,
    required this.hint,
    required this.controller,
    required this.prefixIcon,
    this.role,
    this.controller2,
  });

  final String fieldName;
  final String hint;
  final TextEditingController controller;
  final IconData prefixIcon;
  final String? role;
  final TextEditingController? controller2;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 6,
        bottom: 12,
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText(widget.fieldName, obscureText),
        minLines: 1,
        maxLines: _maxLine(widget.fieldName),
        readOnly: _readOnly(widget.fieldName, widget.role ?? "1"),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: _keyboardType(widget.fieldName),
        inputFormatters: _textInputFormatter(widget.fieldName),
        validator: _customValidator(widget.fieldName),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefixIcon: Icon(widget.prefixIcon),
          suffixIcon: _suffixIcon(widget.fieldName),
          hintStyle: GoogleFonts.openSans(),
          hintText: widget.hint,
          labelText: _labelText(widget.fieldName),
        ),
      ),
    );
  }

  _labelText(String fieldName) {
    if (fieldName == "Keterangan Opsional") {
      return "Keterangan (opsional)";
    }
  }

  _suffixIcon(String fieldName) {
    if (fieldName == "Password" ||
        fieldName == "Password Lama" ||
        fieldName == "Password Baru" ||
        fieldName == "Konfirmasi Password Baru" ||
        fieldName == "Kata Sandi") {
      return IconButton(
        icon: Icon(
          obscureText ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed:
        _togglePasswordVisibility, // Memanggil setState untuk mengubah state
      );
    } else {
      return null;
    }
  }

  _maxLine(String fieldName) {
    if (fieldName == "Deskripsi Gedung" ||
        fieldName == "Fasilitas Gedung" ||
        fieldName == "Peraturan Gedung" ||
        fieldName == "Deskripsi Ekstrakurikuler" ||
        fieldName == "Keterangan") {
      return 6;
    } else {
      return 1;
    }
  }

  TextInputType _keyboardType(String fieldName) {
    if (fieldName == "Nomor Telepon") {
      return TextInputType.number;
    } else if (fieldName == "Email") {
      return TextInputType.emailAddress;
    } else if (fieldName == "Multi Line") {
      return TextInputType.multiline;
    } else {
      return TextInputType.text;
    }
  }

  List<TextInputFormatter> _textInputFormatter(String fieldName) {
    if (fieldName == "Username") {
      return [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))
      ];
    } else if (fieldName == "Password" ||
        fieldName == "Password Lama" ||
        fieldName == "Password Baru" ||
        fieldName == "Konfirmasi Password Baru" ||
        fieldName == "Kata Sandi") {
      return [
        FilteringTextInputFormatter.allow(RegExp(
            r'[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{\};:,<>./?\\|~ ]')),
      ];
    } else if (fieldName == "Nomor Telepon") {
      return [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ];
    } else if (fieldName == "Email") {
      return [
        FilteringTextInputFormatter.allow(
          RegExp(r'[a-zA-Z0-9@._-]'),
        ),
      ];
    } else if (fieldName == "Nama Lengkap") {
      return [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
      ];
    } else if (fieldName == "Judul") {
      return [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]')),
      ];
    } else {
      // Default input formatter
      return [];
    }
  }

  _customValidator(String fieldName) {
    if (fieldName == "Password" ||
        fieldName == "Password Baru") {
      return (value) {
        if (value == null || value.isEmpty) {
          return 'Password tidak boleh kosong!';
        }
        // Validasi minimal 1 huruf besar dan kombinasi huruf dan angka
        if (!RegExp(
            r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d!@#$%^&*()_+\-=\[\]{\};:,<>./?\\|`~\s]+$')
            .hasMatch(value)) {
          return 'Password setidaknya mengandung huruf besar dan angka!';
        }
        if (value.length < 6) {
          return 'Password harus lebih dari 6 karakter!';
        }
        return null;
      };
    } else if (fieldName == "Konfirmasi Password Baru") {
      return (value) {
        if (value == null || value.isEmpty) {
          return 'Password tidak boleh kosong!';
        }
        // Validasi minimal 1 huruf besar dan kombinasi huruf dan angka
        if (!RegExp(
            r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d!@#$%^&*()_+\-=\[\]{\};:,<>./?\\|`~\s]+$')
            .hasMatch(value)) {
          return 'Password setidaknya mengandung huruf besar dan angka!';
        }
        if (value.length < 6) {
          return 'Password harus lebih dari 6 karakter!';
        }
        if (value != widget.controller2?.text) {
          return 'Password baru Anda tidak cocok!';
        }
        return null;
      };
    } else if (fieldName == "Kata Sandi" || fieldName == "Password Lama") {
      return (value) {
        if (value == null || value.isEmpty) {
          return 'Password tidak boleh kosong!';
        }
        return null;
      };
    } else if (fieldName == "Email") {
      return (value) {
        if (value == null || value.isEmpty) {
          return 'Email tidak boleh kosong!';
        }
        // Validasi format email
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Masukkan email dengan benar!';
        }
      };
    } else if (fieldName == "Nomor Telepon") {
      return (value) {
        if (value == null || value.isEmpty) {
          return 'Nomor telepon tidak boleh kosong!';
        }
        // validator tidak boleh kurang dari 10 digit
        if (value.length < 10 || !value.startsWith('08')) {
          return 'Masukkan nomor telepon dengan benar!';
        }
      };
    } else if (fieldName == "Gambar" || fieldName == "Keterangan") {
      return null;
    } else {
      return (value) {
        if (value == null || value.isEmpty) {
          return '$fieldName tidak boleh kosong!';
        } else {
          return null;
        }
      };
    }
  }

  _readOnly(String fieldName, String role) {
    if (fieldName == "Instansi" && role == "1") {
      return true;
    } else  if (fieldName == "Instansi" && role == "2") {
      return true;
    } else if (fieldName == "Gambar") {
      return true;
    } else {
      return false;
    }
  }

  _obscureText(String fieldName, bool obscureText) {
    if (fieldName == "Password" ||
        fieldName == "Password Lama" ||
        fieldName == "Password Baru" ||
        fieldName == "Konfirmasi Password Baru" ||
        fieldName == "Kata Sandi") {
      return obscureText;
    } else {
      return false;
    }
  }
}
