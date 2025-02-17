import 'package:flutter/material.dart';
import 'package:cinehub_tiketbioskop/themes/colors.dart';
import 'package:cinehub_tiketbioskop/screen/auth/login.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double imageHeight = size.height * 0.3;

    return Scaffold(
      backgroundColor: AppColors.screen,
      body: SafeArea(
        child: SingleChildScrollView(
          // Membuat tampilan bisa digulir
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                // Text Welcome
                const Text(
                  "Selamat Datang",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGrey,
                  ),
                ),
                const SizedBox(height: 8),

                // App Name
                const Text(
                  "CineHub",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.orange,
                  ),
                ),
                const SizedBox(height: 16),

                // Image
                Image.asset(
                  'assets/images/get_str.png',
                  height: imageHeight,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16),

                // Description
                const Text(
                  "Pesan Tiket Bioskop Jadi Lebih Mudah dan Cepat.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.darkGrey,
                  ),
                ),

                const SizedBox(height: 50), // Adjust spacing for better layout

                // Login Button
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: AppColors.putih,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Lewati Button
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: OutlinedButton(
                    onPressed: () {
                      // Navigasi ke regis
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      "Daftar Sekarang",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // Privacy Policy
                const Text(
                  "By continuing, you agree to our Privacy Policy and Terms & Conditions.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.darkGrey,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
