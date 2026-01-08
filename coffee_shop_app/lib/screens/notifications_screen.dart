import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy notifications data
    final List<Map<String, dynamic>> notifications = [
      {
        'title': '50% Off Today!',
        'body': 'Get half price on all Lattes until 5 PM.',
        'time': '2 hrs ago',
        'isNew': true,
      },
      {
        'title': 'Order Ready',
        'body': 'Your Caramel Macchiato is waiting for pickup.',
        'time': '5 hrs ago',
        'isNew': false,
      },
      {
        'title': 'New Arrival',
        'body': 'Try our new Pumpkin Spice blend.',
        'time': '1 day ago',
        'isNew': false,
      },
      {
        'title': 'Happy Hour',
        'body': 'Buy 1 Get 1 Free on all Espressos.',
        'time': '2 days ago',
        'isNew': false,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              "Notifications",
              style: GoogleFonts.bebasNeue(fontSize: 40, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 100), // Padding for nav bar
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final item = notifications[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.grey[800]!, Colors.grey[900]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                         BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      border: item['isNew'] ? Border.all(color: Colors.orange.withOpacity(0.5), width: 1) : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: item['isNew'] ? Colors.orange : Colors.grey[800],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            item['isNew'] ? Icons.local_offer : Icons.notifications,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item['title'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  if (item['isNew'])
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.orange.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text('NEW', style: TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item['body'],
                                style: TextStyle(color: Colors.grey[400], fontSize: 13, height: 1.4),
                              ),
                               const SizedBox(height: 8),
                              Text(
                                item['time'],
                                style: TextStyle(color: Colors.grey[600], fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
