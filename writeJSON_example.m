targets = load('targets.mat').targets; 
distractors = load('distractors.mat').distractors; 

level_number='Level 3' %example of a level number 

for y=1%:12 
    JSONFILE_name= sprintf('%s_JSON%d.json',level_number,y); 
    fid=fopen(JSONFILE_name,'w') 
    s = struct("audioData", targets{y}, "DistractorData", distractors{y}); 
    encodedJSON = jsonencode(s); 
    fprintf(fid, encodedJSON); 
end 

fclose('all'); 