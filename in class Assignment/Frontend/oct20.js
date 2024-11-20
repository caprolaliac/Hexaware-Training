/*
Create array of Object of students which has Student
id,name, result,percentage
 
You should list out all passed student and they got the percentage greater than 80
*/

const students = [
  { id: 1, name: "Varun", result: "Pass", percentage: 78 },
  { id: 2, name: "Aryan", result: "Pass", percentage: 85 },
  { id: 3, name: "Tejas", result: "Pass", percentage: 90 }
];

const Above80 = students.filter(student => student.result === "Pass" && student.percentage > 80);

console.log(Above80);


/*
You are provided with an array of user orders.
Your task is to process these orders and generate a summary report
 using JavaScript array methods.
 
1)List the orders to include only those that are delivered.
 
2) filtered orders to an array of objects with only userId and amount.
 
3) Finds the first order placed by the user with userId 102.
 
4) filtered orders to calculate the total revenue.
 
note :you can use map(), filter(), find(), and reduce() methods
 
Given Data:
const orders = [
  { id: 1, userId: 101, product: 'Laptop', amount: 999, delivered: true },
  { id: 2, userId: 102, product: 'Phone', amount: 699, delivered: false },
  { id: 3, userId: 101, product: 'Tablet', amount: 499, delivered: true },
  { id: 4, userId: 103, product: 'Monitor', amount: 199, delivered: true },
  { id: 5, userId: 104, product: 'Keyboard', amount: 49, delivered: false },
  { id: 6, userId: 102, product: 'Mouse', amount: 25, delivered: true },
  { id: 7, userId: 105, product: 'Printer', amount: 150, delivered: true },
  { id: 8, userId: 106, product: 'Webcam', amount: 75, delivered: false },
  { id: 9, userId: 107, product: 'Speakers', amount: 85, delivered: true },
  { id: 10, userId: 108, product: 'Router', amount: 120, delivered: true },
];
*/

const orders = [
  { id: 1, userId: 101, product: 'Laptop', amount: 999, delivered: true },
  { id: 2, userId: 102, product: 'Phone', amount: 699, delivered: false },
  { id: 3, userId: 101, product: 'Tablet', amount: 499, delivered: true },
  { id: 4, userId: 103, product: 'Monitor', amount: 199, delivered: true },
  { id: 5, userId: 104, product: 'Keyboard', amount: 49, delivered: false },
  { id: 6, userId: 102, product: 'Mouse', amount: 25, delivered: true },
  { id: 7, userId: 105, product: 'Printer', amount: 150, delivered: true },
  { id: 8, userId: 106, product: 'Webcam', amount: 75, delivered: false },
  { id: 9, userId: 107, product: 'Speakers', amount: 85, delivered: true },
  { id: 10, userId: 108, product: 'Router', amount: 120, delivered: true },
];

const deliveredOrders = orders.filter(order => order.delivered);
console.log(deliveredOrders);


const userIdAmt = orders
  .filter(order => order.delivered)  
  .map(order => ({ userId: order.userId, amount: order.amount }));
console.log(userIdAmt);

const firstOrderByUser102 = orders.find(order => order.userId === 102);
console.log(firstOrderByUser102);

const totalRevenue = orders
  .filter(order => order.delivered) 
  .reduce((acc, order) => acc + order.amount, 0); 
console.log(totalRevenue);
