enum TimeSpanEnum {
  d(1),
  d3(3),
  w(7),
  w2(14),
  m(30),
  m3(90),
  m6(180),
  y(365);
  const TimeSpanEnum(this.value);
  final num value;
}