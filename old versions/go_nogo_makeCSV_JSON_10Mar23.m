% script to make .tgt files
clc
clear
close all

namefile = 'go_nogo_test';
version = 7;
nT_tot=4;

% Constant values
T.trial_num = (1:nT_tot)';
T.stimulus = ["blue", "orange", "orange", "blue"]';
% T.correct_response = [" ", 'null', 'null', " "]';
T.correct_response = [" ", "", "", " "]';
T.fixation_duration = [500, 600, 400, 700]';

table = struct2table(T);
% T.Properties.VariableNames(1:3) = {'x_axis','y_axis','z_axis'}
% writetable(T,'file1.csv')

filename = strcat([namefile],num2str(version),'.csv');

writetable(table,filename,'Delimiter',',');

% command = 'go_nogo_csv2json.py';
% [status,cmdout] = system(command,'-echo');

!py go_nogo_csv2json.py

%pyrunfile("go_nogo_csv2json.py")
% table_json = jsonencode(table);
% 
% fid=fopen(strcat([namefile],num2str(version),'.json'),'w');
% fprintf(fid, table_json); 