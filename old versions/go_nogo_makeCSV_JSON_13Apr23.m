% script to make .tgt files
clc
clear
close all

namefile = 'go_nogo_exp';
version = 1; % change version also in the go_nogo_csv2json.py

nT_rest = 35;
nT_go_go = 35; % cue1 = go; cue2 = go
nT_go_nogo = 15; % cue1 = go; cue2 = nogo
nT_nogo_nogo = 35; % cue1 = nogo; cue2 = nogo
nT_nogo_go = 15; % cue1 = nogo; cue2 = go

nT_allTypes = [nT_rest, nT_go_go, nT_go_nogo, nT_nogo_nogo, nT_nogo_go];
nT_tot = sum(nT_allTypes);

% Constant values
T.trial_num = (1:nT_tot)';
T.cue1_stimulus = [
    repmat("black_fixate",nT_rest,1);
    repmat("blue_fixate",nT_go_go,1);
    repmat("blue_fixate",nT_go_nogo,1);
    repmat("orange_fixate",nT_nogo_nogo,1);
    repmat("orange_fixate",nT_nogo_go,1)
    ];
T.cue1_duration = 1000*ones(1,nT_tot)';
T.isi = repmat([1200, 1300, 1400, 1500, 1600]',nT_tot/length(nT_allTypes),1); % inter-stimulus-interval (between cue1 and cue2), in ms,
                                         % since there are 5 types of
                                         % trials, can repeat the same five
                                         % isi values and thus, each trial
                                         % type have uniform dist of isi's.
T.cue2_stimulus = [
    repmat("black",nT_rest,1);
    repmat("blue",nT_go_go,1);
    repmat("orange",nT_go_nogo,1);
    repmat("orange",nT_nogo_nogo,1);
    repmat("blue",nT_nogo_go,1)
    ];

T.cue2_duration = 2000*ones(1,nT_tot)';
T.iti = 1000*ones(1,nT_tot)'; % inter-trial-interval, in ms
T.correct_response = [
    repmat("",nT_rest,1);
    repmat(" ",nT_go_go,1);
    repmat("",nT_go_nogo,1);
    repmat("",nT_nogo_nogo,1);
    repmat(" ",nT_nogo_go,1)
    ];

table = struct2table(T);

table_shuffle = table(randperm(size(table,1)), :);
table_shuffle.trial_num = (1:nT_tot)';

filename_csv = strcat(namefile,num2str(version),'.csv');

writetable(table_shuffle,filename_csv,'Delimiter',',');

!py go_nogo_csv2json.py

filename_json = strcat(namefile,num2str(version),'.json');

status_csv = movefile(filename_csv,'trial_seq','f');
status_json = movefile(filename_json,'trial_seq','f');