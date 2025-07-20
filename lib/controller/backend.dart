// Mantul Backend
import 'dart:async';

class Backend {
  // ========================== USER ==========================
  static final List<Map<String, String>> _users = [
    {"username": "admin", "password": "1234"},
    {"username": "user1", "password": "password"},
    {"username": "zenon", "password": "lks2025"},
    {"username": "admin", "password": "admin"},
  ];

  static Future<bool> login(String username, String password) async {
    await Future.delayed(Duration(milliseconds: 500));
    return _users.any(
      (u) => u['username'] == username && u['password'] == password,
    );
  }

  static Future<bool> register(String username, String password) async {
    await Future.delayed(Duration(milliseconds: 500));
    final exists = _users.any((u) => u['username'] == username);
    if (exists) return false;
    _users.add({"username": username, "password": password});
    return true;
  }

  static List<Map<String, String>> get users => List.unmodifiable(_users);

  // ========================== SINGLETON ==========================
  static final Backend _instance = Backend._internal();
  factory Backend() => _instance;
  Backend._internal();

  // ========================== KATEGORI PRODUK ==========================
  final List<Map<String, dynamic>> _categories = [
    {
      "id": 1,
      "nama": "Makanan & Minuman",
      "deskripsi":
          "Produk kuliner lokal seperti makanan tradisional, camilan, dan minuman khas daerah.",
    },
    {
      "id": 2,
      "nama": "Kerajinan Tangan",
      "deskripsi":
          "Produk hasil kreativitas seperti anyaman, batik, ukiran kayu, dan aksesori handmade.",
    },
    {
      "id": 3,
      "nama": "Fashion & Aksesoris",
      "deskripsi":
          "Produk pakaian, sepatu, tas, dan aksesoris berbahan lokal dengan desain unik.",
    },
    {
      "id": 4,
      "nama": "Produk Kecantikan & Kesehatan",
      "deskripsi":
          "Produk herbal, perawatan kulit alami, dan olahan kesehatan tradisional.",
    },
    {
      "id": 5,
      "nama": "Pertanian & Olahan",
      "deskripsi":
          "Hasil pertanian, perkebunan, dan produk olahan seperti kopi, madu, dan rempah-rempah.",
    },
  ];

  List<Map<String, dynamic>> get categories => List.unmodifiable(_categories);

  Map<String, dynamic>? getCategoryById(int id) {
    try {
      return _categories.firstWhere((cat) => cat['id'] == id);
    } catch (e) {
      return null;
    }
  }

