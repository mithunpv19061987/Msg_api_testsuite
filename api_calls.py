import requests
import json
from requests.packages.urllib3.exceptions import InsecureRequestWarning,SNIMissingWarning, InsecurePlatformWarning
requests.packages.urllib3.disable_warnings(InsecureRequestWarning)
requests.packages.urllib3.disable_warnings(InsecurePlatformWarning)
requests.packages.urllib3.disable_warnings(SNIMissingWarning)


def send_message_to_number(auth_id="",auth_token="",src="",dst="",msg=""):
    msg_details = {}
    authorise=(auth_id,auth_token)
    msg_details='{\"src\":'+str(src)+','+'\"dst\":'+str(dst)+','+'\"text\":'+'\"'+msg+'\"'+'}'
    print(msg_details)
    msgurl="https://api.plivo.com/v1/Account/"+auth_id+"/Message/"
    print (msgurl)
    s=requests.post(msgurl,msg_details,auth=authorise,headers={"content-type":"application/json"},verify=False)
    print (s.json(),s.status_code)
    return s.json()

def get_message_details(auth_id="",auth_token="",msg_uuid=""):
    authorise=(auth_id,auth_token)
    msgdeturl="https://api.plivo.com/v1/Account/"+auth_id+"/Message/"+msg_uuid+"/"
    print (msgdeturl)
    s=requests.get(msgdeturl,auth=authorise,headers={"content-type":"application/json"},verify=False)
    print (s.json(),s.status_code)
    return s.json()

def get_outbound_rate(auth_id="",auth_token="",cntiso=""):
    authorise=(auth_id,auth_token)
    msgrateurl="https://api.plivo.com/v1/Account/"+auth_id+"/Pricing/"+cntiso
    print (msgrateurl)
    s=requests.get(msgrateurl,auth=authorise,headers={"content-type":"application/json"},verify=False)
    print (s.json(),s.status_code)
    return s.json()

def get_acc_detail_rate(auth_id="",auth_token=""):
    authorise=(auth_id,auth_token)
    accurl="https://api.plivo.com/v1/Account/"+auth_id+"/"
    s1=requests.get(accurl,auth=authorise,headers={"content-type":"application/json"},verify=False)
    return s1.json()

    
    
