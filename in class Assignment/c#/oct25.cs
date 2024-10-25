// Mode/Book.cs
namespace Test.Model
{
    public class Book
    {
        public string Title { get; set; }
        public string Genre { get; set; }
        public Author Author { get; set; }
    }
}

// Model/Author.cs

namespace Test.Model
{
    public class Author
    {
        public string Name { get; set; }
        public string Country { get; set; }
        public DateTime BirthDate { get; set; }
    }
}

// Model/Customer.cs

namespace Test.Model
{
    public class Customer
    {
        public string Name { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public DateTime DateOfBirth { get; set; }
    }
}

// Repository/ITest.cs

namespace Test.Repository
{
    internal interface ITest
    {
        List<Book> GetBooks();
        public void toJson(string filePath);
        public void toXml(string filePath);
        List<Book> fromJson(string filePath);
        List<Book> fromXml(string filePath);

        // 12.
        List<Customer> GetCustomers();
        bool IsValidEmail(string email);
        bool IsValidPhoneNumber(string phoneNumber);
        bool IsValidDateOfBirth(DateTime dateOfBirth);
    }
}

// Repository/TestImpl.cs

using System.Text.Json;
using System.Xml.Serialization;
using Test.Model;
using System.Text.RegularExpressions;

namespace Test.Repository
{
    internal class TestImpl : ITest
    {

        #region data
        private List<Book> books;
        private List<Customer> customers;

        public TestImpl()
        {
            books = new List<Book>
            {
                new Book
                {
                    Title = "Mistborn",
                    Genre = "Fantasy",
                    Author = new Author
                    {
                        Name="Brandon Sanderson",
                        Country= "USA",
                        BirthDate= new DateTime(1975,12,19)
                    }
                },

                new Book
                {
                    Title = "4321",
                    Genre = "Literary Fiction",
                    Author = new Author
                    {
                        Name="Paul Aster",
                        Country= "USA",
                        BirthDate= new DateTime(1947,2,3)
                    }
                },
                new Book
                {
                    Title = "Project Hail Mary",
                    Genre = "Science Fiction",
                    Author = new Author
                    {
                        Name="Andy Weir",
                        Country= "USA",
                        BirthDate= new DateTime(1972,6,16)
                    }
                },
                new Book
                {
                    Title = "Dune",
                    Genre = "Political Conspitacy Science Fiction",
                    Author = new Author
                    {
                        Name="Frank Herbert",
                        Country= "USA",
                        BirthDate= new DateTime(1920,10,8)
                    }
                },
                new Book
                {
                    Title = "The End of the Affair",
                    Genre = "Romance, psychologcial",
                    Author = new Author
                    {
                        Name="Graham Greene",
                        Country= "England",
                        BirthDate= new DateTime(1904,10,2)
                    }
                }
            };
            customers = new List<Customer>
            {
                new Customer
                {
                    Name = "Varun",
                    Email = "varun@123.com",
                    PhoneNumber = "9873784911",
                    DateOfBirth = new DateTime(2003, 5, 3)
                },
                new Customer
                {
                    Name = "Ram",
                    Email = "ram.1",
                    PhoneNumber = "abcdw",
                    DateOfBirth = new DateTime(1985, 8, 25)
                }
            };
        }
        #endregion
        public List<Book> GetBooks()
        {
            return books;
        }

        public List<Book> fromJson(string filePath)
        {
            var jsonData = File.ReadAllText(filePath);
            return JsonSerializer.Deserialize<List<Book>>(jsonData);
        }

        public List<Book> fromXml(string filePath)
        {
            var xmlSerializer = new XmlSerializer(typeof(List<Book>));
            using (var reader = new StreamReader(filePath))
            {
                return (List<Book>)xmlSerializer.Deserialize(reader);
            }
        }

        public void toJson(string filePath)
        {
            var json = JsonSerializer.Serialize(books, new JsonSerializerOptions { WriteIndented = true });
            File.WriteAllText(filePath, json);
        }

        public void toXml(string filePath)
        {
            var xmlSerializer = new XmlSerializer(typeof(List<Book>));
            using (FileStream fs = new FileStream(filePath, FileMode.Create))
            {
                xmlSerializer.Serialize(fs, books);
            }
        }

//----------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------------

        public List<Customer> GetCustomers()
        {
            return customers;
        }

        public bool IsValidEmail(string email)
        {
            var email_regex=new Regex(@"^[^@\s]+@[^@\s]+\.[^@\s]+$");
            return email_regex.IsMatch(email);

        }

        public bool IsValidPhoneNumber(string phoneNumber)
        {
            var phone_regex = new Regex(@"\+?\d{2}\s*\-?\d+");
            return phone_regex.IsMatch(phoneNumber);
        }

        public bool IsValidDateOfBirth(DateTime dateOfBirth)
        {
            var age=DateTime.Now.Year-dateOfBirth.Year;
            return age < 25;
        }
    }
}

// program.cs
namespace Test
{
    internal class Program
    {
        static void Main(string[] args)
        {
            //Console.WriteLine("Hello, World!");
            
            #region seriialisation and deserialisation
            TestImpl test = new TestImpl();
            string json_fp = "E:\\c#\\books.json";
            string xml_fp = "E:\\c#\\books.xml";
            test.toJson(json_fp);
            Console.WriteLine("Converted to JSON...");
            test.toXml(xml_fp);
            Console.WriteLine("Converted to XML...");

            List<Book> books1 = test.fromJson(json_fp);
            Console.WriteLine("Deserialised books from JSON...");
            foreach (var book in books1)
            {
                Console.WriteLine($"Title: {book.Title}, Genre:{book.Genre}, Author: {book.Author.Name}, Country: {book.Author.Country}");
            }
            List<Book> books2 = test.fromXml(xml_fp);
            Console.WriteLine("Deserialised books from XML...");
            foreach (var book in books2)
            {
                Console.WriteLine($"Title: {book.Title}, Genre:{book.Genre}, Author: {book.Author.Name}, Country: {book.Author.Country}");
            }
            #endregion
            #region validation

            TestImpl test = new TestImpl();
            var customers = test.GetCustomers();
            foreach ( var customer in customers)
            {
                bool isValidEmail = test.IsValidEmail(customer.Email);
                bool isValidPhone = test.IsValidPhoneNumber(customer.PhoneNumber);
                bool isValidDOB = test.IsValidDateOfBirth(customer.DateOfBirth);
                Console.Write($"Name: {customer.Name} Valid \n");

                if (!isValidEmail)
                {
                    Console.Write("Invalid Email. ");
                }

                if (!isValidPhone)
                {
                    Console.Write("Invalid Phone Number. ");
                }

                if (!isValidDOB)
                {
                    Console.Write("Invalid Date of Birth. ");
                }

            }
            #endregion
        }
    }
}
