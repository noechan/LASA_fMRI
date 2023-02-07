clear all
%% Input Arguments
load('/Volumes/LASA/Aphasia_project/tb-fMRI/code_project/singing_performance/trial_idx.mat') %loads array with indices for listen, sing along, sing from memo and baseline trials
data_path='/Volumes/LASA/Aphasia_project/tb-fMRI/recordings';
code_path='/Volumes/LASA/Aphasia_project/tb-fMRI/code_project/singing_performance';
addpath('/Volumes/LASA/Aphasia_project/tb-fMRI/code_project/singing_performance/functions');
%%% These variables to be edited manually %%% 
cohort='LASA2017';
prep='Noise_reduction_copy';
song='Tydyy';
ses='_1';
fnames=dir(fullfile(data_path, cohort, song));
fnames(ismember({fnames.name},{'.','..'}))=[];
%% Start analysis
for sub=1%:numel(fnames.name)
     sub_path=fullfile(data_path,cohort,prep,song, fnames(sub).name, [fnames(sub).name ses]);
     if exist(sub_path)==7
all_wav_files_nr=dir(sub_path);
all_wav_files_nr(ismember({all_wav_files_nr.name},{'.','..'}))=[];
l=1;
for j=1:size(listen,1)
    listen_wav_nr{l,1}=all_wav_files_nr(listen(j,1),:);
    l=l+1;
end

ll=1;
for jj=1:size(sing_along,1)
    sing_along_wav_nr{ll,1}=all_wav_files_nr(sing_along(jj,1),:);
    ll=ll+1;
end

q=1;
for k=1:size(sing_memo,1)
    sing_memo_wav_nr{q,1}=all_wav_files_nr(sing_memo(k,1),:);
    q=q+1;
end

qq=1;
for kk=1:size(baseline,1)
    baseline_wav_nr{qq,1}=all_wav_files_nr(baseline(kk,1),:);
    qq=qq+1;
end
 clear m mm j jj q qq k kk

 %% Loading noise reduced recordings and computing log e
cd (code_path)
Lm=40; %window length threshold
Rm=10; %frame shift step
for j=1:30
   fname1=fullfile(sub_path,char(listen_wav_nr{j}.name));
   [xin,fs]=audioread(fname1);
   listen_audio_nr (:,j)=xin;
   L=round(Lm*fs/1000);
   R=round(Rm*fs/1000);
   [loge,zc,nfrm]=analysis(xin,L,R,fs);
   listen_loge_nr (:,j)=loge;
   listen_zc_nr (:,j)=zc;
   clear xin loge zc
end

for jj=1:30
   fname1=fullfile(sub_path,char(sing_along_wav_nr{jj}.name));
   [xin,fs]=audioread(fname1);
   sing_along_audio_nr (:,jj)=xin;
   L=round(Lm*fs/1000);
   R=round(Rm*fs/1000);
   [loge,zc,nfrm]=analysis(xin,L,R,fs);
   sing_along_loge_nr (:,jj)=loge;
   sing_along_zc_nr (:,jj)=zc;
   clear xin loge zc
end

for k=1:30
   fname1=fullfile(sub_path,char(sing_memo_wav_nr{k}.name));
   [xin,fs]=audioread(fname1);
   sing_memo_audio_nr (:,k)=xin;
   L=round(Lm*fs/1000);
   R=round(Rm*fs/1000);
   [loge,zc,nfrm]=analysis(xin,L,R,fs);
   sing_memo_loge_nr (:,k)=loge;
   sing_memo_zc_nr (:,k)=zc;
   clear xin loge zc
end

for kk=1:20
   fname2=fullfile(sub_path,char(baseline_wav_nr{kk}.name));
   [xin,fs]=audioread(fname2);
   baseline_audio_nr (:,kk)=xin;
   L=round(Lm*fs/1000);
   R=round(Rm*fs/1000);
   [loge,zc,nfrm]=analysis(xin,L,R,fs);
   baseline_loge_nr (:,kk)=loge;
   baseline_zc_nr (:,kk)=zc;
   clear xin loge zc j jj k kk fname1 fname2
end
     end
cd(sub_path)
save (['audio_loge_zc_by_cond_Tydyy_',(fnames(sub).name)],'listen_audio_nr','listen_loge_nr','listen_zc_nr','sing_along_audio_nr','sing_along_loge_nr','sing_along_zc_nr','sing_memo_audio_nr','sing_memo_loge_nr','sing_memo_zc_nr','baseline_audio_nr','baseline_loge_nr','baseline_zc_nr');

