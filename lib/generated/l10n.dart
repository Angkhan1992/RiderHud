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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Riders Hub`
  String get app_title {
    return Intl.message(
      'Riders Hub',
      name: 'app_title',
      desc: '',
      args: [],
    );
  }

  /// `RHID Number`
  String get rhid_number {
    return Intl.message(
      'RHID Number',
      name: 'rhid_number',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Select Delivery Region`
  String get region_picker_title {
    return Intl.message(
      'Select Delivery Region',
      name: 'region_picker_title',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `STATUS MAP`
  String get title_status {
    return Intl.message(
      'STATUS MAP',
      name: 'title_status',
      desc: '',
      args: [],
    );
  }

  /// `ORDERS`
  String get title_order {
    return Intl.message(
      'ORDERS',
      name: 'title_order',
      desc: '',
      args: [],
    );
  }

  /// `HISTORY`
  String get title_history {
    return Intl.message(
      'HISTORY',
      name: 'title_history',
      desc: '',
      args: [],
    );
  }

  /// `CHAT`
  String get title_chat {
    return Intl.message(
      'CHAT',
      name: 'title_chat',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get bottom_status {
    return Intl.message(
      'Status',
      name: 'bottom_status',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get bottom_orders {
    return Intl.message(
      'Orders',
      name: 'bottom_orders',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get bottom_history {
    return Intl.message(
      'History',
      name: 'bottom_history',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get bottom_chat {
    return Intl.message(
      'Chat',
      name: 'bottom_chat',
      desc: '',
      args: [],
    );
  }

  /// `Shift Not Started`
  String get title_offline {
    return Intl.message(
      'Shift Not Started',
      name: 'title_offline',
      desc: '',
      args: [],
    );
  }

  /// `Ready for ride`
  String get title_soon {
    return Intl.message(
      'Ready for ride',
      name: 'title_soon',
      desc: '',
      args: [],
    );
  }

  /// `Looking for orders`
  String get title_online {
    return Intl.message(
      'Looking for orders',
      name: 'title_online',
      desc: '',
      args: [],
    );
  }

  /// `Offline`
  String get status_offline {
    return Intl.message(
      'Offline',
      name: 'status_offline',
      desc: '',
      args: [],
    );
  }

  /// `Soon`
  String get status_soon {
    return Intl.message(
      'Soon',
      name: 'status_soon',
      desc: '',
      args: [],
    );
  }

  /// `Online`
  String get status_online {
    return Intl.message(
      'Online',
      name: 'status_online',
      desc: '',
      args: [],
    );
  }

  /// `Ratings, Break, Profile`
  String get rate_break_profile {
    return Intl.message(
      'Ratings, Break, Profile',
      name: 'rate_break_profile',
      desc: '',
      args: [],
    );
  }

  /// `Duty Option`
  String get duty_option {
    return Intl.message(
      'Duty Option',
      name: 'duty_option',
      desc: '',
      args: [],
    );
  }

  /// `Request Break`
  String get request_break {
    return Intl.message(
      'Request Break',
      name: 'request_break',
      desc: '',
      args: [],
    );
  }

  /// `Extend Duty`
  String get extend_duty {
    return Intl.message(
      'Extend Duty',
      name: 'extend_duty',
      desc: '',
      args: [],
    );
  }

  /// `One Time Only`
  String get one_time_only {
    return Intl.message(
      'One Time Only',
      name: 'one_time_only',
      desc: '',
      args: [],
    );
  }

  /// `Chat Support`
  String get chat_support {
    return Intl.message(
      'Chat Support',
      name: 'chat_support',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message(
      'Year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Today's Orders`
  String get today_order {
    return Intl.message(
      'Today\'s Orders',
      name: 'today_order',
      desc: '',
      args: [],
    );
  }

  /// `New Salalah Zone`
  String get new_salalah_zone {
    return Intl.message(
      'New Salalah Zone',
      name: 'new_salalah_zone',
      desc: '',
      args: [],
    );
  }

  /// `Assigned Orders`
  String get assigned_orders {
    return Intl.message(
      'Assigned Orders',
      name: 'assigned_orders',
      desc: '',
      args: [],
    );
  }

  /// `Nearby Pendings`
  String get nearby_pendings {
    return Intl.message(
      'Nearby Pendings',
      name: 'nearby_pendings',
      desc: '',
      args: [],
    );
  }

  /// `Before You Begin`
  String get before_you_begin {
    return Intl.message(
      'Before You Begin',
      name: 'before_you_begin',
      desc: '',
      args: [],
    );
  }

  /// `Make sure you’re ready for your ride !`
  String get before_dialog_desc {
    return Intl.message(
      'Make sure you’re ready for your ride !',
      name: 'before_dialog_desc',
      desc: '',
      args: [],
    );
  }

  /// `Charged Phone With Data`
  String get charge_phone_data {
    return Intl.message(
      'Charged Phone With Data',
      name: 'charge_phone_data',
      desc: '',
      args: [],
    );
  }

  /// `Enough Fuel`
  String get enough_fuel {
    return Intl.message(
      'Enough Fuel',
      name: 'enough_fuel',
      desc: '',
      args: [],
    );
  }

  /// `Thermal Bag`
  String get thermal_bag {
    return Intl.message(
      'Thermal Bag',
      name: 'thermal_bag',
      desc: '',
      args: [],
    );
  }

  /// `Company T-Shirt`
  String get company_t_shirt {
    return Intl.message(
      'Company T-Shirt',
      name: 'company_t_shirt',
      desc: '',
      args: [],
    );
  }

  /// `Start Riding`
  String get start_riding {
    return Intl.message(
      'Start Riding',
      name: 'start_riding',
      desc: '',
      args: [],
    );
  }

  /// `Ride Now`
  String get ride_now {
    return Intl.message(
      'Ride Now',
      name: 'ride_now',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get items {
    return Intl.message(
      'Items',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Directions`
  String get directions {
    return Intl.message(
      'Directions',
      name: 'directions',
      desc: '',
      args: [],
    );
  }

  /// `PICK UP AT`
  String get pick_up_at {
    return Intl.message(
      'PICK UP AT',
      name: 'pick_up_at',
      desc: '',
      args: [],
    );
  }

  /// `To confirm pickup process, slide the button to right and that means you agreed to terms and conditions.`
  String get pick_up_detail {
    return Intl.message(
      'To confirm pickup process, slide the button to right and that means you agreed to terms and conditions.',
      name: 'pick_up_detail',
      desc: '',
      args: [],
    );
  }

  /// `Slide after arrival`
  String get slider_after_arrival {
    return Intl.message(
      'Slide after arrival',
      name: 'slider_after_arrival',
      desc: '',
      args: [],
    );
  }

  /// `CUSTOMER`
  String get customer {
    return Intl.message(
      'CUSTOMER',
      name: 'customer',
      desc: '',
      args: [],
    );
  }

  /// `ORDER DETAILS`
  String get order_detail {
    return Intl.message(
      'ORDER DETAILS',
      name: 'order_detail',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm the following`
  String get confirm_title {
    return Intl.message(
      'Please confirm the following',
      name: 'confirm_title',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm you have all of the following items, click Confirm or Go Back`
  String get confirm_desc {
    return Intl.message(
      'Please confirm you have all of the following items, click Confirm or Go Back',
      name: 'confirm_desc',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Go Back`
  String get go_back {
    return Intl.message(
      'Go Back',
      name: 'go_back',
      desc: '',
      args: [],
    );
  }

  /// `Delivery for`
  String get delivery_for {
    return Intl.message(
      'Delivery for',
      name: 'delivery_for',
      desc: '',
      args: [],
    );
  }

  /// `DROP OFF`
  String get drop_off {
    return Intl.message(
      'DROP OFF',
      name: 'drop_off',
      desc: '',
      args: [],
    );
  }

  /// `After arrival, Give items to customer then slide to drop off order and take the next order.`
  String get drop_off_title {
    return Intl.message(
      'After arrival, Give items to customer then slide to drop off order and take the next order.',
      name: 'drop_off_title',
      desc: '',
      args: [],
    );
  }

  /// `I’ve arrived at customer`
  String get drop_off_result {
    return Intl.message(
      'I’ve arrived at customer',
      name: 'drop_off_result',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Please keep the order at my door`
  String get notes_detail {
    return Intl.message(
      'Please keep the order at my door',
      name: 'notes_detail',
      desc: '',
      args: [],
    );
  }

  /// `Your Account is Blocked`
  String get account_block {
    return Intl.message(
      'Your Account is Blocked',
      name: 'account_block',
      desc: '',
      args: [],
    );
  }

  /// `Time Left`
  String get min_left {
    return Intl.message(
      'Time Left',
      name: 'min_left',
      desc: '',
      args: [],
    );
  }

  /// `You are in break `
  String get you_break {
    return Intl.message(
      'You are in break ',
      name: 'you_break',
      desc: '',
      args: [],
    );
  }

  /// `Waiting Approval`
  String get api_connection_title {
    return Intl.message(
      'Waiting Approval',
      name: 'api_connection_title',
      desc: '',
      args: [],
    );
  }

  /// `We have received your request.....`
  String get api_connection_desc {
    return Intl.message(
      'We have received your request.....',
      name: 'api_connection_desc',
      desc: '',
      args: [],
    );
  }

  /// `Customer's Payment`
  String get customer_payment {
    return Intl.message(
      'Customer\'s Payment',
      name: 'customer_payment',
      desc: '',
      args: [],
    );
  }

  /// `You’re scheduled to Rider Hub in `
  String get timezone_detail_one {
    return Intl.message(
      'You’re scheduled to Rider Hub in ',
      name: 'timezone_detail_one',
      desc: '',
      args: [],
    );
  }

  /// ` Starts At `
  String get timezone_detail_two {
    return Intl.message(
      ' Starts At ',
      name: 'timezone_detail_two',
      desc: '',
      args: [],
    );
  }

  /// `OMR`
  String get price_unit {
    return Intl.message(
      'OMR',
      name: 'price_unit',
      desc: '',
      args: [],
    );
  }

  /// `Km`
  String get distance_unit {
    return Intl.message(
      'Km',
      name: 'distance_unit',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}