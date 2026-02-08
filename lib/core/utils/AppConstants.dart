import 'package:ecommerce_app/core/config/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

//-------------------------------------------------------------------------- Enums
enum TextFeildValidationMessage {
  feildRequired,
  lengthError,
  emailError,
  passwordError,
  confirmPasswordError,
  nameContentError,
  phoneError,
  VCodeError,
  feildsNotCompatableError,
  invalidEmailOrPassword,
}

enum DeviceSize {
  // Mobile
  smallMobile,
  mediumMobile,
  largeMobile,
  // Tablet
  smallTablet,
  mediumTablet,
  largeTablet,
  // Laptop
  smallLaptop,
  mediumLaptop,
  largeLaptop,
  // TV
  smallTV,
  mediumTV,
  largeTV,
}

enum DeviceGroup { mobile, tablet, laptop, tv }

class AppConstants {
  //-------------------------------------------------------------------------- variables
  static const appName = "ecommerce_app";
  //-------------------------------------------------------------------------- translateValidationMessage method
  static String translateValidationMessage(
    BuildContext context,
    TextFeildValidationMessage error,
  ) {
    final tr = AppLocalizations.of(context)!;
    switch (error) {
      case TextFeildValidationMessage.feildRequired:
        return tr.errorFeildRequired;
      case TextFeildValidationMessage.lengthError:
        return tr.errorShortLength;
      case TextFeildValidationMessage.emailError:
        return tr.errorEmailSyntax;
      case TextFeildValidationMessage.passwordError:
        return tr.errorPasswordDoesntMatch;
      case TextFeildValidationMessage.confirmPasswordError:
        return tr.errorPasswordDoesntMatch;
      case TextFeildValidationMessage.nameContentError:
        return tr.errorShouldStartWithChar;
      case TextFeildValidationMessage.phoneError:
        return tr.errorPhoneNumberSyntax;
      case TextFeildValidationMessage.VCodeError:
        return tr.errorNonValidCode;
      case TextFeildValidationMessage.feildsNotCompatableError:
        return tr.errorFeildsNotCompatable;
      case TextFeildValidationMessage.invalidEmailOrPassword:
        return tr.errorInvalidEmailOrPassword;
    }
  }

  //-------------------------------------------------------------------------- device section
  static late Size screenSize;
  static late double screenWidth;
  static late double screenHeight;
  static late double aspectRatio;
  // static late Orientation orientation;
  static DeviceGroup deviceGroup = DeviceGroup.mobile;
  static DeviceSize deviceSize = DeviceSize.largeMobile;

  static void setDeviceSize(BuildContext context) {
    screenSize = setScreenSize(context);
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    aspectRatio = screenWidth / screenHeight;
    // orientation = MediaQuery.of(context).orientation;

    // --------------------- MOBILE ---------------------
    if (screenWidth < 600) {
      deviceGroup = DeviceGroup.mobile;
      if (screenWidth < 360)
        deviceSize = DeviceSize.smallMobile;
      else if (screenWidth < 420)
        deviceSize = DeviceSize.mediumMobile;
      else if (screenWidth < 600)
        deviceSize = DeviceSize.largeMobile;
    }
    // --------------------- TABLET ---------------------
    else if (screenWidth < 1281) {
      deviceGroup = DeviceGroup.tablet;
      if (screenWidth < 801)
        deviceSize = DeviceSize.smallTablet;
      else if (screenWidth < 1025)
        deviceSize = DeviceSize.mediumTablet;
      else if (screenWidth < 1281)
        deviceSize = DeviceSize.largeTablet;
    }
    // --------------------- LAPTOP ---------------------
    else if (screenWidth < 1920) {
      deviceGroup = DeviceGroup.laptop;
      if (screenWidth < 1366)
        deviceSize = DeviceSize.smallLaptop;
      else if (screenWidth < 1600)
        deviceSize = DeviceSize.mediumLaptop;
      else if (screenWidth < 1920)
        deviceSize = DeviceSize.largeLaptop;
    }
    // --------------------- TV -------------------------
    else if (screenWidth < 3840) {
      deviceGroup = DeviceGroup.tv;
      if (screenWidth < 2560)
        deviceSize = DeviceSize.smallTV;
      else if (screenWidth < 3840)
        deviceSize = DeviceSize.mediumTV;
      else {
        deviceSize = DeviceSize.largeTV;
      }
    }
  }

  static Size setScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}
