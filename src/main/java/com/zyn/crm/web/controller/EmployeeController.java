package com.zyn.crm.web.controller;

import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.Department;
import com.zyn.crm.domain.Employee;
import com.zyn.crm.util.JsonResult;
import com.zyn.crm.domain.Role;
import com.zyn.crm.query.EmployeeQueryObject;
import com.zyn.crm.service.IDepartmentService;
import com.zyn.crm.service.IEmployeeService;
import com.zyn.crm.service.IRoleService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
    @Autowired
    private IEmployeeService employeeService;
    @Autowired
    private IRoleService roleService;
    @Autowired
    private IDepartmentService departmentService;

    @RequestMapping("/list")
    public String list(Model model, @ModelAttribute("qo") EmployeeQueryObject qo) {
        PageInfo pageInfo = employeeService.query(qo);
        List<Department> departments = departmentService.list();
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("departments", departments);

        return "employee/list";
    }

    @RequestMapping("/input")
    @RequiresPermissions(value={"employee_input", "employee:input"}, logical = Logical.OR)
    public String input(Model model, Long id) {
        //query all the roles from this employee, share the data to the jsp page
        List<Role> roles = roleService.list();
        model.addAttribute("roles", roles);

        //query all the departments, share the data to the jsp page

        List<Department> departments = departmentService.list();
        model.addAttribute("departments", departments);
        //if id != null, it is update, get the employee information, share the information
        //to the input field
        if(id != null) {
            Employee employee = employeeService.get(id);
            model.addAttribute("employee", employee);

        }
        return "employee/input";
    }

    @RequestMapping("/delete")
    @ResponseBody
    @RequiresPermissions(value={"employee_delete", "employee:delete"}, logical = Logical.OR)
    public JsonResult delete(Long id) {
        JsonResult result = new JsonResult();
        try {
            employeeService.delete(id);
        } catch (Exception e) {
            e.printStackTrace();
            result.mark("something went wrong");

        }
        return result;
    }


    @RequestMapping("/batchDelete")
    @ResponseBody
    @RequiresPermissions(value={"employee_batchDelete", "employee:batchDelete"}, logical = Logical.OR)
    public JsonResult batchDelete(Long[] ids) {
        JsonResult result = new JsonResult();
        try {
            employeeService.deleteByEmployeeIds(ids);
        } catch (Exception e) {
            e.printStackTrace();
            result.mark("something went wrong");

        }
        return result;
    }

    @RequestMapping("/saveOrUpdate")
    @RequiresPermissions(value={"employee_saveOrUpdate", "employee:saveOrUpdate"}, logical = Logical.OR)
    public String saveOrUpdate(Employee employee, Long[] ids) {
        employeeService.saveOrUpdate(employee, ids);
        return "redirect:/employee/list.do";
    }

}
