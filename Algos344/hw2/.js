class Node {
  constructor(key) {
    this.key = key; // Key value of the node
    this.left = null; // Left child node
    this.right = null; // Right child node
    this.parent = null; // Parent node
  }
}

function insertNode(root, key) {
  let y = null;
  let x = root;

    while (x !== null) {
        y = x;
        if (key < x.key) {
            // console.log({ "x is": x.key });
            x = x.left;
        } else {
      x = x.right;
    }
  }

  // Create a new node with the given key
  let z = new Node(key);
  console.log({ "z is": z.key });

  z.parent = y;
  if (y === null) {
    root = z;
  } else if (z.key < y.key) {
    y.left = z;
  } else {
    y.right = z;
  }

  return root;
}

let root = null;

root = insertNode(root, 5);
root = insertNode(root, 3);
root = insertNode(root, 10);
root = insertNode(root, 8);
root = insertNode(root, 12);
root = insertNode(root, 12);
root = insertNode(root, 8);
root = insertNode(root, 8);
root = insertNode(root, 6);
root = insertNode(root, 6);
root = insertNode(root, 7);
root = insertNode(root, 5);
root = insertNode(root, 8);

// function postOrderTraversal(node) {
//     if (node !== null) {
//         console.log(node.key);
//         postOrderTraversal(node.left);
//         postOrderTraversal(node.right);
//     }
// }

// console.log("Post Order traversal:");
// postOrderTraversal(root);
