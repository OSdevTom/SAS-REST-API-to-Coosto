/* Connection parameters to REST API, and include executes an extra sas statement that containts username and password */

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
    url = cats("&protocol","://","&endpoint","/","&login", "?username=&username%nrstr(&password)=&password");
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

/*parse temp file from json into sas datasets*/

libname opendata JSON fileref=result;

/*creates three files in your work library; root, data and alldata */

proc copy in=opendata out=work;run;

/* the file work.data contains a column sessionid that includes the session cookie"*/

data _NULL_;
	set work.data;
	if _N_ = 1 THEN DO;
		CALL SYMPUT('session',sessionid);
	END;
run;

%put &session;
	


