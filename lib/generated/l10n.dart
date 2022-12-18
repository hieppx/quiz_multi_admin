// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Account`
  String get labelLogin {
    return Intl.message(
      'Account',
      name: 'labelLogin',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get labelPassword {
    return Intl.message(
      'Password',
      name: 'labelPassword',
      desc: '',
      args: [],
    );
  }

  /// `Show`
  String get showPassword {
    return Intl.message(
      'Show',
      name: 'showPassword',
      desc: '',
      args: [],
    );
  }

  /// `Hide`
  String get hidePassword {
    return Intl.message(
      'Hide',
      name: 'hidePassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get buttonLogin {
    return Intl.message(
      'Login',
      name: 'buttonLogin',
      desc: '',
      args: [],
    );
  }

  /// `User account or password incorrect!`
  String get errorLogin {
    return Intl.message(
      'User account or password incorrect!',
      name: 'errorLogin',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get labelHome {
    return Intl.message(
      'Home',
      name: 'labelHome',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get labelInformation {
    return Intl.message(
      'Account',
      name: 'labelInformation',
      desc: '',
      args: [],
    );
  }

  /// `Search course`
  String get searchCourse {
    return Intl.message(
      'Search course',
      name: 'searchCourse',
      desc: '',
      args: [],
    );
  }

  /// `Course Management`
  String get courseManagement {
    return Intl.message(
      'Course Management',
      name: 'courseManagement',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get labelUpdate {
    return Intl.message(
      'Update',
      name: 'labelUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Search question`
  String get searchQuestion {
    return Intl.message(
      'Search question',
      name: 'searchQuestion',
      desc: '',
      args: [],
    );
  }

  /// `ADD`
  String get addCourse {
    return Intl.message(
      'ADD',
      name: 'addCourse',
      desc: '',
      args: [],
    );
  }

  /// `Input`
  String get input {
    return Intl.message(
      'Input',
      name: 'input',
      desc: '',
      args: [],
    );
  }

  /// `Insert course`
  String get insertCourse {
    return Intl.message(
      'Insert course',
      name: 'insertCourse',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get appearance {
    return Intl.message(
      'Appearance',
      name: 'appearance',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Course name`
  String get titleCourse {
    return Intl.message(
      'Course name',
      name: 'titleCourse',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get exit {
    return Intl.message(
      'Cancel',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `Confirm course delete?`
  String get alertDeleteCourse {
    return Intl.message(
      'Confirm course delete?',
      name: 'alertDeleteCourse',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Question`
  String get question {
    return Intl.message(
      'Question',
      name: 'question',
      desc: '',
      args: [],
    );
  }

  /// `Insert question`
  String get insertQuestion {
    return Intl.message(
      'Insert question',
      name: 'insertQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Ex:`
  String get ex {
    return Intl.message(
      'Ex:',
      name: 'ex',
      desc: '',
      args: [],
    );
  }

  /// `Confirm question delete?`
  String get alertDeleteQuestion {
    return Intl.message(
      'Confirm question delete?',
      name: 'alertDeleteQuestion',
      desc: '',
      args: [],
    );
  }

  /// `No question!`
  String get noQuestion {
    return Intl.message(
      'No question!',
      name: 'noQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Manager account`
  String get managerAccount {
    return Intl.message(
      'Manager account',
      name: 'managerAccount',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get nameUser {
    return Intl.message(
      'Full name',
      name: 'nameUser',
      desc: '',
      args: [],
    );
  }

  /// `List manager level 2`
  String get listUser {
    return Intl.message(
      'List manager level 2',
      name: 'listUser',
      desc: '',
      args: [],
    );
  }

  /// `Add account`
  String get insertUser {
    return Intl.message(
      'Add account',
      name: 'insertUser',
      desc: '',
      args: [],
    );
  }

  /// `Confirm user delete?`
  String get deleteQuestion {
    return Intl.message(
      'Confirm user delete?',
      name: 'deleteQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get resetPassword {
    return Intl.message(
      'Reset password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Account already in use!`
  String get checkInsertUser {
    return Intl.message(
      'Account already in use!',
      name: 'checkInsertUser',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get overview {
    return Intl.message(
      'Overview',
      name: 'overview',
      desc: '',
      args: [],
    );
  }

  /// `Total user`
  String get totalUsers {
    return Intl.message(
      'Total user',
      name: 'totalUsers',
      desc: '',
      args: [],
    );
  }

  /// `Total admin level 2`
  String get totalAdmin {
    return Intl.message(
      'Total admin level 2',
      name: 'totalAdmin',
      desc: '',
      args: [],
    );
  }

  /// `Total course`
  String get totalCourses {
    return Intl.message(
      'Total course',
      name: 'totalCourses',
      desc: '',
      args: [],
    );
  }

  /// `Total question`
  String get totalQuestions {
    return Intl.message(
      'Total question',
      name: 'totalQuestions',
      desc: '',
      args: [],
    );
  }

  /// `The most used course`
  String get courseBest {
    return Intl.message(
      'The most used course',
      name: 'courseBest',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
