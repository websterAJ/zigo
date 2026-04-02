import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
      ],
      child: const ZigoApp(),
    ),
  );
}

// ==========================================
// MODELS
// ==========================================

enum Currency { usd, ves }

class Transaction {
  final String id;
  final double amount;
  final Currency currency;
  final double rate;
  final String method;
  final DateTime date;
  final String? reference;

  Transaction({
    required this.id,
    required this.amount,
    required this.currency,
    required this.rate,
    required this.method,
    required this.date,
    this.reference,
  });

  double get amountInUsd => currency == Currency.usd ? amount : amount / rate;
  double get amountInVes => currency == Currency.ves ? amount : amount * rate;
}

// ==========================================
// PROVIDERS
// ==========================================

class TransactionProvider with ChangeNotifier {
  final List<Transaction> _transactions = [];
  final double fixedRate = 36.50;

  List<Transaction> get transactions => [..._transactions].reversed.toList();

  double get totalUsd {
    return _transactions.fold(0.0, (sum, item) => sum + item.amountInUsd);
  }

  double get totalVes {
    return _transactions.fold(0.0, (sum, item) => sum + item.amountInVes);
  }

  void addTransaction({
    required double amount,
    required Currency currency,
    required String method,
    String? reference,
  }) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      amount: amount,
      currency: currency,
      rate: fixedRate,
      method: method,
      date: DateTime.now(),
      reference: reference,
    );
    _transactions.add(newTx);
    notifyListeners();
  }
}

class ZigoApp extends StatelessWidget {
  const ZigoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zigo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2A5CFF),
          primary: const Color(0xFF2A5CFF),
          onPrimary: Colors.white,
          surface: const Color(0xFFF7F9FF),
          secondary: const Color(0xFFE0FF2E),
          onSecondary: Colors.black,
        ),
        textTheme: GoogleFonts.montserratTextTheme().apply(
          bodyColor: const Color(0xFF181C20),
          displayColor: const Color(0xFF181C20),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleTextStyle: TextStyle(
            color: Color(0xFF181C20),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

// ==========================================
// COMPONENTS
// ==========================================

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, child) {
        final usdFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
        final vesFormat = NumberFormat.currency(symbol: 'Bs. ', decimalDigits: 2);

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2A5CFF), Color(0xFF1A3A5F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2A5CFF).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Balance Total',
                style: GoogleFonts.montserrat(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    usdFormat.format(provider.totalUsd),
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                vesFormat.format(provider.totalVes),
                style: GoogleFonts.montserrat(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.trending_up, color: Color(0xFFE0FF2E), size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'Tasa: ${provider.fixedRate} VES',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const QuickActionItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton.filled(
          onPressed: onTap,
          icon: Icon(icon),
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF2A5CFF),
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            shadowColor: Colors.black.withOpacity(0.05),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF43474E),
          ),
        ),
      ],
    );
  }
}

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          QuickActionItem(
            icon: Icons.add_shopping_cart,
            label: 'Venta',
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const SaleFormModal(),
              );
            },
          ),
          QuickActionItem(icon: Icons.outbox, label: 'Gasto', onTap: () {}),
          QuickActionItem(icon: Icons.inventory_2_outlined, label: 'Inventario', onTap: () {}),
          QuickActionItem(icon: Icons.people_outline, label: 'Deudas', onTap: () {}),
        ],
      ),
    );
  }
}

// ==========================================
// SCREENS
// ==========================================

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),
      appBar: AppBar(
        title: const Text('Zigo'),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              backgroundColor: const Color(0xFF2A5CFF).withOpacity(0.1),
              child: const Icon(Icons.person, color: Color(0xFF2A5CFF)),
            ),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            BalanceCard(),
            QuickActions(),
            RecentActivity(),
          ],
        ),
      ),
    );
  }
}

