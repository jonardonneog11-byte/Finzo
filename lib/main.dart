import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:math';

void main() {
  runApp(const FinzoApp());
}

class FinzoApp extends StatelessWidget {
  const FinzoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finzo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB)),
      ),
      home: const LoginScreen(),
    );
  }
}

// ================= COLORS =================
const Color primaryBlue = Color(0xFF2563EB);
const Color darkNavy = Color(0xFF0A1128);
const Color lightBg = Color(0xFFF5F7FA);
const Color textGrey = Color(0xFF64748B);

// GLOBAL STATE
String globalUserName = "User";
List<Map<String, dynamic>> globalActiveLoans = [];
List<Map<String, dynamic>> globalClosedLoans = [];

// ================= LOGIN SCREEN =================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);
    
    // Bypassing Google SHA-1 check for now (Temporary Guest Login)
    await Future.delayed(const Duration(seconds: 1)); 
    
    setState(() {
      globalUserName = "Ujjal"; // Yahan apna naam likh sakte ho
      _isLoading = false;
    });
    
    if (mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 100, height: 100,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)]),
                child: const Center(child: Icon(Icons.eco, size: 50, color: Colors.green)),
              ),
              const SizedBox(height: 20),
              const Text('Finzo', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: darkNavy)),
              const SizedBox(height: 8),
              const Text('Fast, transparent & instant micro credit', style: TextStyle(fontSize: 14, color: textGrey)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 30, offset: const Offset(0, 10))]),
                child: Column(
                  children: [
                    const Text('Welcome to Finzo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkNavy)),
                    const SizedBox(height: 12),
                    const Text('Sign in securely with your Google account to check loan eligibility and apply instantly.', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: textGrey, height: 1.5)),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _signInWithGoogle,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, foregroundColor: darkNavy, side: const BorderSide(color: Color(0xFFE2E8F0)),
                        minimumSize: const Size(double.infinity, 56), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: _isLoading 
                        ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.g_mobiledata, color: Colors.blue, size: 30),
                              const SizedBox(width: 12),
                              Text('Continue with Google', style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16)),
                            ],
                          ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.security, color: primaryBlue, size: 18),
                  SizedBox(width: 8),
                  Text('100% Encrypted & Bank-Grade Security', style: TextStyle(fontSize: 12, color: textGrey, fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= HOME SCREEN =================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightBg, elevation: 0,
        title: Row(
          children: [
            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.eco, color: Colors.green)),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Finzo', style: TextStyle(color: darkNavy, fontWeight: FontWeight.bold, fontSize: 18)),
                Text('Instant Micro Loans', style: TextStyle(color: textGrey, fontSize: 12)),
              ],
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: darkNavy)),
          const SizedBox(width: 8),
        ],
      ),
      body: _currentIndex == 0 ? _buildHomeTab(context) : (_currentIndex == 1 ? _buildMyLoansTab() : _buildAccountTab(context)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: primaryBlue, unselectedItemColor: textGrey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'My Loans'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }

  Widget _buildHomeTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity, padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: darkNavy, borderRadius: BorderRadius.circular(24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Hello, $globalUserName', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                      child: const Row(children: [Icon(Icons.verified, color: Colors.greenAccent, size: 16), SizedBox(width: 4), Text('Verified Account', style: TextStyle(color: Colors.white, fontSize: 12))]),
                    )
                  ],
                ),
                const SizedBox(height: 24),
                const Text('Pre-Approved Instant Credit', style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 8),
                const Text('Up to ₹6,500', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                const Row(children: [Icon(Icons.bolt, color: Colors.yellow, size: 20), SizedBox(width: 8), Text('Instant Disbursal directly into your UPI account', style: TextStyle(color: Colors.white70, fontSize: 12))]),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Available Loan Plans', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkNavy)),
          const SizedBox(height: 8),
          const Text('Select a plan tailored to your financial requirements.', style: TextStyle(color: textGrey)),
          const SizedBox(height: 16),
          _buildPlanCard(context, 'Weekly Quick Loan', '7 Days', '₹1,500', '₹1,600', '6.67% P.A.', '1 Week (7 Days)'),
          const SizedBox(height: 16),
          _buildPlanCard(context, 'Monthly Express Loan', '30 Days', '₹6,000', '₹6,500', '8.33% P.A.', '1 Month (30 Days)'),
        ],
      ),
    );
  }

  Widget _buildMyLoansTab() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2E8F0))),
            child: TabBar(
              indicator: BoxDecoration(color: primaryBlue, borderRadius: BorderRadius.circular(10)),
              labelColor: Colors.white, unselectedLabelColor: textGrey,
              tabs: const [Tab(text: 'Active Loans'), Tab(text: 'Closed Loans')],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildLoanList(globalActiveLoans, true),
                _buildLoanList(globalClosedLoans, false),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLoanList(List<Map<String, dynamic>> loans, bool isActive) {
    if (loans.isEmpty) return Center(child: Text("No ${isActive ? 'active' : 'closed'} loans found.", style: const TextStyle(color: textGrey)));
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: loans.length,
      itemBuilder: (context, index) {
        final loan = loans[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(loan['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: darkNavy)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: isActive ? Colors.green.shade50 : Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        Icon(isActive ? Icons.verified : Icons.check_circle, color: isActive ? Colors.green : Colors.grey, size: 14),
                        const SizedBox(width: 4),
                        Text(isActive ? 'Active' : 'Closed', style: TextStyle(color: isActive ? Colors.green : Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDetailCol('Sanctioned Principal', loan['amount']),
                  _buildDetailCol('Outstanding Balance', loan['total'], isBlue: true),
                ],
              ),
              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [const Icon(Icons.calendar_month, size: 16, color: textGrey), const SizedBox(width: 4), Text('Due: ${loan['dueDate']}', style: const TextStyle(color: textGrey, fontSize: 12))]),
                  const Text('View Details >', style: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildAccountTab(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(radius: 40, backgroundColor: primaryBlue, child: Icon(Icons.person, size: 40, color: Colors.white)),
          const SizedBox(height: 16),
          Text(globalUserName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkNavy)),
          const Text('Signed in as Guest', style: TextStyle(color: textGrey)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              if (context.mounted) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
              }
            }, 
            child: const Text("Logout")
          )
        ],
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, String title, String badge, String amount, String total, String rate, String tenure) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Color(0xFFF0F7FF), borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.payments, color: primaryBlue)), const SizedBox(width: 12), Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: darkNavy))]),
                Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: primaryBlue, borderRadius: BorderRadius.circular(20)), child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [Text(amount, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: darkNavy)), const SizedBox(width: 8), const Padding(padding: EdgeInsets.only(bottom: 4), child: Text('Disbursal Amount', style: TextStyle(color: textGrey)))]),
                const SizedBox(height: 16),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_buildDetailCol('Tenure', tenure), _buildDetailCol('Interest Rate', rate)]),
                const SizedBox(height: 16),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_buildDetailCol('Total Repayment', total, isBlue: true), const Icon(Icons.arrow_forward_ios, size: 16, color: textGrey)]),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LoanDetailsScreen(title: title, amount: amount, total: total, rate: rate, tenure: tenure))),
                    style: ElevatedButton.styleFrom(backgroundColor: primaryBlue, minimumSize: const Size(0, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    child: const Text('Apply Now  →', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDetailCol(String label, String value, {bool isBlue = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: textGrey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isBlue ? primaryBlue : darkNavy)),
      ],
    );
  }
}

