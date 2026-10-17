import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

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

// ================= LOGIN SCREEN =================
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.eco, size: 50, color: primaryBlue),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Finzo',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: darkNavy),
              ),
              const SizedBox(height: 8),
              const Text(
                'Fast, transparent & instant micro credit',
                style: TextStyle(fontSize: 14, color: textGrey),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 30, offset: const Offset(0, 10))
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Welcome to Finzo',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkNavy),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Sign in securely with your Google account to check loan eligibility and apply instantly.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: textGrey, height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: darkNavy,
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        minimumSize: const Size(double.infinity, 56),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Row(
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
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightBg,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.eco, color: Colors.green),
            ),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: darkNavy,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Hello, Itachi', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                        child: const Row(
                          children: [
                            Icon(Icons.verified, color: Colors.greenAccent, size: 16),
                            SizedBox(width: 4),
                            Text('Verified Account', style: TextStyle(color: Colors.white, fontSize: 12)),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('Pre-Approved Instant Credit', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 8),
                  const Text('Up to ₹6,500', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Icon(Icons.bolt, color: Colors.yellow, size: 20),
                      SizedBox(width: 8),
                      Text('Instant Disbursal directly into your UPI account', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryBlue,
        unselectedItemColor: textGrey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'My Loans'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, String title, String badge, String amount, String total, String rate, String tenure) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFF0F7FF),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.payments, color: primaryBlue),
                    ),
                    const SizedBox(width: 12),
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: darkNavy)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: primaryBlue, borderRadius: BorderRadius.circular(20)),
                  child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(amount, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: darkNavy)),
                    const SizedBox(width: 8),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Text('Disbursal Amount', style: TextStyle(color: textGrey)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDetailCol('Tenure', tenure),
                    _buildDetailCol('Interest Rate', rate),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDetailCol('Total Repayment', total, isBlue: true),
                    const Icon(Icons.arrow_forward_ios, size: 16, color: textGrey),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => LoanDetailsScreen(title: title, amount: amount, total: total, rate: rate, tenure: tenure)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      minimumSize: const Size(0, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
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
      appBar: AppBar(
        backgroundColor: lightBg,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: darkNavy), onPressed: () => Navigator.pop(context)),
        title: Text(widget.title, style: const TextStyle(color: darkNavy, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
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
                  _buildRow('Disbursal Date', 'Today (17 Oct 2026)', valueColor: Colors.green),
                  _buildRow('Repayment Due Date', '16 Nov 2026', valueColor: primaryBlue),
                  _buildRow('Verification Fee', '₹20'),
                  _buildRow('Processing Fee', '₹0'),
                  const Divider(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Payable Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(widget.total, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: primaryBlue)),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.calendar_month, color: primaryBlue),
                      SizedBox(width: 8),
                      Text('Repayment Schedule & Dates', style: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.circle, color: Colors.green, size: 12),
                      const SizedBox(width: 12),
                      Expanded(child: Text('Disbursal to Account', style: const TextStyle(fontWeight: FontWeight.w600))),
                      const Text('Today', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.circle, color: primaryBlue, size: 12),
                      const SizedBox(width: 12),
                      Expanded(child: Text('Final Repayment Due', style: const TextStyle(fontWeight: FontWeight.w600))),
                      const Text('16 Nov 2026', style: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Row(
                children: [
                  Checkbox(
                    value: _agreed,
                    onChanged: (val) => setState(() => _agreed = val!),
                    activeColor: primaryBlue,
                  ),
                  const Expanded(
                    child: Text('I have read and agree to the Terms & Conditions, and confirm that all information provided is accurate.', style: TextStyle(fontSize: 12, color: textGrey)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _agreed ? () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ApplicationFormScreen()));
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  disabledBackgroundColor: const Color(0xFFE2E8F0),
                  minimumSize: const Size(0, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text('Proceed to Application  →', style: TextStyle(color: _agreed ? Colors.white : Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: textGrey)),
          Text(value, style: TextStyle(fontWeight: FontWeight.w600, color: valueColor)),
        ],
      ),
    );
  }
}

// ================= APPLICATION FORM SCREEN =================
class ApplicationFormScreen extends StatelessWidget {
  const ApplicationFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightBg,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: darkNavy), onPressed: () => Navigator.pop(context)),
        title: const Text('Loan Application', style: TextStyle(color: darkNavy, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStep(1, 'Details', true, false),
                _buildLine(true),
                _buildStep(2, 'Aadhaar', false, false),
                _buildLine(false),
                _buildStep(3, 'Payment', false, false),
              ],
            ),
            const SizedBox(height: 24),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue.shade100)),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: primaryBlue),
                  const SizedBox(width: 12),
                  const Text('Selected: Monthly Express Loan (₹6000)', style: TextStyle(fontWeight: FontWeight.w600, color: primaryBlue)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: primaryBlue, borderRadius: BorderRadius.circular(8)),
                    child: const Text('30 Days', style: TextStyle(color: Colors.white, fontSize: 10)),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            const Text('Applicant Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkNavy)),
            const SizedBox(height: 16),
            
            _buildTextField('Full Name', Icons.person),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildTextField('Date of Birth', Icons.cake)),
                const SizedBox(width: 16),
                Expanded(child: _buildTextField('Mobile Number', Icons.phone_android)),
              ],
            ),
            const SizedBox(height: 16),
            _buildTextField('City / Area / Town', Icons.location_city),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildTextField('District', Icons.map)),
                const SizedBox(width: 16),
                Expanded(child: _buildTextField('State', Icons.public)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildTextField('PIN Code', Icons.location_on)),
                const SizedBox(width: 16),
                Expanded(child: _buildTextField('UPI ID (for credit)', Icons.account_balance_wallet)),
              ],
            ),
            const SizedBox(height: 16),
            _buildTextField('Street Address', Icons.home),
            const SizedBox(height: 16),
            _buildTextField('Purpose of Loan', Icons.lightbulb_outline),
            
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AadhaarUploadScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  minimumSize: const Size(0, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Next: Upload Aadhaar Documents  →', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: darkNavy, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: primaryBlue),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: primaryBlue)),
          ),
        )
      ],
    );
  }

  Widget _buildStep(int step, String label, bool isActive, bool isDone) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive || isDone ? primaryBlue : const Color(0xFFE2E8F0),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isDone ? const Icon(Icons.check, color: Colors.white, size: 18) : Text('$step', style: TextStyle(color: isActive ? Colors.white : textGrey, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: isActive ? primaryBlue : textGrey, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  Widget _buildLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 20, left: 8, right: 8),
        color: isActive ? primaryBlue : const Color(0xFFE2E8F0),
      ),
    );
  }
}

