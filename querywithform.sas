
%let protocol = https;
%let endpoint = in.coosto.com/api/1;



/* Construct URL to get data, includes the session id that you created by executing login.sas */

/*data _NULL_;
	length url $ 2048.;
    url = cats("&protocol","://","&endpoint","/savedqueries/get_all", "?sessionid=&session");
    call symputx('url',url);
	put url;
run;

/* Save resulting JSON and make the REST API call */
filename qry temp;

%let username = coostoapi@sas.com;
%let password = 28uNzDBqd@Di1;

proc http
	url="https://in.coosto.com/api/1/login/users"
	method=get
	in = form ("username"="&username"
			"password"="&password")
	out=qry;
run;


%put &session;

proc http
	url="https://in.coosto.com/api/1/savedqueries/get_all"
	query= ("session"="&session")
	method=get
	out=qry;
run;


libname opendata JSON fileref=qry;

/*creates files in your work library */

proc copy in=opendata out=work;run;