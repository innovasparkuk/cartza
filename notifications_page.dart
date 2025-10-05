import 'package:flutter/material.dart';

enum NotificationType {
  order,
  promotion,
  delivery,
  payment,
  wishlist,
  general,
  shipping,
  review,
  priceAlert
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  final bool isRead;
  final String? imageUrl;
  final String? routeName;
  final Map<String, dynamic>? routeArguments;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    this.isRead = false,
    this.imageUrl,
    this.routeName,
    this.routeArguments,
  });

  NotificationItem copyWith({bool? isRead}) {
    return NotificationItem(
      id: id,
      title: title,
      message: message,
      type: type,
      timestamp: timestamp,
      isRead: isRead ?? this.isRead,
      imageUrl: imageUrl,
      routeName: routeName,
      routeArguments: routeArguments,
    );
  }
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<NotificationItem> notifications = [
    NotificationItem(
      id: '1',
      title: 'Order Shipped',
      message: 'Your order #12345 has been shipped and will arrive in 2-3 days.',
      type: NotificationType.delivery,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
      routeName: '/orderTracking',
      routeArguments: {'orderId': '12345'},
    ),
    NotificationItem(
      id: '2',
      title: '50% OFF Flash Sale',
      message: 'Limited time offer! Get 50% off on selected items. Shop now!',
      type: NotificationType.promotion,
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      isRead: false,
      routeName: '/home',
    ),
    NotificationItem(
      id: '3',
      title: 'Order Delivered',
      message: 'Your order #12340 has been successfully delivered. Rate your experience!',
      type: NotificationType.order,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
      routeName: '/orders',
    ),
    NotificationItem(
      id: '4',
      title: 'Payment Successful',
      message: 'Payment of ₹12,999 received for order #12345.',
      type: NotificationType.payment,
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      isRead: true,
      routeName: '/paymentHistory',
    ),
    NotificationItem(
      id: '5',
      title: 'Item Back in Stock',
      message: 'Good news! Samsung Galaxy S24 from your wishlist is now available.',
      type: NotificationType.wishlist,
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
      routeName: '/wishlist',
    ),
    NotificationItem(
      id: '6',
      title: 'Price Drop Alert',
      message: 'The price of iPhone 15 Pro has dropped by 15%. Check it out now!',
      type: NotificationType.priceAlert,
      timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 5)),
      isRead: false,
      routeName: '/productDetail',
      routeArguments: {'productId': 'iphone-15-pro'},
    ),
    NotificationItem(
      id: '7',
      title: 'Review Reminder',
      message: 'How was your recent purchase? Share your feedback and help others.',
      type: NotificationType.review,
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      isRead: true,
      routeName: '/reviews',
    ),
    NotificationItem(
      id: '8',
      title: 'Shipping Address Updated',
      message: 'Your default shipping address has been successfully updated.',
      type: NotificationType.shipping,
      timestamp: DateTime.now().subtract(const Duration(days: 4)),
      isRead: true,
      routeName: '/shippingAddress',
    ),
  ];

  String selectedFilter = 'All';
  final List<String> filters = [
    'All',
    'Orders',
    'Promotions',
    'Delivery',
    'Wishlist',
    'Payments'
  ];

  List<NotificationItem> get filteredNotifications {
    if (selectedFilter == 'All') return notifications;

    NotificationType? type;
    switch (selectedFilter) {
      case 'Orders':
        type = NotificationType.order;
        break;
      case 'Promotions':
        type = NotificationType.promotion;
        break;
      case 'Delivery':
        type = NotificationType.delivery;
        break;
      case 'Payments':
        type = NotificationType.payment;
        break;
      case 'Wishlist':
        type = NotificationType.wishlist;
        break;
    }

    return notifications.where((n) => n.type == type).toList();
  }

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  void markAsRead(String id) {
    setState(() {
      final index = notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        notifications[index] = notifications[index].copyWith(isRead: true);
      }
    });
  }

  void markAllAsRead() {
    setState(() {
      notifications =
          notifications.map((n) => n.copyWith(isRead: true)).toList();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('All notifications marked as read'),
        backgroundColor: const Color(0xFF4CAF50),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void deleteNotification(String id) {
    setState(() {
      notifications.removeWhere((n) => n.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Notification deleted'),
        backgroundColor: const Color(0xFFFF6F00),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void clearAll() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Clear All Notifications',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF212121)),
        ),
        content: const Text(
          'Are you sure you want to delete all notifications? This action cannot be undone.',
          style: TextStyle(color: Color(0xFF212121)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF212121))),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6F00),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              setState(() {
                notifications.clear();
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('All notifications cleared'),
                  backgroundColor: const Color(0xFF4CAF50),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  void handleNotificationTap(NotificationItem notification) {
    markAsRead(notification.id);

    if (notification.routeName != null) {
      // Navigate to the specific route
      Navigator.pushNamed(
        context,
        notification.routeName!,
        arguments: notification.routeArguments,
      ).catchError((error) {
        // Handle route not found error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Page not available: ${notification.routeName}'),
            backgroundColor: const Color(0xFFFF6F00),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        return null;
      });
    } else {
      // Show notification details if no route specified
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(
                getIconForType(notification.type),
                color: getColorForType(notification.type),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  notification.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF212121),
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            notification.message,
            style: const TextStyle(color: Color(0xFF212121)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text(
                'Close',
                style: TextStyle(color: Color(0xFFFF6F00)),
              ),
            ),
          ],
        ),
      );
    }
  }

  IconData getIconForType(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return Icons.shopping_bag_outlined;
      case NotificationType.promotion:
        return Icons.local_offer_outlined;
      case NotificationType.delivery:
        return Icons.local_shipping_outlined;
      case NotificationType.payment:
        return Icons.payment_outlined;
      case NotificationType.wishlist:
        return Icons.favorite_border;
      case NotificationType.shipping:
        return Icons.location_on_outlined;
      case NotificationType.review:
        return Icons.rate_review_outlined;
      case NotificationType.priceAlert:
        return Icons.trending_down;
      case NotificationType.general:
        return Icons.info_outline;
    }
  }

  Color getColorForType(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return const Color(0xFF4CAF50);
      case NotificationType.promotion:
        return const Color(0xFFFF6F00);
      case NotificationType.delivery:
        return const Color(0xFF4CAF50);
      case NotificationType.payment:
        return const Color(0xFF2196F3);
      case NotificationType.wishlist:
        return const Color(0xFFE91E63);
      case NotificationType.shipping:
        return const Color(0xFF9C27B0);
      case NotificationType.review:
        return const Color(0xFFFFC107);
      case NotificationType.priceAlert:
        return const Color(0xFFFF5722);
      case NotificationType.general:
        return const Color(0xFF212121);
    }
  }

  String getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final diff = now.difference(timestamp);

    if (diff.inDays > 7) {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    } else if (diff.inDays > 0) {
      return '${diff.inDays}d ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}h ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF212121)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Color(0xFF212121),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          if (unreadCount > 0)
            TextButton.icon(
              onPressed: markAllAsRead,
              icon: const Icon(Icons.done_all, size: 18),
              label: const Text('Mark all'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFFF6F00),
              ),
            ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF212121)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            itemBuilder: (ctx) => [
              const PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings_outlined, size: 20),
                    SizedBox(width: 12),
                    Text('Notification Settings'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, size: 20, color: Color(0xFFFF6F00)),
                    SizedBox(width: 12),
                    Text(
                      'Clear all',
                      style: TextStyle(color: Color(0xFFFF6F00)),
                    ),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'clear') {
                clearAll();
              } else if (value == 'settings') {
                Navigator.pushNamed(context, '/notificationSettings')
                    .catchError((e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Settings page not available')),
                  );
                  return null;
                });
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Unread notification banner
          if (unreadCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFF6F00).withValues(alpha: 0.1),
                border: Border(
                  bottom: BorderSide(
                    color: const Color(0xFFFF6F00).withValues(alpha: 0.2),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6F00),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.notifications_active,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '$unreadCount new notification${unreadCount > 1 ? 's' : ''}',
                    style: const TextStyle(
                      color: Color(0xFFFF6F00),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

          // Filter chips
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (ctx, i) {
                final isSelected = filters[i] == selectedFilter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(filters[i]),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedFilter = filters[i];
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: const Color(0xFFFF6F00).withValues(alpha: 0.15),
                    checkmarkColor: const Color(0xFFFF6F00),
                    side: BorderSide(
                      color: isSelected
                          ? const Color(0xFFFF6F00)
                          : Colors.grey.shade300,
                      width: 1.5,
                    ),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? const Color(0xFFFF6F00)
                          : const Color(0xFF212121),
                      fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),

          // Notification list
          Expanded(
            child: filteredNotifications.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 80,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No notifications',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You\'re all caught up!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: filteredNotifications.length,
              itemBuilder: (ctx, i) {
                final notification = filteredNotifications[i];
                return Dismissible(
                  key: Key(notification.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: const Color(0xFFFF6F00),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  onDismissed: (_) => deleteNotification(notification.id),
                  child: NotificationCard(
                    notification: notification,
                    onTap: () => handleNotificationTap(notification),
                    getIcon: getIconForType,
                    getColor: getColorForType,
                    getTimeAgo: getTimeAgo,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onTap;
  final IconData Function(NotificationType) getIcon;
  final Color Function(NotificationType) getColor;
  final String Function(DateTime) getTimeAgo;

  const NotificationCard({
    Key? key,
    required this.notification,
    required this.onTap,
    required this.getIcon,
    required this.getColor,
    required this.getTimeAgo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = getColor(notification.type);

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: notification.isRead
              ? Colors.white
              : const Color(0xFFFF6F00).withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: notification.isRead
                ? Colors.grey.shade200
                : const Color(0xFFFF6F00).withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            if (!notification.isRead)
              BoxShadow(
                color: const Color(0xFFFF6F00).withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                getIcon(notification.type),
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: notification.isRead
                                ? FontWeight.w600
                                : FontWeight.bold,
                            color: const Color(0xFF212121),
                          ),
                        ),
                      ),
                      if (!notification.isRead) ...[
                        const SizedBox(width: 8),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF6F00),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    notification.message,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        getTimeAgo(notification.timestamp),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (notification.routeName != null) ...[
                        const SizedBox(width: 12),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Colors.grey.shade400,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}