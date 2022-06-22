import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:riderhub/generated/l10n.dart';
import 'package:riderhub/services/string_service.dart';
import 'package:riderhub/themes/colors.dart';
import 'package:riderhub/themes/dimens.dart';
import 'package:riderhub/themes/textstyle.dart';

class OrderModel {
  String company_name = "";
  String company_name_arab = "";
  String customer_avatar = "";
  String customer_name = "";
  String customer_thumb = "";
  String date_created = "";
  String date_updated = "";
  String delivery_price = "";
  String delivery_price1 = "";
  String driver_id = "";
  String driver_name = "";
  String id = "";
  String is_customer_avatar = "";
  String is_retailer_avatar = "";
  String is_service_avatar = "";
  String last_cashout = "";
  String order_address = "";
  String order_address_apartment = "";
  String order_address_company = "";
  String order_currency = "";
  String order_latitude = "";
  String order_longitude = "";
  String order_num = "";
  String order_status = "";
  String order_type = "";
  String payment_type = "";
  String retailer_avatar = "";
  String retailer_phone = "";
  String retailer_thumb = "";
  String service_avatar = "";
  String service_thumb = "";
  String store_id = "";
  String sub_total = "";
  String tip_amount = "";
  String total_price = "";
  String total_price_new = '0.0';
  String transaction_id = "";
  String user_id = "";
  String wallet_amount = "";
  List<ProductModel> products = [];

  OrderModel({
    this.company_name,
    this.company_name_arab,
    this.customer_avatar,
    this.customer_name,
    this.customer_thumb,
    this.date_created,
    this.date_updated,
    this.delivery_price,
    this.delivery_price1,
    this.driver_id,
    this.driver_name,
    this.id,
    this.is_customer_avatar,
    this.is_retailer_avatar,
    this.is_service_avatar,
    this.last_cashout,
    this.order_address,
    this.order_address_apartment,
    this.order_address_company,
    this.order_currency,
    this.order_latitude,
    this.order_longitude,
    this.order_num,
    this.order_status,
    this.order_type,
    this.payment_type,
    this.retailer_avatar,
    this.retailer_phone,
    this.retailer_thumb,
    this.service_avatar,
    this.service_thumb,
    this.store_id,
    this.sub_total,
    this.tip_amount,
    this.total_price,
    this.total_price_new,
    this.transaction_id,
    this.user_id,
    this.wallet_amount,
    this.products,
  });

