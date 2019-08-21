package com.zyn.crm.domain;

import com.alibaba.fastjson.JSON;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Setter
@Getter
@ToString
public class CustomerTraceHistory {
    private Long id;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date traceTime;

    private String traceDetails;

    private SystemDictionaryItem traceType;

    private Integer traceResult;

    private String remark;

    private Customer customer;

    private Employee inputUser;

    private Date inputTime;

    public String getResultName() {
        String name = "";
        if(traceResult == 1) name="bad";
        else if(traceResult == 2) name="medium";
        else name="good";
        return name;
    }

    public String getJson(){
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("customerId", customer.getId());
        map.put("customerName", customer.getName());
        //make the date to a string or it will be millisecond when edit this trace
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        map.put("traceTime", sdf.format(traceTime));
        map.put("traceDetails", traceDetails);
        map.put("traceTypeId", traceType.getId());
        map.put("remark", remark);
        map.put("traceResult",traceResult);
        return JSON.toJSONString(map);
    }



}