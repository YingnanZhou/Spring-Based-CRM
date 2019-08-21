package com.zyn.crm.service;

import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.Customer;
import com.zyn.crm.domain.Employee;
import com.zyn.crm.query.QueryObject;

import java.util.List;

public interface ICustomerService {

    Customer get(Long id);

    PageInfo query(QueryObject qo);

    void saveOrUpdate(Customer customer);

    void updateStatus(Long cid, Integer status);

    void delete(Long id);

    void updateSellerId(Long cid, Long curEmpId);

    void updateNewSeller(Customer customer);

    //List<Customer> list();
}
