import 'package:flutter/cupertino.dart';
// import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:stock_watchlist/DatabaseHelper.dart';
import 'package:stock_watchlist/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> selectedItems = [];



 List<Stock> stocks = [];

  Future<void> fetchStockData() async {
    final response = await http.get(Uri.parse('https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=tesco&apikey=demo'));
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['bestMatches'];
      final List<Stock> stockList = data.map((item) => Stock.fromJson(item)).toList();
print(stockList.length);
print(stocks.length);
      setState(() {
        stocks = stockList;
      });
      print(stocks.length);
    } else {
      throw Exception('Failed to load stock data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchStockData();
  }
   List<Stock> filterStocks(String query) {
    if (query.isEmpty) {
      return stocks;
    }

    query = query.toLowerCase();
    return stocks
        .where((stock) =>
            stock.name.toLowerCase().contains(query) ||
            stock.symbol.toLowerCase().contains(query))
        .toList();
  }

  
 




   TextEditingController _searchController = TextEditingController();
  List<String> searchResults = [];
   List<Stock> selectedStocks = [];
  int _currentIndex = 0;
    final List<Widget> _pages = [
    // First Tab Content
    Center(
      child: Text('Tab 1 Content'),
    ),

    // Second Tab Content
    Center(
      child: Text('Tab 2 Content'),
    ),
  ];
    void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
   void addToDatabase(Stock stock) async{
    print(stock);
    // Create a DatabaseHelper instance and open the database.
  // final dbHelper = DatabaseHelper();
  // await dbHelper.;
    setState(() {
       selectedStocks.add(stock);
    });
    // Clear the search bar.
    // searchController.clear();
    // Update the filtered stocks to exclude the selected items.
    setState(() async{
      filteredStocks = stocks.where((s) => !selectedStocks.contains(s)).toList();
       final dbHelper = DatabaseHelper();
       dbHelper.insertStock(stock);
        print('dbHelper.getItems()');
       print(dbHelper.getStocks());
 

  searchController.clear();

  setState(() {
    filteredStocks = stocks.where((s) => !selectedStocks.contains(s)).toList();
  });
    });
  }
  TextEditingController searchController = TextEditingController();
  List<Stock> filteredStocks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(backgroundColor: Colors.blue,
        title: Text('TRADE BRAINS'),
      ),
      body:  Padding(
        padding:
        EdgeInsets.all(20),
        child: Column(
      children: [
        TextField(
          controller: searchController,
          onChanged: (value) {
            if (value.isEmpty) {
              setState(() {
                filteredStocks = stocks;
              });
            } else {
              setState(() {
                filteredStocks = stocks
                    .where((stock) =>
                        stock.name.toLowerCase().contains(value.toLowerCase()))
                    .toList();
              });
            }
          },
          decoration: InputDecoration(
            labelText: 'Search Stocks',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        SizedBox(height: 10),
        if (selectedStocks.isNotEmpty)
          Container(
            height: 50, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: selectedStocks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text(selectedStocks[index].symbol),
                    onDeleted: () {
                      setState(() {
                        selectedStocks.remove(selectedStocks[index]);
                        filteredStocks = stocks
                            .where((s) => !selectedStocks.contains(s))
                            .toList();
                      });
                    },
                  ),
                );
              },
            ),
          ),
        if (filteredStocks.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemCount: filteredStocks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredStocks[index].name),
                  subtitle: Text(filteredStocks[index].symbol),
                  trailing: ElevatedButton(
                    onPressed: () {
                      print(filteredStocks[index]);
                       setState(() {
                        // Stock stock;
      // selectedStocks.add(filteredStocks[index]);
      //  print(selectedStocks[index].name);
    });
                        addToDatabase(filteredStocks[index]);
                    },
                    child: Text('Add'),
                  ),
                );
              },
            ),
          ),
      ],
    )));
  }
}
  class BestMatch {
    String the1Symbol;
    String the2Name;
    String the3Type;
    String the4Region;
    String the5MarketOpen;
    String the6MarketClose;
    String the7Timezone;
    String the8Currency;
    String the9MatchScore;

    BestMatch({
        required this.the1Symbol,
        required this.the2Name,
        required this.the3Type,
        required this.the4Region,
        required this.the5MarketOpen,
        required this.the6MarketClose,
        required this.the7Timezone,
        required this.the8Currency,
        required this.the9MatchScore,
    });}