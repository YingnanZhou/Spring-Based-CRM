package com.zyn.crm.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.SystemDictionary;
import com.zyn.crm.mapper.SystemDictionaryMapper;
import com.zyn.crm.query.QueryObject;
import com.zyn.crm.service.ISystemDictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SystemDictionaryServiceImpl implements ISystemDictionaryService{
    @Autowired
    private SystemDictionaryMapper systemDictionaryMapper;
    @Override
    public void saveOrUpdate(SystemDictionary systemDictionary) {
        if(systemDictionary.getId() == null) systemDictionaryMapper.insert(systemDictionary);
        else systemDictionaryMapper.updateByPrimaryKey(systemDictionary);

    }


    @Override
    public SystemDictionary get(Long id) {
        return systemDictionaryMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageInfo query(QueryObject qo) {

        PageHelper.startPage(qo.getCurrentPage(), qo.getPageSize());
        List<SystemDictionary> list = systemDictionaryMapper.queryForList(qo);
        return new PageInfo(list);

    }

    @Override
    public List<SystemDictionary> list() {
        return systemDictionaryMapper.selectAll();
    }
}
