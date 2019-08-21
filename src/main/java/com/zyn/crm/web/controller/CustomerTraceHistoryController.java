package com.zyn.crm.web.controller;

import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.CustomerTraceHistory;
import com.zyn.crm.domain.SystemDictionaryItem;
import com.zyn.crm.query.CustomerTraceHistoryQueryObject;
import com.zyn.crm.service.ICustomerTraceHistoryService;
import com.zyn.crm.service.ISystemDictionaryItemService;
import com.zyn.crm.util.JsonResult;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/customerTraceHistory")
public class CustomerTraceHistoryController {
    @Autowired
    private ICustomerTraceHistoryService customerTraceHistoryService;
    @Autowired
    private ISystemDictionaryItemService systemDictionaryItemService;

    @RequestMapping("/list")
    public String list(Model model, @ModelAttribute("qo") CustomerTraceHistoryQueryObject qo) {
        PageInfo pageInfo = customerTraceHistoryService.query(qo);


        model.addAttribute("ccts", systemDictionaryItemService.listBySn("communicationMethod"));
        model.addAttribute("pageInfo", pageInfo);
        return "customerTraceHistory/list";
    }




    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    @RequiresPermissions(value={"customerTraceHistory_saveOrUpdate", "customerTraceHistory:saveOrUpdate"}, logical = Logical.OR)
    public JsonResult saveOrUpdate(CustomerTraceHistory customerTraceHistory) {
        JsonResult result = new JsonResult();
        try {
            customerTraceHistoryService.saveOrUpdate(customerTraceHistory);
        } catch (Exception e) {
            result.mark("something went wrong");
            e.printStackTrace();
        }
        return result;
    }

}
