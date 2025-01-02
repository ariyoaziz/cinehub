import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Make sure to add intl package to pubspec.yaml

class SeatSelectionPage extends StatefulWidget {
  const SeatSelectionPage({Key? key}) : super(key: key);

  @override
  _SeatSelectionPageState createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  DateTime selectedDate = DateTime(2025, 1, 2);
  TimeOfDay selectedTime = const TimeOfDay(hour: 13, minute: 0);
  List<bool> selectedSeats = List.generate(40, (index) => false);
  int maxSelectableSeats = 6;
  String? selectedMovie;
  double ticketPrice = 50000;

  // Predefined seats
  final List<int> occupiedSeats = List.generate(16, (index) => 24 + index);
  final List<String> movies = [
    'Avatar: The Way of Water',
    'Black Panther: Wakanda Forever',
    'Top Gun: Maverick',
    'Jurassic World: Dominion',
  ];

  @override
  void initState() {
    super.initState();
    selectedMovie = movies[0];
  }

  int get selectedSeatCount =>
      selectedSeats.where((isSelected) => isSelected).length;

  double get totalPrice => selectedSeatCount * ticketPrice;

  String getSeatLabel(int index) {
    int row = (index ~/ 8) + 1;
    int seatNum = (index % 8) + 1;
    return '${String.fromCharCode(64 + row)}$seatNum';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMovieSelection(),
                const SizedBox(height: 20),
                _buildDateTimeSection(),
                const SizedBox(height: 30),
                _buildScreenIndicator(),
                const SizedBox(height: 30),
                _buildSeatGrid(),
                const SizedBox(height: 20),
                _buildLegend(),
                const SizedBox(height: 16),
                _buildPriceInfo(),
                const SizedBox(height: 16),
                _buildCheckoutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Pilih Kursi',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline, color: Colors.black),
          onPressed: () => _showInfoDialog(),
        ),
      ],
    );
  }

  Widget _buildMovieSelection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedMovie,
          items: movies.map((String movie) {
            return DropdownMenuItem<String>(
              value: movie,
              child: Text(movie),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedMovie = newValue;
            });
          },
        ),
      ),
    );
  }

  Widget _buildDateTimeSection() {
    return Row(
      children: [
        Expanded(
          child: _buildDatePicker(),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildTimePicker(),
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(2025, 12, 31),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF1B3D6E),
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          setState(() => selectedDate = picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, size: 20),
            const SizedBox(width: 8),
            Text(
              DateFormat('dd MMM yyyy').format(selectedDate),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return GestureDetector(
      onTap: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: selectedTime,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF1B3D6E),
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          setState(() => selectedTime = picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.access_time, size: 20),
            const SizedBox(width: 8),
            Text(
              selectedTime.format(context),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreenIndicator() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.withOpacity(0.3),
                Colors.blue.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: const Text(
            'LAYAR BIOSKOP',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B3D6E),
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 100,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.3),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildSeatGrid() {
    return Center(
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: List.generate(40, (index) {
          bool isOccupied = occupiedSeats.contains(index);
          bool isSelected = selectedSeats[index];

          return GestureDetector(
            onTap: isOccupied
                ? () => _showOccupiedMessage()
                : () => _handleSeatSelection(index),
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: isOccupied
                    ? Colors.red.withOpacity(0.7)
                    : isSelected
                        ? const Color(0xFF1B3D6E)
                        : Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  getSeatLabel(index),
                  style: TextStyle(
                    color: isOccupied || isSelected
                        ? Colors.white
                        : Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem('Tersedia', Colors.white),
        const SizedBox(width: 20),
        _buildLegendItem('Dipilih', const Color(0xFF1B3D6E)),
        const SizedBox(width: 20),
        _buildLegendItem('Terisi', Colors.red.withOpacity(0.7)),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildPriceInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Harga',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp ',
                  decimalDigits: 0,
                ).format(totalPrice),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B3D6E),
                ),
              ),
            ],
          ),
          Text(
            '$selectedSeatCount/${maxSelectableSeats} kursi',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: selectedSeatCount > 0 ? _handleCheckout : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1B3D6E),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Text(
          'Selesaikan Pesanan (${selectedSeatCount} Kursi)',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _handleSeatSelection(int index) {
    if (!selectedSeats[index] && selectedSeatCount >= maxSelectableSeats) {
      _showMaxSeatsDialog();
      return;
    }
    setState(() {
      selectedSeats[index] = !selectedSeats[index];
    });
  }

  void _showMaxSeatsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Batas Maksimum'),
        content: Text(
            'Maksimum pembelian adalah $maxSelectableSeats tiket dalam satu transaksi'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showOccupiedMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Kursi ini sudah terisi'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _handleCheckout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Pesanan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Film: $selectedMovie'),
            const SizedBox(height: 8),
            Text('Tanggal: ${DateFormat('dd MMM yyyy').format(selectedDate)}'),
            const SizedBox(height: 8),
            Text('Jam: ${selectedTime.format(context)}'),
            const SizedBox(height: 8),
            Text(
                'Kursi: ${selectedSeats.asMap().entries.where((entry) => entry.value).map((entry) => getSeatLabel(entry.key)).join(', ')}'),
            const SizedBox(height: 8),
            Text(
                'Total Harga: ${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(totalPrice)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pesanan berhasil diselesaikan!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B3D6E),
            ),
            child: const Text('Konfirmasi',style: TextStyle(color:Color(0xffffffff))),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Informasi'),
        content: const Text(
            'Pilih kursi yang tersedia, pilih waktu dan tanggal untuk menyelesaikan pemesanan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}
