%%% Quality assurance plots %%%
clear all, close all
startup
cohort='LASA2019';
prep='Noise_reduction';
song='Uulaa';
ses=['_3'];
fnames=dir(fullfile(data_path, cohort, prep,song)); %TO DO: update this path in the other conditions
fnames(ismember({fnames.name},{'.','..','PPA'}))=[];
%% Get variables to plot
c1=1; c2=1; c3=1; c4=1;
for sub=1:numel(fnames)
    sub_path=fullfile(data_path,cohort,prep,song, fnames(sub).name, [fnames(sub).name ses]);
    if exist(sub_path)==7
        cd(sub_path)
        if exist(['baseline_false_' song '_' (fnames(sub).name) '.mat'])==2
            load(fullfile(sub_path,(['baseline_false_' song '_' (fnames(sub).name)])))
            baseline_false_sub{c1,1}=fnames(sub).name;
            baseline_false_sub{c1,2}=numel(baseline_false);
            c1=c1+1; 
        end
       
        if exist(['listen_false_' song '_' (fnames(sub).name) '.mat'])==2
            load(fullfile(sub_path,(['listen_false_' song '_' (fnames(sub).name)])))
            listen_false_sub{c2,1}=fnames(sub).name;
            listen_false_sub{c2,2}=numel(listen_false);
            c2=c2+1; 
        end
        
        if exist(['sing_along_false_' song '_' (fnames(sub).name) '.mat'])==2
            load(fullfile(sub_path,(['sing_along_false_' song '_' (fnames(sub).name)])))
            sing_along_false_sub{c3,1}=fnames(sub).name;
            sing_along_false_sub{c3,2}=numel(sing_along_false);
            c3=c3+1; 
        end
        
        if exist(['sing_memo_false_' song '_' (fnames(sub).name) '.mat'])==2
            load(fullfile(sub_path,(['sing_memo_false_' song '_' (fnames(sub).name)])))
            sing_memo_false_sub{c4,1}=fnames(sub).name;
            sing_memo_false_sub{c4,2}=numel(sing_memo_false);
            c4=c4+1;
        end        
    end
end

baseline_false_sub
save(fullfile(code_path, ['false_trials_sub_' cohort '_' song ses '.mat']), 'baseline_false_sub', 'listen_false_sub', 'sing_along_false_sub', 'sing_memo_false_sub')

%% Create plots
cd(code_path)
COH1='LASA2017'; COH2='LASA2019';
song='Uulaa';
ses=['_3'];
TCOH1=load(['false_trials_sub_' COH1 '_' song ses '.mat']);
TCOH2=load(['false_trials_sub_' COH2 '_' song ses '.mat']);

t=tiledlayout(1,4);

nexttile
x1=vertcat(cell2mat(TCOH1.baseline_false_sub(:,2)), cell2mat(TCOH2.baseline_false_sub(:,2)));
bar(x1,'k'); axis square
xticks(1:length(x1)); xticklabels(vertcat(TCOH1.baseline_false_sub(:,1),TCOH2.baseline_false_sub(:,1))'); xtickangle(45)
title(['Baseline False_' song '_ses' ses])

nexttile
x2=vertcat(cell2mat(TCOH1.listen_false_sub(:,2)), cell2mat(TCOH2.listen_false_sub(:,2)));
bar(x2,'w'); axis square
xticks(1:length(x2));xticklabels(vertcat(TCOH1.listen_false_sub(:,1),TCOH2.listen_false_sub(:,1))'); xtickangle(45)
title(['Listen False_' song '_ses' ses])

nexttile
x3=vertcat(cell2mat(TCOH1.sing_along_false_sub(:,2)), cell2mat(TCOH2.sing_along_false_sub(:,2)));
bar(x3,'m'); axis square; 
xticks(1:length(x3)); xticklabels(vertcat(TCOH1.sing_along_false_sub(:,1),TCOH2.sing_along_false_sub(:,1))'); xtickangle(45)
title(['Sing Along_' song '_ses' ses])

nexttile
x4=vertcat(cell2mat(TCOH1.sing_memo_false_sub(:,2)), cell2mat(TCOH2.sing_memo_false_sub(:,2)));
bar(x4,'b'); axis square; 
xticks(1:length(x4)); xticklabels(vertcat(TCOH1.sing_memo_false_sub(:,1),TCOH2.sing_memo_false_sub(:,1))'); xtickangle(45)
title(['Sing Memo_' song '_ses' ses])
savefig(gcf,['False Trials All' song '_ses' ses '.fig'])

figure
bar([mean(x1), mean(x2), mean(x3), mean(x4)]); axis square
xticklabels ({'baseline', 'listen', 'sing along', 'sing memo'})
title(['Group Mean False Trials' song '_ses' ses])
savefig(gcf,['Mean False Trials' song '_ses' ses '.fig'])
close all