// ================= LOAN DETAILS SCREEN =================
class LoanDetailsScreen extends StatefulWidget {
  final String title, amount, total, rate, tenure;
  const LoanDetailsScreen({super.key, required this.title, required this.amount, required this.total, required this.rate, required this.tenure});

  @override
  State<LoanDetailsScreen> createState() => _LoanDetailsScreenState();
}

class _LoanDetailsScreenState extends State<LoanDetailsScreen> {
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: lightBg, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: darkNavy), onPressed: () => Navigator.pop(context)), title: Text(widget.title, style: const TextStyle(color: darkNavy, fontWeight: FontWeight.bold)), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Sanction Amount', style: TextStyle(color: textGrey)),
                  const SizedBox(height: 8),
                  Text(widget.amount, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: darkNavy)),
                  const Divider(height: 40),
                  _buildRow('Repayment Tenure', widget.tenure),
                  _buildRow('Interest Rate', widget.rate),
                  _buildRow('Disbursal Date', 'Today', valueColor: Colors.green),
                  _buildRow('Repayment Due Date', '16 Nov 2026', valueColor: primaryBlue),
                  _buildRow('Verification Fee', '₹20'),
                  _buildRow('Processing Fee', '₹0'),
                  const Divider(height: 40),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Total Payable Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text(widget.total, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: primaryBlue))]),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Row(children: [Checkbox(value: _agreed, onChanged: (val) => setState(() => _agreed = val!), activeColor: primaryBlue), const Expanded(child: Text('I have read and agree to the Terms & Conditions.', style: TextStyle(fontSize: 12, color: textGrey)))]),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _agreed ? () => Navigator.push(context, MaterialPageRoute(builder: (_) => ApplicationFormScreen(title: widget.title, amount: widget.amount, total: widget.total, tenure: widget.tenure))) : null,
                style: ElevatedButton.styleFrom(backgroundColor: primaryBlue, disabledBackgroundColor: const Color(0xFFE2E8F0), minimumSize: const Size(0, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                child: const Text('Proceed to Application  →', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {Color valueColor = darkNavy}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: const TextStyle(color: textGrey)), Text(value, style: TextStyle(fontWeight: FontWeight.w600, color: valueColor))]),
    );
  }
}

