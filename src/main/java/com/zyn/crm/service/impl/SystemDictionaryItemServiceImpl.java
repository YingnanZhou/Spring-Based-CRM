package com.zyn.crm.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.SystemDictionaryItem;
import com.zyn.crm.mapper.SystemDictionaryItemMapper;
import com.zyn.crm.query.QueryObject;
import com.zyn.crm.service.ISystemDictionaryItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SystemDictionaryItemServiceImpl implements ISystemDictionaryItemService{
    @Autowired
    private SystemDictionaryItemMapper systemDictionaryItemMapper;
    @Override
    public void saveOrUpdate(SystemDictionaryItem systemDictionaryItem) {
        if(systemDictionaryItem.getId() == null) systemDictionaryItemMapper.insert(systemDictionaryItem);
        else systemDictionaryItemMapper.updateByPrimaryKey(systemDictionaryItem);

    }

    @Override
    public void delete(Long id) {
        systemDictionaryItemMapper.deleteByPrimaryKey(id);
    }

    @Override
    public SystemDictionaryItem get(Long id) {
        return systemDictionaryItemMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageInfo query(QueryObject qo) {

        PageHelper.startPage(qo.getCurrentPage(), qo.getPageSize());
        List<SystemDictionaryItem> list = systemDictionaryItemMapper.queryForList(qo);
        return new PageInfo(list);

    }

    @Override
    public List<SystemDictionaryItem> list() {
        return systemDictionaryItemMapper.selectAll();
    }

    @Override
    public List<String> queryBySn(String sn) {
       return systemDictionaryItemMapper.selectBySn(sn);
    }

    @Override
    public List<String> listBySn(String communicationMethod) {
        return systemDictionaryItemMapper.selectBySn(communicationMethod);
    }
}
