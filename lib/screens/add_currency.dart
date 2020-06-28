import 'package:cryptotracker/providers/add_currency_service.dart';
import 'package:cryptotracker/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddCurrencyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final addCurrency = Provider.of<AddCurrency>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: () => Navigator.of(context).pop(true),
                icon: Icon(Icons.chevron_left),
              ),
              Text(
                'Add Currency',
                textScaleFactor: 1.4,
                style:
                    GoogleFonts.architectsDaughter(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          if (addCurrency.loading) LoadingScreen(),
          if (!addCurrency.loading)
            Expanded(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Fiat Currency',
                      style: GoogleFonts.architectsDaughter(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DropdownButton(
                    items: addCurrency.supportedCountries
                        .map((e) => DropdownMenuItem(
                              child: Text(
                                e.countryName,
                                style: GoogleFonts.architectsDaughter(),
                              ),
                              value: e,
                            ))
                        .toList(),
                    value: null,
                    hint: Text(
                      'Select to add a country',
                      style: GoogleFonts.architectsDaughter(),
                    ),
                    onChanged: (v) {
                      addCurrency.saveCountry(v);
                    },
                  ),
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 2),
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Chip(
                            label: Text(
                              addCurrency.countries[index].toString(),
                              style: GoogleFonts.architectsDaughter(),
                            ),
                            onDeleted: () => addCurrency
                                .removeCountry(addCurrency.countries[index]),
                          ),
                        );
                      },
                      itemCount: addCurrency.countries.length,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
