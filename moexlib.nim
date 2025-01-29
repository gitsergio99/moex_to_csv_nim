import std/[times,parsecsv,httpclient,strutils,math,strformat,re]

type
    Col* = object
        name*: string
        data*: seq[string]


proc slice_dates_from_request*(start_date:string, end_date:string):seq[array[2,string]] =
    var
        start_dt: DateTime = parse(start_date,"yyyy-MM-dd")
        end_dt: DateTime = parse(end_date,"yyyy-MM-dd")
        tmp_date1: DateTime
        tmp_date2: DateTime
        days_diff = int((end_dt - start_dt).inDays)
        tmp_res_seq: seq[array[2,string]] = @[]
        days_coef: int = int( (days_diff/100).ceil)
        days_tmp: TimeInterval
    days_tmp.days = 100
    for x in countup(0,days_coef-1):
        days_tmp.days = 100 * x
        tmp_date1 = start_dt + days_tmp
        if x == (days_coef - 1):
            tmp_date2 = end_dt
        else:
            days_tmp.days = 100 * x + 99
            tmp_date2 = start_dt + days_tmp
        tmp_res_seq.add([tmp_date1.format("yyyy-MM-dd"),tmp_date2.format("yyyy-MM-dd")])
    return tmp_res_seq

proc get_data_moex*(moex_ticket: string, dates:seq[array[2,string]]):seq[Col] =
    var
        tmp_data:seq[Col] = @[]
        http_c = newHttpClient()
        tmp_req:string = "https://iss.moex.com/iss/history/engines/stock/markets/shares/securities/"
        tmp_req_content:string
        get_col_names:bool = true
        tmp_re_string:string
    #echo dates
    for x in dates:
        tmp_req = tmp_req&fmt"{moex_ticket}?from={x[0]}&till={x[1]}&marketprice_board=1"
        tmp_req_content = http_c.getContent(tmp_req)
        tmp_req = "https://iss.moex.com/iss/history/engines/stock/markets/shares/securities/"
        #echo tmp_req
        #.findAll(re"""(?<=column name\=")(.*?)(?="\s)""")
        if get_col_names:
            for x in tmp_req_content.findAll(re"""(?<=column name\=")(.*?)(?="\s)"""):
                tmp_data.add(Col(name: x, data: @[]))
            get_col_names = false
        #echo tmp_data
        for x in countup(0,len(tmp_data)-1):
            tmp_re_string = fmt"""(?<={tmp_data[x].name}\=")(.*?)(?="\s)"""
            tmp_data[x].data.add(tmp_req_content.findAll(re(tmp_re_string)))
    
    return tmp_data
        #echo tmp_req_content
