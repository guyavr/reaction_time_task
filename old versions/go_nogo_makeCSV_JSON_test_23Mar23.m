% script to make .tgt files
clc
clear
close all

namefile = 'go_nogo_test';
version = 11; % change version also in the go_nogo_csv2json.py
nT_tot=5;

% Constant values
T.trial_num = (1:nT_tot)';
T.cue1_stimulus = ["blue_fixate", "blue_fixate", "black_fixate", "orange_fixate", "orange_fixate"]';
T.cue1_duration = 1000*ones(1,nT_tot)';
T.isi = [1250, 1600, 1400, 1500, 1750]'; % inter-stimulus-interval (between cue1 and cue2), in ms
T.cue2_stimulus = ["blue", "orange", "black", "orange", "blue"]';
T.cue2_duration = 2000*ones(1,nT_tot)';
T.iti = 1000*ones(1,nT_tot)'; % inter-trial-interval, in ms
T.correct_response = [" ", "", "", "", " "]'; % " "- space key, ""- null

table = struct2table(T);

filename_csv = strcat(namefile,num2str(version),'.csv');

writetable(table,filename_csv,'Delimiter',',');

!py go_nogo_csv2json.py

filename_json = strcat(namefile,num2str(version),'.json');

status_csv = movefile(filename_csv,'trial_seq','f');
status_json = movefile(filename_json,'trial_seq','f');