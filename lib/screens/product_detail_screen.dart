import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';
import '../providers/app_state.dart';
import '../components/zigo_top_app_bar.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);
    return Scaffold(
      appBar: ZigoTopAppBar(
        title: 'Zigo',
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.grey.withOpacity(0.1))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(product.imageUrl ?? '', fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.category.toUpperCase(), style: const TextStyle(fontSize: 10, letterSpacing: 1.2, color: Colors.grey)),
                  Text(product.name, style: GoogleFonts.manrope(fontSize: 28, fontWeight: FontWeight.w800, color: const Color(0xFF002446))),
                  Text('SKU: ${product.sku}', style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(color: const Color(0xFFF1F4FA), borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('PRECIO USD', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                              Text('\$ ${product.priceUsd.toStringAsFixed(2)}', style: GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(color: const Color(0xFFF1F4FA), borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('PRECIO VES', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                              Text(NumberFormat('#,##0.00').format(state.convertUsdToVes(product.priceUsd)), style: GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: ElevatedButton(onPressed: () {}, child: const Text('Editar'))),
                      const SizedBox(width: 16),
                      Expanded(child: ElevatedButton(onPressed: () {}, child: const Text('Ajustar Stock'))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: const Color(0xFF1A3A5F), borderRadius: BorderRadius.circular(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('TOTAL EN INVENTARIO', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: '${product.totalStock} ', style: GoogleFonts.manrope(fontSize: 40, fontWeight: FontWeight.w800, color: Colors.white)),
                        const TextSpan(text: 'unidades', style: TextStyle(fontSize: 18, color: Colors.white60)),
                      ],
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
