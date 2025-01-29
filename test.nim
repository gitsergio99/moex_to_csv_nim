import times,math, moexlib
var http_data_table:seq[Col]
let st_dt = parse("2024-10-01","yyyy-MM-dd")
let end_dt = parse("2024-12-01","yyyy-MM-dd")
echo (st_dt - end_dt).inDays
echo st_dt.format("yyyy'+'MM-dd hh:mm:ss")
var ds: TimeInterval
ds.days =10
let x = 285
var y:int = 0
y = int((x/100).ceil)
echo y
echo st_dt + ds

#echo slice_dates_from_request("2024-01-01","2024-12-26")

http_data_table = get_data_moex("LSNG",slice_dates_from_request("2024-01-01","2024-10-10"))
echo http_data_table