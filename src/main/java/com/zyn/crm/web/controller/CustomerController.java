package com.zyn.crm.web.controller;

import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.Customer;
import com.zyn.crm.domain.Employee;
import com.zyn.crm.query.CustomerQueryObject;
import com.zyn.crm.service.ICustomerService;
import com.zyn.crm.service.IEmployeeService;
import com.zyn.crm.service.ISystemDictionaryItemService;
import com.zyn.crm.util.JsonResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/customer")
public class CustomerController {
    @Autowired
    private ICustomerService customerService;
    @Autowired
    private IEmployeeService employeeService;
    @Autowired
    private ISystemDictionaryItemService systemDictionaryItemService;

    @RequestMapping("/list")
    public String list(Model model, @ModelAttribute("qo") CustomerQueryObject qo) {
        PageInfo pageInfo = customerService.query(qo);


        List<Employee> sellers = employeeService.QueryEmployeeBySpecRoles("Market", "Market_Manager");
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("sellers", sellers);

        return "customer/list";
    }


    @RequestMapping("/potentialList")
    public String potentialList(Model model, @ModelAttribute("qo") CustomerQueryObject qo) {


        qo.setStatus(Customer.STATUS_POTENTIAL);
        PageInfo pageInfo = customerService.query(qo);
        List<String> jobs = systemDictionaryItemService.queryBySn("job");
        List<String> sources = systemDictionaryItemService.queryBySn("source");

        model.addAttribute("ccts", systemDictionaryItemService.listBySn("communicationMethod"));
        model.addAttribute("jobs", jobs);
        model.addAttribute("sources", sources);

        List<Employee> sellers = employeeService.QueryEmployeeBySpecRoles("Market", "Market_Manager");
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("sellers", sellers);

        return "customer/potentialList";
    }

    @RequestMapping("/poolList")
    public String poolList(Model model, @ModelAttribute("qo") CustomerQueryObject qo) {


        qo.setStatus(Customer.STATUS_POOL);
        PageInfo pageInfo = customerService.query(qo);


        List<Employee> sellers = employeeService.QueryEmployeeBySpecRoles("Market", "Market_Manager");
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("sellers", sellers);

        return "customer/poolList";
    }


    @RequestMapping("/failedList")
    public String failedList(Model model, @ModelAttribute("qo") CustomerQueryObject qo) {


        qo.setStatus(Customer.STATUS_FAILED);
        PageInfo pageInfo = customerService.query(qo);

        List<Employee> sellers = employeeService.QueryEmployeeBySpecRoles("Market", "Market_Manager");
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("sellers", sellers);

        return "customer/failedList";
    }

    @RequestMapping("/formalList")
    public String formalList(Model model, @ModelAttribute("qo") CustomerQueryObject qo) {


        qo.setStatus(Customer.STATUS_FORMAL);
        PageInfo pageInfo = customerService.query(qo);

        List<Employee> sellers = employeeService.QueryEmployeeBySpecRoles("Market", "Market_Manager");
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("sellers", sellers);

        return "customer/formalList";
    }

    @RequestMapping("/lossList")
    public String lossList(Model model, @ModelAttribute("qo") CustomerQueryObject qo) {


        qo.setStatus(Customer.STATUS_LOST);
        PageInfo pageInfo = customerService.query(qo);

        List<Employee> sellers = employeeService.QueryEmployeeBySpecRoles("Market", "Market_Manager");
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("sellers", sellers);

        return "customer/lossList";
    }

    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public JsonResult saveOrUpdate(Customer customer) {
        JsonResult result = new JsonResult();
        try {
            customerService.saveOrUpdate(customer);
        } catch (Exception e) {
            result.mark("something went wrong");
            e.printStackTrace();
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/updateStatus")
    public JsonResult updateStatus(Long cid, Integer status) {
        JsonResult result = new JsonResult();
        try {
            customerService.updateStatus(cid, status);
        } catch (Exception e) {
            result.mark("something went wrong");
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping("/delete")
    @ResponseBody
    public JsonResult delete(Long id) {

        JsonResult result = new JsonResult();
        try {
            customerService.delete(id);
        } catch (Exception e) {
            result.mark("something went wrong");
            e.printStackTrace();
        }
        return result;
    }

}
