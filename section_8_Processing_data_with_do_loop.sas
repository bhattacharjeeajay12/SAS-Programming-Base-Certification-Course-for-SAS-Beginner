/* ================================================ */
/* SECTION -8 : Process data using do loop  */
/* ===============================================  */
/* 1. Constructing Do Loops - Part-1 */
/* 2. Constructing Do Loops - Part-2 - Using Output */
/* 3. Conditionally Executing Do Loops using Do Loops using Do Until and Do While*/
/* 4. Using Conditional Clause with the iterative Do Statement*/
/* 5. Quiz*/
/* ===============================================  */

%let path = /folders/myshortcuts/datasets/Data_201902/ ;

PROC IMPORT DATAFILE = "&path.SAS date" dbms=xlsx replace out=score_data0;
run; 

/*-------------------------------------------*/
/* 1. Constructing Do Loops - Part-1 */
/*-------------------------------------------*/
data earning1;
	interest = 0.375;
	total=100;
	
	year + 1;
	total + interest * Total;
	
	year + 1;
	total + interest * Total;
	
	year + 1;
	total + interest * Total;
	
	format total dollar10.2;
run;

data earning2;
	interest = 0.375;
	total=100;
	do year=1 to 3;
		total = total*interest;
	end;
	format total dollar10.2;
run;

data earning3 (drop=counter);
	interest = 0.375;
	total=100;
	do counter=1 to 3;
		total = total*interest;
		year+1;
		output;
	end;
	format total dollar10.2;
run;

/*-------------------------------------------*/
/* 2. Constructing Do Loops - Part-2 - Using Output */
/*-------------------------------------------*/
data earning3;
	interest = 0.375;
	total=100;
	do year=1 to 3;
		total = total*interest;
		output;
	end;
	format total dollar10.2;
run;

/*-------------------------------------------------------------------------------*/
/* 3. Conditionally Executing Do Loops using Do Loops using Do Until and Do While*/
/*-------------------------------------------------------------------------------*/

/*want to know how many years it will take to earn $50,000 
if you deposit $2,000 each year into an account that earns 10% interest. 
The DATA step below uses a DO UNTIL statement to perform 
the calculation until $50,000 is reached. Each iteration of 
the DO loop represents one year.*/

data invest;
	do until(capital>=50000);
		capital + 2000;
		capital + capital*0.10;
		year+1;
	end;
run;


/*During each iteration of the DO loop,
	2000 is added to the value of Capital to reflect the annual deposit 
of $2,000
	10% interest is added to Capital
	the value of Year is incremented by 1.
Because there is no index variable in the DO UNTIL statement, 
the variable Year is created in a sum statement 
to count the number of iterations of the DO loop. 
This program produces a data set that contains the single observation. 
To accumulate more than $50,000 in capital requires 13 years 
(and 13 iterations of the DO loop). */
/*DO WHILE*/
data invest;
   do while(Capital>=50000);
      capital+2000;
      capital+capital*.10;
      Year+1;
   end;
run;
/*in this program, because the value of Capital is initially zero, 
which is less than50,000, the DO loop does not execute.*/


/*-------------------------------------------------------------------------------*/
/* 4. Using Conditional Clause with the iterative Do Statement*/
/*-------------------------------------------------------------------------------*/
/*Using Conditional Clauses with the Iterative DO Statement*/

/*In this DATA step, 
Suppose I want to limit the number of years I 
invest my capital to 10 years. And Add the UNTIL expression
to deternime years it takes for an investment to reach $50,000)
to further control the number of iterations. 

This iterative DO statement enables you to execute the DO loop 
until Capital is greater than or equal to 50000 or until 
the DO loop executes ten times, whichever occurs first.*/

data invest;
   do year=1 to 10 until(Capital>=50000);
      capital+2000;
      capital+capital*.10;
      output;
   end;
   if year=11 then year=10;
run;
/*In this case, the DO loop stops executing after ten iterations, 
and the value of Capital never reaches 50000. */


data invest;
   do year=1 to 10 until(Capital>=50000);
      capital+4000;
      capital+capital*.10;
      output;
   end;
   if year=11 then year=10;
run;

/*If you increase the amount added to Capital each year to 4000,
 the DO loop stops executing after the eighth iteration 
 when the value of Capital exceeds 50000.*/

/*=========================================================================*/
/*
Coding Exercise

1. compute each year's salary you will have
if you start with $60,000 at a 3% increase rate per year for 5 years.
2. Conditionally Executing DO Loops:
how many years it will take the salary to reach $100,000 per year
if the salary increase 3% each year, again the initial salary is $60,000.*/
/*=========================================================================*/

data invest;
   salary = 60000;
   output;
   do year=1 to 5 ;
      salary + salary *.3;
      output;
   end;
   if year=6 then year=5;
run;

data invest;
	salary = 60000;
	year = 1;
	output;
	do while(salary<100000);
		salary + salary *.3;	
		year = year+1;
		output;
	end;
run;




























	
	
