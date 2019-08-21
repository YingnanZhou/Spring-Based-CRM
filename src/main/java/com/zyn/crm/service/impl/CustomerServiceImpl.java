package com.zyn.crm.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.Customer;
import com.zyn.crm.domain.Employee;
import com.zyn.crm.mapper.CustomerMapper;

import com.zyn.crm.query.QueryObject;
import com.zyn.crm.service.ICustomerService;
import com.zyn.crm.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class CustomerServiceImpl implements ICustomerService{
    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public Customer get(Long id) {
        return customerMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageInfo query(QueryObject qo) {

        PageHelper.startPage(qo.getCurrentPage(), qo.getPageSize());
        List<Customer> list = customerMapper.queryForList(qo);
        return new PageInfo(list);

    }

    @Override
    public void saveOrUpdate(Customer customer) {
        if(customer.getId() != null) customerMapper.updateByPrimaryKey(customer);
        else {
            customer.setInputUser(UserContext.getCurEmp());
            customer.setInputTime(new Date());
            customerMapper.insert(customer);
        }
    }

    @Override
    public void updateStatus(Long cid, Integer status) {
        customerMapper.updateStatus(cid, status);
    }

    @Override
    public void delete(Long id) {
        customerMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void updateSellerId(Long customerId, Long curEmpId) {
        customerMapper.updateSellerId( customerId, curEmpId);
    }

    @Override
    public void updateNewSeller(Customer customer) {
        customerMapper.updateNewSeller(customer);
    }

}
