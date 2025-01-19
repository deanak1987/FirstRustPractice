fn hello() -> String {
    String::from("Hello, world!")
}

fn reverse_string(input: &str) -> String {
    input.chars().rev().collect()
}

// fn main() {
//     let original = String::from("Hello, Rust!");
//     let reversed = reverse_string(&original);
//     println!("Original: {}", original);
//     println!("Reversed: {}", reversed);
// }


use std::rc::Rc;
use std::cell::RefCell;
use std::fmt::Display;

// Define a Node with a value and a pointer to the next Node
#[derive(Debug)]
struct Node<T> {
    value: T,
    next: Option<Rc<RefCell<Node<T>>>>,
}

// Define the LinkedList struct
#[derive(Debug)]
struct LinkedList<T> {
    head: Option<Rc<RefCell<Node<T>>>>,
}

// Constrain the implementation of LinkedList<T> to types T that implement Display
impl<T: Display> LinkedList<T> {
    // Create a new empty LinkedList
    fn new() -> Self {
        LinkedList { head: None }
    }

    // Add an element to the front of the list
    fn prepend(&mut self, value: T) {
        let new_node = Rc::new(RefCell::new(Node {
            value,
            next: self.head.take(),
        }));
        self.head = Some(new_node);
    }

    // Add an element to the end of the list
    // fn postpend(&mut self, value: T) {
    //     let new_node = Rc::new(RefCell::new(Node { value, next: None }));
    //     match self.head {
    //         Some(ref head) => {
    //             let mut current = Rc::clone(head);
    //             while let Some(next) = current.borrow().next.clone() {
    //                 // Assign `next` to a temporary variable and let the borrow end
    //                 current = next;
    //             }
    //             // Mutably borrow the last node and update its `next` pointer
    //             current.borrow_mut().next = Some(new_node);
    //         }
    //         None => {
    //             // If the list is empty, the new node becomes the head
    //             self.head = Some(new_node);
    //         }
    //     }
    // }


    // Print all the elements of the list
    fn print_list(&self) {
        let mut current = self.head.clone();
        while let Some(node) = current {
            print!("{} -> ", node.borrow().value);
            current = node.borrow().next.clone();
        }
        println!("None");
    }
}

fn main() {
    println!("{}", hello());

    let original = String::from("Hello, Rust!");
    let reversed = reverse_string(&original);
    println!("Original: {}", original);
    println!("Reversed: {}", reversed);

    // Create a new linked list
    let mut list = LinkedList::new();

    // Add elements to the linked list
    list.prepend(3);
    list.prepend(2);
    list.prepend(1);
    // list.postpend(4);

    // Print the linked list
    println!("Linked list elements:");
    list.print_list();
}
