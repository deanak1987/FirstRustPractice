fn hello() -> String {
    String::from("Hello, world!")
}

fn reverse_string(input: &str) -> String {
    input.chars().rev().collect()
}

use std::cell::RefCell;
use std::fmt::Display;
use std::rc::Rc;

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
    println!("### Run a Hello, World Function ###");
    println!("{}", hello());

    println!("\n### Reverse Text ###");
    let original = String::from("Hello, Rust!");
    let reversed = reverse_string(&original);
    println!("Original: {}", original);
    println!("Reversed: {}", reversed);

    println!("\n### Create Vector and Add to it ###");
    let mut numbers = vec![];
    numbers.push(1);
    numbers.push(2);
    println!("{:?}", numbers);

    println!("\n### Use For Loop with Vector and steps of 2");
    for i in (3..=9).step_by(2) {
        numbers.push(i);
    }
    println!("{:?}", numbers);

    println!("\n### Make Linked List from Scratch ###");
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
