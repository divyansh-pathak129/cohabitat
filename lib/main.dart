import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: const CohabitatApp(),
    ),
  );
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
        // Make buttons more modern with rounded corners
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
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
        // Make buttons more modern with rounded corners (dark theme)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
        ),
      ),
      home: Consumer<AuthService>(
        builder: (context, authService, _) {
          // Show splash screen while loading
          if (authService.isLoading) {
            return const SplashScreen();
          }
          // Show login screen if not authenticated
          if (!authService.isAuthenticated) {
            return const LoginScreen();
          }
          // Show home page if authenticated
          return const HomePage();
        },
      ),
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
          NavigationDestination(icon: Icon(Icons.spa), label: 'Amenities'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
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

// Dashboard view with authentication awareness
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
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
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
                  Text(content, style: Theme.of(context).textTheme.bodyMedium),
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
    return const Center(child: Text('Book society amenities here'));
  }
}

// Enhanced Profile view with authentication status
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Get user information from Auth0
    final user = authService.userProfile;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          // Profile avatar
          CircleAvatar(
            radius: 50,
            backgroundColor: colorScheme.primaryContainer,
            child:
                user != null &&
                        user['name'] != null &&
                        user['name'].toString().isNotEmpty
                    ? Text(
                      user['name'].toString()[0].toUpperCase(),
                      style: textTheme.displayLarge?.copyWith(
                        color: colorScheme.primary,
                      ),
                    )
                    : Icon(Icons.person, size: 50, color: colorScheme.primary),
          ),

          const SizedBox(height: 20),

          // User name
          Text(
            user != null && user['name'] != null
                ? user['name'].toString()
                : 'User',
            style: textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),

          // User email
          if (user != null && user['email'] != null)
            Text(
              user['email'].toString(),
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.7),
              ),
            ),

          const SizedBox(height: 40),

          // User information cards
          Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Information',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildProfileInfoRow(
                    context,
                    icon: Icons.apartment,
                    title: 'Flat',
                    value:
                        user != null && user['flatNumber'] != null
                            ? user['flatNumber'].toString()
                            : 'A-101',
                  ),
                  _buildProfileInfoRow(
                    context,
                    icon: Icons.phone,
                    title: 'Phone',
                    value:
                        user != null && user['phoneNumber'] != null
                            ? user['phoneNumber'].toString()
                            : '+1 (555) 123-4567',
                  ),
                  _buildProfileInfoRow(
                    context,
                    icon: Icons.badge,
                    title: 'Member Since',
                    value:
                        user != null && user['memberSince'] != null
                            ? 'January 2025'
                            : 'January 2025',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Logout button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed:
                  authService.isLoading ? null : () => authService.logout(),
              icon:
                  authService.isLoading
                      ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : const Icon(Icons.logout),
              label: Text(
                authService.isLoading ? 'LOGGING OUT...' : 'LOGOUT',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.errorContainer,
                foregroundColor: colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfoRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: colorScheme.primary),
          const SizedBox(width: 12),
          Text(
            '$title: ',
            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
          Text(value, style: textTheme.bodyMedium),
        ],
      ),
    );
  }
}
