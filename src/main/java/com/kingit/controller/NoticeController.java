package com.kingit.controller;

import com.google.common.collect.Maps;
import com.kingit.dto.DatatableResult;
import com.kingit.exception.DataException;
import com.kingit.pojo.Notice;
import com.kingit.service.NoticeService;
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
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/7/11.
 */
@Controller
@RequestMapping("/notice")
public class NoticeController {
    @Inject
    private NoticeService noticeService;
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public String list(){
        return "notice/list";
    }

    @RequestMapping(value = "/list.json",method = RequestMethod.GET)
    @ResponseBody
    public DatatableResult list(HttpServletRequest request){

        String start = request.getParameter("start");
        String length = request.getParameter("length");
        String draw = request.getParameter("draw");

        Map<String,Object> param = Maps.newHashMap();
        param.put("start",start);
        param.put("length",length);

        List<Notice> noticeList = noticeService.findByParam(param);
        Long count = noticeService.getTotalCount();

        return new DatatableResult(draw,count,count,noticeList);
    }

    @RequestMapping(value = "/new",method = RequestMethod.GET)
    public String newNotice(){
        return "notice/new";
    }

    @RequestMapping(value = "/new",method = RequestMethod.POST)
    public String newNotice(Notice notice, RedirectAttributes redirectAttributes){
        noticeService.saveNotice(notice);
        redirectAttributes.addFlashAttribute("message","success");
        return "redirect:/notice/list";
    }

    @RequestMapping(value = "/topic/{id:\\d+}",method = RequestMethod.GET)
    public String topic(@PathVariable("id") Integer id, Model model){
        Notice notice = noticeService.findById(id);
        if (notice==null){
            return "redirect:/404";
        }
        model.addAttribute("notice",notice);
        return "notice/topic";
    }

    @RequestMapping(value = "/img/upload",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> uploadImg(MultipartFile file){
        Map<String,Object> result = Maps.newHashMap();
        if(!file.isEmpty()){
            try {
                String path = noticeService.saveImage(file.getInputStream(),file.getOriginalFilename());
                result.put("success",true);
                result.put("file_path",path);
                System.out.println("--------------------");
                System.out.println(path);
                return result;
            } catch (IOException e) {
                throw new DataException("文件保存失败");
            }
        }else {
            result.put("success",false);
            result.put("msg","请选择文件");
            return result;
        }
    }

}