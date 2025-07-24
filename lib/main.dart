import 'package:flutter/material.dart';

void main() {
  runApp(CycleDefenderApp());
}

// Color palette based on design screenshots
const darkBlue = Color(0xFF191C29);
const midBlue = Color(0xFF5349E3);
const activeBlue = Color(0xFF2868EA);
const blackButton = Color(0xFF232632);
const inputBlue = Color(0xFF65A5FF);

class CycleDefenderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cycle Defender',
      theme: ThemeData(fontFamily: 'Roboto'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/home': (context) => HomePage(),
        '/tripStart': (context) => StartTripPage(),
        '/tripSafe': (context) => OngoingTripSafePage(),
        '/tripAlert': (context) => OngoingTripAlertPage(),
        '/tripDanger': (context) => OngoingTripDangerPage(),
        '/tripCrashed': (context) => OngoingTripCrashedPage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}


class DiagonalBackground extends StatelessWidget {
  final Color topColor, bottomColor;
  final Widget child;
  DiagonalBackground({required this.topColor, required this.bottomColor, required this.child});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DiagonalPainter(topColor: topColor, bottomColor: bottomColor),
      child: child,
    );
  }
}

class _DiagonalPainter extends CustomPainter {
  final Color topColor, bottomColor;
  _DiagonalPainter({required this.topColor, required this.bottomColor});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    // Top dark blue
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.55)
      ..lineTo(0, size.height * 0.4)
      ..close();
    paint.color = topColor;
    canvas.drawPath(path, paint);

    // Bottom mid-blue
    Path path2 = Path()
      ..moveTo(0, size.height * 0.4)
      ..lineTo(size.width, size.height * 0.55)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    paint.color = bottomColor;
    canvas.drawPath(path2, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Icon for the app
class BikeIcon extends StatelessWidget {
  final double size;
  const BikeIcon({this.size = 40});
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.directions_bike, color: activeBlue, size: size);
  }
}

