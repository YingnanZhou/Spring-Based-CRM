package com.zyn.crm.mapper;

import com.zyn.crm.domain.SystemDictionaryItem;
import com.zyn.crm.query.QueryObject;
import java.util.List;

public interface SystemDictionaryItemMapper {
    int deleteByPrimaryKey(Long id);

    int insert(SystemDictionaryItem record);

    SystemDictionaryItem selectByPrimaryKey(Long id);

    List<SystemDictionaryItem> selectAll();

    int updateByPrimaryKey(SystemDictionaryItem record);

    List<SystemDictionaryItem> queryForList(QueryObject qo);

    List<String> selectBySn(String sn);
}