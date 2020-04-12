/* =======================================  */
/* SECTION -4 : CREATING LABELS AND FORMAT  */
/* =======================================  */
/* 1. Use label statement to add label - In Data Step */
/* 2. Use label statement to add label - In Proc Print Step */
/* 3. Use SAS Built in format to assign format to variable*/
/* 4. User Defined Format */
/* 5. Save SAS formats */
/* 6. Length of a SAS variable */
/* 7. Coding Execrcise - 1 */
/* 8. Coding Execrcise - 2 */
/* =======================================  */
 
%let path = /folders/myshortcuts/datasets/Data_201902/ ;

proc import datafile = "&path.score_data_miss" dbms=xlsx replace out=score_data_0;
run;

/* -------------------------------------------------- */
/* 1. Use label statement to add label - In Data Step */
/* -------------------------------------------------- */
DATA score_data_1;
	set score_data_0;
	label score1 = 'Math Score'
	score2 = 'Science Score'
	score3 = 'English Score';
RUN;

proc print data=score_data_1 label; run;

/* -------------------------------------------------------- */
/* 2. Use label statement to add label - In Proc Print Step */
/* -------------------------------------------------------- */
proc print data=score_data_1 label; 
	label name = 'Student Name';
	/* Scope of label name is only in proc print*/
run;

proc means data=score_data_1;
	var score1;
run;

/* -------------------------------------------------------- */
/* 3. Use Format statement to assign format to variable */
/* -------------------------------------------------------- */
Data score_data_1;
	set score_data_0;
	total_score = sum(score1, score2, score3);
	avg_score = mean(score1, score2, score3);
run;

DATA score_data_2;
	set score_data_1;
	format avg_score 5.2; /* Permanent Format*/
	Title "Permanent Format for Average Score";
run;

Proc print data=score_data_2; 
	Title "Permanent Format for Average Score";
run;

Proc print data=score_data_2; 
	format avg_score 5.1; /* Temorary Format*/
	Title "Temporary Format for Average Score";
run;

/* ------------------------- */
/* 4. User Defined Format */
/* ------------------------- */
proc import datafile = "&path.score_data_miss" dbms=xlsx replace out=score_data_0;
run;


Data score_data_1;
	set score_data_0;
	total_score = sum(score1, score2, score3);
	avg_score = mean(score1, score2, score3);
run;

proc format ;
	value $gender    'm' = 'Male'
	                   'f' = 'Female'
	                   other = 'Missing';
	                   
	value avg_score   0-<60 = 'F'
						60-<70 = 'D'
						70-<80 = 'C'
						80-<90 = 'B'
						90-High = 'A'
						other = 'Missing';	
run;

proc print data = score_data_1;
	format gender $gender. avg_score avg_score.;
	title "Formatted Gender & avg_score";
run;

proc print data=score_data_1;
	title "Unformatted Gender & avg_score";
run;

/* ------------------------- */
/* 5. Save SAS formats */
/* ------------------------- */
libname myFmts "/folders/myshortcuts/datasets/Data_201902/Formats";
proc format library=myfmts.avg_score_gender;
	value $gender    'm' = 'Male'
	                   'f' = 'Female'
	                   other = 'Missing';
	                   
	value avg_score   0-<60 = 'F'
						60-<70 = 'D'
						70-<80 = 'C'
						80-<90 = 'B'
						90-High = 'A'
						other = 'Missing';	
run;

/* Using this code we can include the saved format */
proc format library=myfmts.avg_score_gender fmtlib;
run;
/* After can use the format like this  */
proc print data = score_data_1;
	format gender $gender. avg_score avg_score.;
	title "Formatted Gender & avg_score";
run;

/* In Data step, by using format we can write  */
DATA ABC;
	set score_data_1;
	format gender $gender. avg_score avg_score.;
RUN;

options fmtsearch=(myfmts.avg_score_gender work.avg_score_gender libraray.avg_score_gender);
proc print data = score_data_1;
	format gender $gender. avg_score avg_score.;
	title "Formatted Gender & avg_score";
run;

/* --------------------------- */
/* 6. Length of a SAS variable */
/* --------------------------- */
proc import datafile = "&path.score_data_miss" dbms=xlsx replace out=score_data_0;
run;

DATA score_data_1;
	set score_data_0;
	if gender = 'm' then gender_full = 'Male';
	else if gender = 'f' then gender_full = 'Female';
	else gender_full = 'Missing';
run;

DATA score_data_2;
	set score_data_0;
	length gender_full $7.;
	if gender = 'm' then gender_full = 'Male';
	else if gender = 'f' then gender_full = 'Female';
	else gender_full = 'Missing';
run;
 
proc print data=score_data_1;
Title "Truncated Gender Values";
run;

proc print data=score_data_2;
Title "Complete Gender Values";
run;

/* ----------------------- */
/* 7. Coding Execrcise - 1 */
/* ----------------------- */
/*
1. import sale.xlsx and create SAS data set 'sale0'
2. create data 'sale1' with data step program:
   a. assign labels to:
      emid = employee id
      sale_m1 = sale in Jan.
      sale_m2 = sale in Feb.
      sale_m3 = sale in Mar.

   b. calculate average sale of three months' sales
      and assign format to average sale with $ , commas
      and two decimal placesassign same format to sale_m1, 
      sale_m2 and sale_m3
3. Print data 'sales1' with labels and formats
*/

proc import datafile = "&path.Sale" dbms=xlsx replace out=sale0;
run;

Data sale1;
	set sale0;
	label emid = 'employee id'
	sale_m1 = 'sale in Jan'
	sale_m2 = 'sale in Feb'
	sale_m3 = 'sale in Mar';
	
	average_sales = mean(sale_m1, sale_m2, sale_m3);
	format average_sales sale_m1--sale_m3 dollar10.2;
RUN;

proc print data=sale1 label;
run;

/* ----------------------- */
/* 8. Coding Execrcise - 2 */
/* ----------------------- */
/*
1. Re-run the codes in coding Exercise 1

2. create format 'salegroup' for averagesale with following categories

and store the format in library 'myfmts'

low-<700 = 'need improvement'

700-<900 = 'good'

900-high = 'top sale'

3. in Proc Print: reference/use the format 'salegroup' stored in the Myfmts library

as if in a new SAS session, meaning need to include LIBNAME statement
*/
libname myFmts "/folders/myshortcuts/datasets/Data_201902/Formats";
proc format library=myfmts.sales_group;
	value sales_group low-<700 = 'Need Improvement'
					  700-<900 = 'Good'
					  900-high = 'top sale'
					  other = 'Missing';
run;









