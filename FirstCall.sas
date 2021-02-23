/* Connection parameters to REST API */



%let protocol = https;
%let endpoint = in.coosto.com/api/1;
%let login = users/login;

/*** 

Replace with your own username and password 

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

libname opendata JSON fileref=result;
proc copy in=opendata out=work;run;

