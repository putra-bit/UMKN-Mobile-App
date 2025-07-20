import 'package:flutter/material.dart';
import 'package:umkn_smk/controller/backend.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:umkn_smk/controller/provider_thame.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> with TickerProviderStateMixin {
  int selectedIndex = 0;
  late TabController _tabController;

  // Controllers for forms
  final _productFormKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productStokController = TextEditingController();
  final _productDeskripsiController = TextEditingController();
  final _productLokasiController = TextEditingController();
  int _selectedCategoryId = 1; // Default ke ID pertama

  // Search and filter
  String _searchQuery = '';
  int _filterCategoryId = 0; // 0 untuk "Semua"

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);

    // Debug: Print current data status
    _debugPrintDataStatus();

    // Delay sync to ensure widget is fully built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncDataToLocal();
    });
  }

  // Debug function to check data status
  void _debugPrintDataStatus() {
    print('=== DEBUG DATA STATUS ===');
    print('Products count: ${Backend().products.length}');
    print('Products: ${Backend().products}');
    print('Categories count: ${Backend().categories.length}');
    print('Categories: ${Backend().categories}');
    print('Payment Methods count: ${Backend().paymentMethods.length}');
    print('Pemasukan count: ${Backend().pemasukan.length}');
    print('Pemasukan: ${Backend().pemasukan}');
    print('========================');
  }

  @override
  void dispose() {
    _tabController.dispose();
    _productNameController.dispose();
    _productPriceController.dispose();
    _productStokController.dispose();
    _productDeskripsiController.dispose();
    _productLokasiController.dispose();
    super.dispose();
  }

  // ====================== SINKRONISASI DATA (Aspek: 5 poin) ======================
  Future<void> _syncDataToLocal() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/umkm_data.json');

      // Ensure Backend data is properly initialized
      final backend = Backend();

      // Debug: Check if backend instance has data
      print('Syncing - Products: ${backend.products.length}');
      print('Syncing - Transactions: ${backend.pemasukan.length}');

      final data = {
        'products': backend.products,
        'categories': backend.categories,
        'payment_methods': backend.paymentMethods,
        'transactions': backend.pemasukan,
        'users': Backend.users,
        'lastSync': DateTime.now().toIso8601String(),
      };

      await file.writeAsString(jsonEncode(data));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Data berhasil disinkronisasi ke local database\nProducts: ${backend.products.length}, Transactions: ${backend.pemasukan.length}',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('Error syncing data: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal sinkronisasi data'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // ====================== CRUD MASTER DATA (Aspek: 12 poin) ======================
  void _showAddProductDialog() {
    // Reset form
    _productNameController.clear();
    _productPriceController.clear();
    _productStokController.clear();
    _productDeskripsiController.clear();
    _productLokasiController.clear();
    _selectedCategoryId = Backend().categories.first['id'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Tambah Produk Baru'),
              content: SingleChildScrollView(
                child: Form(
                  key: _productFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _productNameController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Produk',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama produk tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _productPriceController,
                        decoration: const InputDecoration(
                          labelText: 'Harga',
                          border: OutlineInputBorder(),
                          prefixText: 'Rp ',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Harga tidak boleh kosong';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Harga harus berupa angka';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _productStokController,
                        decoration: const InputDecoration(
                          labelText: 'Stok',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Stok tidak boleh kosong';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Stok harus berupa angka';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<int>(
                        value: _selectedCategoryId,
                        decoration: const InputDecoration(
                          labelText: 'Kategori',
                          border: OutlineInputBorder(),
                        ),
                        items: Backend().categories.map((category) {
                          return DropdownMenuItem<int>(
                            value: category['id'],
                            child: Text(category['nama']),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          setDialogState(() {
                            _selectedCategoryId = newValue!;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _productDeskripsiController,
                        decoration: const InputDecoration(
                          labelText: 'Deskripsi',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Deskripsi tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _productLokasiController,
                        decoration: const InputDecoration(
                          labelText: 'Lokasi',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lokasi tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_productFormKey.currentState!.validate()) {
                      _addProduct();
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Tambah'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _addProduct() {
    // Menggunakan parameter sesuai Backend.dart
    Backend().addProduct(
      nama: _productNameController.text,
      harga: int.parse(_productPriceController.text),
      stok: int.parse(_productStokController.text),
      kategoriId: _selectedCategoryId,
      deskripsi: _productDeskripsiController.text,
      lokasi: _productLokasiController.text,
    );

    // Clear controllers
    _productNameController.clear();
    _productPriceController.clear();
    _productStokController.clear();
    _productDeskripsiController.clear();
    _productLokasiController.clear();

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Produk berhasil ditambahkan')),
    );
  }

  void _deleteProduct(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: const Text('Apakah Anda yakin ingin menghapus produk ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                bool success = Backend().deleteProduct(id);
                setState(() {});
                Navigator.of(context).pop();

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Produk berhasil dihapus')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Gagal menghapus produk'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _showEditProductDialog(Map<String, dynamic> product) {
    // Set data produk ke form
    _productNameController.text = product['nama'];
    _productPriceController.text = product['harga'].toString();
    _productStokController.text = product['stok'].toString();
    _productDeskripsiController.text = product['deskripsi'];
    _productLokasiController.text = product['lokasi'];
    _selectedCategoryId = product['kategoriId'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Edit Produk'),
              content: SingleChildScrollView(
                child: Form(
                  key: _productFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _productNameController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Produk',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama produk tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _productPriceController,
                        decoration: const InputDecoration(
                          labelText: 'Harga',
                          border: OutlineInputBorder(),
                          prefixText: 'Rp ',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Harga tidak boleh kosong';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Harga harus berupa angka';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _productStokController,
                        decoration: const InputDecoration(
                          labelText: 'Stok',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Stok tidak boleh kosong';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Stok harus berupa angka';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<int>(
                        value: _selectedCategoryId,
                        decoration: const InputDecoration(
                          labelText: 'Kategori',
                          border: OutlineInputBorder(),
                        ),
                        items: Backend().categories.map((category) {
                          return DropdownMenuItem<int>(
                            value: category['id'],
                            child: Text(category['nama']),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          setDialogState(() {
                            _selectedCategoryId = newValue!;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _productDeskripsiController,
                        decoration: const InputDecoration(
                          labelText: 'Deskripsi',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Deskripsi tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _productLokasiController,
                        decoration: const InputDecoration(
                          labelText: 'Lokasi',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lokasi tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_productFormKey.currentState!.validate()) {
                      _editProduct(product['id']);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Update'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _editProduct(int id) {
    bool success = Backend().updateProduct(
      id: id,
      nama: _productNameController.text,
      harga: int.parse(_productPriceController.text),
      stok: int.parse(_productStokController.text),
      kategoriId: _selectedCategoryId,
      deskripsi: _productDeskripsiController.text,
      lokasi: _productLokasiController.text,
    );

    // Clear controllers
    _productNameController.clear();
    _productPriceController.clear();
    _productStokController.clear();
    _productDeskripsiController.clear();
    _productLokasiController.clear();

    setState(() {});

    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Produk berhasil diupdate')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal mengupdate produk'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ====================== SEARCHING & FILTERING (Aspek: 6 poin) ======================
  List<Map<String, dynamic>> _getFilteredProducts() {
    var products = Backend().products;

    // Filter by category
    if (_filterCategoryId != 0) {
      products = products
          .where((p) => p['kategoriId'] == _filterCategoryId)
          .toList();
    }

    // Search by name
    if (_searchQuery.isNotEmpty) {
      products = products
          .where(
            (p) => p['nama'].toString().toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ),
          )
          .toList();
    }

    return products;
  }

  // Fungsi untuk mendapatkan nama kategori berdasarkan ID
  String _getCategoryName(int categoryId) {
    final category = Backend().getCategoryById(categoryId);
    return category?['nama'] ?? 'Tidak diketahui';
  }

  // ====================== EXPORT DATA ======================
  void _showExportOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.picture_as_pdf),
            title: const Text("Ekspor ke PDF"),
            onTap: () {
              Navigator.pop(context);
              exportToPdf();
            },
          ),
          ListTile(
            leading: const Icon(Icons.grid_on),
            title: const Text("Ekspor ke Excel"),
            onTap: () {
              Navigator.pop(context);
              exportToExcel();
            },
          ),
          ListTile(
            leading: const Icon(Icons.data_object),
            title: const Text("Ekspor ke JSON"),
            onTap: () {
              Navigator.pop(context);
              exportToJson();
            },
          ),
        ],
      ),
    );
  }

  Future<void> exportToExcel() async {
    try {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory == null) return;

      final excel = Excel.createExcel();
      final Sheet sheet = excel['Laporan'];

      // Header - gunakan TextCellValue untuk string
      sheet.appendRow([
        TextCellValue('No'),
        TextCellValue('Tanggal'),
        TextCellValue('Items'),
        TextCellValue('Total'),
      ]);

      // Data transaksi
      for (int i = 0; i < Backend().pemasukan.length; i++) {
        final transaksi = Backend().pemasukan[i];
        final items = transaksi['items'] as List<Map<String, dynamic>>;
        final itemNames = items
            .map((item) => '${item['nama']} (${item['quantity']}x)')
            .join(', ');

        sheet.appendRow([
          IntCellValue(i + 1),
          TextCellValue(transaksi['timestamp']),
          TextCellValue(itemNames),
          IntCellValue(transaksi['total']),
        ]);
      }

      final fileBytes = excel.encode();
      final file = File(
        '$selectedDirectory/laporan_umkm_${DateTime.now().millisecondsSinceEpoch}.xlsx',
      );
      await file.writeAsBytes(fileBytes!);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Berhasil ekspor ke Excel: ${file.path}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal ekspor ke Excel'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> exportToPdf() async {
    try {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory == null) return;

      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Laporan Penjualan UMKM',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text('Tanggal: ${DateTime.now().toString().split(' ')[0]}'),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: ['No', 'Tanggal', 'Items', 'Total'],
                data: List.generate(Backend().pemasukan.length, (i) {
                  final t = Backend().pemasukan[i];
                  final items = t['items'] as List<Map<String, dynamic>>;
                  final itemNames = items
                      .map((item) => '${item['nama']} (${item['quantity']}x)')
                      .join(', ');
                  return [
                    (i + 1).toString(),
                    t['timestamp'].toString(),
                    itemNames,
                    'Rp ${t['total']}',
                  ];
                }),
              ),
            ],
          ),
        ),
      );

      final file = File(
        '$selectedDirectory/laporan_umkm_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
      await file.writeAsBytes(await pdf.save());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Berhasil ekspor ke PDF: ${file.path}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal ekspor ke PDF'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> exportToJson() async {
    try {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory == null) return;

      final file = File(
        '$selectedDirectory/umkm_export_${DateTime.now().millisecondsSinceEpoch}.json',
      );

      final exportData = {
        'exported_at': DateTime.now().toIso8601String(),
        'products': Backend().products,
        'categories': Backend().categories,
        'payment_methods': Backend().paymentMethods,
        'transactions': Backend().pemasukan,
        'total_transactions': Backend().pemasukan.length,
        'total_revenue': Backend().pemasukan.fold<int>(
          0,
          (sum, t) => sum + (t['total'] as int),
        ),
      };

      await file.writeAsString(jsonEncode(exportData));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data berhasil diekspor ke: ${file.path}'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal mengekspor data'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // ====================== LAPORAN PERIODE ======================
  Map<String, dynamic> _generatePeriodReport() {
    final transactions = Backend().pemasukan;
    final now = DateTime.now();
    final thisMonth = transactions.where((t) {
      final transDate = DateTime.parse(t['timestamp']);
      return transDate.month == now.month && transDate.year == now.year;
    }).toList();

    final totalRevenue = thisMonth.fold<int>(
      0,
      (sum, t) => sum + (t['total'] as int),
    );
    final totalTransactions = thisMonth.length;

    return {
      'period': 'Bulan ${now.month}/${now.year}',
      'total_revenue': totalRevenue,
      'total_transactions': totalTransactions,
      'average_transaction': totalTransactions > 0
          ? (totalRevenue / totalTransactions).toDouble()
          : 0.0,
    };
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ProviderTheme>(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: _syncDataToLocal,
            tooltip: 'Sinkronisasi Data',
          ),
          IconButton(
            icon:  Icon(Icons.download),
            onPressed: _showExportOptions,
            tooltip: 'Export Data',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Konfirmasi Logout'),
                  content: const Text('Apakah Anda yakin ingin keluar?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Batal'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, '/LoginPage');
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[400],
          tabs: const [
            Tab(icon: Icon(Icons.dashboard), text: 'Dashboard'),
            Tab(icon: Icon(Icons.inventory), text: 'Produk'),
            Tab(icon: Icon(Icons.receipt_long), text: 'Transaksi'),
            Tab(icon: Icon(Icons.analytics), text: 'Laporan'),
            Tab(icon: Icon(Icons.settings), text: 'Pengaturan'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(),
          _buildProductsTab(),
          _buildTransactionsTab(),
          _buildReportsTab(),
          _buildSettingsTab(),
        ],
      ),
    );
  }

  // ====================== DASHBOARD TAB ======================
  Widget _buildDashboardTab() {
    final report = _generatePeriodReport();

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ringkasan Bisnis',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Responsive grid using Wrap
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _buildStatCard(
                      'Total Produk',
                      '${Backend().products.length}',
                      Icons.inventory,
                      Colors.blue,
                      width: (constraints.maxWidth / 2) - 24,
                    ),
                    _buildStatCard(
                      'Transaksi Bulan Ini',
                      '${report['total_transactions']}',
                      Icons.receipt,
                      Colors.green,
                      width: (constraints.maxWidth / 2) - 24,
                    ),
                    _buildStatCard(
                      'Pendapatan Bulan Ini',
                      'Rp ${report['total_revenue']}',
                      Icons.monetization_on,
                      Colors.orange,
                      width: (constraints.maxWidth / 2) - 24,
                    ),
                    _buildStatCard(
                      'Rata-rata Transaksi',
                      'Rp ${(report['average_transaction'] as double).round()}',
                      Icons.trending_up,
                      Colors.purple,
                      width: (constraints.maxWidth / 2) - 24,
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                const Text(
                  'Aktivitas Terbaru',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Fixed-height container for scrollable list
                SizedBox(height: 300, child: _buildRecentActivity()),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color, {
    double? width,
  }) {
    return Container(
      width: width ?? 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    final recentTransactions = Backend().pemasukan.take(10).toList();

    if (recentTransactions.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(child: Text('Belum ada aktivitas terbaru')),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: recentTransactions.length,
        itemBuilder: (context, index) {
          final transaction = recentTransactions[index];
          final items = transaction['items'] as List<Map<String, dynamic>>;
          final itemNames = items.map((item) => item['nama']).join(', ');

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green.withOpacity(0.1),
              child: const Icon(Icons.shopping_cart, color: Colors.green),
            ),
            title: Text(
              'Rp ${transaction['total']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '$itemNames\n${transaction['timestamp']}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          );
        },
      ),
    );
  }

  // ====================== PRODUCTS TAB ======================
  Widget _buildProductsTab() {
    return Column(
      children: [
        // Search and Filter Bar
        SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari produk...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        isExpanded: true,
                        value: _filterCategoryId,
                        decoration: const InputDecoration(
                          labelText: 'Filter Kategori',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        items: [
                          const DropdownMenuItem<int>(
                            value: 0,
                            child: Text('Semua Kategori'),
                          ),
                          ...Backend().categories.map((category) {
                            return DropdownMenuItem<int>(
                              value: category['id'],
                              child: Text(category['nama']),
                            );
                          }).toList(),
                        ],
                        onChanged: (int? newValue) {
                          setState(() {
                            _filterCategoryId = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: _showAddProductDialog,
                      icon: const Icon(Icons.add),
                      label: const Text('Tambah'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Products List
        Expanded(
          child: Container(
            color: Colors.grey[100],
            child: _buildProductsList(),
          ),
        ),
      ],
    );
  }

  Widget _buildProductsList() {
    final filteredProducts = _getFilteredProducts();

    if (filteredProducts.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Tidak ada produk ditemukan',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.withOpacity(0.1),
              child: Text(
                product['nama'][0].toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            title: Text(
              product['nama'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kategori: ${_getCategoryName(product['kategoriId'])}'),
                Text('Harga: Rp ${product['harga']}'),
                Text('Stok: ${product['stok']}'),
                Text('Lokasi: ${product['lokasi']}'),
              ],
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  _showEditProductDialog(product);
                } else if (value == 'delete') {
                  _deleteProduct(product['id']);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, color: Colors.blue),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Hapus'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ====================== TRANSACTIONS TAB ======================
  Widget _buildTransactionsTab() {
    final transactions = Backend().pemasukan;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Transaksi: ${transactions.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Total: Rp ${transactions.fold<int>(0, (sum, t) => sum + (t['total'] as int? ?? 0))}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: transactions.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.receipt_long, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Belum ada transaksi',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    final items =
                        transaction['items'] as List<Map<String, dynamic>>? ??
                        [];
                    final total = transaction['total'] as int? ?? 0;
                    final timestamp =
                        transaction['timestamp']?.toString() ??
                        'Tanggal tidak tersedia';
                    final paymentMethod =
                        transaction['paymentMethod']?.toString() ??
                        'Tidak diketahui';

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ExpansionTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green.withOpacity(0.1),
                          child: const Icon(Icons.receipt, color: Colors.green),
                        ),
                        title: Text(
                          'Rp $total',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('$timestamp\n${items.length} item(s)'),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Detail Pembelian:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),

                                // Safe iteration untuk items
                                if (items.isNotEmpty)
                                  ...items.map((item) {
                                    final itemName =
                                        item['nama']?.toString() ??
                                        'Produk tidak diketahui';
                                    final itemQuantity =
                                        item['quantity'] as int? ?? 0;
                                    final itemPrice =
                                        item['harga'] as int? ?? 0;
                                    final itemTotal = itemPrice * itemQuantity;

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '$itemName x$itemQuantity',
                                            ),
                                          ),
                                          Text('Rp $itemTotal'),
                                        ],
                                      ),
                                    );
                                  }).toList()
                                else
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 2),
                                    child: Text('Tidak ada item'),
                                  ),

                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Metode Pembayaran:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(paymentMethod),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // ====================== REPORTS TAB ======================
  Widget _buildReportsTab() {
    final report = _generatePeriodReport();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Laporan Penjualan',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Periode: ${report['period']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildReportItem(
                    'Total Transaksi',
                    '${report['total_transactions']}',
                  ),
                  _buildReportItem(
                    'Total Pendapatan',
                    'Rp ${report['total_revenue']}',
                  ),
                  _buildReportItem(
                    'Rata-rata per Transaksi',
                    'Rp ${(report['average_transaction'] as double).round()}',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Produk Terlaris',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ..._getTopSellingProducts()
                      .map(
                        (product) => _buildReportItem(
                          product['nama'],
                          '${product['sold']} terjual',
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _showExportOptions,
                  icon: const Icon(Icons.download),
                  label: const Text('Export Laporan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getTopSellingProducts() {
    final Map<String, int> productSales = {};

    for (final transaction in Backend().pemasukan) {
      final items = transaction['items'] as List<Map<String, dynamic>>;
      for (final item in items) {
        final productName = item['nama'] as String;
        final quantity = item['quantity'] as int;
        productSales[productName] = (productSales[productName] ?? 0) + quantity;
      }
    }

    final sortedProducts = productSales.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedProducts
        .take(5)
        .map((entry) => {'nama': entry.key, 'sold': entry.value})
        .toList();
  }

  // ====================== SETTINGS TAB ======================
  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pengaturan Aplikasi',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.sync),
                  title: const Text('Sinkronisasi Data'),
                  subtitle: const Text('Backup data ke penyimpanan lokal'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: _syncDataToLocal,
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.download),
                  title: const Text('Export Data'),
                  subtitle: const Text('Export data ke berbagai format'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: _showExportOptions,
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('Informasi Aplikasi'),
                  subtitle: const Text('Versi dan informasi pengembang'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => _showAppInfo(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.storage),
                  title: const Text('Status Penyimpanan'),
                  subtitle: Text(
                    'Produk: ${Backend().products.length} | '
                    'Transaksi: ${Backend().pemasukan.length}',
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.category),
                  title: const Text('Kategori Tersedia'),
                  subtitle: Text('${Backend().categories.length} kategori'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.payment),
                  title: const Text('Metode Pembayaran'),
                  subtitle: Text('${Backend().paymentMethods.length} metode'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Konfirmasi Logout'),
                        content: const Text(
                          'Apakah Anda yakin ingin keluar dari aplikasi?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushReplacementNamed(
                                context,
                                '/LoginPage',
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAppInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Informasi Aplikasi'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'UMKM Management System',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Versi: 1.0.0'),
              Text('Build: 2025.001'),
              SizedBox(height: 16),
              Text(
                'Fitur yang tersedia:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('• Manajemen produk (CRUD)'),
              Text('• Pencarian dan filter produk'),
              Text('• Tracking transaksi penjualan'),
              Text('• Laporan penjualan periode'),
              Text('• Export data (PDF, Excel, JSON)'),
              Text('• Sinkronisasi data lokal'),
              SizedBox(height: 16),
              Text(
                'Dikembangkan untuk membantu UMKM dalam mengelola bisnis dengan lebih efisien.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 16,),
              Text("Build By Putra Abdul Azis (PxZenon)")
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}
