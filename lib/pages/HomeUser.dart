import 'package:flutter/material.dart';
import 'package:umkn_smk/controller/backend.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  List<Map<String, dynamic>> cart = [];
  bool isLoading = false;

  void addToCart(Map<String, dynamic> product) {
    // Null safety check
    if (product == null || product['id'] == null) return;

    final index = cart.indexWhere(
      (item) => item != null && item['id'] == product['id'],
    );
    setState(() {
      if (index != -1) {
        cart[index]['quantity'] = (cart[index]['quantity'] ?? 0) + 1;
      } else {
        cart.add({...product, 'quantity': 1});
      }
    });

    // Show snackbar confirmation - FIXED: using 'nama' instead of 'nama'
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${product['nama'] ?? 'Produk'} ditambahkan ke keranjang',
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.green,
      ),
    );
  }

  void decreaseFromCart(int productId) {
    final index = cart.indexWhere(
      (item) => item != null && item['id'] == productId,
    );
    setState(() {
      if (index != -1) {
        final currentQuantity = cart[index]['quantity'] ?? 0;
        if (currentQuantity > 1) {
          cart[index]['quantity'] = currentQuantity - 1;
        } else {
          cart.removeAt(index);
        }
      }
    });
  }

  void removeFromCart(int productId) {
    setState(() {
      cart.removeWhere((item) => item != null && item['id'] == productId);
    });
  }

  int getTotal() {
    return cart.fold<int>(0, (sum, item) {
      if (item == null) return sum;
      final price =
          item['harga'] as int? ?? 0; // FIXED: using 'harga' instead of 'harga'
      final quantity = item['quantity'] as int? ?? 0;
      return sum + (price * quantity);
    });
  }

  int getTotalItems() {
    return cart.fold<int>(0, (sum, item) {
      if (item == null) return sum;
      return sum + (item['quantity'] as int? ?? 0);
    });
  }

  void checkout() {
    if (cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Keranjang kosong!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      Backend().addPemasukan(cart, getTotal(), DateTime.now().toString());

      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 28),
                SizedBox(width: 10),
                Text("Pembayaran Berhasil"),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Terima kasih telah membeli produk kami."),
                const SizedBox(height: 10),
                Text(
                  "Total: Rp${getTotal()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    cart.clear();
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal melakukan pembayaran: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Konfirmasi Logout"),
        content: const Text("Apakah Anda yakin ingin keluar?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/LoginPage');
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Null safety check untuk products
    final productsFromBackend = Backend().products;
    final products = productsFromBackend ?? <Map<String, dynamic>>[];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
        title: const Text(
          "UMKM Store",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (_) => buildCartSheet(),
                  );
                },
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${getTotalItems()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: showLogoutConfirmation,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey[800]!, Colors.grey[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Text(
              "Produk UMKM Terbaik",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: products.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Belum ada produk tersedia",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.8,
                        ),
                    itemBuilder: (context, index) {
                      final product = products[index];

                      // Null safety check untuk product
                      if (product == null) {
                        return const SizedBox.shrink();
                      }

                      final isInCart = cart.any(
                        (item) => item != null && item['id'] == product['id'],
                      );

                      // FIXED: Safe access dengan field names yang benar
                      final productName =
                          product['nama']?.toString() ?? 'Produk';
                      final productPrice = product['harga'] ?? 0;
                      final firstLetter = productName.isNotEmpty
                          ? productName[0].toUpperCase()
                          : 'P';

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () => addToCart(product),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.grey[700]!,
                                          Colors.grey[500]!,
                                        ],
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        firstLetter,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    productName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Rp ${productPrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      onPressed: () => addToCart(product),
                                      icon: Icon(
                                        isInCart
                                            ? Icons.add_shopping_cart
                                            : Icons.shopping_cart_outlined,
                                        size: 16,
                                      ),
                                      label: Text(
                                        isInCart ? "Tambah Lagi" : "Tambah",
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: isInCart
                                            ? Colors.green
                                            : Colors.grey[700],
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildCartSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Keranjang Belanja",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  if (cart.isNotEmpty)
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          cart.clear();
                        });
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.clear_all, size: 18),
                      label: const Text("Kosongkan"),
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: cart.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Keranjang masih kosong",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Tambahkan produk untuk berbelanja",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        controller: scrollController,
                        itemCount: cart.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final item = cart[index];

                          // Null safety check untuk item
                          if (item == null) {
                            return const SizedBox.shrink();
                          }

                          // FIXED: menggunakan field names yang benar
                          final itemName = item['nama']?.toString() ?? 'Produk';
                          final itemPrice = item['harga'] ?? 0;
                          final itemQuantity = item['quantity'] ?? 0;
                          final firstLetter = itemName.isNotEmpty
                              ? itemName[0].toUpperCase()
                              : 'P';

                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.grey[700]!,
                                        Colors.grey[500]!,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      firstLetter,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        itemName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Rp ${itemPrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}",
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            decreaseFromCart(item['id']),
                                        icon: const Icon(
                                          Icons.remove,
                                          size: 18,
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 36,
                                          minHeight: 36,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Text(
                                          '$itemQuantity',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => addToCart(item),
                                        icon: const Icon(Icons.add, size: 18),
                                        constraints: const BoxConstraints(
                                          minWidth: 36,
                                          minHeight: 36,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: () => removeFromCart(item['id']),
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              if (cart.isNotEmpty) ...[
                const Divider(thickness: 2),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Rp ${getTotal().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: isLoading
                        ? null
                        : () {
                            Navigator.pop(context);
                            checkout();
                          },
                    icon: isLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Icon(Icons.payment),
                    label: Text(isLoading ? "Memproses..." : "Bayar Sekarang"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
