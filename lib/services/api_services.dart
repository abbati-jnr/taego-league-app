import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../helpers/HTTP_Helpers.dart';
import '../helpers/shared_preference_services.dart';
import '../main.dart';
import '../utils/api_constants.dart';


class ApiService {

  static _getErrorSnackBar(errorTitle, errorMessage) {
    return SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: errorTitle,
        message: errorMessage,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.failure,
      ),
    );
  }

  static loginUser(BuildContext context, Map data) async {
    try {
      final resp = await HttpHelper.post(ApiConstants.loginUser, data);
      print(resp);
      var token = resp['token'];

      await SharedPrefServices.setString(value: token, key: 'token');
      userStore.setUser(resp);

      return resp;
    } on ApiError catch (e) {
      final errorMessages = e.getAllErrorMessages();
      if (errorMessages.isNotEmpty) {
        print(errorMessages);
        final errorMessage = errorMessages.join('\n'); // Join all error messages.
        // Display a single Snackbar containing all error messages.
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(_getErrorSnackBar('Error!', errorMessage));
      }
    } on NetworkError catch (e) {
      // Handle network errors.
      // Display a general error message to the user.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(_getErrorSnackBar('Network Error!', e.errorMessage ?? 'Unable to retrieve data'));
    }
  }

  static registerUser(BuildContext context, FormData data) async {
    try {
      final resp = await HttpHelper.postFormData(ApiConstants.registerUser, data);
      print(resp);
      // var token = resp['token'];
      //
      // await SharedPrefServices.setString(value: token, key: 'token');
      // userStore.setUser(resp);

      return resp;
    } on ApiError catch (e) {
      print(e);
      final errorMessages = e.getAllErrorMessages();
      if (errorMessages.isNotEmpty) {
        print(errorMessages);
        final errorMessage = errorMessages.join('\n'); // Join all error messages.
        // Display a single Snackbar containing all error messages.
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(_getErrorSnackBar('Error!', errorMessage));
      }
    } on NetworkError catch (e) {
      // Handle network errors.
      // Display a general error message to the user.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(_getErrorSnackBar('Network Error!', e.errorMessage ?? 'Unable to retrieve data'));
    }
  }

  static Future getLeagues(BuildContext context) async {

    try {
      final resp = await HttpHelper.get(ApiConstants.leagueList, null);
      return resp;
    } on ApiError catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(_getErrorSnackBar('Error!', e.errorData ?? ''));
    } on NetworkError catch (e) {
      // Handle network errors.
      // Display a general error message to the user.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(_getErrorSnackBar('Network Error!', e.errorMessage ?? 'Unable to retrieve data'));
    }

  }

  static Future getTeams(BuildContext context) async {
    try {
      final resp = await HttpHelper.get(ApiConstants.teamList, null);
      return resp;
    } on ApiError catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(_getErrorSnackBar('Error!', e.errorData ?? ''));
    } on NetworkError catch (e) {
      // Handle network errors.
      // Display a general error message to the user.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(_getErrorSnackBar('Network Error!', e.errorMessage ?? 'Unable to retrieve data'));
    }
  }

  static Future postTeam(BuildContext context, FormData data) async {
    try {
      final resp = await HttpHelper.postFormData(ApiConstants.teamPost, data);
      return resp;
    } on ApiError catch (e) {
      // Handle API validation errors.
      final errorMessages = e.getAllErrorMessages();
      if (errorMessages.isNotEmpty) {
        print(errorMessages);
        final errorMessage = errorMessages.join('\n'); // Join all error messages.
        // Display a single Snackbar containing all error messages.
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(_getErrorSnackBar('Error!', errorMessage));
      }
    } on NetworkError catch (e) {
      // Handle network errors.
      // Display a general error message to the user.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(_getErrorSnackBar('Network Error!', e.errorMessage ?? ''));
    }
  }

  static Future updateTeam(BuildContext context, int id, FormData data) async {
    try {
      final resp = await HttpHelper.update('${ApiConstants.teamUpdate}$id/', data);
      return resp;
    } on ApiError catch (e) {
      // Handle API validation errors.
      print(e);
      final errorMessages = e.getAllErrorMessages();
      if (errorMessages.isNotEmpty) {
        print(errorMessages);
        final errorMessage = errorMessages.join('\n'); // Join all error messages.
        // Display a single Snackbar containing all error messages.
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(_getErrorSnackBar('Error!', errorMessage));
      }
    } on NetworkError catch (e) {
      // Handle network errors.
      // Display a general error message to the user.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(_getErrorSnackBar('Network Error!', e.errorMessage ?? ''));
    }
  }

  static Future deleteTeam(BuildContext context, int id) async {
    try {
      final resp = await HttpHelper.delete('${ApiConstants.teamUpdate}$id/', null);
      return resp;
    } on ApiError catch (e) {
      // Handle API validation errors.
      print(e);
      final errorMessages = e.getAllErrorMessages();
      if (errorMessages.isNotEmpty) {
        print(errorMessages);
        final errorMessage = errorMessages.join('\n'); // Join all error messages.
        // Display a single Snackbar containing all error messages.
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(_getErrorSnackBar('Error!', errorMessage));
      }
    } on NetworkError catch (e) {
      // Handle network errors.
      // Display a general error message to the user.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(_getErrorSnackBar('Network Error!', e.errorMessage ?? ''));
    }
  }

  static Future getFixtures(BuildContext context) async {
    try {
      final resp = await HttpHelper.get(ApiConstants.fixtureList, null);
      return resp;
    } on ApiError catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(_getErrorSnackBar('Error!', e.errorData ?? ''));
    } on NetworkError catch (e) {
      // Handle network errors.
      // Display a general error message to the user.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(_getErrorSnackBar('Network Error!', e.errorMessage ?? 'Unable to retrieve data'));
    }
  }

  static Future getUsers(BuildContext context) async {
    try {
      final resp = await HttpHelper.get(ApiConstants.userList, null);
      return resp;
    } on ApiError catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(_getErrorSnackBar('Error!', e.errorData ?? ''));
    } on NetworkError catch (e) {
      // Handle network errors.
      // Display a general error message to the user.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(_getErrorSnackBar('Network Error!', e.errorMessage ?? 'Unable to retrieve data'));
    }
  }

  static Future updateLeague(BuildContext context, int id, FormData data) async {
    try {
      final resp = await HttpHelper.update('${ApiConstants.leagueUpdate}$id/', data);
      return resp;
    } on ApiError catch (e) {
      // Handle API validation errors.
      print(e);
      final errorMessages = e.getAllErrorMessages();
      if (errorMessages.isNotEmpty) {
        print(errorMessages);
        final errorMessage = errorMessages.join('\n'); // Join all error messages.
        // Display a single Snackbar containing all error messages.
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(_getErrorSnackBar('Error!', errorMessage));
      }
    } on NetworkError catch (e) {
      // Handle network errors.
      // Display a general error message to the user.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(_getErrorSnackBar('Network Error!', e.errorMessage ?? ''));
    }
  }

  static Future postLeague(BuildContext context, FormData data) async {
    try {
      final resp = await HttpHelper.postFormData(ApiConstants.leaguePost, data);
      return resp;
    } on ApiError catch (e) {
      // Handle API validation errors.
      final errorMessages = e.getAllErrorMessages();
      if (errorMessages.isNotEmpty) {
        print(errorMessages);
        final errorMessage = errorMessages.join('\n'); // Join all error messages.
        // Display a single Snackbar containing all error messages.
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(_getErrorSnackBar('Error!', errorMessage));
      }
    } on NetworkError catch (e) {
      // Handle network errors.
      // Display a general error message to the user.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(_getErrorSnackBar('Network Error!', e.errorMessage ?? ''));
    }
  }

  static Future deleteLeague(BuildContext context, int id) async {
    try {
      final resp = await HttpHelper.delete('${ApiConstants.leagueUpdate}$id/', null);
      return resp;
    } on ApiError catch (e) {
      // Handle API validation errors.
      print(e);
      final errorMessages = e.getAllErrorMessages();
      if (errorMessages.isNotEmpty) {
        print(errorMessages);
        final errorMessage = errorMessages.join('\n'); // Join all error messages.
        // Display a single Snackbar containing all error messages.
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(_getErrorSnackBar('Error!', errorMessage));
      }
    } on NetworkError catch (e) {
      // Handle network errors.
      // Display a general error message to the user.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(_getErrorSnackBar('Network Error!', e.errorMessage ?? ''));
    }
  }

  static Future postFixture(BuildContext context, FormData data) async {
    try {
      final resp = await HttpHelper.postFormData(ApiConstants.fixturePost, data);
      return resp;
    } on ApiError catch (e) {
      // Handle API validation errors.
      final errorMessages = e.getAllErrorMessages();
      if (errorMessages.isNotEmpty) {
        print(errorMessages);
        final errorMessage = errorMessages.join('\n'); // Join all error messages.
        // Display a single Snackbar containing all error messages.
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(_getErrorSnackBar('Error!', errorMessage));
      }
    } on NetworkError catch (e) {
      // Handle network errors.
      // Display a general error message to the user.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(_getErrorSnackBar('Network Error!', e.errorMessage ?? ''));
    }
  }

  static Future updateFixture(BuildContext context, int id, FormData data) async {
    try {
      final resp = await HttpHelper.update('${ApiConstants.fixtureUpdate}$id/', data);
      return resp;
    } on ApiError catch (e) {
      // Handle API validation errors.
      print(e);
      final errorMessages = e.getAllErrorMessages();
      if (errorMessages.isNotEmpty) {
        print(errorMessages);
        final errorMessage = errorMessages.join('\n'); // Join all error messages.
        // Display a single Snackbar containing all error messages.
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(_getErrorSnackBar('Error!', errorMessage));
      }
    } on NetworkError catch (e) {
      // Handle network errors.
      // Display a general error message to the user.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(_getErrorSnackBar('Network Error!', e.errorMessage ?? ''));
    }
  }

  static Future deleteFixture(BuildContext context, int id) async {
    try {
      final resp = await HttpHelper.delete('${ApiConstants.fixtureUpdate}$id/', null);
      return resp;
    } on ApiError catch (e) {
      // Handle API validation errors.
      print(e);
      final errorMessages = e.getAllErrorMessages();
      if (errorMessages.isNotEmpty) {
        print(errorMessages);
        final errorMessage = errorMessages.join('\n'); // Join all error messages.
        // Display a single Snackbar containing all error messages.
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(_getErrorSnackBar('Error!', errorMessage));
      }
    } on NetworkError catch (e) {
      // Handle network errors.
      // Display a general error message to the user.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(_getErrorSnackBar('Network Error!', e.errorMessage ?? ''));
    }
  }

  static Future postPlayerInvitation(BuildContext context, FormData data) async {
    try {
      final resp = await HttpHelper.postFormData(ApiConstants.playerInvitation, data);
      return resp;
    } on ApiError catch (e) {
      // Handle API validation errors.
      final errorMessages = e.getAllErrorMessages();
      if (errorMessages.isNotEmpty) {
        print(errorMessages);
        final errorMessage = errorMessages.join('\n'); // Join all error messages.
        // Display a single Snackbar containing all error messages.
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(_getErrorSnackBar('Error!', errorMessage));
      }
    } on NetworkError catch (e) {
      // Handle network errors.
      // Display a general error message to the user.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(_getErrorSnackBar('Network Error!', e.errorMessage ?? ''));
    }
  }


}


// api_service.dart

class ApiError {
  final Map<String, dynamic> errorData;

  ApiError(this.errorData);

  Map<String, dynamic> getFieldErrors() {
    return errorData;
  }

  List<String> getAllErrorMessages() {
    final List<String> errorMessages = [];
    errorData.forEach((field, errors) {
      if (errors.isNotEmpty) {
        errorMessages.add('$field: ${errors[0]}');
      }
    });
    return errorMessages;
  }

  // Implement methods to extract and format error messages.
  String? getMessageForField(String field) {
    final fieldErrors = errorData[field];
    if (fieldErrors != null && fieldErrors.isNotEmpty) {
      return fieldErrors[0]; // Assuming you want to display the first error.
    }
    return null; // No error for this field.
  }
}

class NetworkError {
  final String? errorMessage;

  NetworkError(this.errorMessage);

}