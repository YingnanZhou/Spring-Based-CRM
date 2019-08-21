package com.zyn.crm.domain;

import com.alibaba.fastjson.JSON;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Getter
@Setter
@ToString
public class Customer {
    private Long id;

    private String name;

    private Integer age;

    private Integer gender;

    private String tel;

    private String qq;

    private Date inputTime;

    private SystemDictionaryItem job;

    private SystemDictionaryItem source;

    private Employee seller;

    private Employee inputUser;


    public static final Integer STATUS_POTENTIAL = 0;
    public static final Integer STATUS_FORMAL = 1;
    public static final Integer STATUS_POOL = 2;
    public static final Integer STATUS_LOST = 3;
    public static final Integer STATUS_FAILED = 4;

    private Integer status = 0;

    public String getStatusName(){
        String statusName = "";
        if(status == 0) statusName = "Potential Customer";
       else if(status == 1) statusName = "Formal Customer";
       else if(status == 2) statusName = "Customer Pool";
       else if(status == 3) statusName = "Loss customer";
       else  statusName = "Failed customer";
       return statusName;
    }



    public String getJson(){
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("name", name);
        map.put("age", age);
        map.put("gender", gender);
        map.put("tel", tel);
        map.put("qq", qq);
        map.put("jobId", job.getId());
        map.put("sourceId", source.getId());
        map.put("sellerId", seller.getId());
        map.put("sellerName", seller.getName());

        return JSON.toJSONString(map);
    }


}