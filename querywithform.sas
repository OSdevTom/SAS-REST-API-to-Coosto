/*easy */

proc http
	url="https://in.coosto.com/api/1/query/results"
	method=post
	query= ("sessionid"="&session"
			"qid"="46528")
	out=qry;
debug level = 3;
run;


libname opendata JSON fileref=qry;

/*creates files in your work library */

proc copy in=opendata out=work;run;