// ================= APPLICATION FORM SCREEN =================
class ApplicationFormScreen extends StatefulWidget {
  final String title, amount, total, tenure;
  const ApplicationFormScreen({super.key, required this.title, required this.amount, required this.total, required this.tenure});

  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: lightBg, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: darkNavy), onPressed: () => Navigator.pop(context)), title: const Text('Loan Application', style: TextStyle(color: darkNavy, fontWeight: FontWeight.bold)), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue.shade100)),
                child: Row(children: [const Icon(Icons.check_circle, color: primaryBlue), const SizedBox(width: 12), Expanded(child: Text('Selected: ${widget.title} (${widget.amount})', style: const TextStyle(fontWeight: FontWeight.w600, color: primaryBlue)))]),
              ),
              const SizedBox(height: 24),
              const Text('Applicant Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkNavy)),
              const SizedBox(height: 16),
              _buildTextField('Full Name', Icons.person),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildDatePicker()),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField('Mobile Number', Icons.phone_android)),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField('City / Area / Town', Icons.location_city),
              const SizedBox(height: 16),
              Row(children: [Expanded(child: _buildTextField('District', Icons.map)), const SizedBox(width: 16), Expanded(child: _buildTextField('State', Icons.public))]),
              const SizedBox(height: 16),
              Row(children: [Expanded(child: _buildTextField('PIN Code', Icons.location_on)), const SizedBox(width: 16), Expanded(child: _buildTextField('UPI ID', Icons.account_balance_wallet))]),
              const SizedBox(height: 16),
              _buildTextField('Street Address', Icons.home),
              const SizedBox(height: 16),
              _buildTextField('Purpose of Loan', Icons.lightbulb_outline),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => AadhaarUploadScreen(title: widget.title, amount: widget.amount, total: widget.total, tenure: widget.tenure)));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all required details!')));
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: primaryBlue, minimumSize: const Size(0, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  child: const Text('Next: Upload Aadhaar  →', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Date of Birth', style: TextStyle(fontWeight: FontWeight.w600, color: darkNavy, fontSize: 14)),
        const SizedBox(height: 8),
        TextFormField(
          controller: _dobController,
          readOnly: true,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.cake, color: primaryBlue),
            filled: true, fillColor: Colors.white, hintText: 'Select DOB',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: primaryBlue)),
          ),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1950),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              setState(() {
                _dobController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
              });
            }
          },
          validator: (value) => value!.isEmpty ? 'Required' : null,
        ),
      ],
    );
  }

  Widget _buildTextField(String label, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: darkNavy, fontSize: 14)),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(prefixIcon: Icon(icon, color: primaryBlue), filled: true, fillColor: Colors.white, hintText: 'Enter $label', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: primaryBlue))),
          validator: (value) => value!.isEmpty ? 'Required' : null,
        )
      ],
    );
  }
}