//Welcome Page
class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: DiagonalBackground(
        topColor: darkBlue,
        bottomColor: midBlue,
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 36),
                BikeIcon(size: 50),
                SizedBox(height: 12),
                Text('CYCLE DEFENDER',
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2)),
                SizedBox(height: 30),
                // Demo placeholder for biker
                Icon(Icons.pedal_bike, size: 120, color: Colors.orangeAccent),
                SizedBox(height: 40),
                _MenuButton(
                  text: "LOGIN",
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                ),
                SizedBox(height: 16),
                _MenuButton(
                  text: "SIGN UP",
                  onPressed: () => Navigator.pushNamed(context, '/signup'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Login Page
class LoginPage extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: midBlue,
      body: DiagonalBackground(
        topColor: darkBlue,
        bottomColor: midBlue,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BackButtonRow(),
                SizedBox(height: 18),
                Center(
                  child: Text('LOGIN', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                SizedBox(height: 36),
                _InputField(controller: userController, hint: "Username"),
                SizedBox(height: 18),
                _InputField(controller: passController, hint: "Password", obscureText: true),
                SizedBox(height: 30),
                Center(
                  child: _MenuButton(
                    text: "Continue",
                    onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Signup Page
class SignupPage extends StatelessWidget {
  final _controllers = List.generate(4, (_) => TextEditingController());
  final _hints = ['Name', 'Age', 'Blood Group', 'Gender'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: midBlue,
      body: DiagonalBackground(
        topColor: darkBlue,
        bottomColor: midBlue,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BackButtonRow(),
                SizedBox(height: 18),
                Center(
                  child: Text('SIGNUP',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                SizedBox(height: 28),
                for (int i = 0; i < 4; ++i) ...[
                  _InputField(controller: _controllers[i], hint: _hints[i]),
                  SizedBox(height: 14)
                ],
                SizedBox(height: 8),
                Center(
                  child: _MenuButton(
                    text: "Continue",
                    onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  _InputField({required this.controller, required this.hint, this.obscureText = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: inputBlue, borderRadius: BorderRadius.circular(28)),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: Colors.white, fontSize: 17),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white70)),
      ),
    );
  }
}

//Home Page
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: DiagonalBackground(
        topColor: darkBlue,
        bottomColor: midBlue,
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 35),
                BikeIcon(size: 50),
                SizedBox(height: 10),
                Text('CYCLE DEFENDER',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 40),
                _MenuButton(
                  text: "TRACK YOUR TRIP",
                  onPressed: () => Navigator.pushNamed(context, '/tripStart'),
                ),
                SizedBox(height: 26),
                _MenuButton(
                  text: "SETTINGS",
                  onPressed: () => Navigator.pushNamed(context, '/settings'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Start Trip Page
class StartTripPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: DiagonalBackground(
        topColor: darkBlue,
        bottomColor: midBlue,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              children: [
                SizedBox(height: 20),
                BikeIcon(),
                SizedBox(height: 8),
                Text('CYCLE DEFENDER', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(height: 24),
                Text('Your Location', style: TextStyle(color: Colors.white, fontSize: 16)),
                SizedBox(height: 10),
                MapPlaceholder(),
                SizedBox(height: 18),
                Icon(Icons.location_on, size: 70, color: Colors.orangeAccent),
                Spacer(),
                _MenuButton(
                  text: "START TRIP",
                  onPressed: () => Navigator.pushReplacementNamed(context, '/tripSafe'),
                ),
                SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Ongoing Trip: Safe
class OngoingTripSafePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: DiagonalBackground(
        topColor: darkBlue,
        bottomColor: Colors.green.shade100,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              children: [
                SizedBox(height: 30),
                Text('SAFETY STATUS',
                    style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.white, fontSize: 22)),
                SizedBox(height: 8),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 6),
                    decoration: BoxDecoration(
                        color: Colors.green, borderRadius: BorderRadius.circular(8)),
                    child: Text('Safe', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                SizedBox(height: 20),
                Text('Your Location', style: TextStyle(color: Colors.white, fontSize: 16)),
                SizedBox(height: 8),
                MapPlaceholder(),
                SizedBox(height: 16),
                Text('You are safe! Keep up this pace!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Spacer(),
                _MenuButton(
                  text: "END TRIP",
                  onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/home')),
                ),
                SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Ongoing Trip: Alert
class OngoingTripAlertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade700,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            children: [
              SizedBox(height: 30),
              Text('SAFETY STATUS',
                  style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.white, fontSize: 22)),
              SizedBox(height: 8),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 6),
                  decoration: BoxDecoration(
                      color: Colors.yellow, borderRadius: BorderRadius.circular(8)),
                  child: Text('Alert', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
              SizedBox(height: 20),
              Text('Your Location', style: TextStyle(color: Colors.white, fontSize: 16)),
              SizedBox(height: 8),
              MapPlaceholder(),
              SizedBox(height: 16),
              Text('Be careful! Difficult terrain ahead', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              Spacer(),
              _MenuButton(
                text: "END TRIP",
                onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/home')),
              ),
              SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}

//Ongoing Trip: Danger
class OngoingTripDangerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade800,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            children: [
              SizedBox(height: 30),
              Text('SAFETY STATUS',
                  style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.white, fontSize: 22)),
              SizedBox(height: 8),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 6),
                  decoration: BoxDecoration(
                      color: Colors.red, borderRadius: BorderRadius.circular(8)),
                  child: Text('Danger!!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
              SizedBox(height: 20),
              Text('Your Location', style: TextStyle(color: Colors.white, fontSize: 16)),
              SizedBox(height: 8),
              MapPlaceholder(),
              SizedBox(height: 16),
              Text('Danger!! Truck approaching!',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Spacer(),
              _MenuButton(
                text: "END TRIP",
                onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/home')),
              ),
              SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}

//Ongoing Trip: Crashed
class OngoingTripCrashedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            children: [
              SizedBox(height: 30),
              Text('SAFETY STATUS',
                  style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.white, fontSize: 22)),
              SizedBox(height: 8),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 6),
                  decoration: BoxDecoration(
                      color: Colors.black, borderRadius: BorderRadius.circular(8)),
                  child: Text('Call 999', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
              SizedBox(height: 20),
              Text('Your Location', style: TextStyle(color: Colors.white, fontSize: 16)),
              SizedBox(height: 8),
              MapPlaceholder(),
              SizedBox(height: 16),
              Text('Calling emergency contact......',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Spacer(),
              _MenuButton(
                text: "END TRIP",
                onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/home')),
              ),
              SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}

//Settings Page
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: DiagonalBackground(
        topColor: darkBlue,
        bottomColor: midBlue,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BackButtonRow(),
                SizedBox(height: 18),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: inputBlue,
                      child: Icon(Icons.person, color: Colors.white, size: 38),
                    ),
                    SizedBox(width: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tamanna', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('22, Female, O+', style: TextStyle(color: Colors.white70, fontSize: 15)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Text('Last Trip: Yesterday 3:44 PM', style: TextStyle(color: Colors.white70)),
                Text('Distance: 16Km', style: TextStyle(color: Colors.white70)),
                SizedBox(height: 35),
                _MenuButton(
                  text: "TRIP HISTORY",
                  onPressed: () {}, color: activeBlue),
                SizedBox(height: 18),
                _MenuButton(
                  text: "EMERGENCY CONTACTS",
                  onPressed: () {}, color: inputBlue),
                SizedBox(height: 18),
                _MenuButton(
                  text: "DETECTION RANGE",
                  onPressed: () {}, color: inputBlue),
                SizedBox(height: 18),
                _MenuButton(
                  text: "MORE SETTINGS",
                  onPressed: () {}, color: inputBlue),
                SizedBox(height: 18),
                _MenuButton(
                  text: "LOG OUT",
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                  },
                  color: Colors.redAccent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


//Reusable widgets
class _MenuButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  _MenuButton({required this.text, required this.onPressed, this.color});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color ?? blackButton,
      minWidth: double.infinity,
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      child: Text(text, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 1.1)),
      onPressed: onPressed,
      elevation: 4,
      highlightElevation: 2,
      splashColor: Colors.white24,
    );
  }
}
class _BackButtonRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              BikeIcon(size: 26),
              SizedBox(width: 4),
              Text('Back', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ],
          ),
        )
      ],
    );
  }
}


class MapPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 175,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.black12, width: 2),
      ),
      child: Icon(Icons.map, size: 90, color: Colors.blueGrey),
    );
  }
}