  // ========================== METODE PEMBAYARAN ==========================
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      "id": 1,
      "kode": "CASH",
      "nama": "Tunai",
      "deskripsi": "Pembayaran langsung menggunakan uang tunai.",
      "status": "aktif",
    },
    {
      "id": 2,
      "kode": "TRANSFER",
      "nama": "Transfer Bank",
      "deskripsi":
          "Pembayaran melalui transfer bank manual atau virtual account.",
      "status": "aktif",
    },
    {
      "id": 3,
      "kode": "QRIS",
      "nama": "QRIS",
      "deskripsi": "Pembayaran digital menggunakan QRIS.",
      "status": "aktif",
    },
    {
      "id": 4,
      "kode": "EWALLET",
      "nama": "E-Wallet",
      "deskripsi":
          "Pembayaran melalui dompet digital seperti OVO, GoPay, Dana, dll.",
      "status": "aktif",
    },
    {
      "id": 5,
      "kode": "DEBIT",
      "nama": "Kartu Debit",
      "deskripsi": "Pembayaran menggunakan kartu debit di mesin EDC.",
      "status": "aktif",
    },
    {
      "id": 6,
      "kode": "KREDIT",
      "nama": "Kartu Kredit",
      "deskripsi": "Pembayaran menggunakan kartu kredit.",
      "status": "aktif",
    },
    {
      "id": 7,
      "kode": "TEMPO",
      "nama": "Pembayaran Tempo",
      "deskripsi": "Pembayaran ditunda sesuai kesepakatan.",
      "status": "nonaktif",
    },
  ];

  List<Map<String, dynamic>> get paymentMethods =>
      List.unmodifiable(_paymentMethods);

  Map<String, dynamic>? getPaymentMethodById(int id) {
    try {
      return _paymentMethods.firstWhere((p) => p['id'] == id);
    } catch (e) {
      return null;
    }
  }

  List<Map<String, dynamic>> getActivePaymentMethods() {
    return _paymentMethods.where((p) => p['status'] == 'aktif').toList();
  }

  // ========================== PRODUK ==========================
  final List<Map<String, dynamic>> _products = [
    {
      "id": 1,
      "nama": "Kopi Luak",
      "harga": 20000,
      "stok": 10,
      "kategoriId": 5,
      "deskripsi": "Kopi khas dari hutan Sumatera.",
      "lokasi": "Pagar Alam",
    },
    {
      "id": 2,
      "nama": "Sabun Wangi",
      "harga": 10000,
      "stok": 25,
      "kategoriId": 4,
      "deskripsi": "Sabun herbal alami.",
      "lokasi": "Bandung",
    },
    {
      "id": 3,
      "nama": "Keripik Balado",
      "harga": 15000,
      "stok": 50,
      "kategoriId": 1,
      "deskripsi": "Keripik pedas khas Padang.",
      "lokasi": "Padang",
    },
    {
      "id": 4,
      "nama": "Sambal Cumi Asin",
      "harga": 35000,
      "stok": 38,
      "kategoriId": 1,
      "deskripsi": "Sambal Cumi Asin buatan lokal dengan kualitas terbaik.",
      "lokasi": "Padang, Sumatera Barat",
    },
    {
      "id": 5,
      "nama": "Brownies Kukus Coklat",
      "harga": 40000,
      "stok": 45,
      "kategoriId": 1,
      "deskripsi": "Brownies Kukus Coklat buatan lokal dengan kualitas terbaik.",
      "lokasi": "Padang, Sumatera Barat",
    },
    {
      "id": 6,
      "nama": "Dodol Garut",
      "harga": 45000,
      "stok": 52,
      "kategoriId": 1,
      "deskripsi": "Dodol Garut buatan lokal dengan kualitas terbaik.",
      "lokasi": "Padang, Sumatera Barat",
    },
    {
      "id": 7,
      "nama": "Rendang Sapi",
      "harga": 50000,
      "stok": 59,
      "kategoriId": 1,
      "deskripsi": "Rendang Sapi buatan lokal dengan kualitas terbaik.",
      "lokasi": "Padang, Sumatera Barat",
    },
    {
      "id": 8,
      "nama": "Teh Bunga Telang",
      "harga": 55000,
      "stok": 66,
      "kategoriId": 1,
      "deskripsi": "Teh Bunga Telang buatan lokal dengan kualitas terbaik.",
      "lokasi": "Padang, Sumatera Barat",
    },
    {
      "id": 9,
      "nama": "Susu Kedelai Organik",
      "harga": 60000,
      "stok": 73,
      "kategoriId": 1,
      "deskripsi": "Susu Kedelai Organik buatan lokal dengan kualitas terbaik.",
      "lokasi": "Padang, Sumatera Barat",
    },
    {
      "id": 10,
      "nama": "Keripik Pisang Manis",
      "harga": 65000,
      "stok": 80,
      "kategoriId": 1,
      "deskripsi": "Keripik Pisang Manis buatan lokal dengan kualitas terbaik.",
      "lokasi": "Padang, Sumatera Barat",
    },
    {
      "id": 11,
      "nama": "Tas Anyaman Pandan",
      "harga": 70000,
      "stok": 87,
      "kategoriId": 2,
      "deskripsi": "Tas Anyaman Pandan buatan lokal dengan kualitas terbaik.",
      "lokasi": "Jepara, Jawa Tengah",
    },
    {
      "id": 12,
      "nama": "Kalung Manik-Manik Dayak",
      "harga": 75000,
      "stok": 94,
      "kategoriId": 2,
      "deskripsi": "Kalung Manik-Manik Dayak buatan lokal dengan kualitas terbaik.",
      "lokasi": "Jepara, Jawa Tengah",
    },
    {
      "id": 13,
      "nama": "Gantungan Kunci Kayu",
      "harga": 80000,
      "stok": 101,
      "kategoriId": 2,
      "deskripsi": "Gantungan Kunci Kayu buatan lokal dengan kualitas terbaik.",
      "lokasi": "Jepara, Jawa Tengah",
    },
    {
      "id": 14,
      "nama": "Miniatur Perahu Pinisi",
      "harga": 85000,
      "stok": 108,
      "kategoriId": 2,
      "deskripsi": "Miniatur Perahu Pinisi buatan lokal dengan kualitas terbaik.",
      "lokasi": "Jepara, Jawa Tengah",
    },
    {
      "id": 15,
      "nama": "Dompet Tenun Ikat",
      "harga": 90000,
      "stok": 115,
      "kategoriId": 2,
      "deskripsi": "Dompet Tenun Ikat buatan lokal dengan kualitas terbaik.",
      "lokasi": "Jepara, Jawa Tengah",
    },
    {
      "id": 16,
      "nama": "Lukisan Batik Tulis",
      "harga": 95000,
      "stok": 122,
      "kategoriId": 2,
      "deskripsi": "Lukisan Batik Tulis buatan lokal dengan kualitas terbaik.",
      "lokasi": "Jepara, Jawa Tengah",
    },
    {
      "id": 17,
      "nama": "Topeng Kayu Wayang",
      "harga": 100000,
      "stok": 129,
      "kategoriId": 2,
      "deskripsi": "Topeng Kayu Wayang buatan lokal dengan kualitas terbaik.",
      "lokasi": "Jepara, Jawa Tengah",
    },
    {
      "id": 18,
      "nama": "Keranjang Rotan Serbaguna",
      "harga": 105000,
      "stok": 136,
      "kategoriId": 2,
      "deskripsi": "Keranjang Rotan Serbaguna buatan lokal dengan kualitas terbaik.",
      "lokasi": "Jepara, Jawa Tengah",
    },
    {
      "id": 19,
      "nama": "Cermin Hias Mozaik",
      "harga": 110000,
      "stok": 143,
      "kategoriId": 2,
      "deskripsi": "Cermin Hias Mozaik buatan lokal dengan kualitas terbaik.",
      "lokasi": "Jepara, Jawa Tengah",
    },
    {
      "id": 20,
      "nama": "Aksesoris Kulit Handmade",
      "harga": 115000,
      "stok": 150,
      "kategoriId": 2,
      "deskripsi": "Aksesoris Kulit Handmade buatan lokal dengan kualitas terbaik.",
      "lokasi": "Jepara, Jawa Tengah",
    },
    {
      "id": 21,
      "nama": "Batik Tulis Motif Parang",
      "harga": 120000,
      "stok": 157,
      "kategoriId": 3,
      "deskripsi": "Batik Tulis Motif Parang buatan lokal dengan kualitas terbaik.",
      "lokasi": "Solo, Jawa Tengah",
    },
    {
      "id": 22,
      "nama": "Sepatu Kulit Handmade",
      "harga": 125000,
      "stok": 164,
      "kategoriId": 3,
      "deskripsi": "Sepatu Kulit Handmade buatan lokal dengan kualitas terbaik.",
      "lokasi": "Solo, Jawa Tengah",
    },
    {
      "id": 23,
      "nama": "Tas Rajut Modern",
      "harga": 130000,
      "stok": 171,
      "kategoriId": 3,
      "deskripsi": "Tas Rajut Modern buatan lokal dengan kualitas terbaik.",
      "lokasi": "Solo, Jawa Tengah",
    },
    {
      "id": 24,
      "nama": "Kaos Sablon Etnik",
      "harga": 135000,
      "stok": 178,
      "kategoriId": 3,
      "deskripsi": "Kaos Sablon Etnik buatan lokal dengan kualitas terbaik.",
      "lokasi": "Solo, Jawa Tengah",
    },
    {
      "id": 25,
      "nama": "Jaket Denim Bordir",
      "harga": 140000,
      "stok": 185,
      "kategoriId": 3,
      "deskripsi": "Jaket Denim Bordir buatan lokal dengan kualitas terbaik.",
      "lokasi": "Solo, Jawa Tengah",
    },
    {
      "id": 26,
      "nama": "Syal Tenun Songket",
      "harga": 145000,
      "stok": 192,
      "kategoriId": 3,
      "deskripsi": "Syal Tenun Songket buatan lokal dengan kualitas terbaik.",
      "lokasi": "Solo, Jawa Tengah",
    },
    {
      "id": 27,
      "nama": "Blus Batik Kontemporer",
      "harga": 150000,
      "stok": 199,
      "kategoriId": 3,
      "deskripsi": "Blus Batik Kontemporer buatan lokal dengan kualitas terbaik.",
      "lokasi": "Solo, Jawa Tengah",
    },
    {
      "id": 28,
      "nama": "Topi Anyaman Lontar",
      "harga": 155000,
      "stok": 206,
      "kategoriId": 3,
      "deskripsi": "Topi Anyaman Lontar buatan lokal dengan kualitas terbaik.",
      "lokasi": "Solo, Jawa Tengah",
    },
    {
      "id": 29,
      "nama": "Ikat Pinggang Kulit Asli",
      "harga": 160000,
      "stok": 13,
      "kategoriId": 3,
      "deskripsi": "Ikat Pinggang Kulit Asli buatan lokal dengan kualitas terbaik.",
      "lokasi": "Solo, Jawa Tengah",
    },
    {
      "id": 30,
      "nama": "Celana Kain Linen",
      "harga": 165000,
      "stok": 20,
      "kategoriId": 3,
      "deskripsi": "Celana Kain Linen buatan lokal dengan kualitas terbaik.",
      "lokasi": "Solo, Jawa Tengah",
    },
    {
      "id": 31,
      "nama": "Sabun Herbal Lidah Buaya",
      "harga": 170000,
      "stok": 27,
      "kategoriId": 4,
      "deskripsi": "Sabun Herbal Lidah Buaya buatan lokal dengan kualitas terbaik.",
      "lokasi": "Bandung, Jawa Barat",
    },
    {
      "id": 32,
      "nama": "Minyak Lulur Rempah",
      "harga": 175000,
      "stok": 34,
      "kategoriId": 4,
      "deskripsi": "Minyak Lulur Rempah buatan lokal dengan kualitas terbaik.",
      "lokasi": "Bandung, Jawa Barat",
    },
    {
      "id": 33,
      "nama": "Masker Wajah Bengkoang",
      "harga": 180000,
      "stok": 41,
      "kategoriId": 4,
      "deskripsi": "Masker Wajah Bengkoang buatan lokal dengan kualitas terbaik.",
      "lokasi": "Bandung, Jawa Barat",
    },
    {
      "id": 34,
      "nama": "Lotion Kulit Kelapa",
      "harga": 185000,
      "stok": 48,
      "kategoriId": 4,
      "deskripsi": "Lotion Kulit Kelapa buatan lokal dengan kualitas terbaik.",
      "lokasi": "Bandung, Jawa Barat",
    },
    {
      "id": 35,
      "nama": "Minyak Zaitun Alami",
      "harga": 190000,
      "stok": 55,
      "kategoriId": 4,
      "deskripsi": "Minyak Zaitun Alami buatan lokal dengan kualitas terbaik.",
      "lokasi": "Bandung, Jawa Barat",
    },
    {
      "id": 36,
      "nama": "Scrub Kopi Organik",
      "harga": 195000,
      "stok": 62,
      "kategoriId": 4,
      "deskripsi": "Scrub Kopi Organik buatan lokal dengan kualitas terbaik.",
      "lokasi": "Bandung, Jawa Barat",
    },
    {
      "id": 37,
      "nama": "Lip Balm Madu",
      "harga": 200000,
      "stok": 69,
      "kategoriId": 4,
      "deskripsi": "Lip Balm Madu buatan lokal dengan kualitas terbaik.",
      "lokasi": "Bandung, Jawa Barat",
    },
    {
      "id": 38,
      "nama": "Shampo Daun Waru",
      "harga": 205000,
      "stok": 76,
      "kategoriId": 4,
      "deskripsi": "Shampo Daun Waru buatan lokal dengan kualitas terbaik.",
      "lokasi": "Bandung, Jawa Barat",
    },
    {
      "id": 39,
      "nama": "Essential Oil Serai",
      "harga": 210000,
      "stok": 83,
      "kategoriId": 4,
      "deskripsi": "Essential Oil Serai buatan lokal dengan kualitas terbaik.",
      "lokasi": "Bandung, Jawa Barat",
    },
    {
      "id": 40,
      "nama": "Face Mist Mawar",
      "harga": 215000,
      "stok": 90,
      "kategoriId": 4,
      "deskripsi": "Face Mist Mawar buatan lokal dengan kualitas terbaik.",
      "lokasi": "Bandung, Jawa Barat",
    },
    {
      "id": 41,
      "nama": "Madu Hutan Murni 500ml",
      "harga": 220000,
      "stok": 97,
      "kategoriId": 5,
      "deskripsi": "Madu Hutan Murni 500ml buatan lokal dengan kualitas terbaik.",
      "lokasi": "Ciwidey, Jawa Barat",
    },
    {
      "id": 42,
      "nama": "Teh Hijau Organik 100gr",
      "harga": 225000,
      "stok": 104,
      "kategoriId": 5,
      "deskripsi": "Teh Hijau Organik 100gr buatan lokal dengan kualitas terbaik.",
      "lokasi": "Ciwidey, Jawa Barat",
    },
    {
      "id": 43,
      "nama": "Beras Merah Organik 5kg",
      "harga": 230000,
      "stok": 111,
      "kategoriId": 5,
      "deskripsi": "Beras Merah Organik 5kg buatan lokal dengan kualitas terbaik.",
      "lokasi": "Ciwidey, Jawa Barat",
    },
    {
      "id": 44,
      "nama": "Rempah Bubuk Lengkuas",
      "harga": 235000,
      "stok": 118,
      "kategoriId": 5,
      "deskripsi": "Rempah Bubuk Lengkuas buatan lokal dengan kualitas terbaik.",
      "lokasi": "Ciwidey, Jawa Barat",
    },
    {
      "id": 45,
      "nama": "Jahe Merah Instan",
      "harga": 240000,
      "stok": 125,
      "kategoriId": 5,
      "deskripsi": "Jahe Merah Instan buatan lokal dengan kualitas terbaik.",
      "lokasi": "Ciwidey, Jawa Barat",
    },
    {
      "id": 46,
      "nama": "Kopi Robusta Lampung",
      "harga": 245000,
      "stok": 132,
      "kategoriId": 5,
      "deskripsi": "Kopi Robusta Lampung buatan lokal dengan kualitas terbaik.",
      "lokasi": "Ciwidey, Jawa Barat",
    },
    {
      "id": 47,
      "nama": "Minyak Kelapa Murni",
      "harga": 250000,
      "stok": 139,
      "kategoriId": 5,
      "deskripsi": "Minyak Kelapa Murni buatan lokal dengan kualitas terbaik.",
      "lokasi": "Ciwidey, Jawa Barat",
    },
    {
      "id": 48,
      "nama": "Cabe Bubuk Kering",
      "harga": 255000,
      "stok": 146,
      "kategoriId": 5,
      "deskripsi": "Cabe Bubuk Kering buatan lokal dengan kualitas terbaik.",
      "lokasi": "Ciwidey, Jawa Barat",
    },
    {
      "id": 49,
      "nama": "Kacang Mete Panggang",
      "harga": 260000,
      "stok": 153,
      "kategoriId": 5,
      "deskripsi": "Kacang Mete Panggang buatan lokal dengan kualitas terbaik.",
      "lokasi": "Ciwidey, Jawa Barat",
    },
    {
      "id": 50,
      "nama": "Gula Aren Kristal",
      "harga": 265000,
      "stok": 160,
      "kategoriId": 5,
      "deskripsi": "Gula Aren Kristal buatan lokal dengan kualitas terbaik.",
      "lokasi": "Ciwidey, Jawa Barat",
    }
  ];

  List<Map<String, dynamic>> get products => List.unmodifiable(_products);

  void addProduct({
    required String nama,
    required int harga,
    required int stok,
    required int kategoriId,
    required String deskripsi,
    required String lokasi,
  }) {
    final newId = _products.isEmpty
        ? 1
        : _products.map((p) => p['id'] as int).reduce((a, b) => a > b ? a : b) +
            1;
    _products.add({
      "id": newId,
      "nama": nama,
      "harga": harga,
      "stok": stok,
      "kategoriId": kategoriId,
      "deskripsi": deskripsi,
      "lokasi": lokasi,
    });
  }

  bool deleteProduct(int id) {
    final index = _products.indexWhere((product) => product['id'] == id);
    if (index != -1) {
      _products.removeAt(index);
      return true;
    }
    return false;
  }

  bool updateProduct({
    required int id,
    required String nama,
    required int harga,
    required int stok,
    required int kategoriId,
    required String deskripsi,
    required String lokasi,
  }) {
    final index = _products.indexWhere((product) => product['id'] == id);
    if (index != -1) {
      _products[index] = {
        "id": id,
        "nama": nama,
        "harga": harga,
        "stok": stok,
        "kategoriId": kategoriId,
        "deskripsi": deskripsi,
        "lokasi": lokasi,
      };
      return true;
    }
    return false;
  }

  Map<String, dynamic>? getProductById(int id) {
    try {
      return _products.firstWhere((product) => product['id'] == id);
    } catch (e) {
      return null;
    }
  }

  // ========================== PEMASUKAN ==========================
  final List<Map<String, dynamic>> _pemasukan = [];

  List<Map<String, dynamic>> get pemasukan => List.unmodifiable(_pemasukan);

  // FIXED: Tambahkan parameter paymentMethod
  void addPemasukan(List<Map<String, dynamic>> cartItems, int total, String paymentMethod) {
    _pemasukan.add({
      'items': cartItems,
      'total': total,
      'timestamp': DateTime.now().toString(),
      'paymentMethod': paymentMethod, //Payment Methode sarimi
    });
  }
}

