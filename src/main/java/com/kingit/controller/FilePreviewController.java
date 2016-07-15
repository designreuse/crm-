package com.kingit.controller;

import com.kingit.exception.NotFoundException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

/**
 * Created by Administrator on 2016/7/12.
 */
@Controller
public class FilePreviewController {
    @Value("${imagePath}")
    private String filePath;

//    @RequestMapping("/preview/{fileName}")
//    public void previewFile(@PathVariable("fileName") String fileName, HttpServletResponse response) throws IOException {
//        File file = new File(filePath,fileName);
//        if (!file.exists()){
//            throw new NotFoundException();
//        }
//
//        FileInputStream fileInputStream = new FileInputStream(file);
//       OutputStream outputStream = response.getOutputStream();
//        IOUtils.copy(fileInputStream,outputStream);
//
//        outputStream.flush();
//        outputStream.close();
//        fileInputStream.close();
//
//    }

    @RequestMapping("/preview/{fileName}")
    public ResponseEntity<InputStreamResource> previewFile(@PathVariable("fileName") String fileName) throws IOException {
        File file = new File(filePath,fileName);
        if (!file.exists()){
            throw new NotFoundException();
        }
        FileInputStream fileInputStream = new FileInputStream(file);
        return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body(new InputStreamResource(fileInputStream));
    }

}
