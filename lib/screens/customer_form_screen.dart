import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/customer.dart';
import '../components/zigo_top_app_bar.dart';
import '../components/zigo_text_field.dart';

class CustomerFormScreen extends StatelessWidget {
  final Customer? customer;

  const CustomerFormScreen({super.key, this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZigoTopAppBar(
        title: customer == null ? 'Nuevo Cliente' : 'Editar Cliente',
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
        actions: [IconButton(icon: const Icon(Icons.help_outline), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: const Color(0xFFF1F4FA),
                    child: Icon(customer == null ? Icons.person_add : Icons.person, size: 40, color: const Color(0xFF002446)),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    customer == null ? 'Añadir a la Red' : customer!.name,
                    style: GoogleFonts.manrope(fontSize: 24, fontWeight: FontWeight.w800, color: const Color(0xFF002446)),
                  ),
                  const Text('Registra la información de tu cliente para facilitar cobros y ventas.', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF43474E), fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const ZigoTextField(label: 'Nombre Completo', placeholder: 'Ej. Juan Pérez', icon: Icons.badge),
            const SizedBox(height: 24),
            const ZigoTextField(label: 'Nombre del Negocio', placeholder: 'Ej. Panadería El Trigal', icon: Icons.storefront),
            const SizedBox(height: 24),
            const ZigoTextField(label: 'Número de Teléfono', placeholder: '+58 412 000 0000', icon: Icons.call, keyboardType: TextInputType.phone),
            const SizedBox(height: 24),
            const ZigoTextField(label: 'Dirección de Entrega', placeholder: 'Av. Principal, Edif. Zigo, Local 1...', icon: Icons.location_on, maxLines: 3),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFC3C6CF).withOpacity(0.3))),
              child: Row(
                children: [
                  const Icon(Icons.verified_user, color: Color(0xFF1B6D24)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Gestión Segura', style: GoogleFonts.manrope(fontWeight: FontWeight.bold, color: const Color(0xFF002446))),
                        const Text('Los datos de tus clientes están protegidos bajo los protocolos de seguridad de Zigo Enterprise.', style: TextStyle(fontSize: 12, color: Color(0xFF43474E))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF002446),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(customer == null ? Icons.person_add : Icons.save),
              const SizedBox(width: 8),
              Text(customer == null ? 'Guardar Cliente' : 'Guardar Cambios', style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
