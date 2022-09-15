import 'dart:developer';

import 'package:ShoolManagementSystem/src/screens/branch_details.dart';
import 'package:ShoolManagementSystem/src/screens/office_details.dart';
import 'package:ShoolManagementSystem/src/screens/organization_details.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../auth.dart';
import '../data.dart';
import '../routing.dart';
import '../screens/sign_in.dart';
import '../widgets/fade_transition_page.dart';
import 'author_details.dart';
import 'book_details.dart';
import 'employee_details.dart';
import 'address_type_details.dart';
import 'job_band_details.dart';
import 'scaffold.dart';

/// Builds the top-level navigator for the app. The pages to display are based
/// on the `routeState` that was parsed by the TemplateRouteParser.
class SMSNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const SMSNavigator({
    required this.navigatorKey,
    super.key,
  });

  @override
  State<SMSNavigator> createState() => _SMSNavigatorState();
}

class _SMSNavigatorState extends State<SMSNavigator> {
  final _signInKey = const ValueKey('Sign in');
  final _scaffoldKey = const ValueKey('App scaffold');
  final _bookDetailsKey = const ValueKey('Book details screen');
  final _authorDetailsKey = const ValueKey('Author details screen');
  final _employeeDetailsKey = const ValueKey('Employee details screen');
  final _addressTypeDetailsKey = const ValueKey('Adress Type details screen');
  final _organizationDetailsKey = const ValueKey('Organization details screen');
  final _branchDetailsKey = const ValueKey('Branch details screen');
  final _officeDetailsKey = const ValueKey('Offices details screen');
  final _jobBandsDetailsKey = const ValueKey('Job Bands details screen');

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    final authState = SMSAuthScope.of(context);
    final pathTemplate = routeState.route.pathTemplate;

    Book? selectedBook;
    if (pathTemplate == '/book/:bookId') {
      selectedBook = hrSystemInstance.allBooks.firstWhereOrNull(
          (b) => b.id.toString() == routeState.route.parameters['bookId']);
    }

    Author? selectedAuthor;
    if (pathTemplate == '/author/:authorId') {
      selectedAuthor = hrSystemInstance.allAuthors.firstWhereOrNull(
          (b) => b.id.toString() == routeState.route.parameters['authorId']);
    }

    Employee? selectedEmployee;
    if (pathTemplate == '/employee/:employeeId') {
      selectedEmployee = hrSystemInstance.allEmployees?.firstWhereOrNull(
          (e) => e.id.toString() == routeState.route.parameters['employeeId']);
    }

    AddressType? selectedAddressType;
    if (pathTemplate == '/address_type/:id') {
      selectedAddressType = hrSystemInstance.addressTypes?.firstWhereOrNull(
          (at) => at.id.toString() == routeState.route.parameters['id']);
    }

    Organization? selectedOrganization;
    if (pathTemplate == '/organization/:id') {
      selectedOrganization = hrSystemInstance.organizations?.firstWhereOrNull(
          (organization) =>
              organization.id.toString() == routeState.route.parameters['id']);
    }

    Office? selectedOffice;
    if (pathTemplate == '/office/:id') {
      selectedOffice = hrSystemInstance.offices?.firstWhereOrNull((office) =>
          office.id.toString() == routeState.route.parameters['id']);
    }

    Branch? selectedBranch;
    if (pathTemplate == '/branch/:id') {
      selectedBranch = hrSystemInstance.branches?.firstWhereOrNull((branch) =>
          branch.id.toString() == routeState.route.parameters['id']);
    }

    JobBand? selectedJobBand;
    if (pathTemplate == '/job_band/:id') {
      selectedJobBand = hrSystemInstance.jobBands?.firstWhereOrNull(
          (jb) => jb.id.toString() == routeState.route.parameters['id']);
    }

    if (pathTemplate == '/#access_token') {
      log('Navigator $routeState.route.parameters.toString()');
      log('Navigator $routeState.route.queryParameters.toString()');
    }

    return Navigator(
      key: widget.navigatorKey,
      onPopPage: (route, dynamic result) {
        // When a page that is stacked on top of the scaffold is popped, display
        // the /books or /authors tab in SMSScaffold.
        if (route.settings is Page &&
            (route.settings as Page).key == _bookDetailsKey) {
          routeState.go('/books/popular');
        }

        if (route.settings is Page &&
            (route.settings as Page).key == _authorDetailsKey) {
          routeState.go('/authors');
        }

        if (route.settings is Page &&
            (route.settings as Page).key == _employeeDetailsKey) {
          routeState.go('/employees/popular');
        }

        if (route.settings is Page &&
            (route.settings as Page).key == _addressTypeDetailsKey) {
          routeState.go('/address_types/popular');
        }

        if (route.settings is Page &&
            (route.settings as Page).key == _organizationDetailsKey) {
          routeState.go('/organizations/popular');
        }

        if (route.settings is Page &&
            (route.settings as Page).key == _branchDetailsKey) {
          routeState.go('/branches/popular');
        }

        if (route.settings is Page &&
            (route.settings as Page).key == _officeDetailsKey) {
          routeState.go('/offices/popular');
        }

        if (route.settings is Page &&
            (route.settings as Page).key == _jobBandsDetailsKey) {
          routeState.go('/job_bands/popular');
        }

        return route.didPop(result);
      },
      pages: [
        if (routeState.route.pathTemplate == '/signin')
          // Display the sign in screen.
          FadeTransitionPage<void>(
            key: _signInKey,
            child: SignInScreen(
              onSignIn: (credentials) async {
                var signedIn = await authState.signIn(
                    credentials.username, credentials.password);
                if (signedIn) {
                  await routeState.go('/books/popular');
                }
              },
            ),
          )
        else ...[
          // Display the app
          FadeTransitionPage<void>(
            key: _scaffoldKey,
            child: const SMSScaffold(),
          ),
          // Add an additional page to the stack if the user is viewing a book
          // or an author
          if (selectedBook != null)
            MaterialPage<void>(
              key: _bookDetailsKey,
              child: BookDetailsScreen(
                book: selectedBook,
              ),
            )
          else if (selectedAuthor != null)
            MaterialPage<void>(
              key: _authorDetailsKey,
              child: AuthorDetailsScreen(
                author: selectedAuthor,
              ),
            )
          else if (selectedEmployee != null)
            MaterialPage<void>(
              key: _employeeDetailsKey,
              child: EmployeeDetailsScreen(
                employee: selectedEmployee,
              ),
            )
          else if (selectedAddressType != null)
            MaterialPage<void>(
              key: _addressTypeDetailsKey,
              child: AddressTypeDetailsScreen(
                addressType: selectedAddressType,
              ),
            )
          else if (selectedOrganization != null)
            MaterialPage<void>(
              key: _organizationDetailsKey,
              child: OrganizationDetailsScreen(
                organization: selectedOrganization,
              ),
            )
          else if (selectedBranch != null)
            MaterialPage<void>(
              key: _branchDetailsKey,
              child: BranchDetailsScreen(
                branch: selectedBranch,
              ),
            )
          else if (selectedOffice != null)
            MaterialPage<void>(
              key: _officeDetailsKey,
              child: OfficeDetailsScreen(
                office: selectedOffice,
              ),
            )
          else if (selectedJobBand != null)
            MaterialPage<void>(
              key: _jobBandsDetailsKey,
              child: JobBandDetailsScreen(
                jobBand: selectedJobBand,
              ),
            ),
        ],
      ],
    );
  }
}