// ================= AADHAAR UPLOAD SCREEN =================
class AadhaarUploadScreen extends StatelessWidget {
  const AadhaarUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightBg,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: darkNavy), onPressed: () => Navigator.pop(context)),
        title: const Text('Document Verification', style: TextStyle(color: darkNavy, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStep(1, 'Details', false, true),
                _buildLine(true),
                _buildStep(2, 'Aadhaar', true, false),
                _buildLine(false),
                _buildStep(3, 'Payment', false, false),
              ],
            ),
            const SizedBox(height: 24),
            
            const Text('Upload KYC Documents', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkNavy)),
            const SizedBox(height: 8),
            const Text('Please upload clear photos of your Aadhaar Card (Front and Back sides) for instant identity verification.', style: TextStyle(color: textGrey)),
            const SizedBox(height: 20),
            
            _buildUploadBox('Aadhaar Card (Front Side)', 'Photo side with Name, DOB and Aadhaar Number clearly visible'),
            const SizedBox(height: 16),
            _buildUploadBox('Aadhaar Card (Back Side)', 'Address side with QR code clearly visible'),
            
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: const Row(
                children: [
                  Icon(Icons.lock, color: Colors.green),
                  SizedBox(width: 12),
                  Expanded(child: Text('Your Aadhaar information is encrypted with bank-grade 256-bit SSL and used exclusively for underwriting.', style: TextStyle(fontSize: 12, color: textGrey))),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  minimumSize: const Size(0, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Next: Pay Verification Fee  →', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildUploadBox(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.badge, color: primaryBlue),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: textGrey, fontSize: 12)),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0), style: BorderStyle.solid),
            ),
            child: const Column(
              children: [
                Icon(Icons.camera_alt, color: primaryBlue, size: 40),
                SizedBox(height: 8),
                Text('Take Photo or Upload Image', style: TextStyle(color: primaryBlue, fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                Text('PNG, JPG or JPEG up to 10MB', style: TextStyle(color: textGrey, fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStep(int step, String label, bool isActive, bool isDone) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive || isDone ? (isDone ? Colors.green : primaryBlue) : const Color(0xFFE2E8F0),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isDone ? const Icon(Icons.check, color: Colors.white, size: 18) : Text('$step', style: TextStyle(color: isActive ? Colors.white : textGrey, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: isActive || isDone ? (isDone ? Colors.green : primaryBlue) : textGrey, fontWeight: isActive || isDone ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  Widget _buildLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 20, left: 8, right: 8),
        color: isActive ? primaryBlue : const Color(0xFFE2E8F0),
      ),
    );
  }
}

// ================= PAYMENT SCREEN =================
class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  final String upiId = 'finzoverification@axl';
  final String payeeName = 'Finzo Verification';
  final String amount = '20.00';

  @override
  Widget build(BuildContext context) {
    final String upiUrl = 'upi://pay?pa=$upiId&pn=$payeeName&am=$amount&cu=INR&tn=Finzo%20Verification';
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightBg,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: darkNavy), onPressed: () => Navigator.pop(context)),
        title: const Text('Verification Fee Payment', style: TextStyle(color: darkNavy, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStep(1, 'Details', false, true),
                _buildLine(true),
                _buildStep(2, 'Aadhaar', false, true),
                _buildLine(true),
                _buildStep(3, 'Payment', true, false),
              ],
            ),
            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Column(
                children: [
                  const Text('Instant Verification & Underwriting Fee', style: TextStyle(color: textGrey, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  const Text('₹20', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: primaryBlue)),
                  const SizedBox(height: 12),
                  const Text('Monthly Express Loan (Amount: ₹6000)', style: TextStyle(color: darkNavy, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code, color: primaryBlue),
                      SizedBox(width: 8),
                      Text('Scan UPI QR Code to Pay', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: darkNavy)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('Scan with Google Pay, PhonePe, Paytm or BHIM', style: TextStyle(color: textGrey, fontSize: 12)),
                  const SizedBox(height: 20),
                  
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: QrImageView(
                        data: upiUrl,
                        version: QrVersions.auto,
                        size: 180.0,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2E8F0))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.account_balance, color: primaryBlue),
                        const SizedBox(width: 8),
                        Text(upiId, style: const TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(width: 8),
                        const Icon(Icons.copy, size: 16, color: textGrey),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pay Directly via UPI App', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: darkNavy)),
                  const SizedBox(height: 8),
                  const Text('Tap your preferred app to open and complete ₹20 verification fee payment:', style: TextStyle(color: textGrey, fontSize: 12)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildUpiBtn('Google Pay', Icons.payment)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildUpiBtn('PhonePe', Icons.phone_android)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildUpiBtn('Paytm', Icons.account_balance_wallet)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildUpiBtn('BHIM UPI', Icons.account_balance)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.receipt, color: primaryBlue),
                      SizedBox(width: 8),
                      Text('Submit Payment Proof', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: darkNavy)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('Upload screenshot of payment and enter UTR to send application to Pending verification:', style: TextStyle(color: textGrey, fontSize: 12)),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: const Column(
                        children: [
                          Icon(Icons.add_photo_alternate, color: primaryBlue, size: 32),
                          SizedBox(height: 8),
                          Text('Upload Payment Screenshot', style: TextStyle(color: primaryBlue, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.tag, color: primaryBlue),
                      hintText: '12-Digit UTR / Transaction Ref...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Application Submitted Successfully!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        minimumSize: const Size(0, 56),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('Submit Form (Send to Pending)  →', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildUpiBtn(String name, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: primaryBlue, size: 20),
          const SizedBox(width: 8),
          Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildStep(int step, String label, bool isActive, bool isDone) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive || isDone ? (isDone ? Colors.green : primaryBlue) : const Color(0xFFE2E8F0),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isDone ? const Icon(Icons.check, color: Colors.white, size: 18) : Text('$step', style: TextStyle(color: isActive ? Colors.white : textGrey, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: isActive || isDone ? (isDone ? Colors.green : primaryBlue) : textGrey, fontWeight: isActive || isDone ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  Widget _buildLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 20, left: 8, right: 8),
        color: isActive ? primaryBlue : const Color(0xFFE2E8F0),
      ),
    );
  }
}
