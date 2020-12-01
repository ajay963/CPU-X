import 'package:flutter/foundation.dart';

class AndriodSystemInfo extends ChangeNotifier {
  String kernelArchitecture;
  String kernelBitness;
  String kernelName;
  String kernelVersion;
  String operatingSystemName;
  String operatingSystemVersion;
  String userDirectory;
  String userId;
  String userName;
  String userSpaceBitness;
  String processorName;
  String architecture;
  String name;
  String socket;
  String vendor;
  String getTotalPhysicalMemory = 'madar';
  String getFreePhysicalMemory = 'madar';
  String getTotalVirtualMemory;
  String getFreeVirtualMemory;
  String getVirtualMemorySize;

  void andriodInfo() {}
}
