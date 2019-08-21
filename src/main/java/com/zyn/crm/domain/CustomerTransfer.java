package com.zyn.crm.domain;

import com.alibaba.fastjson.JSON;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Getter
@Setter
@ToString
public class CustomerTransfer {
    private Long id;

    private Customer customer;

    private Employee operator;

    private Date operateTime;

    private Employee oldSeller;

    private Employee newSeller;

    private String reason;
//
//    public String getJson() {
//        Map<String, Object> map = new HashMap<>();
//        map.put("id", id);
//        map.put("customerName", customer.getName());
//        map.put("customerId", customer.getId());
//        map.put("operator", operator.getId());
//
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//        map.put("operateTime", sdf.format(operateTime));
//
//        map.put("oldSellerId", oldSeller.getId());
//        map.put("oldSellerName", oldSeller.getName());
//        map.put("newSeller", newSeller.getId());
//        map.put("reason", reason);
//        return JSON.toJSONString(map);
//    }


}