import 'package:flutter/material.dart';
import 'package:stock_watchlist/DatabaseHelper.dart';
import 'package:stock_watchlist/model.dart';
import 'package:flutter/cupertino.dart';
class StockListPage extends StatelessWidget {
  // StockDatabase stockDB = StockDatabase(); // Define and initialize the stockDB variable
     DatabaseHelper stockDB=DatabaseHelper();
 
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(title: Text('Stock List')),
      body: FutureBuilder<List<Stock>>(
        future: stockDB.getStocks(),
        builder: (context, snapshot) {
           print('snapshot.data!.length');
           print(snapshot.data!.length);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final stock = snapshot.data![index];
                return ListTile(
                  title: Text(stock.name),
                  subtitle: Text(stock.symbol),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Delete the stock when the delete button is pressed
                      // stockDB.i(index);
                      // setState(() {}); // Refresh the list
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            // return ('Error: ${snapshot.error}');
          }
           return Text('snapshot.data![index]');
        },
      ),
    );
  }
}
