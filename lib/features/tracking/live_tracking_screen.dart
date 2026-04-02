import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/model/tracking_data.dart';
import 'package:dinar_app/core/widgets/tracking/tracking_map_widget.dart';
import 'package:dinar_app/core/widgets/tracking/tracking_top_overlay.dart';
import 'package:dinar_app/core/widgets/tracking/driver_info_panel.dart';

class LiveTrackingscreen extends StatefulWidget {
  final TrackingData? trackingData;
  const LiveTrackingscreen({super.key, this.trackingData});

  @override
  State<LiveTrackingscreen> createState() => _LiveTrackingscreenState();
}

class _LiveTrackingscreenState extends State<LiveTrackingscreen> {
  late TrackingData _data;

  @override
  void initState() {
    super.initState();
    _data = widget.trackingData ?? dummyTrackingData; // TODO: replace with API
  }

  void _callDriver() {
    // TODO: await launchUrl(Uri(scheme: 'tel', path: _data.driverPhone));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Calling ${_data.driverPhone}…')),
    );
  }

  void _messageDriver() {
    // TODO: await launchUrl(Uri(scheme: 'sms', path: _data.driverPhone));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Messaging ${_data.driverPhone}…')),
    );
  }

  void _cancelBooking() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Cancel Booking?'),
        content: const Text('Are you sure you want to cancel this trip?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text('No')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.pop();
            },
            child:
                const Text('Yes, Cancel', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                TrackingMapWidget(data: _data),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: TrackingTopOverlay(
                      etaMinutes: _data.etaMinutes,
                      onBack: () => context.pop(),
                      onClose: () => context.pop(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          DriverInfoPanel(
            data: _data,
            onCallDriver: _callDriver,
            onMessage: _messageDriver,
            onCancel: _cancelBooking,
          ),
        ],
      ),
    );
  }
}
