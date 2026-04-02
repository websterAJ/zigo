import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/customer.dart';
import '../providers/app_state.dart';
import '../components/zigo_top_app_bar.dart';

class CustomerDetailScreen extends StatelessWidget {
  final Customer customer;

  const CustomerDetailScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);
    final totalDebt = customer.totalDebt;
    final vesEquivalent = state.convertUsdToVes(totalDebt);

    return Scaffold(
      appBar: ZigoTopAppBar(
        title: 'Customers',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            CircleAvatar(
              radius: 48,
              backgroundColor: const Color(0xFFD3E3FF),
              child: Text(
                customer.name.substring(0, 2).toUpperCase(),
                style: GoogleFonts.manrope(fontSize: 32, fontWeight: FontWeight.bold, color: const Color(0xFF001C39)),
              ),
            ),
            const SizedBox(height: 16),
            Text(customer.name, style: GoogleFonts.manrope(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('ID: ${customer.id}', style: const TextStyle(color: Color(0xFF43474E), fontSize: 14)),
            const SizedBox(height: 24),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.call),
                    label: const Text('Llamar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA0F399),
                      foregroundColor: const Color(0xFF217128),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.chat),
                    label: const Text('WhatsApp'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25D366),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Debt Balance Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F4FA),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('SALDO DEUDOR TOTAL', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                      if (totalDebt > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: const Color(0xFF79000A), borderRadius: BorderRadius.circular(12)),
                          child: const Text('EN MORA', style: TextStyle(color: Color(0xFFFF7A70), fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Text('\$', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 4),
                      Text(
                        NumberFormat('#,##0.00').format(totalDebt),
                        style: GoogleFonts.manrope(fontSize: 48, fontWeight: FontWeight.w800, color: const Color(0xFF002446)),
                      ),
                    ],
                  ),
                  Text(
                    'Equivalente: ${NumberFormat('#,##0.00').format(vesEquivalent)} VES',
                    style: const TextStyle(color: Color(0xFF43474E), fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Registrar Pago CTA
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.payments),
                label: const Text('Registrar Pago', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF002446),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Transaction History
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Historial de Movimientos', style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF002446))),
                TextButton(onPressed: () {}, child: const Text('Ver Todo', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
              ],
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: customer.transactions.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final tx = customer.transactions[index];
                final isSale = tx.type == 'sale';
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: isSale ? const Color(0xFFE5E8EE) : const Color(0xFFA3F69C),
                            child: Icon(isSale ? Icons.shopping_bag : Icons.check_circle, color: isSale ? const Color(0xFF002446) : const Color(0xFF005312)),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tx.description, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              Text(DateFormat('MMM dd, hh:mm a').format(tx.date).toUpperCase(), style: const TextStyle(fontSize: 10, color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${isSale ? '+' : '-'}\$${tx.amount.toStringAsFixed(2)}',
                            style: TextStyle(fontWeight: FontWeight.bold, color: isSale ? Colors.black : const Color(0xFF1B6D24)),
                          ),
                          Text(isSale ? 'Venta a Crédito' : (tx.paymentMethod ?? 'Pago'), style: const TextStyle(fontSize: 10, color: Color(0xFF43474E))),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Metadata
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFE5E8EE).withOpacity(0.5), borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('CATEGORÍA', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                            Text(customer.category ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('LÍMITE CRÉDITO', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                            Text('\$${customer.creditLimit.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('DIRECCIÓN DE ENTREGA', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                            Text(customer.address, style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
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
