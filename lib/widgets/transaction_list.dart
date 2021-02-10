import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function deleteTx;
  TransactionList(this._userTransactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 488,
      child: _userTransactions.isEmpty
          ? Column(
              children: [
                Text(
                  'Nothing yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: _userTransactions.length,
              itemBuilder: (ctx, index) {
                return Dismissible(
                  key: Key(_userTransactions[index].id),
                  onDismissed: (direction) {
                    deleteTx(_userTransactions[index].id);
                  },
                  background: Card(
                    color: Theme.of(context).errorColor,
                  ),
                  child: Card(
                    elevation: 3,
                    margin: EdgeInsets.all(4),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 35,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FittedBox(
                              child:
                                  Text('\$${_userTransactions[index].amount}')),
                        ),
                      ),
                      title: Text(
                        _userTransactions[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd()
                            .format(_userTransactions[index].date),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_sweep_rounded),
                        color: Theme.of(context).errorColor,
                        onPressed: () => deleteTx(_userTransactions[index].id),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
