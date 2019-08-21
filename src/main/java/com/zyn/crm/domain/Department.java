package com.zyn.crm.domain;

import com.alibaba.fastjson.JSON;
import lombok.*;

import java.util.HashMap;
import java.util.Map;

@Setter@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Department {
    private Long id;
    private String name;
    private String sn;


    public String getJson() {
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("name", name);
        map.put("sn", sn);

        return JSON.toJSONString(map);
    }
}
