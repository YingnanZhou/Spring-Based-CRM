package com.zyn.crm.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.CustomerTraceHistory;
import com.zyn.crm.mapper.CustomerTraceHistoryMapper;
import com.zyn.crm.query.QueryObject;
import com.zyn.crm.service.ICustomerTraceHistoryService;
import com.zyn.crm.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class CustomerTraceHistoryServiceImpl implements ICustomerTraceHistoryService{
    @Autowired
    private CustomerTraceHistoryMapper customerTraceHistoryMapper;
    @Override
    public void saveOrUpdate(CustomerTraceHistory customerTraceHistory) {
        if(customerTraceHistory.getId() == null) {
            customerTraceHistory.setInputUser(UserContext.getCurEmp());
            customerTraceHistory.setInputTime(new Date());
            customerTraceHistoryMapper.insert(customerTraceHistory);

        }
        else customerTraceHistoryMapper.updateByPrimaryKey(customerTraceHistory);

    }


    @Override
    public CustomerTraceHistory get(Long id) {
        return customerTraceHistoryMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageInfo query(QueryObject qo) {

        PageHelper.startPage(qo.getCurrentPage(), qo.getPageSize());
        List<CustomerTraceHistory> list = customerTraceHistoryMapper.queryForList(qo);
        return new PageInfo(list);

    }

    @Override
    public List<CustomerTraceHistory> list() {
        return customerTraceHistoryMapper.selectAll();
    }
}
