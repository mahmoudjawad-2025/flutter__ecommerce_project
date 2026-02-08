import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF111111),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Follow Us',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _circleIcon(Icons.camera_alt),
              _circleIcon(Icons.push_pin),
              _circleIcon(Icons.email),
              _circleIcon(Icons.message),
            ],
          ),

          const SizedBox(height: 30),
          const Text('Our Product', style: _headerStyle),
          const SizedBox(height: 10),
          _footerText('All Products'),
          _footerText('Laptops'),
          _footerText('Headphones'),
          _footerText('Smartphones'),
          _footerText('PlayStation'),
          _footerText('Smartwatch'),

          const SizedBox(height: 30),
          const Text('Links', style: _headerStyle),
          const SizedBox(height: 10),
          _footerText('Terms & Conditions'),
          _footerText('Privacy Policy'),
          _footerText('Refund & Return Policy'),

          const SizedBox(height: 30),
          const Text('Site Pages', style: _headerStyle),
          const SizedBox(height: 10),
          _footerText('Homepage'),
          _footerText('About KA Store'),
          _footerText('Shop'),
          _footerText('Contact Us'),

          const SizedBox(height: 30),
          Container(height: 1, color: Colors.white24),
          const SizedBox(height: 20),

          const Text(
            'Sunday to Thursday\n09 AM — 07 PM',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),

          const SizedBox(height: 20),
          Row(
            children: [
              _circleIcon(Icons.call, size: 40),
              const SizedBox(width: 10),
              _circleIcon(Icons.near_me, size: 40),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.white),
                    SizedBox(width: 6),
                    Text('Location', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),
          const Text(
            'KA Store © 2025 | All Rights Reserved',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  static const _headerStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static Widget _footerText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white70, fontSize: 14),
      ),
    );
  }

  static Widget _circleIcon(IconData icon, {double size = 36}) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.cyanAccent, width: 1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.cyanAccent, size: size * 0.55),
    );
  }
}
