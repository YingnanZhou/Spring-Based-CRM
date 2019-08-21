package com.zyn.crm.service;

import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.SystemDictionary;
import com.zyn.crm.query.QueryObject;

import java.util.List;

public interface ISystemDictionaryService {
    void saveOrUpdate(SystemDictionary u);

    SystemDictionary get(Long id);

    PageInfo query(QueryObject qo);

    List<SystemDictionary> list();
}
