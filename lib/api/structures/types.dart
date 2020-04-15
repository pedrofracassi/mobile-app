enum Period {
  DAYS7,
  MONTH1,
  MONTH3,
  MONTH6,
  YEAR1,
  OVERALL
}

extension PeriodValue on Period {
  String get value => const {
    Period.DAYS7: '7day',
    Period.MONTH1: '1month',
    Period.MONTH3: '3month',
    Period.MONTH6: '6month',
    Period.YEAR1: '1year',
    Period.OVERALL: 'overall'
  }[this];
}