*** Settings ***
Resource  resource.robot
Suite Setup     Open And Configure Browser
Suite Teardown  Close Browser
Test Setup      Reset Application Create User And Go To Register Page

*** Test Cases ***

Register With Valid Username And Password
    Set Username  tuuli
    Set Password  tuuli123
    Set Password Confirmation  tuuli123
    Submit Credentials
    Registration Should Succeed

Register With Too Short Username And Valid Password
    Set Username  a
    Set Password  asdf1234
    Set Password Confirmation  asdf1234
    Submit Credentials
    Registration Should Fail With Message  Username is too short

Register With Valid Username And Too Short Password
    Set Username  tuuli
    Set Password  a
    Set Password Confirmation  a
    Submit Credentials
    Registration Should Fail With Message  Password is too short

Register With Valid Username And Invalid Password
    Set Username  tuuli
    Set Password  asdfghjk
    Set Password Confirmation  asdfghjk
    Submit Credentials
    Registration Should Fail With Message  Password must contain numbers   

Register With Nonmatching Password And Password Confirmation
    Set Username  tuuli
    Set Password  tuuli123
    Set Password Confirmation  tuuli12
    Submit Credentials
    Registration Should Fail With Message  Password and password confirmation do not match

Register With Username That Is Already In Use
    Set Username  kalle
    Set Password  kalle123
    Set Password Confirmation  kalle123
    Submit Credentials
    Registration Should Fail With Message  User with username kalle already exists

Login After Successful Registration
    Set Username  tuuli
    Set Password  tuuli123
    Set Password Confirmation  tuuli123
    Submit Credentials
    Registration Should Succeed
    Logout
    Login Page Should Be Open
    Set Username  tuuli
    Set Password  tuuli123
    Login
    Login Should Succeed

Login After Failed Registration
    Set Username  tuuli
    Set Password  tuuli123
    Set Password Confirmation  tuuli124
    Submit Credentials
    Registration Should Fail With Message  Password and password confirmation do not match
    Try To Login
    Login Page Should Be Open
    Set Username  tuuli
    Set Password  tuuli123
    Login
    Login Should Fail With Message  Invalid username or password    

*** Keywords ***
Submit Credentials
    Click Button  Register

Set Username
    [Arguments]  ${username}
    Input Text  username  ${username}

Set Password
    [Arguments]  ${password}
    Input Password  password  ${password}

Set Password Confirmation
    [Arguments]  ${password_confirmation}
    Input Password  password_confirmation  ${password_confirmation}

Registration Should Fail With Message
    [Arguments]  ${message}
    Register Page Should Be Open
    Page Should Contain  ${message}

Registration Should Succeed
    Welcome Page Should Be Open

Logout
    Click Link  Continue to main page
    Click Button  Logout

Login
    Click Button  Login

Login Should Succeed
    Main Page Should Be Open

Try To Login
    Click Link  Login

Login Should Fail With Message
    [Arguments]  ${message}
    Login Page Should Be Open
    Page Should Contain  ${message}

*** Keywords ***
Reset Application Create User And Go To Register Page
    Reset Application
    Create User  kalle  kalle123
    Go To Register Page