  Widget itemWidget(BuildContext context, bool isEnglish,
      {bool isShownDate = true}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: offsetBase, vertical: offsetSm),
      padding: EdgeInsets.all(offsetBase),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(offsetSm)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.24),
              blurRadius: 4.0,
            )
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${StringService.orderIdFormatted(id)} (',
                      style: boldText.copyWith(
                          fontSize: 18.0, color: Colors.black),
                    ),
                    Text(
                      StringService.orderNumberFormatted(order_num),
                      style: boldText.copyWith(
                          fontSize: 18.0, color: lightGreyTextColor),
                    ),
                    Text(
                      ')',
                      style: boldText.copyWith(
                          fontSize: 18.0, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: offsetSm,
                ),
                Text(
                  isEnglish ? company_name : company_name_arab,
                  style: boldText.copyWith(
                      fontSize: 14.0, color: lightGreyTextColor),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        payment_type == '0'
                            ? 'assets/icons/ic_coin.png'
                            : 'assets/icons/ic_card.png',
                        width: 24.0,
                        height: 24.0,
                      ),
                      SizedBox(
                        width: offsetXSm,
                      ),
                      Text(
                        '${StringService.priceFormatted(total_price)} ${S.of(context).price_unit}',
                        style: boldText.copyWith(
                            fontSize: 12.0, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: offsetBase,
              ),
              if (isShownDate)
                Text(
                  '${StringService.timestampToTime(date_updated)}',
                  style: boldText.copyWith(fontSize: 10.0, color: Colors.black),
                )
            ],
          ),
        ],
      ),
    );
  }

  Widget pendingWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: offsetBase, vertical: offsetSm),
      padding: EdgeInsets.all(offsetBase),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(offsetSm)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.24),
              blurRadius: 4.0,
            )
          ]),
      child: Row(
        children: [
          Text(
            '#0000053462 (',
            style: boldText.copyWith(fontSize: 18.0, color: Colors.black),
          ),
          Text(
            '24#',
            style: boldText.copyWith(fontSize: 18.0, color: lightGreyTextColor),
          ),
          Text(
            ')',
            style: boldText.copyWith(fontSize: 18.0, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    var map = {
      'company_name': company_name,
      'company_name_arab': company_name_arab,
      'customer_avatar': customer_avatar,
      'customer_name': customer_name,
      'customer_thumb': customer_thumb,
      'date_created': date_created,
      'date_updated': date_updated,
      'delivery_price': delivery_price,
      'delivery_price1': delivery_price1,
      'driver_id': driver_id,
      'driver_name': driver_name,
      'id': id,
      'is_customer_avatar': is_customer_avatar,
      'is_retailer_avatar': is_retailer_avatar,
      'is_service_avatar': is_service_avatar,
      'last_cashout': last_cashout,
      'order_address': order_address,
      'order_address_apartment': order_address_apartment,
      'order_address_company': order_address_company,
      'order_currency': order_currency,
      'order_latitude': order_latitude,
      'order_longitude': order_longitude,
      'order_num': order_num,
      'order_status': order_status,
      'order_type': order_type,
      'payment_type': payment_type,
      'retailer_avatar': retailer_avatar,
      'retailer_phone': retailer_phone,
      'retailer_thumb': retailer_thumb,
      'service_avatar': service_avatar,
      'service_thumb': service_thumb,
      'store_id': store_id,
      'sub_total': sub_total,
      'tip_amount': tip_amount,
      'total_price': total_price,
      'total_price_new': total_price_new,
      'transaction_id': transaction_id,
      'user_id': user_id,
      'wallet_amount': wallet_amount,
      'products': products?.map((x) => x.toMap())?.toList(),
    };
    return map;
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      company_name: map['company_name'],
      company_name_arab: map['company_name_arab'],
      customer_avatar: map['customer_avatar'],
      customer_name: map['customer_name'],
      customer_thumb: map['customer_thumb'],
      date_created: map['date_created'],
      date_updated: map['date_updated'],
      delivery_price: map['delivery_price'],
      delivery_price1: map['delivery_price1'],
      driver_id: map['driver_id'],
      driver_name: map['driver_name'],
      id: map['id'],
      is_customer_avatar: map['is_customer_avatar'],
      is_retailer_avatar: map['is_retailer_avatar'],
      is_service_avatar: map['is_service_avatar'],
      last_cashout: map['last_cashout'],
      order_address: map['order_address'],
      order_address_apartment: map['order_address_apartment'],
      order_address_company: map['order_address_company'],
      order_currency: map['order_currency'],
      order_latitude: map['order_latitude'],
      order_longitude: map['order_longitude'],
      order_num: map['order_num'],
      order_status: map['order_status'],
      order_type: map['order_type'],
      payment_type: map['payment_type'],
      retailer_avatar: map['retailer_avatar'],
      retailer_phone: map['retailer_phone'],
      retailer_thumb: map['retailer_thumb'],
      service_avatar: map['service_avatar'],
      service_thumb: map['service_thumb'],
      store_id: map['store_id'],
      sub_total: map['sub_total'],
      tip_amount: map['tip_amount'],
      total_price: map['total_price'],
      total_price_new: (map['total_price_new']).toString(),
      transaction_id: map['transaction_id'],
      user_id: map['user_id'],
      wallet_amount: map['wallet_amount'],
      products: List<ProductModel>.from(
          map['products']?.map((x) => ProductModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));
}

class ProductModel {
  String amount = '';
  String id = '';
  String product_id = '';
  String product_price = '';
  String title = '';
  String title_arab = '';

  ProductModel({
    this.amount,
    this.id,
    this.product_id,
    this.product_price,
    this.title,
    this.title_arab,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'id': id,
      'product_id': product_id,
      'product_price': product_price,
      'title': title,
      'title_arab': title_arab,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      amount: map['amount'],
      id: map['id'],
      product_id: map['product_id'],
      product_price: map['product_price'],
      title: map['title'],
      title_arab: map['title_arab'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
