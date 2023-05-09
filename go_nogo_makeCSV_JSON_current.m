% script to make .tgt files
clc
clear
close all

namefile = 'go_nogo_exp';
version = 1; % change version also in the go_nogo_csv2json.py

% % Exp (mod 5)
% nT_rest = 35;
% nT_go_go = 35; % cue1 = go; cue2 = go
% nT_go_nogo = 15; % cue1 = go; cue2 = nogo
% nT_nogo_nogo = 35; % cue1 = nogo; cue2 = nogo
% nT_nogo_go = 15; % cue1 = nogo; cue2 = go

% Exp (mod 4)
nT_rest = 28;
nT_go_go = 28; % cue1 = go; cue2 = go
nT_go_nogo = 12; % cue1 = go; cue2 = nogo
nT_nogo_nogo = 28; % cue1 = nogo; cue2 = nogo
nT_nogo_go = 12; % cue1 = nogo; cue2 = go

% Test
% nT_rest = 2;
% nT_go_go = 2; % cue1 = go; cue2 = go
% nT_go_nogo = 2; % cue1 = go; cue2 = nogo
% nT_nogo_nogo = 2; % cue1 = nogo; cue2 = nogo
% nT_nogo_go = 2; % cue1 = nogo; cue2 = go

nT_allTypes = [nT_rest, nT_go_go, nT_go_nogo, nT_nogo_nogo, nT_nogo_go];
nT_tot = sum(nT_allTypes);

% Constant values
T.trial_num = (1:nT_tot)';
T.cue1_stimulus = [
    repmat("cue1_orange",nT_rest,1);
    repmat("cue1_blueHigh_orangeLow",nT_go_go,1);
    repmat("cue1_blueHigh_orangeLow",nT_go_nogo,1);
    repmat("cue1_orangeHigh_blueLow",nT_nogo_nogo,1);
    repmat("cue1_orangeHigh_blueLow",nT_nogo_go,1)
    ];
T.cue1_duration = 1000*ones(1,nT_tot)';

isi_short = [700 900];
T.isi = [isi_short round(linspace(1100,1600,nT_rest-2)),...
        isi_short round(linspace(1100,1600,nT_go_go-2)),...
        isi_short round(linspace(1100,1600,nT_go_nogo-2)),...
        isi_short round(linspace(1100,1600,nT_nogo_nogo-2)),...
        isi_short round(linspace(1100,1600,nT_nogo_go-2))]';

T.cue2_stimulus = [
    repmat("cue2_orange",nT_rest,1);
    repmat("cue2_blue",nT_go_go,1);
    repmat("cue2_orange",nT_go_nogo,1);
    repmat("cue2_orange",nT_nogo_nogo,1);
    repmat("cue2_blue",nT_nogo_go,1)
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