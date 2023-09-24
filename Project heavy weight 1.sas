%macro impCla(Var1);
proc import datafile="/home/u62978370/sasuser.v94/Guided_assignment//&Var1..xlsx"
dbms=xlsx out= &Var1.class;
getnames=Yes;
run;
proc sort data= &Var1.class;
by name;
run;
%mend;
%impCla(HIST);
%impCla(STAT);
%impCla(STUDHT);

Data Class;
set HISTclass STATclass;
by name;
run;

Data Class_merged;
merge Class STUDHTclass;
by name;
weight_KG = weight * 0.454 ;
Height_M = Height * 2.54/100;
BMI = weight_KG/(Height_M * Height_M);
if BMI < 18 then STATUS="Underweight";
if BMI >= 18 and BMI < 20 then STATUS="Healthy";
if BMI >= 20 and BMI < 22 then STATUS="Overweight";
if BMI >= 22 then STATUS="Obese";
drop weight Height;
run;

proc chart data=Class_merged;
pie STATUS;
run;