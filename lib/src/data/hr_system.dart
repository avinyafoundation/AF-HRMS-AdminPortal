import 'package:ShoolManagementSystem/src/data.dart';

final List<Organization> organizations = [
  Organization(
      name: 'Avinya Foundation',
      description: 'Avinya Foundation - the present organization'),
  Organization(
      name: 'Bandaragama Campus',
      description: 'Avinya campus located in Bandaragama')
];

final List<Team> teams = [
  Team(
      name: 'Executive',
      description: 'Team of executives who make all executive decisions',
      organization: organizations[0]),
  Team(
      name: 'Education',
      description:
          'Team who handles and manages curriculum, educators and students',
      organization: organizations[0]),
  Team(
      name: 'Technology',
      description:
          'Technology, R&D, Engineering and IT systems handled by this ',
      organization: organizations[0]),
  Team(
      name: 'Operations',
      description: 'All matters related to operations handled by this team',
      organization: organizations[0]),
  Team(
      name: 'HR',
      description: 'All matters related to HR handled by this team',
      organization: organizations[0]),
  Team(
      name: 'Foundation Program',
      description:
          'Team who is responsible for all matters related to foundation program',
      organization: organizations[1]),
  Team(
      name: 'Vocational IT',
      description:
          'Team who is responsible for all matters related to Vocational IT program',
      organization: organizations[1]),
  Team(
      name: 'Vocational Health',
      description:
          'Team who is responsible for all matters related to Vocational Health program',
      organization: organizations[1]),
  Team(
      name: 'Vocational Hospitality',
      description:
          'Team who is responsible for all matters related to Vocational Hospitality program',
      organization: organizations[1]),
  Team(
      name: 'Operations',
      description:
          'Team who is responsible for all matters related to campus operations',
      organization: organizations[1])
];

final List<Job> jobs = [
  Job(
      name: 'Executie Director',
      description: 'The ececutive of the foundation',
      team: teams[0],
      hc_plan: 1,
      employees: [Employee(employee_id: 'AF001', display_name: 'Anju Moses')]),
  Job(
      name: 'Head - Foundation Program',
      description: 'The head of the foundation program',
      team: teams[1],
      hc_plan: 1,
      employees: [
        Employee(employee_id: 'AF002', display_name: 'Dinesha Senaratne')
      ]),
  Job(
      name: 'Head - Healthcare',
      description: 'The head of the vocational healthcare program',
      team: teams[1],
      hc_plan: 1),
  Job(
      name: 'Head - Hospitality',
      description: 'The head of the vocational hospitality program',
      team: teams[1],
      hc_plan: 1),
  Job(
      name: 'Head - IT',
      description: 'The head of the vocational IT program',
      team: teams[1],
      hc_plan: 1),
  Job(
      name: 'CTO',
      description: 'Chienf Technology Officer',
      team: teams[2],
      hc_plan: 1,
      employees: [
        Employee(employee_id: 'AF003', display_name: 'Samisa Abeysinghe')
      ]),
  Job(
      name: 'Strategy and Technology Consultant',
      description: 'Software architect working on overall SMS',
      team: teams[2],
      hc_plan: 1,
      employees: [
        Employee(employee_id: 'AF004', display_name: 'Rukmal Weerawarana')
      ]),
  Job(
      name: 'Software Engineer',
      description: 'Full stack software engineer',
      team: teams[2],
      hc_plan: 4,
      employees: [
        Employee(employee_id: 'AF005', display_name: 'Person 1'),
        Employee(employee_id: 'AF006', display_name: 'Person 2')
      ]),
  Job(
      name: 'Head - School Operations',
      description: 'The head of overall school operations',
      team: teams[3],
      hc_plan: 1),
  Job(
      name: 'Head - HR',
      description: 'The head of overall HR operations',
      team: teams[4],
      hc_plan: 1),
];

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
      isNew: false)
  ..setOrganizations(organizations)
  ..addTeam(team: teams[0])
  ..addTeam(team: teams[1])
  ..addTeam(team: teams[2])
  ..addTeam(team: teams[3])
  ..addTeam(team: teams[4])
  ..addTeam(team: teams[5])
  ..addTeam(team: teams[6])
  ..addTeam(team: teams[7])
  ..addTeam(team: teams[8])
  ..addJob(job: jobs[0])
  ..addJob(job: jobs[1])
  ..addJob(job: jobs[2])
  ..addJob(job: jobs[3])
  ..addJob(job: jobs[4])
  ..addJob(job: jobs[5])
  ..addJob(job: jobs[6])
  ..addJob(job: jobs[7])
  ..addJob(job: jobs[8])
  ..addJob(job: jobs[9]);

class HRSystem {
  final List<Book> allBooks = [];
  final List<Author> allAuthors = [];
  List<Employee>? allEmployees = [];
  List<AddressType>? addressTypes = [];
  List<Organization>? organizations = [];
  List<Branch>? branches = [];
  List<Office>? offices = [];
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

  void setBranches(List<Branch>? branches) {
    this.branches = branches;
  }

  void setOffices(List<Office>? offices) {
    this.offices = offices;
  }

  void setJobBands(List<JobBand>? jobBands) {
    this.jobBands = jobBands;
  }

  addOrganization({
    required String name,
    required String description,
  }) {
    var organization = Organization(
        id: organizations!.length, name: name, description: description);
    organizations!.add(organization);
  }

  addTeam({
    required Team team,
  }) {
    team.organization!.teams!.add(team);
  }

  addJob({
    required Job job,
  }) {
    job.team!.jobs!.add(job);
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

  loadInitData() async {
    //this.organizations = await fetchOrganizations(); Differ this until the BFF and DS API is ready
  }
}