%% Finding recordings with voice in listen trials
ethreshold=10; %in dB
zcthreshold=80; %crossings per 10msec interval
a=1;aa=1;
for m=1:size(listen,1)
    [M,I]=max(listen_loge_nr(:,m));
    if M > ethreshold
        listen_false(a)=listen(m,1);
        a=a+1;
    else
        if  I < 12 && mean (listen_zc_nr([I:I+24],m)) < zcthreshold %Look for mean zc rate in the 960msec window centered the max location
            listen_false(a)=listen(m,1);
            a=a+1;
        elseif I >12 && I <= 385 && mean (listen_zc_nr([I-12:I+12],m)) < zcthreshold %Look for mean zc rate in the 960msec window centered the max location
            listen_false(a)=listen(m,1);
            a=a+1;
        elseif I > 385 && mean (listen_zc_nr([I-24:I],m)) < zcthreshold
            listen_false(a)=listen(m,1);
            a=a+1;
        else
            listen_true(aa)=listen(m,1);
            aa=aa+1;
        end
    end
    clear M I 
end

if exist('listen_false') ==1
    listen_false=listen_false';
    save (['listen_false_Tydyy_',(names(sub,:))],'listen_false');
end

if exist('listen_true') ==1
    listen_true=listen_true';
    b=num2cell(listen_true);
    save (['listen_true_Tydyy_',(names(sub,:))],'listen_true');
end
clear a aa
%% Finding recordings with voice in sing along trials
ethreshold=10; %in dB
zcthreshold=80; %crossings per 10msec interval
a=1;aa=1;
for m=1:size(sing_along,1)
    [M,I]=max(sing_along_loge_nr(:,m));
    if M > ethreshold
        sing_along_true(a)=sing_along(m);
        a=a+1;
    else
        if  I < 12 && mean (sing_along_zc_nr([I:I+24],m)) < zcthreshold %Look for mean zc rate in the 960msec window centered the max location
            sing_along_true(a)=sing_along(m);
            a=a+1;
        elseif I >12 && I <= 385 && mean (sing_along_zc_nr([I-12:I+12],m)) < zcthreshold %Look for mean zc rate in the 960msec window centered the max location
            sing_along_true(a)=sing_along(m);
            a=a+1;
        elseif I > 385 && mean (sing_along_zc_nr([I-24:I],m)) < zcthreshold
            sing_along_true(a)=sing_along(m);
            a=a+1;
        else
            sing_along_false(aa)=sing_along(m);
            aa=aa+1;
        end
    end
    clear M I
end

if exist('sing_along_false') ==1
    sing_along_false=sing_along_false';
    save (['sing_along_false_Tydyy_',(names(sub,:))],'sing_along_false');
end
if exist('sing_along_true') ==1
    sing_along_true=sing_along_true';
    c=num2cell(sing_along_true);
    save (['sing_along_true_Tydyy_',(names(sub,:))],'sing_along_true');
end

clear a aa
%% Finding recordings with voice in sing memo trials
ethreshold=10; %in dB
zcthreshold=80; %crossings per 10msec interval
a=1;aa=1;
for m=1:size(sing_memo,1)
    [M,I]=max(sing_memo_loge_nr(:,m));
    if M > ethreshold
        sing_memo_true(a)=sing_memo(m);
        a=a+1;
    else
        if  I < 12 && mean (sing_memo_zc_nr([I:I+24],m)) < zcthreshold %Look for mean zc rate in the 960msec window centered the max location
            sing_memo_true(a)=sing_memo(m);
            a=a+1;
        elseif I >12 && I <= 385 && mean (sing_memo_zc_nr([I-12:I+12],m)) < zcthreshold %Look for mean zc rate in the 960msec window centered the max location
            sing_memo_true(a)=sing_memo(m);
            a=a+1;
        elseif I > 385 && mean (sing_memo_zc_nr([I-24:I],m)) < zcthreshold
            sing_memo_true(a)=sing_memo(m);
            a=a+1;
        else
            sing_memo_false(aa)=sing_memo(m);
            aa=aa+1;
        end
    end
    clear M I
end

if exist('sing_memo_false') ==1
    sing_memo_false=sing_memo_false';
    save (['sing_memo_false_Tydyy_',(names(sub,:))],'sing_memo_false');
end
if exist('sing_memo_true') ==1
    sing_memo_true=sing_memo_true';
    d=num2cell(sing_memo_true);
    save (['sing_memo_true_Tydyy_',(names(sub,:))],'sing_memo_true');
