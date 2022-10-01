part of 'widgets.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;

  const TransactionTile(this.transaction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isInflow = transaction.type == 'INFLOW';
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        boxShadow: const <BoxShadow>[
          BoxShadow(
            blurRadius: 0.1,
            spreadRadius: 1,
            color: Colors.black12,
            // blurStyle: BlurStyle.outer,
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.transparent,
            child: SvgPicture.network(
                'https://statics.development.belvo.io/institutions/icon_logos/bancolombia.svg'),
          ),
          const SizedBox(width: 20),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction.description),
                Text(
                  '${isInflow ? '+' : '-'} ${formatPriceFromDouble(transaction.amount)}',
                  style: TextStyle(
                    color: isInflow ? Colors.green : Colors.red,
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
