/* ==========================================================================  */
/* SECTION -6 : Use SAS Function to manipulate character & numeric data value  */
/* ==========================================================================  */
/* 1.  Character to numeric conversion */
/* 2.  Numeric to character conversion */
/* 3.  Scan function - Extracting part of a string at aspecific location*/
/* 4.  SUBSTR Function - EXTRACTING a substring from the string*/
/* 5.  SUBSTR Function - REPLACING a substring from the string*/
/* 6.  TRIM(removes tarling space) & CATX Function(removes trailing and leading space from )*/
/* 7.  Index funtion - Searches a string in a string and returns it's index*/
/* 8.  Lowcase, Ucase & Propcase */
/* 9.  TRANWRD - replaces or removes an occurence of string in a string*/
/* 10. INT & ROUND Function*/
/* 11. Coding Exercise */
/* ==========================================================================  */

%let path = /folders/myshortcuts/datasets/Data_201902/ ;

PROC IMPORT DATAFILE = "&path.Convert Data" dbms=xlsx replace out=score_data0;
run;

/* ---------------------------------- */
/* 1. Character to numeric conversion */
/* ---------------------------------- */
data score_data1;
	set score_data0;
	score_ac = raw_score*1;
	score_num = input(raw_score, 7.);
run;

/* ---------------------------------- */
/* 2. Numeric to character conversion */
/* ---------------------------------- */
data scoredata2;
	set score_data0;
	gender_ac = gender|| '/' ||gender_code; /*auto*/
	gender_char = put(gender_code, 8.);
run;

/* ---------------------------------------------------------------- */
/* 3. Using Scan function to search for a particular part of string */
/* ---------------------------------------------------------------- */
PROC IMPORT DATAFILE = "&path.Chara_data" dbms=xlsx replace out=score_data0;
run;

data scoredata2;
	set score_data0;
	last_name = SCAN(full_name, 1, ',: ');
run;

proc print data=scoredata2;
run;

/* ------------------------------------------------------------*/
/* 4.  SUBSTR Function - EXTRACTING a substring from the string*/
/* ------------------------------------------------------------*/
PROC IMPORT DATAFILE = "&path.Chara_data1" dbms=xlsx replace out=score_data0;
run;

DATA score_data1;
	set score_data0;
	Exchange = SUBSTR(phone, 1, 3);  /* EXTRACT */
RUN;

/* ------------------------------------------------------------*/
/* 5.  SUBSTR Function - REPLACING a substring from the string */
/* ------------------------------------------------------------*/
DATA score_data2;
	set score_data1;
	if Exchange = '000' then SUBSTR(phone, 1, 3)='408'; /* REPLACE */
RUN;

/* ------------------------------------------------------------*/
/* 6.  TRIM & CATX Function*/
/* ------------------------------------------------------------*/
PROC IMPORT DATAFILE = "&path.Chara_data" dbms=xlsx replace out=score_data0;
run;

data score_data1;
	set score_data0;
	last_name = SCAN(full_name, 1, ',: ');
	first_name = SCAN(full_name, 2, ',: ');
run;

/* Trim removes the trailing space */
/* CATX takes two strings as input removes leading & trailing spaces  and puts a separator provided in first argument*/
data score_data2;
	set score_data1;
	student_name1 =  trim(last_name) || ', ' || trim(first_name);
	
	length student_name2 $25.;
	student_name2 = catx(', ', last_name, first_name);
run;

/* ------------------------------------------------------------*/
/* 7.  Index*/
/* ------------------------------------------------------------*/
PROC IMPORT DATAFILE = "&path.Chara_data1" dbms=xlsx replace out=score_data0;
run;

data score_data1;
	set score_data0;
	index_num = index(phone, '408');
run;

/* ------------------------------------------------------------*/
/* 8.  Lowcase, Ucase & Propcase*/
/* ------------------------------------------------------------*/

data score_data1;
	set score_data0;
	up_name = upcase(full_name);
	low_name = lowcase(full_name);
	prop_name = propcase(full_name);
run;

/* --------------------------------------------------------------------*/
/* 9.  TRANWRD - replaces or removes an occurence of string in a string*/
/* --------------------------------------------------------------------*/
PROC IMPORT DATAFILE = "&path.Chara_data1" dbms=xlsx replace out=score_data0;
run;

data score_data1;
	set score_data0;
	length phone_update $10.;
	phone_update = TRANWRD(phone, '000', '408');
run;

/* --------------------------------------------------------------------*/
/* 10.  INT & ROUND function*/
/* --------------------------------------------------------------------*/

PROC IMPORT DATAFILE = "&path.score_data" dbms=xlsx replace out=score_data0;
run;

data score_data1;
	set score_data0;
	average_score = mean(score1, score2, score3);
	avg_score_INT = INT(average_score);
	avg_score_round0 = Round(average_score, .1);
	avg_score_round1 = Round(average_score, .01);
run;

/* --------------------------------------------------------------------*/
/* 11.  Coding Exercise*/
/* --------------------------------------------------------------------
chara_data2.xlsx; variable DOB is a character var in this data set.
Instruction:

1. creating new vars DOB_year, DOB_month, DOB_day by
Extracting year and day from var DOB using Scan function
Extracting month from var DOB using Substr function

2. creating new vars DOB_new1, DOB_new2 by concatenating
vars DOB_year, DOB_month, DOB_day using TRIM and CATX function
the new values will be in the form of 2007, 9, 23

3. Using Tranwrd function to replace 'missing' with ' 'in var raw_score

4. Using Index function to search for 2007 in the values of DOB,
then to create a subset data CD2 */

PROC IMPORT DATAFILE = "&path.Chara_data2" dbms=xlsx replace out=score_data0;
run;
/*1. */
DATA scoredata1;
	set score_data0;
	DOB_year = SCAN(DOB, 3, '/');
	DOB_day = SCAN(DOB, 2, '/' );
	DOB_Month = substr(DOB, 1, 1);
run;

/*2.  */
DATA scoredata2;
	set scoredata1;
	DOB_new1 = trim (DOB_year) || ',' || trim(DOB_Month) || ',' || trim(DOB_day);
	DOB_new2 = catx(',', DOB_year, DOB_Month, DOB_day);
run;

/*3.  */
data score_data1;
	set score_data0;
	length phone_update $10.;
	raw_score = TRANWRD(raw_score, 'missing', ' ');
run;

/*4.   */
DATA CD2;
	set score_data0;
	where index(DOB, '2007') NE 0;
run;






































