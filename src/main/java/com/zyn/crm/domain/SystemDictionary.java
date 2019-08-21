package com.zyn.crm.domain;

import com.alibaba.fastjson.JSON;
import lombok.Getter;
import lombok.Setter;

import java.util.HashMap;
import java.util.Map;

@Getter
@Setter
public class SystemDictionary {
    private Long id;

    private String sn;

    private String title;

    private String intro;

    public String getJson() {
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("title", title);
        map.put("sn", sn);
        map.put("intro", intro);

        return JSON.toJSONString(map);
    }


}