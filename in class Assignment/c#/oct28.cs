//models/user.cs
using LibraryMgmt.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LibraryMgmt.Models
{
    public class user
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }

    public class Student : user { }
    public class Teacher : user { }
    public class Librarian : user { }

}
//
using LibraryMgmt.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LibraryMgmt.Repository.Interfaces
{
    internal interface IUser
    {
        public void BorrowBook(book book);
        public void ReserveBook(book book);
    }
}
//
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LibraryMgmt.Models
{
    internal class book
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Author { get; set; }
        public bool IsAvailable { get; set; }
        public bool IsReserved { get; set; }
    }
}

//
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LibraryMgmt.Models;
using LibraryMgmt.Repository.Interfaces;

namespace LibraryMgmt.Repository
{
    internal class stuImpl : IUser
    {
        public void BorrowBook(book book)
        {
            if (book.IsAvailable && !book.IsReserved)
            {
                book.IsAvailable = false;
                Console.WriteLine($"Student borrowed: {book.Title}");
            }
            else
            {
                Console.WriteLine($"{book.Title} is not available to borrow.");
            }
        }

        public void ReserveBook(book book)
        {
            Console.WriteLine("Students cannot Reserve a book.");
        }
    }
}
//

using LibraryMgmt.Models;
using LibraryMgmt.Repository.Interfaces;

namespace LibraryMgmt.Repository
{
    internal class teacImpl:IUser
    {
        public void BorrowBook(book book)
        {
            if (book.IsAvailable && !book.IsReserved)
            {
                book.IsAvailable = false;
                Console.WriteLine($"Teacher borrowed: {book.Title}");
            }
            else if (book.IsReserved)
            {
                Console.WriteLine($"{book.Title} is reserved and cannot be borrowed.");
            }
            else
            {
                Console.WriteLine($"{book.Title} is not available for borrowing.");
            }
        }

        public void ReserveBook(book book)
        {
            if (book.IsAvailable && !book.IsReserved)
            {
                book.IsReserved = true;
                Console.WriteLine($"Teacher reserved: {book.Title}");
            }
            else if (book.IsReserved)
            {
                Console.WriteLine($"{book.Title} is already reserved.");
            }
            else
            {
                Console.WriteLine($"{book.Title} is not available for reservation.");
            }
        }
    }
}
//
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LibraryMgmt.Models;
using LibraryMgmt.Repository.Interfaces;

namespace LibraryMgmt.Repository
{
    internal class libImpl : IUser
    {

        public interface ILibrarianActions : IUser
        {
            void AddBook(book book);
            void RemoveBook(book book);
        }


        public void BorrowBook(book book)
        {
            if (book.IsAvailable && !book.IsReserved)
            {
                book.IsAvailable = false;
                Console.WriteLine($"Librarian borrowed: {book.Title}");
            }
            else if (book.IsReserved)
            {
                Console.WriteLine($"{book.Title} is reserved and cannot be borrowed.");
            }
            else
            {
                Console.WriteLine($"{book.Title} is not available for borrowing.");
            }
        }

        public void AddBook(book book)
        {
        }
        public void RemoveBook(book book)
        {
        }

        public void ReserveBook(book book)
        {
            Console.WriteLine("Only teachers can Reserve a book");
        }
    }
}
//

using LibraryMgmt.Models;
using LibraryMgmt.Repository;
using LibraryMgmt.Repository.Interfaces;

class Program
{
    static void Main(string[] args)
    {
        book book1 = new book { Id = 1, Title = "C#_1", Author = "Varun", IsAvailable = true, IsReserved = false };
        book book2 = new book { Id = 2, Title = "C#_2", Author = "G", IsAvailable = false, IsReserved = true };

        IUser students = new stuImpl();
        IUser teachers = new teacImpl();
        IUser librarians = new libImpl();

        students.BorrowBook(book1);
        teachers.ReserveBook(book2);

    }
}
