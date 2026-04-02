import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/app_state.dart';
import '../components/zigo_top_app_bar.dart';

class AccountsReceivableScreen extends StatelessWidget {
  const AccountsReceivableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);
    final totalReceivable = state.customers.fold(0.0, (sum, c) => sum + c.totalDebt);

    return Scaffold(
      appBar: ZigoTopAppBar(
        title: 'Zigo',
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(color: const Color(0xFFE5E8EE), borderRadius: BorderRadius.circular(20)),
            child: const Center(child: Text('\$ 36.50 VES', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: const Color(0xFF1A3A5F),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('TOTAL POR COBRAR', style: TextStyle(color: Color(0xFF87A4CF), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  Row(
                    children: [
                      const Text('\$', style: TextStyle(color: Color(0xFFD3E3FF), fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      Text(NumberFormat('#,##0.00').format(totalReceivable), style: GoogleFonts.manrope(color: Colors.white, fontSize: 48, fontWeight: FontWeight.w800)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('${state.customers.where((c) => c.totalDebt > 0).length} clientes con saldos pendientes', style: const TextStyle(color: Color(0xFF87A4CF), fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar cliente por nombre o teléfono...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xFFE5E8EE),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Clientes Deudores', style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF002446))),
                const Text('Ordenado por urgencia', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.customers.where((c) => c.totalDebt > 0).length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final customer = state.customers.where((c) => c.totalDebt > 0).toList()[index];
                final status = customer.overdueStatus;
                final isUrgent = status.contains('VENCIDO');

                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border(left: BorderSide(color: isUrgent ? Colors.red : Colors.green, width: 4)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: const Color(0xFFD3E3FF),
                            child: Text(customer.name.substring(0, 2).toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF001C39))),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(customer.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text(customer.phone, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(color: isUrgent ? const Color(0xFFFFDAD6) : const Color(0xFFE5E8EE), borderRadius: BorderRadius.circular(10)),
                                  child: Text(status, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: isUrgent ? const Color(0xFF93000A) : Colors.black54)),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('DEUDA TOTAL', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                              Text('\$ ${customer.totalDebt.toStringAsFixed(2)}', style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 20, color: const Color(0xFF002446))),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.chat, size: 16),
                          label: const Text('Recordar', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFA0F399),
                            foregroundColor: const Color(0xFF217128),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF1A3A5F),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
