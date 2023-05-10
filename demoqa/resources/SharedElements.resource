*** Settings ***
Documentation
...     This resource file is designed to provide a centralized repository
...     variables and elements that can be utilized across all test cases in
...     the test automation project. By using a resource file,
...     the test scripts can remain modular and maintainable,
...     promoting better organization and reducing duplication of code.
Resource        keywords.resource


*** Variables ***
${MAIN_HEADER}
...     //div[@class="main-header"]
&{DEMOGA PAGES}
...     Text Box=text-box
&{PAGE VERIFICATION ELEMENTS}
...     Text Box=Text Box