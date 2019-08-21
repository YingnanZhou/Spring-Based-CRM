package com.zyn.crm.service;

import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.Department;
import com.zyn.crm.query.DepartmentQueryObject;

import java.util.List;

public interface IDepartmentService {
    void saveOrUpdate(Department u);

    void delete(Long id);

    Department get(Long id);

    PageInfo query(DepartmentQueryObject qo);

    List<Department> list();
}
