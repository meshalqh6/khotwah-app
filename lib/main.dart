import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'otp_verification_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Khotwah',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
        '/places': (context) => TouristPlacesScreen(),
        '/signup': (context) => SignupScreen(),
        '/itinerary': (context) => ItineraryScreen(),
        '/otp': (context) => OTPVerificationScreen(email: ''),
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validateEmail(String? value) {
    String pattern = r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Please enter your email';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Invalid Password';
    }
    return null;
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Here you would typically authenticate with your backend
      // For this example, we'll just simulate a successful login and move to OTP verification
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPVerificationScreen(email: _emailController.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://i.ibb.co/D5f2ngS/APP-BG-KHOTWAH.jpg",
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'KHOTWAH',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserratAlternates(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.email, color: Colors.grey),
                      ),
                      validator: validateEmail,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.lock, color: Colors.grey),
                      ),
                      validator: validatePassword,
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.normal,
                          height: 1.3,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: _login,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Flutter map widget
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: LatLng(24.7136, 46.6753),  // Riyadh location
              zoom: 12.0,                        // Initial zoom level
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(24.7136, 46.6753),
                    builder: (ctx) => Icon(Icons.location_on, color: Colors.red, size: 50),
                  ),
                ],
              ),
            ],
          ),

          // Attribution widget added manually as a positioned element
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.all(5),
              color: Colors.white,
              child: Text(
                '© Dev AlFadhel',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),

          // Floating Action Buttons for zoom controls
          Positioned(
            right: 10,
            bottom: 80,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    _mapController.move(_mapController.center, _mapController.zoom + 1);
                  },
                  child: Icon(Icons.zoom_in),
                  mini: true,
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () {
                    _mapController.move(_mapController.center, _mapController.zoom - 1);
                  },
                  child: Icon(Icons.zoom_out),
                  mini: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validateEmail(String? value) {
    String pattern = r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Please enter your email';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
        .hasMatch(value)) {
      return 'Password does not match the requirements';
    }
    return null;
  }

  void _signup() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign Up Successful! Please Log In.')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with dark overlay for contrast
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://www.abercrombiekent.co.uk/-/media/abercrombiekent/images/experiences/north-africa-and-middle-east/saudi-arabia/ancient-wonders-of-al-ula-tour/sta-aula-012.jpg?la=en&hash=4036587EA449C80D7992C0C10927AD1971E8FB2D",
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App name/logo at the top
                    Text(
                      'KHOTWAH',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserratAlternates(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 30),

                    // Profile Icon/Avatar
                    CircleAvatar(
                      radius: 90,
                      backgroundImage: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/512/4091/4091048.png'),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(height: 30),

                    // Email input field
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.email, color: Colors.grey),
                      ),
                      validator: validateEmail,
                    ),
                    SizedBox(height: 20),

                    // Password input field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.lock, color: Colors.grey),
                      ),
                      validator: validatePassword,
                    ),
                    SizedBox(height: 20),

                    // Password Requirements Info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• At least 6 characters',
                            style: TextStyle(color: Colors.black)),
                        Text('• At least 1 uppercase letter',
                            style: TextStyle(color: Colors.black)),
                        Text('• At least 1 digit',
                            style: TextStyle(color: Colors.black)),
                        Text('• At least 1 special character',
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Sign Up button
                    GestureDetector(
                      onTap: _signup,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Back to login button
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: Text(
                        'Back to Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.normal,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TouristPlacesScreen extends StatefulWidget {
  @override
  _TouristPlacesScreenState createState() => _TouristPlacesScreenState();
}

class _TouristPlacesScreenState extends State<TouristPlacesScreen> {
  int _selectedIndex = 2;  // Start with the map screen selected (center index)

  final List<Widget> _pages = [
    TouristPlacesContent(), // First tab
    HotelsScreen(),         // Second tab
    MapScreen(),            // Center tab (Map)
    TransportScreen(),       // Fourth tab
    ProfileScreen(),         // Fifth tab
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Places',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hotel),
            label: 'Hotels',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),  // Center Map icon
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Transport',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

// Content for Tourist Places
class TouristPlacesContent extends StatefulWidget {
  @override
  _TouristPlacesContentState createState() => _TouristPlacesContentState();
}

class _TouristPlacesContentState extends State<TouristPlacesContent> {
  final List<Map<String, String>> places = [
    {'name': '5-Day Adventure To The Empty Quarter', 'category': 'Adventure', 'imageUrl': 'https://visitabudhabi.ae/-/media/project/vad/where-to-go/about-abu-dhabi/the-empty-quarter/article/the-empty-quarter-03.jpg', 'price': '6,891.38 SAR / Per person | Adventure'},
    {'name': 'King Abdullah Financial District (KAFD)', 'category': 'Attractions', 'imageUrl': 'https://i.ibb.co/6mhyh75/kafd-city-new-banner-crop-1920x1080.jpg', 'price': 'Free | Attractions'},
    {'name': 'AlManjoor Trail Hiking Experience in Riyadh', 'category': 'Nature', 'imageUrl': 'https://book.visitsaudi.com/_next/image?url=%2Fapi%2Fimage-proxy%3Furl%3Dhttps%253A%252F%252Fhalayallaimages-new.s3.me-south-1.amazonaws.com%252Fimages%252Fvenues%252Fprovider_venue_66583c2b85212.&w=3840&q=85', 'price': '250 SAR / Per person | Nature'},
  ];

  List<Map<String, String>> filteredPlaces = [];
  final TextEditingController _searchController = TextEditingController();
  String? selectedCategory;  // To track the selected filter category

  @override
  void initState() {
    super.initState();
    filteredPlaces = places;
    _searchController.addListener(() {
      filterPlaces();
    });
  }

  // This function filters the list based on search query and selected category
  void filterPlaces() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredPlaces = places.where((place) {
        bool matchesSearch = place['name']!.toLowerCase().contains(query);
        bool matchesCategory = selectedCategory == null || place['category'] == selectedCategory;
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  // This function is called when a filter chip is selected
  void selectCategory(String? category) {
    setState(() {
      selectedCategory = category == selectedCategory ? null : category;  // Toggle selection
      filterPlaces();  // Reapply filters
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Explore',
            style: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Tourists Places',
            style: GoogleFonts.montserrat(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Find your place',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Welcome to',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          Text(
            'RIYADH',
            style: GoogleFonts.montserrat(
              fontSize: 36,
              fontWeight: FontWeight.w400,
              color: Color(0xFF4FA458),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Things to do in Riyadh',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),

          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CategoryChip(
                  title: 'Adventure',
                  isSelected: selectedCategory == 'Adventure',
                  onTap: () => selectCategory('Adventure'),
                ),
                SizedBox(width: 10),
                CategoryChip(
                  title: 'Attractions',
                  isSelected: selectedCategory == 'Attractions',
                  onTap: () => selectCategory('Attractions'),
                ),
                SizedBox(width: 10),
                CategoryChip(
                  title: 'Nature',
                  isSelected: selectedCategory == 'Nature',
                  onTap: () => selectCategory('Nature'),
                ),
                CategoryChip(
                  title: 'Culture & History',
                  isSelected: selectedCategory == 'Culture & History',
                  onTap: () => selectCategory('Culture & History'),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
          SizedBox(height: 30),

          // Activity Cards filtered by search and category
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: filteredPlaces.map((place) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ActivityCard(
                      imageUrl: place['imageUrl']!,
                      title: place['name']!,
                      price: place['price']!,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// CategoryChip Widget (Updated to handle selected state)
class CategoryChip extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF9C4674) : Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          title,
          style: GoogleFonts.montserrat(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}



// ActivityCard Widget
class ActivityCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;

  const ActivityCard({
    required this.imageUrl,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.network(
              imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              price,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItineraryScreen(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xFF9C4674),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Center(
                child: Text(
                  'View Details',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Hotels & Accommodations Screen
class HotelsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
        'Hotels & Accommodations',
        style: GoogleFonts.montserrat(
        fontSize: 24, // Larger font size
        fontWeight: FontWeight.bold, // Make it bold
    ),
    ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Find a Stay',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  HotelCard(
                    imageUrl:
                    'https://cf2.bstatic.com/xdata/images/hotel/max1024x768/390155609.jpg?k=d7f78c3c8a3b44587f939704032dee92c500b3a9bbfa8556688968d3c0ea8ea1&o=&hp=1',
                    title: 'Four Seasons Riyadh',
                    price: '1,200 SAR / Per night',
                  ),
                  SizedBox(height: 10),
                  HotelCard(
                    imageUrl:
                    'https://cf.bstatic.com/xdata/images/hotel/max1024x768/433356293.jpg?k=400f4b6f5cafeff9b55c739a6f96d5d1da49059024cbc86fc266e5ee2c2752f7&o=&hp=1',
                    title: 'Ritz-Carlton Riyadh',
                    price: '1,500 SAR / Per night',
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

// HotelCard Widget - Vertical Layout
class HotelCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;

  const HotelCard({
    required this.imageUrl,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  price,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Add your booking logic here
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Book Now',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Transport Screen - Vertical Layout
class TransportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text(
        'Transport Options',
        style: GoogleFonts.montserrat(
          fontSize: 24, // Larger font size
          fontWeight: FontWeight.bold, // Make it bold
        ),
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available Transport',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  TransportCard(
                    imageUrl:
                    'https://static.tildacdn.net/tild6361-3130-4863-a139-653435333165/jeddah_orig.png',
                    title: 'Saudi Railways',
                    price: '150 SAR / Per ticket',
                  ),
                  SizedBox(height: 10),
                  TransportCard(
                    imageUrl:
                    'https://saudigazette.com.sa/uploads/images/2023/03/19/2094076.jpg',
                    title: 'SAPTCO Bus',
                    price: '60 SAR / Per ticket',
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

// TransportCard Widget - Vertical Layout
class TransportCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;

  const TransportCard({
    required this.imageUrl,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  price,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Add your booking logic here
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Book Now',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _userEmail = "useremail@example.com";
  String _userName = "Dev Test";
  String _userPhone = "+966";

  @override
  void initState() {
    super.initState();
    _nameController.text = _userName;
    _phoneController.text = _userPhone;
  }

  void _saveProfile() {
    setState(() {
      _userName = _nameController.text;
      _userPhone = _phoneController.text;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile updated successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header with Avatar
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.purple[800],
                ),
                Positioned(
                  top: 50,
                  left: MediaQuery.of(context).size.width / 2 - 50,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://img.freepik.com/premium-vector/businessman-icon-man-from-saudi-emirate-avatar-isolated-white-background_53562-14513.jpg?w=1380"),
                  ),
                ),
                Positioned(
                  top: 170,
                  left: MediaQuery.of(context).size.width / 2 - 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _userName,
                        style: GoogleFonts.montserrat(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _userEmail,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Information Cards
            _buildCard('My Personal Information', Icons.person),
            _buildCard('My Bookings', Icons.book),
            _buildCard('Help & Support', Icons.help_outline),
            _buildCard('Settings & Privacy', Icons.settings),

            SizedBox(height: 20),

            // Sign Out Button
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false); // Add Sign Out logic
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Sign Out',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // App Version
            Text(
              "Version 1.0.001 (911)",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100], // Light background for consistency
    );
  }

  // Reusable method to build the card for each item
  Widget _buildCard(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.purple, size: 30),
            SizedBox(width: 15),
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}


// ItineraryScreen Widget remains the same
class ItineraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('5-Day Adventure Itinerary'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  'https://book.visitsaudi.com/_next/image?url=%2Fapi%2Fimage-proxy%3Furl%3Dhttps%253A%252F%252Fhalayallaimages-new.s3.me-south-1.amazonaws.com%252Fimages%252Fvenues%252Fprovider_venue_6649ed88d784d.&w=3840&q=85',
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 20,
                  left: 17,
                  child: Text(
                    '5-Day Adventure To The Empty Quarter',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your passion for adventure is filling up your heart and the thirst for adrenaline rush is growing day by day...'
                        'In this trip we explore and traverse the desert of the Empty Quarter in a 5-day program...',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Included',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '• Consultation before the program.\n'
                        '• Necessary permits from the Ministry of Tourism.\n'
                        '• Professional organizing team.\n'
                        '• 4x4 wheel drive.\n'
                        '• First Aid Kit.\n'
                        '• Meal Plan: Breakfast, lunch, and dinner.\n'
                        '• Individual Tent.',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'What\'s not Included',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '• Any Personal Expenses\n'
                        '• Flight Ticket\n'
                        '• Any meals not mentioned',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Refund Policy',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '2 Days before the event date:\n'
                        '• 5% deducted as an administrative fee...\n'
                        '• The remaining amount will be returned within 20 working days.',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF9C4674),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Book Now - 6,891.38 SAR',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