end
clear a aa
%% Finding recordings with voice in baseline trials
ethreshold=10; %in dB
zcthreshold=80; %crossings per 10msec interval
b=1;bb=1;
for n=1:size(baseline,1)
    [M,I]=max(baseline_loge_nr(:,n));
    if M > ethreshold
        baseline_false(b)=baseline(n);
        b=b+1;
    else
        if  I < 12 && mean (baseline_zc_nr([I:I+24],n)) < zcthreshold %Look for mean zc rate in the 960msec window centered the max location
            baseline_false(b)=baseline(n);
            b=b+1;
        elseif I >12 && I <= 385 && mean (baseline_zc_nr([I-12:I+12],n)) < zcthreshold %Look for mean zc rate in the 960msec window centered the max location
            baseline_false(b)=baseline(n);
            b=b+1;
        elseif I > 385 && mean (baseline_zc_nr([I-24:I],n)) < zcthreshold
            baseline_false(b)=baseline(n);
            b=b+1;
        else
            baseline_true(bb)=baseline(n);
            bb=bb+1;
        end
    end
    clear M I
end

if exist('baseline_false') ==1
    baseline_false=baseline_false';
    save (['baseline_false_Tydyy_',(names(sub,:))],'baseline_false');
end

if exist('baseline_true') ==1
    baseline_true=baseline_true';
    a=num2cell(baseline_true);
    save (['baseline_true_Tydyy_',(names(sub,:))],'baseline_true');
end

%% Calculating index array for true conditions
if exist('listen_true') ==1
    d1=1;
    for w1=1:length (listen_true)
        listen_true_index (d1,1)= find (listen(:,1)==listen_true(w1));
        d1=d1+1;
    end
    save (['listen_true_index_Tydyy_',(names(sub,:))],'listen_true_index');
end

if exist('baseline_true') ==1
    d2=1;
    for w2=1:length (baseline_true)
        baseline_true_index (d2,1)= find (baseline(:,1)==baseline_true(w2));
        d2=d2+1;
    end
    save (['baseline_true_index_Tydyy_',(names(sub,:))],'baseline_true_index');
end

if exist('sing_along_true') ==1
    d3=1;
    for w3=1:length (sing_along_true)
        sing_along_true_index(d3,1)= find (sing_along(:,1)==sing_along_true(w3));
        d3=d3+1;
    end
    save (['sing_along_true_index_Tydyy_',(names(sub,:))],'sing_along_true_index');
end

if exist('sing_memo_true') ==1
    d4=1;
    for w4=1:length (sing_memo_true)
        sing_memo_true_index(d4,1)= find (sing_memo(:,1)==sing_memo_true(w4));
        d4=d4+1;
    end
    save (['sing_memo_true_index_Tydyy_',(names(sub,:))],'sing_memo_true_index');
