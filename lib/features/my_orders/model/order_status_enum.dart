import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharma_connect/core/styles/app_colors.dart';

enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered;

  static OrderStatus fromString(String value) => switch (value.toLowerCase()) {
    'processing' => processing,
    'shipped' => shipped,
    'delivered' => delivered,
    'order placed' || 'pending' || String() => pending,
  };

  static OrderStatus fromDate(String date) {
    final currentDate = DateTime.now();
    final dateTime = DateFormat('dd-MM-yyyy').parse(date);
    final difference = currentDate.difference(dateTime).inDays;
    if (difference <= 0) {
      return pending; // Order has not been processed yet
    } else if (difference <= 3) {
      return processing; // Order is in processing
    } else if (difference <= 12) {
      return shipped; // Order is shipped
    } else {
      return delivered; // Order is delivered
    }
  }

  Color get statusColor => switch (this) {
    pending => Colors.orange, // Orange for pending
    processing => Colors.blue, // Blue for processing
    shipped => Colors.green, // Green for shipped
    delivered => AppColors.deepteal, // Grey for delivered
  };

  String get statusDescription => switch (this) {
    pending => 'Order Is Pending',
    processing => 'Order Is Being Processed',
    shipped => 'Order has been Shipped',
    delivered => 'Order has been Delivered',
  };
}
