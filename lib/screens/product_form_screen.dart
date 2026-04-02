import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';
import '../components/zigo_top_app_bar.dart';
import '../components/zigo_text_field.dart';

class ProductFormScreen extends StatelessWidget {
  final Product? product;

  const ProductFormScreen({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZigoTopAppBar(
        title: product == null ? 'Nuevo Producto' : 'Editar Producto',
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Inventario / Gestión', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2)),
            Text('Arquitectura de Producto', style: GoogleFonts.manrope(fontSize: 32, fontWeight: FontWeight.w800, color: const Color(0xFF002446))),
            const SizedBox(height: 32),

            // Core Details Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const Row(
                    children: [
                      Icon(Icons.info, size: 16, color: Color(0xFF002446)),
                      SizedBox(width: 8),
                      Text('Detalles Generales', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF002446))),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const ZigoTextField(label: 'Nombre del Producto', placeholder: 'Ej. Laptop Pro Titanium'),
                  const SizedBox(height: 24),
                  const ZigoTextField(label: 'Descripción', placeholder: 'Especificaciones técnicas...', maxLines: 4),
                  const SizedBox(height: 24),
                  const Row(
                    children: [
                      Expanded(child: ZigoTextField(label: 'Categoría', placeholder: 'Seleccionar')),
                      SizedBox(width: 16),
                      Expanded(child: ZigoTextField(label: 'SKU / Barcode', placeholder: '750100...', icon: Icons.photo_camera)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Variants Section
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: const Color(0xFFF1F4FA), borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.layers, size: 16, color: Color(0xFF002446)),
                          SizedBox(width: 8),
                          Text('Variantes', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF002446))),
                        ],
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add_circle, size: 16),
                        label: const Text('Añadir Atributo', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildVariantChip('Talla: M'),
                      _buildVariantChip('Color: Azul'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Las variantes permiten gestionar inventarios específicos por talla, color o material.', style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Pricing Section
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: const Color(0xFF002446), borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('FINANZAS MULTI-MONEDA', style: TextStyle(color: Color(0xFFABC8F5), fontSize: 10, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Text('\$', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(hintText: '0.00', hintStyle: TextStyle(color: Colors.white24), border: InputBorder.none),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('CÁLCULO AUTOMÁTICO (VES)', style: TextStyle(color: Color(0xFFABC8F5), fontSize: 10)),
                            Text('TASA: 36.50', style: TextStyle(color: Color(0xFFA0F399), fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text('Bs.', style: TextStyle(color: Color(0xFFA3F69C), fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(width: 8),
                            Text('0,00', style: TextStyle(color: Color(0xFFA3F69C), fontSize: 32, fontWeight: FontWeight.w900)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Inventory Control Card
             Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const Row(
                    children: [
                      Icon(Icons.inventory_2, size: 16, color: Color(0xFF002446)),
                      SizedBox(width: 8),
                      Text('Control de Existencias', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF002446))),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const ZigoTextField(label: 'Cantidad Inicial', placeholder: '0', keyboardType: TextInputType.number),
                  const SizedBox(height: 24),
                   Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFFFFDAD6).withOpacity(0.3), borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('ALERTA DE STOCK MÍNIMO', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF93000A))),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Expanded(child: TextField(decoration: InputDecoration(hintText: '5', border: InputBorder.none), keyboardType: TextInputType.number)),
                            Icon(Icons.notifications_active, color: Theme.of(context).colorScheme.error),
                          ],
                        ),
                        const Text('Se notificará cuando el inventario caiga por debajo de este nivel.', style: TextStyle(fontSize: 10, color: Color(0xFF93000A))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Guardar Producto'),
        icon: const Icon(Icons.save),
        backgroundColor: const Color(0xFF002446),
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildVariantChip(String label) {
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      onDeleted: () {},
      backgroundColor: const Color(0xFFDFE3E8),
      deleteIcon: const Icon(Icons.close, size: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide.none),
    );
  }
}
