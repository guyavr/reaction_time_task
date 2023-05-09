import csv, ast

f = open('go_nogo_test5.csv')
csv_f = csv.reader(f)

rows = []
for row in csv_f:
	if 'Experiment 1' in row[3]:
		lst_row = ast.literal_eval(row[3]) # convert string list to an actual list
		rows.append(lst_row) # add the trial to be its own row

f = open('convertedtrialdata.csv', 'wt')
try:
    writer = csv.writer(f)
    writer.writerow( ('Experiment Name', 'Subject ID', 'Start Time', 'Trial Number', 'Target Angle', 'Cursor FB', 'Rotation', 'Hand Angle', 'RT', 'MT', 'Search Time', 'Reach FB') )
    for i in range(len(rows)): # go through each row
    	# make each thing a separate column
        writer.writerow( (rows[i][0], rows[i][1], rows[i][2], rows[i][3], rows[i][4], rows[i][5], rows[i][6], rows[i][7], rows[i][8], rows[i][9], rows[i][10], rows[i][11]) )
finally:
    f.close()

print(open('convertedtrialdata.csv', 'rt').read())
