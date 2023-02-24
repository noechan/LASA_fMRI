%% Singing performance stats
%load data
clear ()
sing_falsetrials_Tydyy=readtable('sing_perf_ttests_Tydyy.csv');
sing_falsetrials_Tydyy_cell=table2cell(sing_falsetrials_Tydyy);
sing_falsetrials_Tydyy_base_s1=cell2mat(sing_falsetrials_Tydyy_cell(1:19,3));
sing_falsetrials_Tydyy_listen_s1=cell2mat(sing_falsetrials_Tydyy_cell(20:38,3));
sing_falsetrials_Tydyy_singa_s1=cell2mat(sing_falsetrials_Tydyy_cell(39:57,3));
sing_falsetrials_Tydyy_singm_s1=cell2mat(sing_falsetrials_Tydyy_cell(58:76,3));
sing_falsetrials_Tydyy_base_s2=cell2mat(sing_falsetrials_Tydyy_cell(1:19,6));
sing_falsetrials_Tydyy_listen_s2=cell2mat(sing_falsetrials_Tydyy_cell(20:38,6));
sing_falsetrials_Tydyy_singa_s2=cell2mat(sing_falsetrials_Tydyy_cell(39:57,6));
sing_falsetrials_Tydyy_singm_s2=cell2mat(sing_falsetrials_Tydyy_cell(58:76,6));
sing_perf_Tydyy_base_s1=cell2mat(sing_falsetrials_Tydyy_cell(1:19,4));
sing_perf_Tydyy_listen_s1=cell2mat(sing_falsetrials_Tydyy_cell(20:38,4));
sing_perf_Tydyy_singa_s1=cell2mat(sing_falsetrials_Tydyy_cell(39:57,4));
sing_perf_Tydyy_singm_s1=cell2mat(sing_falsetrials_Tydyy_cell(58:76,4));
sing_perf_Tydyy_base_s2=cell2mat(sing_falsetrials_Tydyy_cell(1:19,7));
sing_perf_Tydyy_listen_s2=cell2mat(sing_falsetrials_Tydyy_cell(20:38,7));
sing_perf_Tydyy_singa_s2=cell2mat(sing_falsetrials_Tydyy_cell(39:57,7));
sing_perf_Tydyy_singm_s2=cell2mat(sing_falsetrials_Tydyy_cell(58:76,7));

%hypothesis testing
[h, pbase_falsetrials_Tydyy]=ttest(sing_falsetrials_Tydyy_base_s1, sing_falsetrials_Tydyy_base_s2);
[h, plisten_falsetrials_Tydyy]=ttest(sing_falsetrials_Tydyy_listen_s1, sing_falsetrials_Tydyy_listen_s2);
[h, psinga_falsetrials_Tydyy]=ttest(sing_falsetrials_Tydyy_singa_s1, sing_falsetrials_Tydyy_singa_s2);
[h, psingm_falsetrials_Tydyy]=ttest(sing_falsetrials_Tydyy_singm_s1, sing_falsetrials_Tydyy_singm_s2);

save('ttest_sing_falsetrials_Tydyy.mat', 'pbase_falsetrials_Tydyy','plisten_falsetrials_Tydyy','psinga_falsetrials_Tydyy','psingm_falsetrials_Tydyy')

[h, pbase_perf_Tydyy]=ttest(sing_perf_Tydyy_base_s1, sing_perf_Tydyy_base_s2);
[h, plisten_perf_Tydyy]=ttest(sing_perf_Tydyy_listen_s1, sing_perf_Tydyy_listen_s2);
[h, psinga_perf_Tydyy]=ttest(sing_perf_Tydyy_singa_s1, sing_perf_Tydyy_singa_s2);
[h, psingm_perf_Tydyy]=ttest(sing_perf_Tydyy_singm_s1, sing_perf_Tydyy_singm_s2);

save('ttest_sing_perf_Tydyy.mat', 'pbase_perf_Tydyy','plisten_perf_Tydyy','psinga_perf_Tydyy','psingm_perf_Tydyy')

%load data
clear ()
sing_falsetrials_Uulaa=readtable('sing_perf_ttests_Uulaa.csv');
sing_falsetrials_Uulaa_cell=table2cell(sing_falsetrials_Uulaa);
sing_falsetrials_Uulaa_base_s1=cell2mat(sing_falsetrials_Uulaa_cell(1:19,3));
sing_falsetrials_Uulaa_listen_s1=cell2mat(sing_falsetrials_Uulaa_cell(20:38,3));
sing_falsetrials_Uulaa_singa_s1=cell2mat(sing_falsetrials_Uulaa_cell(39:57,3));
sing_falsetrials_Uulaa_singm_s1=cell2mat(sing_falsetrials_Uulaa_cell(58:76,3));
sing_falsetrials_Uulaa_base_s2=cell2mat(sing_falsetrials_Uulaa_cell(1:19,6));
sing_falsetrials_Uulaa_listen_s2=cell2mat(sing_falsetrials_Uulaa_cell(20:38,6));
sing_falsetrials_Uulaa_singa_s2=cell2mat(sing_falsetrials_Uulaa_cell(39:57,6));
sing_falsetrials_Uulaa_singm_s2=cell2mat(sing_falsetrials_Uulaa_cell(58:76,6));
sing_perf_Uulaa_base_s1=cell2mat(sing_falsetrials_Uulaa_cell(1:19,4));
sing_perf_Uulaa_listen_s1=cell2mat(sing_falsetrials_Uulaa_cell(20:38,4));
sing_perf_Uulaa_singa_s1=cell2mat(sing_falsetrials_Uulaa_cell(39:57,4));
sing_perf_Uulaa_singm_s1=cell2mat(sing_falsetrials_Uulaa_cell(58:76,4));
sing_perf_Uulaa_base_s2=cell2mat(sing_falsetrials_Uulaa_cell(1:19,7));
sing_perf_Uulaa_listen_s2=cell2mat(sing_falsetrials_Uulaa_cell(20:38,7));
sing_perf_Uulaa_singa_s2=cell2mat(sing_falsetrials_Uulaa_cell(39:57,7));
sing_perf_Uulaa_singm_s2=cell2mat(sing_falsetrials_Uulaa_cell(58:76,7));

