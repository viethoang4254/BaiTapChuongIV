*** Settings ***
Documentation    Test cases for login functionality on OrangeHRM
Library          SeleniumLibrary
Test Setup       Open Browser To Login Page
Test Teardown    Close Browser

*** Variables ***
${URL}                https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${BROWSER}            Chrome
${VALID_USERNAME}      Admin
${VALID_PASSWORD}      admin123
${INVALID_USERNAME}    paboz1
${INVALID_PASSWORD}    hoang2004
${USERNAME_FIELD}      xpath=//input[@name='username']
${PASSWORD_FIELD}      xpath=//input[@name='password']
${LOGIN_BUTTON}        xpath=//button[@type='submit']
${DASHBOARD_TEXT}      Dashboard
${ERROR_MESSAGE}       Invalid credentials

*** Test Cases ***
Login With Valid Credentials
    [Documentation]    Verify login with valid credentials
    Fill In Login Form    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Submit Login Form
    Verify Successful Login
    Sleep    10s

Login With Invalid Credentials
    [Documentation]    Verify login with invalid credentials
    Fill In Login Form    ${INVALID_USERNAME}    ${INVALID_PASSWORD}
    Submit Login Form
    Verify Login Failed
    Sleep    10s

*** Keywords ***
Open Browser To Login Page
    [Documentation]    Open browser and navigate to login page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${USERNAME_FIELD}    30s

Fill In Login Form
    [Documentation]    Fill in the login form with username and password
    [Arguments]    ${username}    ${password}
    Input Text    ${USERNAME_FIELD}    ${username}
    Input Text    ${PASSWORD_FIELD}    ${password}

Submit Login Form
    [Documentation]    Click the login button
    Click Element    ${LOGIN_BUTTON}

Verify Successful Login
    [Documentation]    Verify successful login by checking dashboard
    Wait Until Location Contains    /dashboard    30s
    Wait Until Page Contains    ${DASHBOARD_TEXT}    30s

Verify Login Failed
    [Documentation]    Verify login failure by checking error message
    Wait Until Page Contains    ${ERROR_MESSAGE}    30s