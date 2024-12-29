import 'package:flutter/material.dart';

class MovieDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Detail Film',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  'https://miro.medium.com/v2/resize:fit:1400/1*0FKhwNV-o-OEiuFqSz_tSQ.jpeg', // Ganti dengan URL gambar Spider-Man
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: 200,
                ),
                Positioned(
                  top: 80,
                  left: MediaQuery.of(context).size.width / 2 - 30,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(
                      Icons.play_arrow,
                      size: 40,
                      color: Colors.blue,
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
                    'Spider Man',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Director : Sam Raimi',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      _buildTag(
                        'Action',
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      _buildTag(
                        'Adventure',
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      _buildTag(
                        'Superhero',
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.star, color: Colors.yellow, size: 20),
                      Text(
                        ' 9.5',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Sinopsis',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Peter Parker (Tobey Maguire) adalah seorang remaja canggung yang hidup di New York City bersama bibinya, May, dan pamannya, Ben. Setelah digigit oleh laba-laba yang terkontaminasi.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Pemain Utama (Pemeran)',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  _buildActorsList(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            //menavigasi halaman selanjutnya
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => halamankedua()),
            // );
            // Tambahkan fungsi pemesanan
          },
          child: Text(
            'Pesan Sekarang',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
            backgroundColor: const Color.fromARGB(255, 35, 59, 96),
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String label, {Color color = Colors.black}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.yellow[700],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style:
            TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildActorsList() {
    // Contoh daftar aktor
    final actors = [
      'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTeQ4_0Niq2OaVg6Vbu73DWxWFyxsVepGZ3fC3uhJp8VxGJUsvxuXNLDqb_xsTmEFWKg530vaiXREQNyIoKoHLPOg',
      'https://upload.wikimedia.org/wikipedia/commons/e/e4/Tobey_Maguire_2007_Shankbone.jpg',
      'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcScFG5Q1nOqYDjEqJ8u5FzX9oSv1epYkSnqXI36sHJetDkdL6YGteTBkLpArey5MghKWTw57YeQiDIIra_EiFLEzw',
      'https://m.media-amazon.com/images/M/MV5BMjExMzc5NDM0Nl5BMl5BanBnXkFtZTcwOTU3MDU3OA@@._V1_FMjpg_UX1000_.jpg',
      'https://upload.wikimedia.org/wikipedia/commons/0/0c/Drake_Bell_2019_by_Glenn_Francis_%28cropped%29.jpg',
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: actors.map((actor) {
        return CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(actor),
        );
      }).toList(),
    );
  }
}
