package com.zyn.crm.service;

import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.CustomerTraceHistory;
import com.zyn.crm.query.QueryObject;

import java.util.List;

public interface ICustomerTraceHistoryService {
    void saveOrUpdate(CustomerTraceHistory u);


    CustomerTraceHistory get(Long id);

    PageInfo query(QueryObject qo);

    List<CustomerTraceHistory> list();
}
