import 'package:flutter/material.dart';

class Validators {
  Validators._();
  // กำหนดฟังก์ชั่น สำหรับระบุฟิลด์ที่ต้องกรอก
  static FormFieldValidator<String> required(String? errMsg) {
    return (value) {
      if (value == null) {
        return errMsg;
      } else if (value.isEmpty) {
        return errMsg;
      }
      return null;
    };
  }

  // กำหนดฟังก์ชั่น สำหรับระบุฟิลด์ต้องกรอกตัวเลขต่ำสุดอย่างน้อย
  static FormFieldValidator<String> min(int min, String errMsg) {
    return (value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      // Remove non-numeric characters
      final sanitizedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
      if (sanitizedValue.isEmpty) {
        return errMsg;
      }
      return (int.parse(sanitizedValue) < min) ? errMsg : null;
    };
  }

  // กำหนดฟังก์ชั่น สำหรับระบุฟิลด์ต้องกรอกตัวเลขสูงสุดอย่างน้อย
  static FormFieldValidator<String> max(int max, String errMsg) {
    return (value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      return (int.parse(value) >= 0 && int.parse(value) > max) ? errMsg : null;
    };
  }

  // กำหนดฟังก์ชั่น สำหรับระบุฟิลด์ต้องใช้งานรูปแบบอีเมล
  static FormFieldValidator<String> email(String errMsg) {
    final emailPattern = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
    );
    return (value) =>
        (value != null && value.isNotEmpty && !emailPattern.hasMatch(value))
        ? errMsg
        : null;
  }

  // กำหนดฟังก์ชั่น สำหรับระบุฟิลด์ต้องใช้งานรูปแบบหมายเลขโทรศัพท์ไทย 9-10 หลัก
  static FormFieldValidator<String> phone(String errMsg) {
    return (value) {
      if (value == null || value.isEmpty)
        return null; // ให้ required จัดการเองถ้าจำเป็น

      final digits = value.replaceAll(RegExp(r'[^0-9]'), '');

      // ความยาวต้องเป็น 9 หรือ 10 หลัก และต้องขึ้นต้นด้วย 0
      if (!(digits.length == 9 || digits.length == 10)) {
        return errMsg;
      }
      if (!digits.startsWith('0')) {
        return errMsg;
      }
      // (อาจเพิ่มการตรวจ prefix ให้เฉพาะ 06,08,09 สำหรับมือถือได้ในอนาคต)
      return null;
    };
  }

  // กำหนดฟังก์ชั่น สำหรับระบุฟิลด์ต้องใช้งานการตรวจสอบหลายๆ คำสั่งรวมกัน
  static FormFieldValidator<String> compose(
    List<FormFieldValidator<String>> validators,
  ) {
    return (value) {
      for (final validator in validators) {
        if (validator(value) != null) return validator(value);
      }
      return null;
    };
  }
}
