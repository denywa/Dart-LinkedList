import 'dart:async';
import 'dart:io';

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

  // Mengambil ukuran terminal secara dinamis
  int width = stdout.terminalColumns;
  int height = stdout.terminalLines;

  for (int row = 0; row < height; row++) {
    if (row % 2 == 0) {
      // Baris genap: kiri ke kanan
      for (int col = 0; col < width; col++) {
        stdout.write(name[nameIndex]);
        nameIndex = (nameIndex + 1) % name.length;
        await Future.delayed(Duration(milliseconds: 10));
      }
    } else {
      // Baris ganjil: kanan ke kiri
      List<String> rowChars = List.filled(width, ' ');
      for (int col = width - 1; col >= 0; col--) {
        rowChars[col] = name[nameIndex];
        nameIndex = (nameIndex + 1) % name.length;
        
        // Pindah kursor ke awal baris
        stdout.write('\r');
        
        // Cetak seluruh baris
        stdout.write(rowChars.join());
        
        await Future.delayed(Duration(milliseconds: 10));
      }
    }

    // Pindah ke baris berikutnya
    if (row < height - 1) {
      stdout.write("\n");
    }

    // Update ukuran terminal setiap kali mulai baris baru
    width = stdout.terminalColumns;
    height = stdout.terminalLines;
  }
}

void main() {
  // Membuat linked list dan menambahkan huruf-huruf dari nama
  LinkedList nameList = LinkedList();
  String name = "DENY WAHYUDI ";
  for (int i = 0; i < name.length; i++) {
    nameList.add(name[i]);
  }

  clearScreen();
  printAnimation(nameList);
}