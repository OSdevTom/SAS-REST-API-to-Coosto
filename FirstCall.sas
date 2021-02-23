/* Connection parameters to REST API */
/*
%let protocol = https;
%let endpoint = xxx;
%let api_key = xxx;
%let query_param = symbol;
%let param_value = AAPL;
*/

%let protocol = https;
%let endpoint = opendata.ecdc.europa.eu/covid19/casedistribution/json;

/* Construct URL to get data */
data _NULL_;
	length url $ 2048.;
    url = cats("&protocol","://","&endpoint","?token=","&api_key","&","&query_param","=","&param_value");
    call symputx('url',url);
	put url;
run;

/* Save resulting JSON and make the REST API call */
filename result "/srv/nfs/kubedata/compute-landingzone/result.json";
proc http
	url="%superq(url)"
	method="GET"
	out=result;
run;

libname opendata JSON fileref=result;
proc copy in=opendata out=work;run;

