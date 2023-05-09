% script to make .tgt files
clc
clear
close all

namefile = 'go_nogo_test';
version = 9; % change version also in the go_nogo_csv2json.py
nT_tot=4;

% Constant values
T.trial_num = (1:nT_tot)';
T.stimulus = ["blue", "orange", "orange", "blue"]';
% T.correct_response = [" ", 'null', 'null', " "]';
T.correct_response = [" ", "", "", " "]'; % " "- space key, ""- null
T.fixation_duration = [500, 600, 400, 700]';

table = struct2table(T);

filename = strcat(namefile,num2str(version),'.csv');

writetable(table,filename,'Delimiter',',');

!py go_nogo_csv2json.py
