package com.zyn.crm.service;

import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.CustomerTransfer;
import com.zyn.crm.query.QueryObject;

import java.util.List;

public interface ICustomerTransferService {
    void saveOrUpdate(CustomerTransfer u);

    void delete(Long id);

    CustomerTransfer get(Long id);

    PageInfo query(QueryObject qo);

    List<CustomerTransfer> list();
}