class RecentActivity extends StatelessWidget {
  const RecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, child) {
        final transactions = provider.transactions;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Actividad Reciente',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A3A5F),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Ver todo'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (transactions.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Text(
                      'No hay transacciones registradas',
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: transactions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final tx = transactions[index];
                    final vesFormat = NumberFormat.currency(symbol: 'Bs. ', decimalDigits: 2);

                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0FF2E).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.payment, color: Color(0xFF2A5CFF)),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tx.method,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  DateFormat('dd MMM, HH:mm').format(tx.date),
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                vesFormat.format(tx.amountInVes),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  color: Color(0xFF2A5CFF),
                                ),
                              ),
                              Text(
                                tx.currency == Currency.usd
                                  ? '\$${tx.amount.toStringAsFixed(2)}'
                                  : '\$${(tx.amount / tx.rate).toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              const SizedBox(height: 100),
            ],
          ),
        );
      },
    );
  }
}

class SaleFormModal extends StatefulWidget {
  const SaleFormModal({super.key});

  @override
  State<SaleFormModal> createState() => _SaleFormModalState();
}

class _SaleFormModalState extends State<SaleFormModal> {
  final _amountController = TextEditingController();
  final _refController = TextEditingController();
  Currency _selectedCurrency = Currency.usd;
  String _selectedMethod = 'Efectivo';
  final List<String> _methods = ['Efectivo', 'Pago Móvil', 'Zelle', 'Punto'];

  bool get _showReference => _selectedMethod == 'Pago Móvil' || _selectedMethod == 'Zelle';

  @override
  void dispose() {
    _amountController.dispose();
    _refController.dispose();
    super.dispose();
  }

  void _submit() {
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) return;

    context.read<TransactionProvider>().addTransaction(
          amount: amount,
          currency: _selectedCurrency,
          method: _selectedMethod,
          reference: _showReference ? _refController.text : null,
        );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final provider = context.watch<TransactionProvider>();
    final amountValue = double.tryParse(_amountController.text) ?? 0.0;

    double convertedAmount;
    String convertedSymbol;
    if (_selectedCurrency == Currency.usd) {
      convertedAmount = amountValue * provider.fixedRate;
      convertedSymbol = 'VES';
    } else {
      convertedAmount = amountValue / provider.fixedRate;
      convertedSymbol = '\$';
    }

    return Container(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomPadding),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Registrar Venta',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1A3A5F),
              ),
            ),
            const SizedBox(height: 32),
            // Amount Input
            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        _selectedCurrency == Currency.usd ? '\$' : 'Bs.',
                        style: GoogleFonts.montserrat(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2A5CFF),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IntrinsicWidth(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          textAlign: TextAlign.center,
                          autofocus: true,
                          onChanged: (_) => setState(() {}),
                          style: GoogleFonts.montserrat(
                            fontSize: 48,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF2A5CFF),
                          ),
                          decoration: const InputDecoration(
                            hintText: '0.00',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Color(0xFFD3E3FF)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '≈ ${convertedAmount.toStringAsFixed(2)} $convertedSymbol',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Currency Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Moneda',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F4FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      _buildCurrencyOption(Currency.usd, 'USD'),
                      _buildCurrencyOption(Currency.ves, 'VES'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Payment Method Chips
            Text(
              'Método de Pago',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: _methods.map((method) {
                final isSelected = _selectedMethod == method;
                return ChoiceChip(
                  label: Text(method),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedMethod = method);
                  },
                  backgroundColor: const Color(0xFFF1F4FA),
                  selectedColor: const Color(0xFF2A5CFF),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF43474E),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  side: BorderSide.none,
                  showCheckmark: false,
                );
              }).toList(),
            ),
            if (_showReference) ...[
              const SizedBox(height: 24),
              TextField(
                controller: _refController,
                decoration: InputDecoration(
                  labelText: 'Referencia',
                  filled: true,
                  fillColor: const Color(0xFFF1F4FA),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ],
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE0FF2E),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(
                  'REGISTRAR VENTA',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyOption(Currency currency, String label) {
    final isSelected = _selectedCurrency == currency;
    return GestureDetector(
      onTap: () => setState(() => _selectedCurrency = currency),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2A5CFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF43474E),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
