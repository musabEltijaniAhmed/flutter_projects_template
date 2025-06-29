
import '../constants/app_string.dart';

class AppValidator {
//valid empty data============================================================
  static String? validatorEmpty(v) {
    if (v == null || v.isEmpty) {
      return AppMessage.mandatoryTx;
    } else {
      return null;
    }
  }

  static String? validatorNotEmpty(v) {
    return null;
  }
  //valid empty data============================================================

  static String? validatorEmptyObject(v) {
    if (v == null) {
      return AppMessage.mandatoryTx;
    } else {
      return null;
    }
  }
  //valid Phone data============================================================
  static String? validatorPhone(phone) {
    final phoneRegExp = RegExp(r"^\s*\d{9}$");
    if (phone.trim().isEmpty) {
      return AppMessage.mandatoryTx;
    }
    if (phoneRegExp.hasMatch(phone) == false) {
      return AppMessage.invalidPhone;
    }
    if (!phone.startsWith('5')) {
      return AppMessage.notStart0;
    }
    return null;
  }
}
