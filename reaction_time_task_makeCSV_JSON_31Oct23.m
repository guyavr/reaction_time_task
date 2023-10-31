% script to make .tgt files
clc
clear
close all

namefile = 'reaction_time_task';
version = 1; % change version also in the go_nogo_csv2json.py

% Standard Reaction time
nT_rt_task = 20;

nT_allTypes = nT_rt_task;
nT_tot = sum(nT_allTypes);

% Constant values
T.trial_num = (1:nT_tot)';
T.cue1_stimulus = repmat("cue1_blue",nT_rt_task,1);
T.cue1_duration = 1000*ones(1,nT_tot)';

T.isi = round(linspace(700,900,nT_rt_task))';

T.cue2_stimulus = repmat("cue2_blue",nT_rt_task,1);

T.cue2_duration = 2000*ones(1,nT_tot)';
T.iti = 1000*ones(1,nT_tot)'; % inter-trial-interval, in ms
T.correct_response = repmat(" ",nT_rt_task,1);

table = struct2table(T);

table_shuffle = table(randperm(size(table,1)), :);
table_shuffle.trial_num = (1:nT_tot)';

filename_csv = strcat(namefile,num2str(version),'.csv');

writetable(table_shuffle,filename_csv,'Delimiter',',');

!py reaction_time_task_csv2json.py

filename_json = strcat(namefile,num2str(version),'.json');

status_csv = movefile(filename_csv,'trial_seq','f');
status_json = movefile(filename_json,'trial_seq','f');