class Logger {
  static void printInfo(StackTrace stackTrace, [String message = '']) {
    final stackTraceRegex = RegExp(r'#[0-9]+[\s]+(.+) \(([^\s]+)\)');
    final lines = stackTrace.toString().split("\n");
    final match = stackTraceRegex.matchAsPrefix(lines.first);
    final line = ("${match.group(1)} (${match.group(2)})");
    print('[I] $line\n');
    if (message.isNotEmpty) {
      print('[M] $message\n');
    }
    print(
        '-----------------------------------------------------------------------');
  }
}
