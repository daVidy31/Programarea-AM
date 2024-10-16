import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

void main() {
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CurrencyConverterPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  _CurrencyConverterPageState createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  String fromCurrency = 'MDL';
  String toCurrency = 'USD';
  double amount = 0;
  double convertedAmount = 0.0;
  double exchangeRate = 0.0;
  DateTime lastUpdated = DateTime.now();

  TextEditingController convertedAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchExchangeRate(); // Fetch exchange rate on app start
  }

  Future<void> fetchExchangeRate() async {
    String formattedDateForRequst =
    DateFormat('dd.MM.yyyy').format(lastUpdated);
    String url =
        'https://www.bnm.md/ro/official_exchange_rates?get_xml=1&date=$formattedDateForRequst';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final document = XmlDocument.parse(response.body);
        final usdElement = document.findAllElements('Valute').firstWhere(
                (element) =>
            element.findElements('CharCode').first.text == 'USD');
        String usdRate = usdElement.findElements('Value').single.text;
        setState(() {
          exchangeRate = double.parse(usdRate);
          convertedAmount = amount / exchangeRate;

          convertedAmountController.text = convertedAmount.toStringAsFixed(2);
          print('Exchange rate: $exchangeRate');
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Function to select date
  Future<void> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: lastUpdated,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != lastUpdated) {
      setState(() {
        lastUpdated = picked;
      });
      return fetchExchangeRate();
    }
  }

  // Swap currency function
  void swapCurrencies() {
    setState(() {
      // Swap the currency
      String temp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temp;

      // Swap the exchange rate logic (invert the exchange rate)
      if (exchangeRate != 0) {
        exchangeRate = 1 / exchangeRate;
      }

      // Recalculate the converted amount based on the new exchange rate
      convertedAmount = amount / exchangeRate;

      // Update the converted amount controller
      convertedAmountController.text = convertedAmount.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd.MM.yyyy').format(lastUpdated);

    // Update the images based on the currency selection
    String fromCurrencyImage = fromCurrency == 'MDL' ? 'images/img1.png' : 'images/img.png';
    String toCurrencyImage = toCurrency == 'MDL' ? 'images/img1.png' : 'images/img.png';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
          elevation: 0,
        ),
      ),
      body: Container(
        color: const Color(0xFFF2F2F2),
        child: Column(
          children: [
            const SizedBox(height: 43),
            const Text(
              'Currency Converter',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: Color(0xFF1F2261),
              ),
            ),
            const SizedBox(height: 42),
            Center(
              child: Container(
                width: 350,
                child: Card(
                  elevation: 40,
                  color: Color(0xFFFFFFFF),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 17, left: 22),
                          child: Row(
                            children: [
                              Image.asset(
                                fromCurrencyImage,
                                width: 48,
                                height: 45,
                              ),
                              const Spacer(),
                              Text(fromCurrency,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF1F2261),
                                  )),
                              IconButton(
                                  icon: const Icon(Icons.arrow_drop_down),
                                  onPressed: () {}),
                              const Spacer(),
                              Container(
                                width: 120,
                                height: 45,
                                child: TextField(
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9.]')),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      amount = double.tryParse(value) ?? 0.0;
                                      convertedAmount = amount / exchangeRate;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Divider(
                                  color: Color(0xFFE7E7EE),
                                  thickness: 2,
                                ),
                              ),
                              Container(
                                width: 47,
                                height: 47,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF1F2261),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.swap_vert,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: swapCurrencies,
                                ),
                              ),
                              const Expanded(
                                child: Divider(
                                  color: Color(0xFFE7E7EE),
                                  thickness: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(top: 6, left: 22),
                            child: Row(children: [
                              Text('Converted Amount',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFFA1A1A1),
                                  ))
                            ])),
                        Padding(
                          padding: EdgeInsets.only(top: 17, left: 22),
                          child: Row(
                            children: [
                              Image.asset(
                                toCurrencyImage,
                                width: 48,
                                height: 45,
                              ),
                              const Spacer(),
                              Text(toCurrency,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF1F2261),
                                  )),
                              IconButton(
                                  icon: const Icon(Icons.arrow_drop_down),
                                  onPressed: () {}),
                              const Spacer(),
                              Container(
                                width: 120,
                                height: 45,
                                child: TextField(
                                  textAlign: TextAlign.right,
                                  controller: convertedAmountController,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
