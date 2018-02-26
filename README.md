This is a refactoring of [John Gruber’s Title Case program](http://daringfireball.net/2008/05/title_case), which also includes a universal test suite containing all the test cases listed by John.

The test suite is provided in the form of a Perl script called `test.pl` which expects to be passed a command line for invoking a program that performs titlecasing. E.g. to test the provided `titlecase` itself:

````
perl test.pl ./titlecase
````

The program under test should work like John’s: it should read any number of titles from standard input, one title per line, and write the case-corrected titles to standard output in the same form.
