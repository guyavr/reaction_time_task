% script to make .tgt files
clc
clear
close all

namefile = 'go_nogo_test';
version = 9; % change version also in the go_nogo_csv2json.py
nT_tot=4;

% Constant values
T.trial_num = (1:nT_tot)';
T.fixation_stimulus = ["blue_fixate", "blue_fixate", "orange_fixate", "orange_fixate"]';
T.stimulus = ["blue", "orange", "orange", "blue"]';
% T.correct_response = [" ", 'null', 'null', " "]';
T.correct_response = [" ", "", "", " "]'; % " "- space key, ""- null
T.fixation_duration = [1250, 1600, 1500, 1750]';

table = struct2table(T);

filename_csv = strcat(namefile,num2str(version),'.csv');

writetable(table,filename_csv,'Delimiter',',');

!py go_nogo_csv2json.py

filename_json = strcat(namefile,num2str(version),'.json');

status_csv = movefile(filename_csv,'trial_seq','f');
status_json = movefile(filename_json,'trial_seq','f');