end
%% Save all true trials
% if sub~=4
%     all_true_scans=vertcat(a,b,c,d);
%     all_true_scans=sortrows(all_true_scans);
%     save (['all_true_scans_Tydyy'],'all_true_scans');
% elseif sub==4
%     all_true_scans=vertcat(b,c,d);
%     all_true_scans=sortrows(all_true_scans);
%     save (['all_true_scans_Tydyy'],'all_true_scans');
% end
clear a b c d w1 w2 w3 w4 d1 d2 d3 d4
% %% Find sing onsets/offsets based on amplitude
% cd (script_path)
% %%% Sing along true onsets/offsets
% count_singa=1;
% for q=1:length(sing_along_true)
%     [yupper,ylower]=envelope(sing_along_audio_nr(:,find(sing_along(:,1)==sing_along_true(q))),30,'peak');
%     yupper_singa(:,count_singa)=yupper;
%     ylower_singa(:,count_singa)=ylower;
%     count_singa=count_singa+1;
% end
% clear q
% 
% for q=1:length(sing_along_true)
%     if sub==5 && sing_along_true(q)==38 || sub==9 && sing_along_true(q)==57 || sub==12 && sing_along_true(q)==74 || sub==13 && (sing_along_true(q)==8 || sing_along_true(q)==52) ...
%        || sub==14 && (sing_along_true(q)==2 || sing_along_true(q)==85 || sing_along_true(q)==107);    
%        for qq=1:length(yupper_singa)
%             if yupper_singa(qq,q) > 0.01  || ylower_singa(qq,q) < -0.01
%                 singa_onset(1,q)=qq;
%                 singa_onset_sec(1,q)=qq/fs;
%                 break
%             end
%         end
%     else
%         for qq=8820:length(yupper_singa) % first 200ms excluded
%             if yupper_singa(qq,q) > 0.01  || ylower_singa(qq,q) < -0.01
%                 singa_onset(1,q)=qq;
%                 singa_onset_sec(1,q)=qq/fs;
%                 break
%             end
%         end
%         clear q qq
%     end
% end
% for q=1:length(sing_along_true)
%     for qq=length(yupper_singa):-1:8820 % first 200ms excluded
%         if yupper_singa(qq,q) > 0.01  || ylower_singa(qq,q) < -0.01
%             singa_offset(1,q)=qq;
%             singa_offset_sec(1,q)=qq/fs;
%             break
%         end
%     end
% end
% clear q qq yupper ylower
% %%% Sing from memory true onsets/offsets
% count_singm=1;
% for q=1:length(sing_memo_true)
%     [yupper,ylower]=envelope(sing_memo_audio_nr(:,find(sing_memo(:,1)==sing_memo_true(q))),30,'peak');
%     yupper_singm(:,count_singm)=yupper;
%     ylower_singm(:,count_singm)=ylower;
%     count_singm=count_singm+1;
% end
% clear q
% 
% for q=1:length(sing_memo_true)
%     if sub==8 && sing_memo_true(q)==20 || sub==13 && (sing_memo_true(q)==9 || sing_memo_true(q)==31 || sing_memo_true(q)==39 || sing_memo_true(q)==53)
%         for qq=1:length(yupper_singm)
%             if yupper_singm(qq,q) > 0.01  || ylower_singm(qq,q) < -0.01
%                 singm_onset(1,q)=qq;
%                 singm_onset_sec(1,q)=qq/fs;
%                 break
%             end
%         end
%     else
%         for qq=8820:length(yupper_singm) % first 200ms excluded
%             if yupper_singm(qq,q) > 0.01  || ylower_singm(qq,q) < -0.01
%                 singm_onset(1,q)=qq;
%                 singm_onset_sec(1,q)=qq/fs;
%                 break
%             end
%         end
%         clear q qq
%     end
% end
% 
% for q=1:length(sing_memo_true)
%     for qq=length(yupper_singm):-1:8820 % first 200ms excluded
%         if yupper_singm(qq,q) > 0.01  || ylower_singm(qq,q) < -0.01
%             singm_offset(1,q)=qq;
%             singm_offset_sec(1,q)=qq/fs;
%             break
%         end
%     end
% end
% clear q qq yupper ylower
% cd (sub_path)
% save (['sing_along_endpoints_Tydyy_',(names(sub,:))],'singa_onset','singa_offset');
% save (['sing_memo_endpoints_Tydyy_',(names(sub,:))],'singm_onset','singm_offset');
% save (['singa_onset_Tydyy_sec_',(names(sub,:))],'singa_onset_sec');  
% save (['singa_offset_Tydyy_sec_',(names(sub,:))],'singa_offset_sec'); 
% save (['singm_onset_Tydyy_sec_',(names(sub,:))],'singm_onset_sec');  
% save (['singm_offset_Tydyy_sec_',(names(sub,:))],'singm_offset_sec'); 
% end

%% Plot true & false 
%% plot voiced signal from listen recording
if exist('listen_false')
    figure;
    L=length(listen_audio_nr);
    T=1/fs;
    t = (0:L-1)*T;
    for p=1:length (listen_false)
        subplot (6,5,p)
        plot(t,listen_audio_nr(:,find(listen(:,1)==listen_false(p))),'r','LineWidth',2),hold on,grid on;
        title (num2str(listen_false(p)))
    end
    saveas(gcf,['listen_false_Tydyy_' (names(sub,:)) '.fig'])
end
%% plot unvoiced signal from listen recording 
if exist('listen_true')
    figure;
    L=length(listen_audio_nr);
    T=1/fs;
    t = (0:L-1)*T;
    for p=1:length(listen_true)
        subplot (6,5,p)
        plot(t,listen_audio_nr(:,find(listen(:,1)==listen_true(p))),'r','LineWidth',2),hold on,grid on;
        title (num2str(listen_true(p)))
    end
    saveas(gcf,['listen_true_Tydyy_' (names(sub,:)) '.fig'])
end
%% plot voiced signal from singing along recording
if exist('sing_along_true')
    figure;
    L=length(sing_along_audio_nr);
    T=1/fs;
    t = (0:L-1)*T;
    for p=1:length (sing_along_true)
        subplot (6,5,p)
        plot(t,sing_along_audio_nr(:,find(sing_along(:,1)==sing_along_true(p))),'r','LineWidth',2),hold on,grid on;
        title (num2str(sing_along_true(p)))
    end
    saveas(gcf,['sing_along_true_Tydyy_' (names(sub,:)) '.fig'])
