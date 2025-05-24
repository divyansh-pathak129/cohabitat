import 'package:flutter/material.dart';

void main() {
  runApp(const CohabitatApp());
}

class CohabitatApp extends StatelessWidget {
  const CohabitatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cohabitat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Enable Material 3 design
        useMaterial3: true,
        // Use a teal color scheme which feels appropriate for a society management app
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00897B), // Teal shade
          brightness: Brightness.light,
        ),
        // Configure text theme to ensure good readability
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00897B),
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Placeholder widgets for the different sections of the app
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardView(),
    NoticesView(),
    AmenitiesView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cohabitat'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Implement notifications view
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Implement settings view
            },
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onItemTapped,
        selectedIndex: _selectedIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.announcement),
            label: 'Notices',
          ),
          NavigationDestination(
            icon: Icon(Icons.spa),
            label: 'Amenities',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement quick action menu
        },
        tooltip: 'Quick Actions',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Placeholder view for the Dashboard section
class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to Cohabitat',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          _buildInfoCard(
            context,
            title: 'Society Updates',
            content: 'No new updates today',
            icon: Icons.update,
          ),
          const SizedBox(height: 12),
          _buildInfoCard(
            context,
            title: 'Maintenance Due',
            content: 'Next payment due on 1st June',
            icon: Icons.payment,
          ),
          const SizedBox(height: 12),
          _buildInfoCard(
            context,
            title: 'Upcoming Events',
            content: 'Society Meeting - Sunday, 10:00 AM',
            icon: Icons.event,
          ),
          const SizedBox(height: 12),
          _buildInfoCard(
            context,
            title: 'Visitor Management',
            content: '2 visitors expected today',
            icon: Icons.people,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    style: Theme.of(context).textTheme.bodyMedium,
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

// Placeholder view for the Notices section
class NoticesView extends StatelessWidget {
  const NoticesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Notices and Announcements will appear here'),
    );
  }
}

// Placeholder view for the Amenities section
class AmenitiesView extends StatelessWidget {
  const AmenitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Book society amenities here'),
    );
  }
}

// Placeholder view for the Profile section
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('User profile information will appear here'),
    );
  }
}
