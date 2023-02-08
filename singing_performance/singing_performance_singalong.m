clear all, close all
%% Load trial indices and get filenames
load('/Volumes/LASA/Aphasia_project/tb-fMRI/code_project/singing_performance/trial_idx.mat')
fnames=dir(fullfile(data_path, cohort, prep,song));
fnames(ismember({fnames.name},{'.','..'}))=[];

for sub=1:numel(fnames)
    sub_path=fullfile(data_path,cohort,prep,song, fnames(sub).name, [fnames(sub).name ses]);
    if exist(sub_path)==7
        cd(sub_path)
        load(['fs_audio_loge_zc_by_cond_' song '_' (fnames(sub).name)])%loads array with indices for listen, sing along, sing from memo and baseline trials
        %% Finding recordings with voice in baseline trials
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
            save (['sing_along_false_' song '_' (fnames(sub).name)],'sing_along_false');
        end
        if exist('sing_along_true') ==1
            sing_along_true=sing_along_true';
            c=num2cell(sing_along_true);
            save (['sing_along_true_' song '_' (fnames(sub).name)],'sing_along_true');
        end

        clear a aa

        %% Calculating index array for true conditions
        if exist('sing_along_true') ==1
            d3=1;
            for w3=1:length (sing_along_true)
                sing_along_true_index(d3,1)= find (sing_along(:,1)==sing_along_true(w3));
                d3=d3+1;
            end
            save (['sing_along_true_index_' song '_' (fnames(sub).name)],'sing_along_true_index');
        end

        %% plot unvoiced signal from singing along recording
        if exist('sing_along_false')
            figure ('Visible','off'); % to open figure: openfig('figurename.fig', 'new','Visible')
            L=length(sing_along_audio_nr);
            T=1/fs;
            t = (0:L-1)*T;
            for p=1:length (sing_along_false)
                subplot (6,5,p)
                plot(t,sing_along_audio_nr(:,find(sing_along(:,1)==sing_along_false(p))),'r','LineWidth',2),hold on,grid on;
                title (num2str(sing_along_false(p)))
            end
            sgtitle('Sing Along False')
            saveas(gcf,['sing_along_false_' song '_' (fnames(sub).name) '.fig'])
        end

        %% plot voiced signal from singing along recording
        if exist('sing_along_true')
            figure ('Visible','off'); % to open figure: openfig('figurename.fig', 'new','Visible')
            L=length(sing_along_audio_nr);
            T=1/fs;
            t = (0:L-1)*T;
            for p=1:length (sing_along_true)
                subplot (6,5,p)
                plot(t,sing_along_audio_nr(:,find(sing_along(:,1)==sing_along_true(p))),'r','LineWidth',2),hold on,grid on;
                title (num2str(sing_along_true(p)))
            end
            sgtitle('Sing Along True')
            saveas(gcf,['sing_along_true_' song '_' (fnames(sub).name) '.fig'])
        end
    end
end