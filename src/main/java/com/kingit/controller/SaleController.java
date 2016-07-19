package com.kingit.controller;

import com.google.common.collect.Maps;
import com.kingit.dto.DatatableResult;
import com.kingit.exception.DataException;
import com.kingit.exception.ForbiddenException;
import com.kingit.exception.NotFoundException;
import com.kingit.pojo.Sale;
import com.kingit.pojo.SaleLog;
import com.kingit.pojo.Salefile;
import com.kingit.service.CustomerService;
import com.kingit.service.SaleService;
import com.kingit.service.UserService;
import com.kingit.utils.ShiroUtil;
import com.kingit.utils.Strings;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/7/16.
 */
@Controller
@RequestMapping("/sale")
public class SaleController {
    @Value("${saleFilePath}")
    private String savePath;
    @Inject
    private SaleService saleService;
    @Inject
    private UserService userService;
    @Inject
    private CustomerService customerService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String saleList(Model model) {
        model.addAttribute("userid", ShiroUtil.getCurrentUserId());
        model.addAttribute("userlist", userService.findUserList());
        model.addAttribute("companyList", customerService.findCompanyList());

        model.addAttribute("customerList", customerService.findByOwerUserid());

        return "sale/list";
    }

    @RequestMapping(value = "/load", method = RequestMethod.GET)
    @ResponseBody
    public DatatableResult saleListLoad(HttpServletRequest request) {
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");

        String changename = request.getParameter("changename");
        changename = Strings.toUTF8(changename);
        String progress = request.getParameter("progress");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");


        Map<String, Object> param = Maps.newHashMap();
        param.put("start", start);
        param.put("length", length);
        param.put("changename", changename);
        param.put("progress", progress);
        param.put("startDate", startDate);
        param.put("endDate", endDate);


        Long filterCount = saleService.countByParam(param);
        Long totalCount = saleService.totalCount();
        List<Sale> saleList = saleService.findByParam(param);


        return new DatatableResult<>(draw, filterCount, totalCount, saleList);
    }

    @RequestMapping(value = "/view/{id:\\d+}", method = RequestMethod.GET)
    public String view(@PathVariable("id") Integer id, Model model) {
        Sale sale = saleService.findById(id);
        if (sale == null) {
            throw new NotFoundException();
        }
        if (!(ShiroUtil.isManger() || ShiroUtil.getCurrentUserId().equals(sale.getUserid()))) {
            throw new ForbiddenException();
        }
        List<SaleLog> saleLogList = saleService.findSaleLogBySaleId(id);
        List<Salefile> fileList = saleService.findFileBySaleId(id);
        model.addAttribute("fileList",fileList);
        model.addAttribute("sale", sale);
        model.addAttribute("saleLogList", saleLogList);
        return "sale/view";
    }

    @RequestMapping(value = "/new", method = RequestMethod.POST)
    @ResponseBody
    public String newSale(Sale sale) {
        if (sale == null) {
            throw new DataException("服务器异常");
        }
        saleService.save(sale);
        return "success";
    }

    @RequestMapping(value = "/edit/{id:\\d+}", method = RequestMethod.POST)
    public String editSaleProgress(Integer id, String progress, RedirectAttributes redirectAttributes) {
        Sale sale = saleService.findById(id);
        if (sale == null) {
            throw new DataException("服务器异常");
        }
        if (!(ShiroUtil.isManger() || ShiroUtil.getCurrentUserId().equals(sale.getUserid()))) {
            throw new ForbiddenException();
        }
        saleService.editSale(sale, progress, SaleLog.TYPE_LOG_AUTO);
        redirectAttributes.addFlashAttribute("message", "修改进度成功.");
        return "redirect:/sale/view/" + sale.getId();
    }

    @RequestMapping(value = "/edithand/{id:\\d+}", method = RequestMethod.POST)
    @ResponseBody
    public String editByHand(@PathVariable("id") Integer id, String content,RedirectAttributes redirectAttributes) {
        Sale sale = saleService.findById(id);
        if (sale == null) {
            throw new DataException("服务器异常");
        }
        if (!(ShiroUtil.isManger() || ShiroUtil.getCurrentUserId().equals(sale.getUserid()))) {
            throw new ForbiddenException();
        }
        saleService.editSale(sale, content, SaleLog.TYPE_LOG_HAND);
        redirectAttributes.addFlashAttribute("message","跟进新的记录.");
        return "success";
    }

    @RequestMapping(value = "/del/{id:\\d+}", method = RequestMethod.GET)
    @ResponseBody
    public String delSale(@PathVariable("id") Integer id,RedirectAttributes redirectAttributes) {
        String content = "删除项目";
        Sale sale = saleService.findById(id);
        if (sale == null) {
            throw new NotFoundException();
        }
        if (!(ShiroUtil.isManger() || ShiroUtil.getCurrentUserId().equals(sale.getUserid()))) {
            throw new ForbiddenException();
        }
        saleService.delSale(sale, content, SaleLog.TYPE_LOG_AUTO);
        redirectAttributes.addFlashAttribute("message","删除机会成功");
        return "success";
    }

    @RequestMapping(value = "/file/upload", method = RequestMethod.POST)
    @ResponseBody
    public String saveSaleFile(MultipartFile file,Integer saleid, RedirectAttributes redirectAttributes) throws IOException {
        if (file.isEmpty()) {
            throw new NotFoundException();
        }

        saleService.saveFile(file.getInputStream(), file.getOriginalFilename(), file.getContentType(), file.getSize(),saleid);
        redirectAttributes.addFlashAttribute("message","文件上传成功");
        return "success";
    }

    @RequestMapping(value = "/file/{id:\\d+}", method = RequestMethod.GET)
    public ResponseEntity<InputStreamResource> downloadSaleFile(@PathVariable("id") Integer id) throws FileNotFoundException {
        Salefile salefile = saleService.findFileById(id);
        if (salefile==null){
            throw new NotFoundException();
        }
        File file = new File(savePath,salefile.getFilename());
        if (!file.exists()){
            throw new NotFoundException();
        }
        FileInputStream fileInputStream = new FileInputStream(file);
        String originName = salefile.getName();
        originName = Strings.utf8ToIso8859(originName);
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(salefile.getContenttype()))
                .contentLength(file.length())
                .header("Content-Disposition", "attachment;filename=\"" + originName + "\"")
                .body(new InputStreamResource(fileInputStream));


    }
}
