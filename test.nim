import times,math, moexlib
#var for data from moex
var http_data_table:seq[Col]
#neccery columns 
var clmn:seq[string] = @["TRADEDATE","OPEN","HIGH","LOW","CLOSE","LEGALCLOSEPRICE","VOLUME"]

#get data from moex, moex push back only 100 records per 1 request. So, slice_dates_from_request - slice request if it need.
#
http_data_table = get_data_moex_colmn("LSNG",slice_dates_from_request("2024-01-01","2024-10-10"),clmn)

echo http_data_table
#save data to csv file.
save_data_to_csv(http_data_table,"lsng.csv")