// ================= AADHAAR UPLOAD SCREEN =================
class AadhaarUploadScreen extends StatefulWidget {
  final String title, amount, total, tenure;
  const AadhaarUploadScreen({super.key, required this.title, required this.amount, required this.total, required this.tenure});

  @override
  State<AadhaarUploadScreen> createState() => _AadhaarUploadScreenState();
}

class _AadhaarUploadScreenState extends State<AadhaarUploadScreen> {
  File? _frontImage;
  File? _backImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(bool isFront) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() { if (isFront) _frontImage = File(image.path); else _backImage = File(image.path); });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: lightBg, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: darkNavy), onPressed: () => Navigator.pop(context)), title: const Text('Document Verification', style: TextStyle(color: darkNavy, fontWeight: FontWeight.bold)), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Upload KYC Documents', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkNavy)),
            const SizedBox(height: 8),
            const Text('Please upload clear photos of your Aadhaar Card for verification.', style: TextStyle(color: textGrey)),
            const SizedBox(height: 20),
            _buildUploadBox('Aadhaar Card (Front)', _frontImage, () => _pickImage(true)),
            const SizedBox(height: 16),
            _buildUploadBox('Aadhaar Card (Back)', _backImage, () => _pickImage(false)),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (_frontImage != null && _backImage != null) ? () => Navigator.push(context, MaterialPageRoute(builder: (_) => PaymentScreen(title: widget.title, amount: widget.amount, total: widget.total, tenure: widget.tenure))) : () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please upload both Front & Back photos first!'))),
                style: ElevatedButton.styleFrom(backgroundColor: (_frontImage != null && _backImage != null) ? primaryBlue : const Color(0xFFE2E8F0), minimumSize: const Size(0, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                child: Text('Next: Pay Fee  →', style: TextStyle(color: (_frontImage != null && _backImage != null) ? Colors.white : textGrey, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildUploadBox(String title, File? image, VoidCallback onTap) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          InkWell(
            onTap: onTap,
            child: Container(
              width: double.infinity, height: 120,
              decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2E8F0)), image: image != null ? DecorationImage(image: FileImage(image), fit: BoxFit.cover) : null),
              child: image == null ? const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.camera_alt, color: primaryBlue, size: 30), SizedBox(height: 4), Text('Tap to Upload', style: TextStyle(color: primaryBlue, fontWeight: FontWeight.w600, fontSize: 12))]) : null,
            ),
          )
        ],
      ),
    );
  }
}

