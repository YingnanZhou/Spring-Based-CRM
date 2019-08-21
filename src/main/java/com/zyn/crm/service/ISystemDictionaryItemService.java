package com.zyn.crm.service;

import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.SystemDictionaryItem;
import com.zyn.crm.query.QueryObject;

import java.util.List;

public interface ISystemDictionaryItemService {
    void saveOrUpdate(SystemDictionaryItem u);

    void delete(Long id);

    SystemDictionaryItem get(Long id);

    PageInfo query(QueryObject qo);

    List<SystemDictionaryItem> list();

    List<String> queryBySn(String sn);

    List<String> listBySn(String communicationMethod);
}
