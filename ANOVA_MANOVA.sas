ods rtf file='N:\Multivariate Data Analysis DSCI 449\Week 8\ANOVA 1.rtf';
*One way anova;
*sorting data to perform univariate procedure;  
proc sort data=sasuser.hbat200;
   by customer_type200;

*checking assumption of normality;
*checking normality of satisfaction for each level of customer_type;
proc univariate data=sasuser.hbat200 plot normal;
   by customer_type200;
   var satis200;
run;
ods rtf close;

ods rtf file='N:\Multivariate Data Analysis DSCI 449\Week 8\ANOVA 2.rtf';
*One way anova using satis as dep var and customer_type as ind var;
proc glm data=sasuser.hbat200;
   class customer_type200;
   model satis200=customer_type200;
   means customer_type200 /tukey lines hovtest=levene;
run;

ods rtf close;

ods rtf file='N:\Multivariate Data Analysis DSCI 449\Week 8\ANOVA 3.rtf';
*Two-way anova--using satis as dep var and customer_type and firm_size200 as ind var;
proc glm data=sasuser.hbat200;
  class customer_type200 firm_size200;
  model satis200=customer_type200 firm_size200 customer_type200*firm_size200;
  lsmeans customer_type200*firm_size200 /tdiff adjust=tukey;;
run;
ods rtf close;


ods rtf file='N:\Multivariate Data Analysis DSCI 449\Week 8\MANOVA 4.rtf';
*One way Manova on three dep var, 1 ind var--customer_type;
proc glm data=sasuser.hbat200;
   class customer_type200;  
   model satis200 recommend200 future_purch200 = customer_type200;
   manova h=customer_type200; 
   means customer_type200/tukey hovtest=levene; 
   *hovtest is checking for equal variances;
run;
ods rtf close;

ods rtf file='N:\Multivariate Data Analysis DSCI 449\Week 8\TWO_WAY_MANOVA 5.rtf';
*Two-way Manova;
proc glm data=sasuser.hbat200;
   class customer_type200 firm_size200;
   model satis200 recommend200 future_purch200 = customer_type200 firm_size200 customer_type200*firm_size200;
   manova h=customer_type200 firm_size200 customer_type200*firm_size200;
   lsmeans customer_type200 firm_size200 /tdiff out=two;
run;
ods rtf close;



ods rtf file='N:\Multivariate Data Analysis DSCI 449\Week 8\TWO_WAY_MANOVA 6.rtf';
*checking plots of cell means by each independent variable;
proc sgplot data=two;
   xaxis type=discrete;
   scatter y=lsmean x= customer_type200/ markerchar=_name_ group=_name_;

proc sgplot data=two;
   xaxis type=discrete;
   scatter y=lsmean x= firm_size200/ markerchar=_name_ group=_name_;
run;
ods rtf close;