// ================= PAYMENT SCREEN =================
class PaymentScreen extends StatefulWidget {
  final String title, amount, total, tenure;
  const PaymentScreen({super.key, required this.title, required this.amount, required this.total, required this.tenure});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final String upiId = 'finzoverification@axl';
  final String payeeName = 'Finzo Verification';
  final String fee = '20.00';
  File? _paymentScreenshot;
  final _utrController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickScreenshot() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => _paymentScreenshot = File(image.path));
  }

  Future<void> _launchUpiApp(String appName) async {
    String scheme = 'upi://pay?pa=$upiId&pn=$payeeName&am=$fee&cu=INR&tn=Finzo%20Verification';
    if (appName == 'PhonePe') scheme = 'phonepe://pay?pa=$upiId&pn=$payeeName&am=$fee&cu=INR&tn=Finzo%20Verification';
    if (appName == 'Google Pay') scheme = 'tez://upi/pay?pa=$upiId&pn=$payeeName&am=$fee&cu=INR&tn=Finzo%20Verification';
    
    final Uri uri = Uri.parse(scheme);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'error';
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$appName is not installed. Please scan the QR Code above instead.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final String upiUrl = 'upi://pay?pa=$upiId&pn=$payeeName&am=$fee&cu=INR&tn=Finzo%20Verification';
    return Scaffold(
      appBar: AppBar(backgroundColor: lightBg, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: darkNavy), onPressed: () => Navigator.pop(context)), title: const Text('Fee Payment', style: TextStyle(color: darkNavy, fontWeight: FontWeight.bold)), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: double.infinity, padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Column(children: [const Text('Verification Fee', style: TextStyle(color: textGrey, fontWeight: FontWeight.w600)), const SizedBox(height: 12), const Text('₹20', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: primaryBlue)), const SizedBox(height: 12), Text('${widget.title} (Amount: ${widget.amount})', style: const TextStyle(color: darkNavy, fontWeight: FontWeight.w500))]),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity, padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Column(children: [const Text('Scan UPI QR Code to Pay', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: darkNavy)), const SizedBox(height: 20), Container(width: 200, height: 200, decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE2E8F0)), borderRadius: BorderRadius.circular(16)), child: Center(child: QrImageView(data: upiUrl, version: QrVersions.auto, size: 160.0, backgroundColor: Colors.white))), const SizedBox(height: 16), Text(upiId, style: const TextStyle(fontWeight: FontWeight.w600, color: primaryBlue))]),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity, padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pay Directly via UPI App', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: darkNavy)),
                  const SizedBox(height: 16),
                  Row(children: [Expanded(child: _buildUpiBtn('Google Pay', Icons.payment, () => _launchUpiApp('Google Pay'))), const SizedBox(width: 12), Expanded(child: _buildUpiBtn('PhonePe', Icons.phone_android, () => _launchUpiApp('PhonePe')))]),
                  const SizedBox(height: 12),
                  Row(children: [Expanded(child: _buildUpiBtn('Paytm', Icons.account_balance_wallet, () => _launchUpiApp('Paytm'))), const SizedBox(width: 12), Expanded(child: _buildUpiBtn('BHIM UPI', Icons.account_balance, () => _launchUpiApp('BHIM')))]),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity, padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Submit Payment Proof', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: darkNavy)),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: _pickScreenshot,
                    child: Container(
                      width: double.infinity, height: 100,
                      decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2E8F0)), image: _paymentScreenshot != null ? DecorationImage(image: FileImage(_paymentScreenshot!), fit: BoxFit.cover) : null),
                      child: _paymentScreenshot == null ? const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.add_photo_alternate, color: primaryBlue, size: 30), SizedBox(height: 4), Text('Upload Screenshot', style: TextStyle(color: primaryBlue, fontWeight: FontWeight.w600, fontSize: 12))]) : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(controller: _utrController, decoration: InputDecoration(prefixIcon: const Icon(Icons.tag, color: primaryBlue), hintText: '12-Digit UTR', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))))),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_paymentScreenshot != null && _utrController.text.length >= 10) {
                          String appId = 'APP-${Random().nextInt(900000) + 100000}';
                          String today = DateFormat('dd MMM yyyy').format(DateTime.now());
                          globalActiveLoans.add({'id': appId, 'title': widget.title, 'amount': widget.amount, 'total': widget.total, 'date': today, 'utr': _utrController.text, 'dueDate': '16 Nov 2026', 'status': 'PENDING'});
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ApplicationStatusScreen(loan: globalActiveLoans.last)));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please upload screenshot and enter valid UTR!')));
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: primaryBlue, minimumSize: const Size(0, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                      child: const Text('Submit Application  →', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpiBtn(String name, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2E8F0))),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: primaryBlue, size: 20), const SizedBox(width: 8), Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))]),
      ),
    );
  }
}

