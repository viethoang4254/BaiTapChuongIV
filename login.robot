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
    [Documentation]    Kiểm tra đăng nhập với thông tin hợp lệ
    Fill In Login Form    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Submit Login Form
    Verify Successful Login
    Sleep    10s

Login With Invalid Credentials
    [Documentation]    Kiểm tra đăng nhập với thông tin không hợp lệ
    Fill In Login Form    ${INVALID_USERNAME}    ${INVALID_PASSWORD}
    Submit Login Form
    Verify Login Failed
    Sleep    10s

*** Keywords ***
Open Browser To Login Page
    [Documentation]    Mở trình duyệt và điều hướng đến trang đăng nhập
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${USERNAME_FIELD}    30s

Fill In Login Form
    [Documentation]     Điền thông tin vào form đăng nhập
    [Arguments]    ${username}    ${password}
    Input Text    ${USERNAME_FIELD}    ${username}
    Input Text    ${PASSWORD_FIELD}    ${password}

Submit Login Form
    [Documentation]   Nhấn nút đăng nhập
    Click Element    ${LOGIN_BUTTON}

Verify Successful Login
    [Documentation]   Xác minh đăng nhập thành công bằng cách kiểm tra dashboard
    Wait Until Location Contains    /dashboard    30s
    Wait Until Page Contains    ${DASHBOARD_TEXT}    30s

Verify Login Failed
    [Documentation]    Xác minh đăng nhập thất bại bằng cách kiểm tra thông báo lỗi
    Wait Until Page Contains    ${ERROR_MESSAGE}    30s