%hypothesis testing
[h, pbase_falsetrials_Uulaa]=ttest(sing_falsetrials_Uulaa_base_s1, sing_falsetrials_Uulaa_base_s2);
[h, plisten_falsetrials_Uulaa]=ttest(sing_falsetrials_Uulaa_listen_s1, sing_falsetrials_Uulaa_listen_s2);
[h, psinga_falsetrials_Uulaa]=ttest(sing_falsetrials_Uulaa_singa_s1, sing_falsetrials_Uulaa_singa_s2);
[h, psingm_falsetrials_Uulaa]=ttest(sing_falsetrials_Uulaa_singm_s1, sing_falsetrials_Uulaa_singm_s2);

save('ttest_sing_falsetrials_Uulaa.mat', 'pbase_falsetrials_Uulaa','plisten_falsetrials_Uulaa','psinga_falsetrials_Uulaa','psingm_falsetrials_Uulaa')

[h, pbase_perf_Uulaa]=ttest(sing_perf_Uulaa_base_s1, sing_perf_Uulaa_base_s2);
[h, plisten_perf_Uulaa]=ttest(sing_perf_Uulaa_listen_s1, sing_perf_Uulaa_listen_s2);
[h, psinga_perf_Uulaa]=ttest(sing_perf_Uulaa_singa_s1, sing_perf_Uulaa_singa_s2);
[h, psingm_perf_Uulaa]=ttest(sing_perf_Uulaa_singm_s1, sing_perf_Uulaa_singm_s2);

save('ttest_sing_perf_Uulaa.mat', 'pbase_perf_Uulaa','plisten_perf_Uulaa','psinga_perf_Uulaa','psingm_perf_Uulaa')

%load data
clear ()
sing_falsetrials_TU=readtable('sing_perf_ttests_TU.csv');
sing_falsetrials_TU_cell=table2cell(sing_falsetrials_TU);
sing_falsetrials_TU_base_s1=cell2mat(sing_falsetrials_TU_cell(1:19,5));
sing_falsetrials_TU_listen_s1=cell2mat(sing_falsetrials_TU_cell(20:38,5));
sing_falsetrials_TU_singa_s1=cell2mat(sing_falsetrials_TU_cell(39:57,5));
sing_falsetrials_TU_singm_s1=cell2mat(sing_falsetrials_TU_cell(58:76,5));
sing_falsetrials_TU_base_s2=cell2mat(sing_falsetrials_TU_cell(1:19,12));
sing_falsetrials_TU_listen_s2=cell2mat(sing_falsetrials_TU_cell(20:38,12));
sing_falsetrials_TU_singa_s2=cell2mat(sing_falsetrials_TU_cell(39:57,12));
sing_falsetrials_TU_singm_s2=cell2mat(sing_falsetrials_TU_cell(58:76,12));
sing_perf_TU_base_s1=cell2mat(sing_falsetrials_TU_cell(1:19,8));
sing_perf_TU_listen_s1=cell2mat(sing_falsetrials_TU_cell(20:38,8));
sing_perf_TU_singa_s1=cell2mat(sing_falsetrials_TU_cell(39:57,8));
sing_perf_TU_singm_s1=cell2mat(sing_falsetrials_TU_cell(58:76,8));
sing_perf_TU_base_s2=cell2mat(sing_falsetrials_TU_cell(1:19,15));
sing_perf_TU_listen_s2=cell2mat(sing_falsetrials_TU_cell(20:38,15));
sing_perf_TU_singa_s2=cell2mat(sing_falsetrials_TU_cell(39:57,15));
sing_perf_TU_singm_s2=cell2mat(sing_falsetrials_TU_cell(58:76,15));

%hypothesis testing
[h, pbase_falsetrials_TU]=ttest(sing_falsetrials_TU_base_s1, sing_falsetrials_TU_base_s2);
[h, plisten_falsetrials_TU]=ttest(sing_falsetrials_TU_listen_s1, sing_falsetrials_TU_listen_s2);
[h, psinga_falsetrials_TU]=ttest(sing_falsetrials_TU_singa_s1, sing_falsetrials_TU_singa_s2);
[h, psingm_falsetrials_TU]=ttest(sing_falsetrials_TU_singm_s1, sing_falsetrials_TU_singm_s2);

save('ttest_sing_falsetrials_TU.mat', 'pbase_falsetrials_TU','plisten_falsetrials_TU','psinga_falsetrials_TU','psingm_falsetrials_TU')

[h, pbase_perf_TU]=ttest(sing_perf_TU_base_s1, sing_perf_TU_base_s2);
[h, plisten_perf_TU]=ttest(sing_perf_TU_listen_s1, sing_perf_TU_listen_s2);
[h, psinga_perf_TU]=ttest(sing_perf_TU_singa_s1, sing_perf_TU_singa_s2);
[h, psingm_perf_TU]=ttest(sing_perf_TU_singm_s1, sing_perf_TU_singm_s2);

save('ttest_sing_perf_TU.mat', 'pbase_perf_TU','plisten_perf_TU','psinga_perf_TU','psingm_perf_TU')