// ========================== STATUS PEMBAYARAN ==========================
final List<Map<String, dynamic>> _paymentStatuses = [
  {
    "id": 1,
    "kode": "PENDING",
    "nama": "Menunggu Pembayaran",
    "deskripsi": "Transaksi sudah dibuat tapi belum dibayar.",
    "warna": "#FFA500",
    "status": "aktif",
  },
  {
    "id": 2,
    "kode": "PAID",
    "nama": "Lunas",
    "deskripsi": "Pembayaran sudah diterima.",
    "warna": "#28A745",
    "status": "aktif",
  },
  {
    "id": 3,
    "kode": "PARTIAL",
    "nama": "Pembayaran Sebagian",
    "deskripsi": "Pembayaran sebagian, masih ada sisa tagihan.",
    "warna": "#17A2B8",
    "status": "aktif",
  },
  {
    "id": 4,
    "kode": "FAILED",
    "nama": "Gagal",
    "deskripsi": "Pembayaran gagal diproses.",
    "warna": "#DC3545",
    "status": "aktif",
  },
  {
    "id": 5,
    "kode": "REFUNDED",
    "nama": "Dikembalikan",
    "deskripsi": "Pembayaran sudah dikembalikan ke pelanggan.",
    "warna": "#6C757D",
    "status": "aktif",
  },
  {
    "id": 6,
    "kode": "CANCELLED",
    "nama": "Dibatalkan",
    "deskripsi": "Transaksi dibatalkan sebelum pembayaran.",
    "warna": "#343A40",
    "status": "aktif",
  },
];

List<Map<String, dynamic>> get paymentStatuses =>
    List.unmodifiable(_paymentStatuses);

Map<String, dynamic>? getPaymentStatusById(int id) {
  try {
    return _paymentStatuses.firstWhere((status) => status['id'] == id);
  } catch (e) {
    return null;
  }
}

List<Map<String, dynamic>> getActivePaymentStatuses() {
  return _paymentStatuses
      .where((status) => status['status'] == 'aktif')
      .toList();
}