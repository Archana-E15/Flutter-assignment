class Stock {
  String symbol;
  String name;
  String type;
  String region;
  String marketOpen;
  String marketClose;
  String timezone;
  String currency;
  double matchScore;

  Stock({
    required this.symbol,
    required this.name,
    required this.type,
    required this.region,
    required this.marketOpen,
    required this.marketClose,
    required this.timezone,
    required this.currency,
    required this.matchScore,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      symbol: json['1. symbol'],
      name: json['2. name'],
      type: json['3. type'],
      region: json['4. region'],
      marketOpen: json['5. marketOpen'],
      marketClose: json['6. marketClose'],
      timezone: json['7. timezone'],
      currency: json['8. currency'],
      matchScore: double.parse(json['9. matchScore']),
    );
  }

Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'type': type,
      'region': region,
      'marketOpen': marketOpen,
      'marketClose': marketClose,
      'timezone': timezone,
      'currency': currency,
      'matchScore': matchScore,
    };
  }
}