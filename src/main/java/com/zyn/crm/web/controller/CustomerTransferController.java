package com.zyn.crm.web.controller;

import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.Customer;
import com.zyn.crm.domain.CustomerTransfer;
import com.zyn.crm.domain.Employee;
import com.zyn.crm.query.CustomertransferQueryObject;
import com.zyn.crm.service.ICustomerService;
import com.zyn.crm.service.ICustomerTransferService;
import com.zyn.crm.util.JsonResult;
import com.zyn.crm.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/customerTransfer")
public class CustomerTransferController {

    @Autowired
    private ICustomerService customerService;
    @Autowired
    private ICustomerTransferService customerTransferService;

    @RequestMapping("/list")
    public String list(Model model, @ModelAttribute("qo") CustomertransferQueryObject qo) {
        PageInfo pageInfo = customerTransferService.query(qo);
        for (Object o : pageInfo.getList()) {
            System.out.println(o);
        }
        model.addAttribute("pageInfo", pageInfo);
        return "customertransfer/list";
    }



    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public JsonResult saveOrUpdate(CustomerTransfer customertransfer) {
        JsonResult result = new JsonResult();
        try {
            Customer customer = new Customer();
            customer.setId(customertransfer.getCustomer().getId());
            customer.setSeller(customertransfer.getNewSeller());


            customerService.updateNewSeller(customer);
            customerTransferService.saveOrUpdate(customertransfer);

        } catch (Exception e) {
            result.mark("something went wrong");
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping("/absorb")
    @ResponseBody
    public JsonResult absorb(CustomerTransfer customertransfer) {
        JsonResult result = new JsonResult();
        try {
            Customer customer = new Customer();
            customer.setStatus(Customer.STATUS_POTENTIAL);
            customer.setId(customertransfer.getCustomer().getId());
            customer.setSeller(UserContext.getCurEmp());

            customerService.updateNewSeller(customer);
            customerService.updateStatus(customer.getId(), Customer.STATUS_POTENTIAL);
            customerTransferService.saveOrUpdate(customertransfer);

        } catch (Exception e) {
            result.mark("something went wrong");
            e.printStackTrace();
        }
        return result;
    }

}
