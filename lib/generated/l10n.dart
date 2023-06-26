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

  /// `Band This Video`
  String get home_top_bar_band {
    return Intl.message(
      'Band This Video',
      name: 'home_top_bar_band',
      desc: '',
      args: [],
    );
  }

  /// `Report This Video`
  String get home_top_bar_report {
    return Intl.message(
      'Report This Video',
      name: 'home_top_bar_report',
      desc: '',
      args: [],
    );
  }

  /// `TaDa`
  String get home_bottom_bar_TaDa {
    return Intl.message(
      'TaDa',
      name: 'home_bottom_bar_TaDa',
      desc: '',
      args: [],
    );
  }

  /// `Me`
  String get home_bottom_bar_me {
    return Intl.message(
      'Me',
      name: 'home_bottom_bar_me',
      desc: '',
      args: [],
    );
  }

  /// `Subscribers`
  String get home_creator_subscribers {
    return Intl.message(
      'Subscribers',
      name: 'home_creator_subscribers',
      desc: '',
      args: [],
    );
  }

  /// `tadas`
  String get home_creator_tadas {
    return Intl.message(
      'tadas',
      name: 'home_creator_tadas',
      desc: '',
      args: [],
    );
  }

  /// `views`
  String get home_creator_views {
    return Intl.message(
      'views',
      name: 'home_creator_views',
      desc: '',
      args: [],
    );
  }

  /// `Upload TaDa`
  String get home_upload_title {
    return Intl.message(
      'Upload TaDa',
      name: 'home_upload_title',
      desc: '',
      args: [],
    );
  }

  /// `Upload Video`
  String get home_upload_video {
    return Intl.message(
      'Upload Video',
      name: 'home_upload_video',
      desc: '',
      args: [],
    );
  }

  /// `Upload Video From Gallery`
  String get home_upload_video_from_gallery {
    return Intl.message(
      'Upload Video From Gallery',
      name: 'home_upload_video_from_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Add Description`
  String get home_upload_add_desc {
    return Intl.message(
      'Add Description',
      name: 'home_upload_add_desc',
      desc: '',
      args: [],
    );
  }

  /// `Make your work more exciting`
  String get home_upload_make_your_work_more_exciting {
    return Intl.message(
      'Make your work more exciting',
      name: 'home_upload_make_your_work_more_exciting',
      desc: '',
      args: [],
    );
  }

  /// `Upload Video`
  String get home_upload_btn {
    return Intl.message(
      'Upload Video',
      name: 'home_upload_btn',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get login_skip {
    return Intl.message(
      'Skip',
      name: 'login_skip',
      desc: '',
      args: [],
    );
  }

  /// `Let's you in`
  String get login_title {
    return Intl.message(
      'Let\'s you in',
      name: 'login_title',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get login_privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'login_privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Term of Use`
  String get login_term_of_use {
    return Intl.message(
      'Term of Use',
      name: 'login_term_of_use',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get user_top_bar_title {
    return Intl.message(
      'Profile',
      name: 'user_top_bar_title',
      desc: '',
      args: [],
    );
  }

  /// `My Upload`
  String get user_tab_bar_upload {
    return Intl.message(
      'My Upload',
      name: 'user_tab_bar_upload',
      desc: '',
      args: [],
    );
  }

  /// `Draft`
  String get user_tab_bar_draft {
    return Intl.message(
      'Draft',
      name: 'user_tab_bar_draft',
      desc: '',
      args: [],
    );
  }

  /// `views`
  String get user_views {
    return Intl.message(
      'views',
      name: 'user_views',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get user_settings_title {
    return Intl.message(
      'Settings',
      name: 'user_settings_title',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get user_settings_privacy_police {
    return Intl.message(
      'Privacy Policy',
      name: 'user_settings_privacy_police',
      desc: '',
      args: [],
    );
  }

  /// `Term of Use`
  String get user_settings_term_of_use {
    return Intl.message(
      'Term of Use',
      name: 'user_settings_term_of_use',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get user_settings_about {
    return Intl.message(
      'About',
      name: 'user_settings_about',
      desc: '',
      args: [],
    );
  }

  /// `Something wrong with your network, try again later`
  String get notifications_error {
    return Intl.message(
      'Something wrong with your network, try again later',
      name: 'notifications_error',
      desc: '',
      args: [],
    );
  }

  /// `Uploading`
  String get notifactions_uploading {
    return Intl.message(
      'Uploading',
      name: 'notifactions_uploading',
      desc: '',
      args: [],
    );
  }

  /// `Upload Success!`
  String get notifactions_sucess {
    return Intl.message(
      'Upload Success!',
      name: 'notifactions_sucess',
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
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
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
