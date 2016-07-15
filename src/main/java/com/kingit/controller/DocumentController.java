package com.kingit.controller;

import com.kingit.exception.NotFoundException;
import com.kingit.pojo.Document;
import com.kingit.service.DocumentService;
import com.kingit.utils.Strings;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.inject.Inject;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

/**
 * Created by Administrator on 2016/7/13.
 */
@Controller
@RequestMapping("/doc")
public class DocumentController {
    @Inject
    private DocumentService documentService;

    @Value("${imagePath}")
    private String savePath;

    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model,
                       @RequestParam(required = false, defaultValue = "0") Integer fid) {
        List<Document> documentList = documentService.findByFid(fid);
        Document document = documentService.findById(fid);
        if (document == null && fid != 0){
            return "redirect:/404";
        }
        model.addAttribute("fid", fid);
        model.addAttribute("documentList", documentList);
        return "document/list";
    }

    @RequestMapping(value = "/file/upload", method = RequestMethod.POST)
    @ResponseBody
    public String saveFile(MultipartFile file, Integer fid, RedirectAttributes redirectAttributes) throws IOException {
        if (file.isEmpty()) {
            return "redirect:/404";
        }
        System.out.println(file.getContentType());
        documentService.saveFile(file.getInputStream(), file.getOriginalFilename(), fid, file.getContentType(), file.getSize());
        redirectAttributes.addFlashAttribute("message","文件上传成功");
        return "success";

    }

    @RequestMapping(value = "/dir/new", method = RequestMethod.POST)
    @ResponseBody
    public String newDir(String dirname, Integer fid) {
        documentService.newDir(dirname, fid);
        return "success";
    }

    @RequestMapping(value = "/download/{id:\\d+}", method = RequestMethod.GET)
    public ResponseEntity fileDownload(@PathVariable("id") Integer id) throws FileNotFoundException {
        Document document = documentService.findById(id);
        if (document == null) {
            throw new NotFoundException();
        }

        File file = new File(savePath, document.getFilename());
        if (!file.exists()) {
            throw new NotFoundException();
        }
        FileInputStream fileInputStream = new FileInputStream(file);
        String fileName = document.getName();
        fileName = Strings.utf8ToIso8859(fileName);

        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(document.getContenttype()))
                .contentLength(file.length())
                .header("Content-Disposition", "attachment;filename=\"" + fileName + "\"")
                .body(new InputStreamResource(fileInputStream));


    }
}
