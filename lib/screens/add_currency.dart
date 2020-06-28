import 'package:cryptotracker/providers/add_currency_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCurrencyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(true),
            icon: Icon(Icons.arrow_left),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Country'),
              ),
              Consumer<AddCurrency>(builder: (_, value, __) {
                if (!value.loading)
                  return DropdownButton(
                    items: value.supportedCountries
                        .map((e) => DropdownMenuItem(
                              child: Text(e.countryName),
                              value: e,
                            ))
                        .toList(),
                    value: null,
                    hint: Text('Select to add'),
                    onChanged: (v) {
                      value.saveCountry(v);
                    },
                  );
                return CircularProgressIndicator();
              }),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          Consumer<AddCurrency>(builder: (_, value, __) {
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 2),
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text(value.countries[index].toString()),
                    onDeleted: () =>
                        value.removeCountry(value.countries[index]),
                  ),
                );
              },
              itemCount: value.countries.length,
            );
          })
        ],
      ),
    );
  }
}
