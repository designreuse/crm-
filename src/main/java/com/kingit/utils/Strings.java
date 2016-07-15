package com.kingit.utils;

import com.kingit.exception.DataException;
import com.mysql.jdbc.StringUtils;
import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;
import org.apache.commons.lang3.math.NumberUtils;

import java.io.UnsupportedEncodingException;

/**
 * Created by Administrator on 2016/7/5.
 */
public class Strings {
    public static String toUTF8(String string){
        if (StringUtils.isNullOrEmpty(string)){
            return "";
        }else {
            try {
                return new String(string.getBytes("ISO8859-1"),"UTF-8");
            } catch (UnsupportedEncodingException e) {
                throw new RuntimeException("字符串转换异常");
            }
        }
    }

    public static Integer StringToInt(String str){
        if (NumberUtils.isNumber(str)){
            return NumberUtils.toInt(str);
        }
        return null;
    }

    public static String utf8ToIso8859(String string){
        try {
            return new String(string.getBytes("UTF-8"),"ISO8859-1");
        } catch (UnsupportedEncodingException e) {
            throw new DataException("格式转换异常");
        }
    }

    public static String iso8859ToUtf8(String string) {
        try {
            return new String(string.getBytes("ISO8859-1"),"UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new DataException("格式转换异常");
        }
    }

    public static String hanziToPinyin(String str){
        HanyuPinyinOutputFormat format = new HanyuPinyinOutputFormat();
        format.setCaseType(HanyuPinyinCaseType.LOWERCASE);//汉字转为小写拼音
        format.setToneType(HanyuPinyinToneType.WITHOUT_TONE);//拼音不要音调
        format.setVCharType(HanyuPinyinVCharType.WITH_V);//u:发音用V
        try {
            return PinyinHelper.toHanYuPinyinString(str,format,"",true);
        } catch (BadHanyuPinyinOutputFormatCombination badHanyuPinyinOutputFormatCombination) {
            throw new DataException("汉字转拼音异常",badHanyuPinyinOutputFormatCombination);
        }
    }


}
