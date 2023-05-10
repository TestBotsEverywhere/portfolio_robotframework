*** Settings ***
Documentation
...     This resource file is designed to provide a centralized repository
...     of reusable keywords that can be utilized across all test cases in
...     the test automation project. By using a resource file,
...     the test scripts can remain modular and maintainable,
...     promoting better organization and reducing duplication of code.
Resource            elements.resource
Library             Browser

*** Keywords ***
Open Demoqa To ${page} Page
    New Browser                 headless=false
    Set Browser Timeout         20
    New Page                    https://demoqa.com/${DEMOGA_PAGES}[${page}]
    Wait For Elements State     ${MAIN_HEADER}              visible
    Get Text                    ${MAIN_HEADER}      ==      ${PAGE_VERIFICATION_ELEMENTS}[${page}]

At ${page} Page Click ${what}
    Click    ${ELEMENTS ${page} PAGE}[${what}]