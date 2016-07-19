package com.kingit.utils;

/**
 * Created by Administrator on 2016/7/16.
 */
public class SqlUtil {
    public static String save(String... args) {
        if (args.length == 0) {
            return "";
        }
        String saveStatement = "";
        String saveStatement2 = "";
        for (int i = 0; i < args.length; i++) {
            saveStatement += args[i] + ",";
            saveStatement2 += "#{" + args[i] + "},";
        }
        saveStatement = saveStatement.substring(0, saveStatement.length() - 1);
        saveStatement2 = saveStatement2.substring(0, saveStatement2.length() - 1);
        return "INSERT INTO  " + "t_xxx" + "(" + saveStatement + ")" + "  VALUES(" + saveStatement2 + ")";
    }

    public static String update(String... args) {
        if (args.length == 0) {
            return "";
        }
        String saveStatement = "";
        String saveStatement2 = "";
        String saveStatement3 = "";
        for (int i = 0; i < args.length; i++) {
            saveStatement = args[i];
            saveStatement2 = "#{" + args[i] + "}";
            saveStatement3 += saveStatement + "=" + saveStatement2 + ",";
        }
        saveStatement3 = saveStatement3.substring(0,saveStatement3.length() - 1);
        return "UPDATE  " + "t_xxx " + "SET " + saveStatement3 + " WHERE id=#{id}";
    }

    public static String setUpdate(String... args) {
        if (args.length == 0) {
            return "";
        }
        String saveStatement = "";
        String saveStatement2 = "";
        String saveStatement3 = "";
        for (int i = 0; i < args.length; i++) {
            saveStatement = args[i];
            saveStatement2 = "#{" + args[i] + "}";
            if (args.length==1){
                saveStatement3 +="<if test =\" "+args[i]+" !=null and "+args[i]+"!=''\">"+ " "+saveStatement + "=" + saveStatement2 + "</if>";
                break;
            }
            if (i==0){
                saveStatement3 +="<if test =\" "+args[i]+" !=null and "+args[i]+"!=''\">"+ " "+saveStatement + "=" + saveStatement2 + ",</if>";
            }else if (i<args.length-1){
                saveStatement3 +="<if test =\" "+args[i]+" !=null and "+args[i]+"!=''\">"+ saveStatement + "=" + saveStatement2 + ",</if>";
            }else {
                saveStatement3 +="<if test =\" "+args[i]+" !=null and "+args[i]+"!=''\">"+ saveStatement + "=" + saveStatement2 + "</if>";
            }
        }
        return "UPDATE  " + "t_xxx " + "<set> " + saveStatement3 + "</set> WHERE id=#{id}";
    }
}
