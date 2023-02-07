clear all
source='/Volumes/LASA/Aphasia_project/tb-fMRI/recordings/';
cohort='LASA2019';
folder='Noise_reduction';
folder_dest='Noise_reduction_copy';
song='Uulaa';
ses='_3';
fnames=dir(fullfile(data_path, cohort, prep,song));
fnames(ismember({fnames.name},{'.','..'}))=[];

for sub=1:numel(fnames)
    sub_path1=fullfile(source,cohort,folder,song, fnames(sub).name);
    sub_path2=fullfile(source,cohort,folder_dest,song);
    src_path=fullfile(sub_path1,[fnames(sub).name ses]);
    if exist(src_path)==7
        cd(src_path)
        if strcmp(cohort,'LASA2019')
            if (strcmp(ses,'_3') && sub==3) || (strcmp(song,'Uulaa') && sub==2)
                src_fnames=dir('norm*');
            elseif ~strcmp(ses,'_1') || sub==10
                src_fnames=dir('NR*');
            end
        else
            src_fnames=dir('renorm*');
        end
        cd(sub_path2); mkdir(fnames(sub).name); cd (fnames(sub).name); mkdir([fnames(sub).name ses])
        for src=1:numel(src_fnames)
            copyfile(fullfile(sub_path1, [fnames(sub).name ses], src_fnames(src).name), fullfile(sub_path2, fnames(sub).name, [fnames(sub).name ses]))
        end
    end
end
