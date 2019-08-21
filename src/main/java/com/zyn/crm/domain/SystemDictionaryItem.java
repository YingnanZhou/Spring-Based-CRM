package com.zyn.crm.domain;

import com.alibaba.fastjson.JSON;
import lombok.Getter;
import lombok.Setter;

import java.util.HashMap;
import java.util.Map;

@Getter
@Setter
public class SystemDictionaryItem {
    private Long id;

    private Long parentId;

    private String title;

    private Integer sequence;

    public String getJson() {
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("parentId", parentId);
        map.put("title", title);
        map.put("sequence", sequence);

        return JSON.toJSONString(map);
    }
}