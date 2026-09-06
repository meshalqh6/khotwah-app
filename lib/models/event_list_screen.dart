import 'package:flutter/material.dart';
import 'package:khotwah/models/event_model.dart';

class EventListScreen extends StatelessWidget {
  final List<Event> events = [
    Event(
      title: 'Music Festival',
      description: 'An exciting music festival with live performances.',
      date: '2024-10-15',
      location: 'Riyadh',
    ),
    Event(
      title: 'Cultural Exhibition',
      description: 'Explore the culture of Saudi Arabia.',
      date: '2024-10-20',
      location: 'Riyadh',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return ListTile(
            title: Text(event.title),
            subtitle: Text('${event.location} - ${event.date}'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to event details if needed
            },
          );
        },
      ),
    );
  }
}
