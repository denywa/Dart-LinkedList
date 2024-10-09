void main() {
  // Contoh penggunaan linked list
  LinkedList linkedList = LinkedList();
  linkedList.add(1);
  linkedList.add(2);
  linkedList.add(3);
  linkedList.add(4);
  linkedList.add(5);
  linkedList.display();
}

class Node {
  int data; //Data yang disimpan dalam node
  Node? next; //Poi~nter ke node berikutnya

  Node(this.data);
}


class LinkedList {
  Node? head; //head = node pertama dalam linked list

  void add(int data) {
    //Jika linked list masih kosong (head = null)
    if (head == null) {
      //Buat node baru dan jadikan sebagai head 
      head = Node(data);
    } else {
      //Jika linked list tidak kosong
      //Mulai dari head
      Node current = head!;
      //Iterasi sampai menemukan node terakhir (current.next = null)
      while (current.next != null) {
        current = current.next!;
      }
      // Tambahkan node baru di akhir linked list
      current.next = Node(data);
    }
  }

  void display() {
    Node? current = head;
    while (current != null) {
      print('${current.data}');
      current = current.next;
    }
    print('null');
  }

}