// ================= APPLICATION STATUS SCREEN =================
class ApplicationStatusScreen extends StatelessWidget {
  final Map<String, dynamic> loan;
  const ApplicationStatusScreen({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: lightBg, elevation: 0, automaticallyImplyLeading: false, title: const Text('Application Status', style: TextStyle(color: darkNavy, fontWeight: FontWeight.bold)), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: double.infinity, padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Column(
                children: [
                  const Text('Application Reference ID', style: TextStyle(color: textGrey, fontSize: 14)),
                  const SizedBox(height: 8),
                  Text(loan['id'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkNavy)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.orange.shade200)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.info_outline, color: Colors.orange.shade700, size: 16), const SizedBox(width: 6), Text('Pending', style: TextStyle(color: Colors.orange.shade700, fontWeight: FontWeight.bold))]),
                  ),
                  const SizedBox(height: 16),
                  const Text('Your verification payment and application details have been received and are currently under verification by our Credit Assessment Team.', textAlign: TextAlign.center, style: TextStyle(color: textGrey, fontSize: 12, height: 1.5)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity, padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(children: [Icon(Icons.timeline, color: primaryBlue, size: 20), SizedBox(width: 8), Text('Verification Stages', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: darkNavy))]),
                  const SizedBox(height: 24),
                  _buildTimelineStep('Verification Fee Payment', '₹20 fee verified via UPI', true, false),
                  _buildTimelineStep('KYC & Aadhaar Verification', 'Under Credit Team Review', true, true),
                  _buildTimelineStep('Instant Bank Disbursal', 'Sanction & Disbursal in Progress', false, false, isLast: true),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity, padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Selected Loan Plan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: darkNavy)),
                  const SizedBox(height: 16),
                  _buildRow('Plan Name', loan['title']),
                  _buildRow('Requested Amount', loan['amount']),
                  _buildRow('Disbursal Date', loan['date']),
                  _buildRow('Repayment Due Date', loan['dueDate']),
                  _buildRow('KYC Documents', 'Aadhaar Front & Back Uploaded'),
                  _buildRow('Verification Fee', '₹20 (Paid)'),
                  _buildRow('Total Repayment', loan['total'], isBlue: true),
                  _buildRow('UTR / Reference', loan['utr']),
                  _buildRow('Submitted On', '${loan['date']}, 07:40 PM'),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false),
                      style: ElevatedButton.styleFrom(backgroundColor: primaryBlue, minimumSize: const Size(0, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      child: const Text('Go to Dashboard', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineStep(String title, String subtitle, bool isActive, bool isCurrent, {bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24, height: 24,
              decoration: BoxDecoration(color: isActive ? (isCurrent ? primaryBlue : Colors.green) : const Color(0xFFE2E8F0), shape: BoxShape.circle),
              child: Icon(isActive ? (isCurrent ? Icons.hourglass_empty : Icons.check) : Icons.circle, color: isActive ? Colors.white : Colors.transparent, size: 14),
            ),
            if (!isLast) Container(width: 2, height: 40, color: isActive ? (isCurrent ? const Color(0xFFE2E8F0) : Colors.green) : const Color(0xFFE2E8F0)),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isActive ? darkNavy : textGrey)),
              const SizedBox(height: 4),
              Text(subtitle, style: TextStyle(fontSize: 12, color: textGrey)),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildRow(String label, String value, {bool isBlue = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: const TextStyle(color: textGrey, fontSize: 13)), Text(value, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: isBlue ? primaryBlue : darkNavy))]),
    );
  }
}
