
import '../constants/app_string.dart';
import 'app_error_state.dart';

class AppErrorMessage {
  /// This static method returns a readable message for exceptions
  static String getMessage(String message) {
    switch (message) {
      case AppErrorState.serverExceptions:
        return AppMessage.serverText;
      case AppErrorState.socketException:
        return AppMessage.socketText;
      case AppErrorState.timeoutException:
        return AppMessage.timeoutText;
      case AppErrorState.formatException:
        return AppMessage.formatText;
      case AppErrorState.unAuthorized:
        return AppMessage.unAuthorizedText;
      default:
        return message;
    }
  }
}
