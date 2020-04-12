/* =============================  */
/* SECTION -4 : WORK WITH DATA    */
/* =============================  */
/* 1. use of infile  */
/* 2. use of if then else */
/* 3. use of format for variables creted later in data step */
/* 4. Subsetting data - with if */
/* 5. Subsetting data - with delete */
/* 6. Creating 1-D Array */
/* 7. QUIZ - SAS Code Execise */
/* =============================  */

%let path = /folders/myshortcuts/datasets/Data_201902/ ;
%put "&path.score_data";

/* ------------------- */
/* 1. Use of Infile */
/* ------------------- */
proc import datafile = "&path.score_data_miss" dbms=xlsx replace out=score_data_0;
run;

/* ------------------- */
/* 2. use of if then else */
/* ------------------- */
Data score_data_1;
	set score_data_0;
	total_score = sum(score1, score2, score3);
	avg_score = mean(score1, score2, score3);
run;

Data score_data_if_then;
	set work.score_data_0;
	/* Score sum	 */
	total_score = sum(score1, score2, score3);
	
	/* Score Average	 */
	avg_score = mean(score1, score2, score3);
	
	/* Gender code	 */
	if gender="m" then gender_code = 1;
	
	/* 	Take */
	if score1 NE . and score2 NE . and score3 NE . then take = "complete";
	
	/* Grade & Pass	 */
	if avg_score >= 90 then do;
		grade = "A";
		pass = "pass";
	end;
run;

/* --------------------------------- */
/* 3. use of format for variables creted later in data step */
/* --------------------------------- */
Data score_data_if_then;
	set work.score_data_0;
	/*change the format of gender_code, grade, pass, */
	format gender_code $char7.;
	format grade $char7.;
	format pass $char7.;
	format take $char12.;
	/* Score sum	 */
	total_score = sum(score1, score2, score3);

	/* Score Average	 */
	avg_score = mean(score1, score2, score3);
	
	/* Gender code	 */
	if gender="m" then gender_code = 1;
	else if gender="f" then do
		gender_code = 2;
	end;
	else do;
		gender_code = "missing";
	end;
	
	/* 	Take */
	if score1 NE . and score2 NE . and score3 NE . then take = "complete";
	else take = "incomplete";
	/* Grade & Pass	 */
	if avg_score >= 90 then do;
		grade = "A";
		pass = "pass";
	end;
	else if avg_score >= 80 then do;
		grade = "B";
		pass = "pass";
	end;
	else if avg_score >= 70 then do;
		grade = "C";
		pass = "pass";
	end;
	else if avg_score >= 60 then do;
		grade = "D";
		pass = "pass";
	end;
	else if 0 <= avg_score < 60 then do;
		grade = "F";
		pass = "pass";
	end;
	else do;
		grade = "missing";
		pass = "missing";
	end;
run;

proc freq data=score_data_if_then;
	tables gender_code / nocum nopercent missing;
run;

/* ---------------------------- */
/* 4. Subsetting data - with if */
/* ---------------------------- */
data sustet_if;
	set score_data_if_then;
	if take ='complete';
run;

/* ---------------------------- */
/* 5. Subsetting data - with delete */
/* ---------------------------- */
data sustet_delete;
	set score_data_if_then;
	if take EQ 'incomplete' then delete;
run;


/* ---------------------------- */
/* 6. One_D Array in SAS */
/* ---------------------------- */

proc import datafile = "&path.score_data_miss999" dbms=xlsx replace out=score_data_miss999;
run;

data scoredata1;
	set score_data_miss999;
	ARRAY score_var(3) score1 score2 score3;
	Do i=1 to 3;
		if score_var(i)=999 then score_var(i)=.;
	END;
run;

/* ---------------------------- */
/* 7. QUIZ SAS Code exercise */
/* ---------------------------- */
proc import datafile = "&path.score_data_miss777" dbms=xlsx replace out=score_data0;
run;

Data score_data1;
	set score_data0;
	Array score_var(3) score1 score2 score3;
	Array NS(3) NS1 NS2 NS3;
	
	do i = 1 to 3;
		if score_var(i) EQ 777 then NS(i)=.;
		else NS(i)=score_var(i);
	END;
	
	avg_score = mean(NS1, NS2, NS3);
run;

proc print data=score_data1;
run;

   



