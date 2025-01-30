import times,math, moexlib
var http_data_table:seq[Col]
var clmn:seq[string] = @["TRADEDATE","OPEN","HIGH","LOW","CLOSE","LEGALCLOSEPRICE","VOLUME"]

#echo slice_dates_from_request("2024-01-01","2024-12-26")

#http_data_table = get_data_moex_all_colmn("LSNG",slice_dates_from_request("2024-01-01","2024-10-10"))
#echo http_data_table

http_data_table = get_data_moex_colmn("LSNG",slice_dates_from_request("2024-01-01","2024-10-10"),clmn)
echo http_data_table
save_data_to_csv(http_data_table,"lsng.csv")