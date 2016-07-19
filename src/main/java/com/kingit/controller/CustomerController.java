package com.kingit.controller;

import com.google.common.collect.Maps;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.kingit.dto.DatatableResult;
import com.kingit.exception.ForbiddenException;
import com.kingit.exception.NotFoundException;
import com.kingit.pojo.Customer;
import com.kingit.pojo.Todo;
import com.kingit.pojo.User;
import com.kingit.service.CustomerService;
import com.kingit.service.TodoService;
import com.kingit.service.UserService;
import com.kingit.utils.ShiroUtil;
import com.kingit.utils.Strings;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/7/14.
 */
@Controller
@RequestMapping("/customer")
public class CustomerController {
    @Inject
    private CustomerService customerService;
    @Inject
    private UserService userService;
    @Inject
    private TodoService todoService;

    private void testNullOrForbid(Customer customer) {
        if (customer == null) {
            throw new NotFoundException();
        }
        if (customer.getUserid() != null && !ShiroUtil.isManger() && !(ShiroUtil.getCurrentUserId().equals(customer.getUserid()))) {
            throw new ForbiddenException();
        }
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list() {
        return "customer/list";
    }


    @RequestMapping(value = "/list", method = RequestMethod.POST)
    @ResponseBody
    public String newCustomer(Customer customer) {
        customerService.save(customer);
        return "success";
    }

    @RequestMapping(value = "/getcompanylist", method = RequestMethod.GET)
    @ResponseBody
    public List<Customer> getcompanylist(Customer customer) {
        return customerService.findCompanyList();
    }

    @RequestMapping(value = "/show.json", method = RequestMethod.GET)
    @ResponseBody
    public DatatableResult show(HttpServletRequest request) {
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        String keyword = request.getParameter("search[value]");
        keyword = Strings.toUTF8(keyword);

        Map<String, Object> param = Maps.newHashMap();
        param.put("start", start);
        param.put("length", length);
        param.put("keyword", keyword);

        long filterCount = customerService.getFilterCount(param);
        long totalCount = customerService.getTotalCount();
        List<Customer> customerList = customerService.findByParam(param);


        return new DatatableResult(draw, filterCount, totalCount, customerList);

    }

    @RequestMapping(value = "/del/{id:\\d+}", method = RequestMethod.GET)
    @ResponseBody
    public String del(@PathVariable("id") Integer id) {
        if (customerService.findById(id) == null) {
            throw new NotFoundException();
        }
        customerService.delete(id);
        return ("success");
    }

    @RequestMapping(value = "/edit/{id:\\d+}", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> editForm(@PathVariable("id") Integer id) {
        List<Customer> companys = customerService.findCompanyList();
        Customer customer = customerService.findById(id);
        if (customer == null) {
            throw new NotFoundException();
        }
        Map<String, Object> result = Maps.newHashMap();
        result.put("companys", companys);
        result.put("customer", customer);
        return result;

    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ResponseBody
    public String edit(Customer customer) {
        if (customer == null) {
            throw new NotFoundException();
        }
        customerService.update(customer);
        return ("success");
    }

    @RequestMapping(value = "/view/{id:\\d+}", method = RequestMethod.GET)
    public String view(@PathVariable("id") Integer id, Model model) {
        Customer customer = customerService.findById(id);
       testNullOrForbid(customer);

        model.addAttribute("customer", customer);
        if (customer.getType().equals(Customer.TYPE_COMPANY)) {
            List<Customer> customerList = customerService.findCustomerByComapnyid(customer.getId());
            model.addAttribute("customerList", customerList);
        }

        model.addAttribute("userid", ShiroUtil.getCurrentUserId());
        System.out.println(ShiroUtil.getCurrentUserId());
        System.out.println("===========");

        List<User> userList = userService.findAll();
        model.addAttribute("userList", userList);

        return "customer/view";
    }



    @RequestMapping(value = "/move", method = RequestMethod.POST)
    public String move(Integer id, Integer userid, RedirectAttributes redirectAttributes) {
        Customer customer = customerService.findById(id);
        testNullOrForbid(customer);
        if (!customerService.isCompanyEmpty(customer)) {
            redirectAttributes.addFlashAttribute("message", "该公司内还有您的客户,暂时无法转含有您顾客的公司.");
            return "redirect:/customer/view/" + id;
        }

        customerService.moveCustomer(customer, userid);

        return "redirect:/customer/list";
    }


    @RequestMapping(value = "/open/{id:\\d+}", method = RequestMethod.GET)
    public String open(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        Customer customer = customerService.findById(id);
        testNullOrForbid(customer);
        if (!customerService.isCompanyEmpty(customer)) {
            redirectAttributes.addFlashAttribute("message", "该公司内还有您的客户,暂时无法设为公有.");
            return "redirect:/customer/view/" + id;
        }

        customerService.openCustomer(customer);
        redirectAttributes.addFlashAttribute("message", "公开客户成功.");
        return "redirect:/customer/view/" + id;
    }

    @RequestMapping(value = "/private/{id:\\d+}", method = RequestMethod.GET)
    public String privateCustomer(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        Customer customer = customerService.findById(id);
        testNullOrForbid(customer);
        customerService.privateCustomer(customer);

        redirectAttributes.addFlashAttribute("message", "私有客户成功,请珍惜自己的顾客.");
        return "redirect:/customer/view/" + id;
    }


    @RequestMapping(value = "/qrcode/{id:\\d+}.png", method = RequestMethod.GET)
    public void makeQrcode(@PathVariable Integer id, HttpServletResponse response) throws WriterException, IOException {
        String mecard = customerService.makeMecard(id);

        Map<EncodeHintType, String> hints = Maps.newHashMap();
        hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");

        BitMatrix bitMatrix = new MultiFormatWriter().encode(mecard, BarcodeFormat.QR_CODE, 200, 200, hints);
        OutputStream outputStream = response.getOutputStream();
        MatrixToImageWriter.writeToStream(bitMatrix, "png", outputStream);
        outputStream.flush();
        outputStream.close();

    }

    @RequestMapping(value = "/newtodo",method = RequestMethod.POST)
    public String newTodo(Todo todo,String hour,String minute){
        todoService.saveCustomTodo(todo,hour,minute);
        return "redirect:/customer/view/"+todo.getCustid();
    }


}
