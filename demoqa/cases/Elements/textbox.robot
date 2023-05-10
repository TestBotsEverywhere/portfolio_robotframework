*** Settings ***
Documentation
...     This test script is designed to validate the functionality and user experience
...     of the text boxes on the practice website (https://demoqa.com/), specifically
...     focusing on the Full Name, Email, Current Address, and Permanent Address input fields.
...     The test script ensures that the fields can handle various input scenarios and that
...     the submit button displays the correct output format. Comprehensive plan can be found
...     from here demoqa/task_objectives/ElementsTextBox.txt

Library     Browser
Resource        ../../../demoqa/resources/SharedElements.resource
Resource        ../../../demoqa/resources/SharedKeywords.resource
Suite Setup     Open Demoqa To Text Box Page
Test Teardown   Reload
Force Tags      input

*** Variables ***
&{ELEMENTS TEXT BOX PAGE}
...     Submit=id=submit    Name=id=userName  Email=id=userEmail    Current Address=id=currentAddress   Permanent Address=id=permanentAddress

&{TEXT BOX PAGE NAME INPUTS}
...     Valid=John Doe      Empty=${EMPTY}
...     Too Long=SuchALongNameThatItIsImpossibleToGetThisWholeNameInToSuchSmallSpaceWithoutIsBreakingCompletelyAndCausingsomeKindOfSceneOrWhatnotYouKnowRight

&{TEXT BOX PAGE EMAIL INPUTS}
...     Valid=valid@sovalid.ma        Invalid=invalidemailisinvalid       Empty=${EMPTY}
...     Too Long=SuchALongNameThatItIsImpossibleToGetThisWholeNameInToSuchSmallSpaceWithoutIsBreakingCompletelyAndCausingsomeKindOfScene@OrWhatnotYouKnow.Ri

&{TEXT BOX PAGE CURRENT ADDRESS INPUTS}
...     Valid=Curent Address, 2a         Empty=${EMPTY}
...     Too Long=SuchALongCurrentAddressThatItIsImpossibleToGetThisWholeNameInToSuchSmallSpaceWithoutIsBreakingCompletelyAndCausingsomeKindOfSceneOrWhatnotYouKnowRight

&{TEXT BOX PAGE PERMANENT ADDRESS INPUTS}
...     Valid=Permanent Address, 123         Empty=${EMPTY}
...     Too Long=SuchALongPermanentAddressThatItIsImpossibleToGetThisWholeNameInToSuchSmallSpaceWithoutIsBreakingCompletelyAndCausingsomeKindOfSceneOrWhatnotYouKnowRight

&{ELEMENTS TEXT BOX PAGE OUTPUT}
...     Name=id=name   Email=id=email
...     Current Address=//p[@id="currentAddress"]    Permanent Address=//p[@id="permanentAddress"]
&{OUTPUT FIELD TEXTS}
...     Name=Name:  Email=Email:
...     Current Address=Current Address :   Permanent Address=Permananet Address :

*** Test Cases ***
Test Empty Input Fields
    [Tags]
    At Text Box Page Click Submit
    The Output Field Should Not Contain Anything

Test Input Only In Full Name Field
    At Text Box Page Input Name That Is Valid
    At Text Box Page Click Submit
    The Output Field Should Contain Name That Is Valid

Test Input Only In Email Field Valid
    At Text Box Page Input Email That Is Valid
    At Text Box Page Click Submit
    The Output Field Should Contain Email That Is Valid

Test Input Only In Email Field Invalid
    At Text Box Page Input Email That Is Invalid
    At Text Box Page Click Submit
    The Output Field Should Not Contain Anything

Test Input Only In Current Address Field
    At Text Box Page Input Current Address That Is Valid
    At Text Box Page Click Submit
    The Output Field Should Contain Current Address That Is Valid

Test Input Only In Permanent Address Field
    At Text Box Page Input Permanent Address That Is Valid
    At Text Box Page Click Submit
    The Output Field Should Contain Permanent Address That Is Valid

Test Input In All Fields Valid Email
    At Text Box Page Input Name That Is Valid
    At Text Box Page Input Email That Is Valid
    At Text Box Page Input Current Address That Is Valid
    At Text Box Page Input Permanent Address That Is Valid
    At Text Box Page Click Submit
    The Output Field Should Contain Name That Is Valid
    The Output Field Should Contain Email That Is Valid
    The Output Field Should Contain Current Address That Is Valid
    The Output Field Should Contain Permanent Address That Is Valid

Test Input In All Fields Invalid Email
    At Text Box Page Input Name That Is Valid
    At Text Box Page Input Email That Is Invalid
    At Text Box Page Input Current Address That Is Valid
    At Text Box Page Input Permanent Address That Is Valid
    At Text Box Page Click Submit
    The Output Field Should Not Contain Anything

Test Long Input In All Fields
    At Text Box Page Input Name That Is Too Long
    At Text Box Page Input Email That Is Too Long
    At Text Box Page Input Current Address That Is Too Long
    At Text Box Page Input Permanent Address That Is Too Long
    At Text Box Page Click Submit
    The Output Field Should Contain Name That Is Too Long
    The Output Field Should Contain Email That Is Too Long
    The Output Field Should Contain Current Address That Is Too Long
    The Output Field Should Contain Permanent Address That Is Too Long

*** Keywords ***
The Output Field Should Contain ${what} That Is ${status}
    Get Text    ${ELEMENTS TEXT BOX PAGE OUTPUT}[${what}]   ==   ${OUTPUT FIELD TEXTS}[${what}]${TEXT BOX PAGE ${what} INPUTS}[${status}]

The Output Field Should Not Contain Anything
    Wait Until Network Is Idle
    Get Text    id=output   ==      ${EMPTY}

At ${page} Page Input ${what} That Is ${status}
    Type Text    ${ELEMENTS ${page} PAGE}[${what}]   ${${PAGE} PAGE ${WHAT} INPUTS}[${STATUS}]