import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ar'),
  ];

  /// Note here with this structure you can add meta data as comments
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// //-------------------------------------------------------------------------- title
  ///
  /// In en, this message translates to:
  /// **'Theme & Language Demo'**
  String get title;

  /// No description provided for @pickThemeColor.
  ///
  /// In en, this message translates to:
  /// **'Pick Theme Color'**
  String get pickThemeColor;

  /// No description provided for @generalOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get generalOk;

  /// No description provided for @generalCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get generalCancel;

  /// No description provided for @generalYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get generalYes;

  /// No description provided for @generalNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get generalNo;

  /// No description provided for @generalSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get generalSignIn;

  /// No description provided for @generalSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get generalSignUp;

  /// No description provided for @generalOr.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get generalOr;

  /// No description provided for @generalApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get generalApply;

  /// No description provided for @nameFacebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get nameFacebook;

  /// No description provided for @nameGoogle.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get nameGoogle;

  /// No description provided for @nameAppleId.
  ///
  /// In en, this message translates to:
  /// **'Apple ID'**
  String get nameAppleId;

  /// No description provided for @messageAreYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get messageAreYouSure;

  /// No description provided for @messageProblem.
  ///
  /// In en, this message translates to:
  /// **'Sorry, something went wrong'**
  String get messageProblem;

  /// No description provided for @messageFailure.
  ///
  /// In en, this message translates to:
  /// **'Sorry, proccess failed'**
  String get messageFailure;

  /// No description provided for @messageSuccess.
  ///
  /// In en, this message translates to:
  /// **'Proccess done successfully!'**
  String get messageSuccess;

  /// No description provided for @errorFeildsNotCompatable.
  ///
  /// In en, this message translates to:
  /// **'Feilds aren\'t Compatable!'**
  String get errorFeildsNotCompatable;

  /// No description provided for @errorPasswordDoesntMatch.
  ///
  /// In en, this message translates to:
  /// **'Password Doesn\'t Match'**
  String get errorPasswordDoesntMatch;

  /// No description provided for @errorShortLength.
  ///
  /// In en, this message translates to:
  /// **'less than minimum length'**
  String get errorShortLength;

  /// No description provided for @errorShouldStartWithChar.
  ///
  /// In en, this message translates to:
  /// **'Must start with a char'**
  String get errorShouldStartWithChar;

  /// No description provided for @errorEmailSyntax.
  ///
  /// In en, this message translates to:
  /// **'Enter valid email'**
  String get errorEmailSyntax;

  /// No description provided for @errorPhoneNumberSyntax.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get errorPhoneNumberSyntax;

  /// No description provided for @errorNonValidCode.
  ///
  /// In en, this message translates to:
  /// **'Enter valid code please'**
  String get errorNonValidCode;

  /// No description provided for @errorFeildRequired.
  ///
  /// In en, this message translates to:
  /// **'This feild is required'**
  String get errorFeildRequired;

  /// No description provided for @errorInvalidEmailOrPassword.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get errorInvalidEmailOrPassword;

  /// No description provided for @buttonResendAgain.
  ///
  /// In en, this message translates to:
  /// **'Resend Again'**
  String get buttonResendAgain;

  /// No description provided for @buttonSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get buttonSend;

  /// No description provided for @buttonSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get buttonSubmit;

  /// No description provided for @buttonReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get buttonReset;

  /// No description provided for @buttonForgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get buttonForgetPassword;

  /// No description provided for @labelFirstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get labelFirstName;

  /// No description provided for @labelLastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get labelLastName;

  /// No description provided for @labelEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get labelEmail;

  /// No description provided for @labelPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get labelPassword;

  /// No description provided for @labelNewPassword.
  ///
  /// In en, this message translates to:
  /// **'NewPassword'**
  String get labelNewPassword;

  /// No description provided for @labelConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'ConfirmPassword'**
  String get labelConfirmPassword;

  /// No description provided for @titleWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome !'**
  String get titleWelcome;

  /// No description provided for @titleCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get titleCreateAccount;

  /// No description provided for @titleStep1.
  ///
  /// In en, this message translates to:
  /// **'Step 1'**
  String get titleStep1;

  /// No description provided for @titleStep2.
  ///
  /// In en, this message translates to:
  /// **'Step 2'**
  String get titleStep2;

  /// No description provided for @titleStep3.
  ///
  /// In en, this message translates to:
  /// **'Step 3'**
  String get titleStep3;

  /// No description provided for @textDontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have account?'**
  String get textDontHaveAccount;

  /// No description provided for @textDoYouHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Do you have already an account?'**
  String get textDoYouHaveAccount;

  /// No description provided for @textTimeRemaining.
  ///
  /// In en, this message translates to:
  /// **'Time Remaining: '**
  String get textTimeRemaining;

  /// No description provided for @customEnterYourPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number to receive a code :'**
  String get customEnterYourPhone;

  /// No description provided for @customEnterCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the code please :'**
  String get customEnterCode;

  /// No description provided for @customSetNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Set a New Password'**
  String get customSetNewPassword;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
