/* ================================================ */
/* SECTION -7 : Use SAS Function to SAS Date value  */
/* ===============================================  */
/* 1. MDY */
/* 2. YEAR QTR MONTH & DAY Functions */
/* 3. Today Date INTCK Function*/
/* 4. DATEDIF YRDIF  Function*/
/* 5. Quiz */
/* ===============================================  */

%let path = /folders/myshortcuts/datasets/Data_201902/ ;

PROC IMPORT DATAFILE = "&path.SAS date" dbms=xlsx replace out=score_data0;
run;

/* ---------------------------------- */
/* 1. MDY() to create Date */
/* ---------------------------------- */

/* SAS date starts from January 1, 1960 */
data scoredata1;
	set score_data0;
	bdate = MDY(month, day, year);
	fix_date1 = mdy(1, 1, 1960);
	fix_date2 = mdy(8, 31, 2050);
	fix_date3 = mdy(8, 31, 50);
	format bdate date11.;
	format fix_date1 fix_date2 fix_date3 date9.;
run;

proc print data=scoredata1; run;

/* ---------------------------------- */
/* 2. YEAR QTR MONTH & DAY Functions */
/* ---------------------------------- */
data scoredata1;
	set score_data0;
	sdate = start_date;   /* to show the SAS date values for start date */
run;

data score_data2;
	set scoredata1;
	s_qtr = qtr(start_date);
	s_mth = month(start_date);
	s_day = day(start_date);
	s_weekday = WEEKDAY(start_date);
run;

data score_data3;
	set score_data2;
	if s_weekday in (9);
run;

/* ---------------------------------- */
/* 3. Today Date & INTCK    
Today() returns todays date
INTCK - returns mumber of year/month/days between start date and end date            */
/* ---------------------------------- */
%let path = /folders/myshortcuts/datasets/Data_201902/ ;

PROC IMPORT DATAFILE = "&path.SAS date" dbms=xlsx replace out=score_data0;
run;

data score_data1;
	set score_data0;
	today_date_1 = today();
	today_date_2 = date();
	/* intck returns number of years between start_date and today */
	years = intck('year', start_date, today());
	
	/* intck returns number of months between start_date and today */
	months = intck('month', start_date, today());
run;

proc print data=score_data1;
	format today_date_1 date9.;
	format today_date_2 date9.;
run;

/* ------------------------------------------------------------------ */
/* 4. DATEDIF YRDIF  Function*/
/* DATDIF()  returns days between start date and end date*/
/* YRDIF() returns number of years between start date and end date*/
/* ------------------------------------------------------------------ */
data scoredata1;
	set score_data0;
	year_diff1 = YRDIF(start_date, today());
	year_diff2 = YRDIF(start_date, '12Apr2020'd, '30/360');
	year_diff3 = YRDIF(start_date, today(), 'ACT/ACT');
	year_diff4 = YRDIF(start_date, today(), 'ACT/360');
	year_diff5 = YRDIF(start_date, today(), 'ACT/365');
	
	day_diff1 = DATDIF(start_date, today(), '30/360');
	day_diff2 = DATDIF(start_date, '12Apr2020'd, 'ACT/ACT');
Run;

proc print data=scoredata1;run;


/* ---------------------------------- */
/* 5. QUIZ                            */
/* ---------------------------------- */
/*
data:patient_HD.xlsx

instruction:

1. extract the year of patients adminitered to hospital
2. calculate the number of days that patients stayed in hospital in two ways
3. creating a var containing today's date as analysis date
*/

%let path = /folders/myshortcuts/datasets/Data_201902/ ;

PROC IMPORT DATAFILE = "&path.Patient_HD" dbms=xlsx replace out=score_data0;
run;

DATA ABC;
	SET score_data0;
	year_admitted = year(Start_date);
	days_stayed1 = DATDIF(start_date, end_date, 'ACT/ACT');
	days_stayed2 = intck('day', start_date, end_date);
	analysis_date = today();
	format analysis_date date10.;
RUN;




























