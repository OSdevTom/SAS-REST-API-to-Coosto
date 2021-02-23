/* Connection parameters to REST API */

%let protocol = https;
%let endpoint = in.coosto.com/api/1;
%let login = users/login;


%include '/srv/nfs/kubedata/compute-landingzone/sbxtot/PasswordandUser_Coosto.sas';


/*** 
In this SAS file, I have the following 2 lines of code 

%let username = abc@abc.com;
%let password = Password123;
***/


/* Construct URL to get data */
data _NULL_;
	length url $ 2048.;
    url = "https://in.coosto.com/api/1/users/login?username=&username%nrstr(&password)=&password";
    call symputx('url',url);
	put url;
run;

/* Save resulting JSON and make the REST API call */
filename result temp;
proc http
	url="%superq(url)"
	method="GET"
	out=result;
run;

/*parse temp file from json into sas dataset*/

libname opendata JSON fileref=result;

/*creates three files in your work library*/

proc copy in=opendata out=work;run;

