*** Variables***
${testsRootFolder}  ${CURDIR}
${src_number}    ${sr}
${dst_number}    ${ds} 
${msg_content}   ${ms}
${auth_id}      ${autid}
${auth_token}    ${auttoken}
${country_iso}    ${cntryiso}

*** Settings ***

Library  ${testsRootFolder}\\api_calls.py
Variables  ${testsRootFolder}\\config.py
 



*** Test Cases ***
Send Message From Source to Destination
    [Documentation]    send an sms from source to destination
    [Tags]   TLID-Send_message
    ${acc_json}  get_acc_detail_rate      auth_id=${auth_id}  auth_token=${auth_token}
    ${msg_json}  send_message_to_number   auth_id=${auth_id}  auth_token=${auth_token}  src=${src_number}   dst=${dst_number}   msg=${msg_content}
    Set Global Variable   ${msg_id}   ${msg_json['message_uuid'][0]}
    Set Global Variable   ${acc_pre_rate}   ${acc_json['cash_credits']}
    Log   ${msg_id}
    
Get Message Detail From msg_uuid
    [Documentation]    Get Message Detail from uuid
    [Tags]   TLID-Get Msg detail
    ${msgdet_json}   get_message_details   auth_id=${auth_id}   auth_token=${auth_token}   msg_uuid=${msg_id}
    Set Global Variable    ${msgdet_rate_json}   ${msgdet_json['total_rate']}
   Log   ${msgdet_rate_json}
    
Get rate of Message Outbound rate
    [Documentation]    Get rate of Mesage which is outbound rate
    [Tags]   TLID-Get rate
    ${msgrate_json}   get_outbound_rate   auth_id=${auth_id}   auth_token=${auth_token}   cntiso=${country_iso}
    Set Global Variable   ${msg_outbound_rate}    ${msgrate_json['message']['outbound']}
    Log    ${msg_outbound_rate}

Verify rate and the price deducted are same
    [Documentation]    To Verify rate and the price are same
    [Tags]   TLID-verify rate
    Set Test Variable   ${deducted_rate}   ${msgdet_rate_json}
    Set Test Variable   ${rate}   ${msg_outbound_rate['rate']}
    Should Be Equal   ${deducted_rate}  ${rate}

Verify Cash Credit is Less Than deducted amount
    [Documentation]    To Verify Cash credit is less than deducted amount
    [Tags]   TLID-verify cash credit
    ${acc1_json}  get_acc_detail_rate      auth_id=${auth_id}  auth_token=${auth_token}
    Set Test Variable   ${acc_post_rate}   ${acc1_json['cash_credits']}
    ${status}  Set Variable If   ${acc_pre_rate} > ${acc_post_rate}   ${TRUE}
    Should Be Equal   ${status}  ${TRUE}
    

    





