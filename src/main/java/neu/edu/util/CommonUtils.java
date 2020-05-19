package neu.edu.util;

import neu.edu.model.Comment;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CommonUtils {
    /**
     * @Description: check whether the input is a valid email address
     * @param emailAddress String
     * @return boolean
     * @date 2020/4/1 11:47
     */
    public static boolean isValidEmail(String emailAddress){
        String check = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
        Pattern regex = Pattern.compile(check);
        if (emailAddress == null){
            return false;
        }
        Matcher matcher = regex.matcher(emailAddress);
        boolean isValid = matcher.matches();
        return isValid;
    }
    
    /**
     * @Description: check whether the input is a valid username
     * @param username String
     * @return boolean
     * @date 2020/4/1 11:47
     */
    public static boolean isValidUsername(String username) {
        // Username only can contain number, char, and _. length: 4-16
            String regExp = "^[a-z0-9_-]{4,16}$";
            if (username.matches(regExp)) {
                return true;
            }else {
                return false;
        }
    }

    /**
     * @Description: check whether the input is a valid password
     * @param password String
     * @return boolean
     * @date 2020/4/1 11:48
     */
    public static boolean isPwdValid(String password) {
        // Check password is valid or not
        String regexZ = "\\d*";
        String regexS = "[a-zA-Z]+";
        String regexT = "\\W+$";
        String regexZT = "\\D*";
        String regexST = "[\\d\\W]*";
        String regexZS = "\\w*";
        String regexZST = "[\\w\\W]*";

        if (password.length() <= 8) {
            return false;
        }
        if (password.matches(regexZ)) {
            return false;
        }
        if (password.matches(regexS)) {
            return false;
        }
        if (password.matches(regexT)) {
            return false;
        }
        if (password.matches(regexZT)) {
            return true;
        }
        if (password.matches(regexST)) {
            return true;
        }
        if (password.matches(regexZS)) {
            return true;
        }
        if (password.matches(regexZST)) {
            return true;
        }
        return false;
    }

    /**
     * @Description: check a file is a valid image format
     * @param fileName String, file name
     * @return boolean
     * @date 2020/4/8 15:43
     */
    public static boolean isValidImageFormat(String fileName) {
        String allowedFileExtensions = ".jpg,.jpeg,.png,.gif,.bmp,";
        int lastIndex = fileName.lastIndexOf('.');
        String fileExtension = fileName.substring(lastIndex).toLowerCase();

        return allowedFileExtensions.contains(fileExtension);
    }
    
    /**
     * @Description: return the Extensition of a file
     * @param fileName String
     * @return java.lang.String
     * @date 2020/4/11 22:18
     */
    public static String getFileExtension(String fileName) {
        int lastIndex = fileName.lastIndexOf('.');
        String fileExtension = fileName.substring(lastIndex + 1).toLowerCase();
        
        return fileExtension;
    }

   /**
    * @Description: convert a MultiPart to File and save to dirPath
    * @param multipart  MultipartFile object
    * @param dirPath    directory path
    * @param filename   filename
    * @return java.io.File
    * @date 2020/4/8 17:29
    */
    public static File multipartToFile(MultipartFile multipart, String dirPath, String filename) throws IllegalStateException, IOException, IOException, IOException {
        CommonUtils.createFolderIfNotExist(new File(dirPath));

        File convFile = new File(dirPath + "/" + filename);
        multipart.transferTo(convFile);
        return convFile;
    }

    /**
     * @Description: delete a File
     * @param filePath String, path of the file to delete
     * @return boolean  Flag indicating the delete is successful or not
     * @date 2020/4/10 14:34
     */
    public static boolean deleteFile(String filePath) {
        File file = new File(filePath);
        if (!file.exists()) {
            return false;
        }

        if (file.isDirectory()) {
            return false;
        }

        return file.delete();
    }

    /**
     * @Description: create a folder if not exist
     * @param file File, path to the directory
     * @return void
     * @date 2020/4/8 15:59
     */
    public static void createFolderIfNotExist(File file){
        if(!file.exists()){
            file.mkdir();
        }
    }

    /**
     * @Description: sort the list by updateTime DESC
     * @param list  List<Comment>, return by Dao
     * @return void
     * @date 2020/4/16 1:56
     */
    public static void commentsSortByUpdateTimeDesc(List<Comment> list) {
        list.sort(new Comparator<Comment>() {
            @Override
            public int compare(Comment o1, Comment o2) {
                if (o1.getUpdateTime().isAfter(o2.getUpdateTime())) {
                    return -1;
                } else if (o1.getUpdateTime().isBefore(o2.getUpdateTime())) {
                    return 1;
                } else {
                    return 0;
                }
            }
        });
    }
}
