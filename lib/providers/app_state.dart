import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../models/product.dart';
import '../models/transaction.dart';

class AppState extends ChangeNotifier {
  final List<Customer> _customers = [...mockCustomers];
  final List<Product> _products = [...mockProducts];
  final double exchangeRate = 36.50;

  List<Customer> get customers => _customers;
  List<Product> get products => _products;

  void addCustomer(Customer customer) {
    _customers.add(customer);
    notifyListeners();
  }

  void updateCustomer(Customer customer) {
    int index = _customers.indexWhere((c) => c.id == customer.id);
    if (index != -1) {
      _customers[index] = customer;
      notifyListeners();
    }
  }

  void deleteCustomer(String id) {
    _customers.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    int index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _products.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  double convertUsdToVes(double usd) {
    return usd * exchangeRate;
  }
}

// --- Mock Data ---

final List<Customer> mockCustomers = [
  Customer(
    id: 'V-24.892.110',
    name: 'Alejandro Villalobos',
    phone: '+58 412-000-0000',
    address: 'Av. Las Américas, Edif. Torre Pro, Piso 4, Caracas.',
    category: 'Cliente VIP',
    creditLimit: 1500.0,
    transactions: [
      Transaction(
        id: 'ZA-8821',
        type: 'sale',
        amount: 125.0,
        date: DateTime.now(),
        description: 'Venta #ZA-8821',
      ),
      Transaction(
        id: 'P-001',
        type: 'payment',
        amount: 50.0,
        date: DateTime.now().subtract(const Duration(days: 1)),
        description: 'Abono Recibido',
        paymentMethod: 'Zelle',
      ),
      Transaction(
        id: 'ZA-8750',
        type: 'sale',
        amount: 407.50,
        date: DateTime.now().subtract(const Duration(days: 32)), // Older date for status check
        description: 'Venta #ZA-8750',
      ),
    ],
  ),
  Customer(
    id: 'ZG-8821',
    name: 'Alejandro Herrera',
    businessName: 'Herrera & Asociados C.A.',
    taxId: 'J-12345678-9',
    phone: '+58 412 555 0123',
    address: 'Av. Principal de Las Mercedes, Edif. Orinoco, Piso 4, Caracas.',
    profilePic: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDx2jcEMN32Va-7Fm9fEs_za00lVwoi3okISv56aOykvng8Gdlk5VDaOhuJ6ci7bUZy1qHlcn0zwz3sfWH6_EoAUiQD3Yrp8ACsCYhPPLbO0htmPVw_F7LlF-w6-W-_Rtc5FTehkytp-BwxPzMjeiDa7EdJIvs07KbJqyuOMLPLX4Dx9y5PEgPOCsJgb151viRzMAVkwuRq4EJBU45R8wsIU7HZVu5EoBxaxyvp-tbF6eOlsI5T9dE2rFOkG1jD9V7kEzXXLK4CgJw',
  ),
  Customer(
    id: 'AM-001',
    name: 'Alejandro Mendoza',
    phone: '+58 412-555-0123',
    address: 'Caracas',
    transactions: [
       Transaction(id: 'T1', type: 'sale', amount: 340.0, date: DateTime.now().subtract(const Duration(days: 32)), description: 'Deuda inicial'),
    ]
  ),
  Customer(
    id: 'LR-001',
    name: 'Lucía Rodríguez',
    phone: '+58 424-999-4455',
    address: 'Caracas',
    transactions: [
       Transaction(id: 'T2', type: 'sale', amount: 85.20, date: DateTime.now().subtract(const Duration(days: 25)), description: 'Deuda inicial'),
    ]
  ),
  Customer(
    id: 'CH-001',
    name: 'Carlos Hernández',
    phone: '+58 416-123-4567',
    address: 'Caracas',
    transactions: [
       Transaction(id: 'T3', type: 'sale', amount: 512.30, date: DateTime.now().subtract(const Duration(days: 10)), description: 'Deuda inicial'),
    ]
  ),
];

final List<Product> mockProducts = [
  Product(
    id: 'P1',
    name: 'Nike Air Max Crimson',
    description: 'Zapatilla de alto rendimiento con cámara de aire visible y diseño ergonómico en color carmesí vibrante.',
    category: 'Calzado Deportivo',
    sku: 'NIKE-AM-CRM-001',
    priceUsd: 185.0,
    initialQuantity: 42,
    minStockAlert: 5,
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuD46-ZdhTtM1EjO9wBD71y5vQMgx1c3cKOwA5Va8CTx4A6m9THANU-bSn7PrLnmUozzkXAkTUjnsDdEETsdSKUQb2cUL9lNB1Ct5MnbQ5qnU0zhdhqcesnPdDuEcD6berZ0RNPmhaE5EhKapoXNQfupYvkcsLDOi4crEkC-PHWmQmIpZGcKFITRUUivO6ExfUPZPQ-qoBbSDndjIz8XK4pTqXQskiDQwk7BYy6Ce9T50j1pGn10yTTU2_zM2lDLCx4ysUBkc6Hni4k',
    variants: [
      ProductVariant(id: 'V1', attributeName: 'Talla', attributeValue: '42.5 EU', stock: 12, sku: 'NIKE-AM-CRM-01-425'),
      ProductVariant(id: 'V2', attributeName: 'Talla', attributeValue: '44.0 EU', stock: 30, sku: 'NIKE-AM-CRM-01-440'),
    ],
  ),
];
