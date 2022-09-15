import 'package:ShoolManagementSystem/src/data.dart';

final hrSystemInstance = HRSystem()
  ..addBook(
      title: 'Left Hand of Darkness',
      authorName: 'Ursula K. Le Guin',
      isPopular: true,
      isNew: true)
  ..addBook(
      title: 'Too Like the Lightning',
      authorName: 'Ada Palmer',
      isPopular: false,
      isNew: true)
  ..addBook(
      title: 'Kindred',
      authorName: 'Octavia E. Butler',
      isPopular: true,
      isNew: false)
  ..addBook(
      title: 'The Lathe of Heaven',
      authorName: 'Ursula K. Le Guin',
      isPopular: false,
      isNew: false);

class HRSystem {
  final List<Book> allBooks = [];
  final List<Author> allAuthors = [];
  List<Employee>? allEmployees = [];
  List<AddressType>? addressTypes = [];
  List<Organization>? organizations = [];
  List<JobBand>? jobBands = [];

  // void addEmployee(Employee employee) {
  //   allEmployees.add(employee);
  // }

  void setEmployees(List<Employee>? employees) {
    allEmployees = employees;
  }

  void setAddressTypes(List<AddressType>? addressTypes) {
    this.addressTypes = addressTypes;
  }

  void setOrganizations(List<Organization>? organizations) {
    this.organizations = organizations;
  }

  void setJobBands(List<JobBand>? jobBands) {
    this.jobBands = jobBands;
  }

  void addBook({
    required String title,
    required String authorName,
    required bool isPopular,
    required bool isNew,
  }) {
    var author = allAuthors.firstWhere(
      (author) => author.name == authorName,
      orElse: () {
        final value = Author(allAuthors.length, authorName);
        allAuthors.add(value);
        return value;
      },
    );
    var book = Book(allBooks.length, title, isPopular, isNew, author);

    author.books.add(book);
    allBooks.add(book);
  }

  List<Book> get popularBooks => [
        ...allBooks.where((book) => book.isPopular),
      ];

  List<Book> get newBooks => [
        ...allBooks.where((book) => book.isNew),
      ];
}