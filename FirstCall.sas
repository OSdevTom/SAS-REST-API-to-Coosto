filename folders temp;
proc http
    url = "https://xxx.sas.com/folders/folders"
    out= folders
    oauth_bearer = sas_services;
    headers
        'Accept'= 'application/vnd.sas.collection+json';
run;
libname folders clear;
libname folders json;