end
%% plot unvoiced signal from singing along recording
if exist('sing_along_false')
    figure;
    L=length(sing_along_audio_nr);
    T=1/fs;
    t = (0:L-1)*T;
    for p=1:length (sing_along_false)
        subplot (6,5,p)
        plot(t,sing_along_audio_nr(:,find(sing_along(:,1)==sing_along_false(p))),'r','LineWidth',2),hold on,grid on;
        title (num2str(sing_along_false(p)))
    end
    saveas(gcf,['sing_along_false_Tydyy_' (names(sub,:)) '.fig'])
end
%% plot unvoiced signal from singing memo recording
if exist('sing_memo_false')
    figure;
    L=length(sing_memo_audio_nr);
    T=1/fs;
    t = (0:L-1)*T;
    for p=1:length (sing_memo_false)
        subplot (6,5,p)
        plot(t,sing_memo_audio_nr(:,find(sing_memo(:,1)==sing_memo_false(p))),'r','LineWidth',2),hold on,grid on;
        title (num2str(sing_memo_false(p)))
    end
    saveas(gcf,['sing_memo_false_Tydyy_' (names(sub,:)) '.fig'])
end
%% plot voiced signal from singing memo recording 
if exist('sing_memo_true')
    figure;
    L=length(sing_memo_audio_nr);
    T=1/fs;
    t = (0:L-1)*T;
    for p=1:length(sing_memo_true)
        subplot (6,5,p)
        plot(t,sing_memo_audio_nr(:,find(sing_memo(:,1)==sing_memo_true(p))),'r','LineWidth',2),hold on,grid on;
        title (num2str(sing_memo_true(p)))
    end
    saveas(gcf,['sing_memo_true_Tydyy_' (names(sub,:)) '.fig'])
end
%% plot unvoiced signal from baseline recording
if exist('baseline_true')
    figure;
    L=length(baseline_audio_nr);
    T=1/fs;
    t = (0:L-1)*T;
    for p=1:length (baseline_true)
        subplot (5,4,p)
        plot(t,baseline_audio_nr(:,find(baseline(:,1)==baseline_true(p))),'r','LineWidth',2),hold on,grid on;
        title (num2str(baseline_true(p)))
    end
    saveas(gcf,['baseline_true_Tydyy_' (names(sub,:)) '.fig'])
end
%% plot voiced signal from baseline recording 
if exist('baseline_false')
    figure;
    L=length(baseline_audio_nr);
    T=1/fs;
    t = (0:L-1)*T;
    for p=1:length (baseline_false)
        subplot (5,4,p)
        plot(t,baseline_audio_nr(:,find(baseline(:,1)==baseline_false(p))),'r','LineWidth',2),hold on,grid on;
        title (num2str(baseline_false(p)))
    end
    saveas(gcf,['baseline_false_Tydyy_' (names(sub,:)) '.fig'])
end
end
% %% Plot sing onsets/offsets
% %% sing along true
% cd(script_path)
% if exist('sing_along_true')
%     tt=1:length(yupper_singa);
%     figure;
%     for p=1:length(sing_along_true)
%         subplot(5,6,p)
%         plot(tt,sing_along_audio_nr(:,find(sing_along(:,1)==sing_along_true(p))))
%         hold on
%         vline(singa_onset(p),'r','Onset')
%         vline(singa_offset(p),'r','Offset')
%         title (num2str(sing_along_true(p)))
%     end
%     cd(sub_path)
%     saveas(gcf,['sing_along_true_Tydyy_' (names(sub,:)) '_on_off.fig'])
% end
% 
% %% sing memo true
% cd(script_path)
% if exist('sing_memo_true')
%     tt=1:length(yupper_singm);
%     figure;
%     for p=1:length(sing_memo_true)
%         subplot(5,6,p)
%         plot(tt, sing_memo_audio_nr(:,find(sing_memo(:,1)==sing_memo_true(p))))
%         hold on
%         vline(singm_onset(p),'r','Onset')
%         vline(singm_offset(p),'r','Offset')
%         title (num2str(sing_memo_true(p)))
%     end
%     cd(sub_path)
%     saveas(gcf,['sing_memo_true_Tydyy_' (names(sub,:)) '_on_off.fig'])
% end

% figure; plot(1:length(yupper), sing_memo_audio_nr(:,1))
% envelope(sing_along_audio_nr(:,2),30,'peak')
%Sound check  
% sound(sing_audio_raw(:,find(sing==sing_true(52))),fs)
% sound(sing_audio_raw(:,find(sing==sing_false(3))),fs)

