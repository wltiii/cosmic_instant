import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cosmic_instant/extensions/date_time_apis.dart';

class CosmicInstantPage extends StatefulWidget {
  CosmicInstantPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _CosmicInstantPageState createState() => _CosmicInstantPageState();
}

class _CosmicInstantPageState extends State<CosmicInstantPage> {
  DateTime _instant = DateTime.now();
  String _name = 'Local Instant';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: _buildInstantContainer(),
      ),
    );
  }

  Widget _buildInstantContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: _buildInstantName(),
        ),
        Expanded(
          child: _buildCosmicInstant(),
          flex: 3,
        ),
        Expanded(
          child: _buildInstantFooter(),
        ),
      ],
    );
  }

  Widget _buildInstantName() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.black12,
        ),
        child:  Center(
            child: Text(
              '${_name}',
              key: Key('instant-name'),
              style: Theme.of(context).textTheme.headline4,
            )
        )
    );
  }

  Widget _buildCosmicInstant() {
    return Container(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${DateFormat.yMMMd().format(_instant)}',
                  key: Key('cosmic-date'),
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(
                  '${DateFormat.jms().format(_instant)}',
                  key: Key('cosmic-time'),
                  style: Theme.of(context).textTheme.headline3,
                ),
              ],
            )

        )
    );
  }

  Widget _buildInstantFooter() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
      ),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildUtcInstant(),
          _buildIsoInstant(),
        ],
      ),
    );
  }
  Widget _buildUtcInstant() {
    return Container(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'UTC',
                  style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
                ),
                Text(
                  '${DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(_instant.toUtc())}',
                  key: Key('utc-instant'),
                  style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
                ),
              ],
            )

        )
    );
  }

  Widget _buildIsoInstant() {
    return Container(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ISO 8601',
                  style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
                ),
                Text(
                  '${_instant.toIso8601StringWithOffset()}',
                  key: Key('iso-instant'),
                  style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
                ),
              ],
            )

        )
    );
  }
}