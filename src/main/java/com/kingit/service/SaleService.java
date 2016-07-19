package com.kingit.service;

import com.kingit.mapper.SaleLogMapper;
import com.kingit.mapper.SaleMapper;
import com.kingit.mapper.SalefileMapper;
import com.kingit.pojo.Customer;
import com.kingit.pojo.Sale;
import com.kingit.pojo.SaleLog;
import com.kingit.pojo.Salefile;
import com.kingit.utils.ShiroUtil;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import javax.inject.Named;
import java.io.*;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Named
public class SaleService {
    @Value("${saleFilePath}")
    private String savePath;
    @Inject
    private SaleMapper saleMapper;
    @Inject
    private SalefileMapper salefileMapper;
    @Inject
    private SaleLogMapper saleLogMapper;
    @Inject
    private CustomerService customerService;


    public Long countByParam(Map<String, Object> param) {
        return saleMapper.countByParam(param);
    }

    public Long totalCount() {
        return saleMapper.totalCount();
    }

    public List<Sale> findByParam(Map<String, Object> param) {
        return saleMapper.findByParam(param);
    }

    public void save(Sale sale) {
        Customer customer = customerService.findById(sale.getCustid());
        sale.setUserid(ShiroUtil.getCurrentUserId());
        sale.setUsername(ShiroUtil.getCurrentRealName());
        sale.setCustname(customer.getName());
        sale.setLasttime(DateTime.now().toString("yyyy-MM-dd hh:mm:ss"));

        saleMapper.save(sale);

        SaleLog saveLog = new SaleLog(ShiroUtil.getCurrentRealName() + ":" + SaleLog.TYPE_CONTRNT_FIRST, SaleLog.TYPE_LOG_AUTO, sale.getId());
        saleLogMapper.save(saveLog);
    }

    public Sale findById(Integer id) {
        return saleMapper.findById(id);
    }

    @Transactional
    public void editSale(Sale sale, String progress, String editType) {
        String oldProgress = sale.getProgress();
        String newProgress = progress;
        sale.setProgress(newProgress);
        if (newProgress.equals("完成交易")) {
            sale.setSuccesstime(DateTime.now().toString("yyyy-MM-dd"));
        }
        sale.setLasttime(DateTime.now().toString("yyyy-MM-dd HH:mm:ss"));
        saleMapper.update(sale);

        String content = "将进程:" + oldProgress + "修改为" + newProgress;

        if (editType.equals("hand")) {
            content = "手动修改进程为:" + progress;
        }
        saleLogMapper.save(new SaleLog(content, editType, sale.getId()));
    }

    public List<SaleLog> findSaleLogBySaleId(Integer id) {
        return saleLogMapper.findBySaleId(id);
    }

    @Transactional
    public void delSale(Sale sale, String content, String typeLogAuto) {
        salefileMapper.delBySaleId(sale.getId());
        saleLogMapper.delBySaleId(sale.getId());
        saleMapper.delSale(sale.getId());
    }

    @Transactional
    public void saveFile(InputStream inputStream, String originalFilename, String contentType, long size, Integer saleid) throws IOException {
        String extName = "";
        File file = new File("E:/image/salefile");
        if (!file.exists() && !file.isDirectory()) {
            file.mkdir();
        }
        if (originalFilename.contains(".")) ;
        {
            extName = originalFilename.substring(originalFilename.lastIndexOf("."));
        }

        String filename = UUID.randomUUID().toString() + extName;


        FileOutputStream outputStream = new FileOutputStream(new File(savePath, filename));
        IOUtils.copy(inputStream, outputStream);
        outputStream.flush();
        outputStream.close();
        inputStream.close();

        Salefile saleFile = new Salefile();
        saleFile.setContenttype(contentType);
        saleFile.setFilename(filename);
        saleFile.setSize(FileUtils.byteCountToDisplaySize(size));
        saleFile.setName(originalFilename);
        saleFile.setSaleid(saleid);
        salefileMapper.save(saleFile);

        saleLogMapper.save(new SaleLog("上传文件:"+originalFilename, SaleLog.TYPE_LOG_AUTO, saleid));
    }

    public List<Salefile> findFileBySaleId(Integer id) {
        return salefileMapper.findBySaleId(id);
    }

    public Salefile findFileById(Integer id) {
        return salefileMapper.findById(id);
    }
}
