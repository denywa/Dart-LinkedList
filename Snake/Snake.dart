import 'dart:async';
import 'dart:io';
import 'dart:math';

class Node {
  String data;
  Node? next;
  Node(this.data);
}

class LinkedList {
  Node? head;

  void add(String data) {
    if (head == null) {
      head = Node(data);
    } else {
      Node? current = head;
      while (current?.next != null) {
        current = current?.next;
      }
      current?.next = Node(data);
    }
  }

  String getName() {
    Node? current = head;
    String name = '';
    while (current != null) {
      name += current.data;
      current = current.next;
    }
    return name;
  }
}

// Warna menggunakan kode ANSI
const String reset = '\x1B[0m'; // Kode untuk mereset warna
const String red = '\x1B[31m'; // Kode warna merah
const String green = '\x1B[32m'; // Kode warna hijau
const String yellow = '\x1B[33m'; // Kode warna kuning
const String blue = '\x1B[34m'; // Kode warna biru
const String magenta = '\x1B[35m'; // Kode warna magenta
const String cyan = '\x1B[36m'; // Kode warna cyan
const List<String> colors = [
  red,
  green,
  yellow,
  blue,
  magenta,
  cyan
]; // Daftar warna teks
// Random
String getRandomColor() {
  return colors[Random().nextInt(colors.length)];
}

void clearScreen() {
  if (Platform.isWindows) {
    stdout.write("\x1B[2J\x1B[0;0H");
  } else {
    stdout.write("\x1B[2J\x1B[H");
  }
}

void printAnimation(LinkedList nameList) async {
  String name = nameList.getName();
  int nameIndex = 0;
  String currentColor = reset; // Mulai dengan warna putih (default)

  // Mengambil ukuran terminal 
  int width = stdout.terminalColumns;
  int height = stdout.terminalLines;

  while (true) {
    for (int row = 0; row < height; row++) {
      if (row % 2 == 0) {
        // Baris genap: kiri ke kanan
        stdout.write('\x1B[${row + 1};1H');
        for (int col = 0; col < width; col++) {
          stdout.write('$currentColor${name[nameIndex]}$reset');
          nameIndex = (nameIndex + 1) % name.length;
          await Future.delayed(Duration(milliseconds: 10));
        }
      } else {
        // Baris ganjil: kanan ke kiri
        for (int col = width - 1; col >= 0; col--) {
          stdout.write(
              '\x1B[${row + 1};${col + 1}H'); 
          stdout.write('$currentColor${name[nameIndex]}$reset');
          nameIndex = (nameIndex + 1) % name.length;
          await Future.delayed(Duration(milliseconds: 10));
        }
      }
    }

    // Ganti warna setelah satu putaran
    currentColor = getRandomColor();
    // Update ukuran terminal
    width = stdout.terminalColumns;
    height = stdout.terminalLines;
  }
}

// Function untuk meminta input nama, tidak boleh null
String inputName() {
  while (true) {
    stdout.write("Masukkan Nama: ");
    String? input = stdin.readLineSync();
    if (input != null && input.isNotEmpty) {
      return input;
    } else {
      print("Input tidak boleh kosong. Silakan coba lagi.");
    }
  }
}

void main() {
  // Membuat linked list dari nama yang di input
  LinkedList nameList = LinkedList();
  String name = inputName();
  for (int i = 0; i < name.length; i++) {
    nameList.add(name[i]);
  }

  clearScreen();
  printAnimation(nameList);
}
