package neu.edu.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;
import neu.edu.dao.CommentDao;
import neu.edu.dao.ImageDao;
import neu.edu.dao.UserDao;
import neu.edu.model.Comment;
import neu.edu.model.Image;
import neu.edu.model.User;
import neu.edu.util.CommonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    CommentDao commentDao;

    @Autowired
    UserDao userDao;

    @Autowired
    ImageDao imageDao;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userDao.findUserByUsername(username);

        if (user == null) {
            throw new UsernameNotFoundException("User not found with username: " + username);
        }
        return new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(), new ArrayList<>());
    }

    /**
     * @Description: save User to DB (first time)
     * @param user a User Object
     * @return neu.edu.model.User
     * @date 2020/4/1 11:39
     */
    public User saveUser(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setCreateTime();
        user.setUpdateTime();
        user.setProfileImagePath("images/userAvator.jpg");
        if (user.getUsername() == null || user.getEmail() == null) {
            return null;
        }
        return userDao.save(user);
    }
    
    /**
     * @Description: update User object information in DB
     * @param user a User Object return by DAO
     * @return neu.edu.model.User
     * @date 2020/4/1 11:42
     */
    public User updateUser(User user) {
        user.setUpdateTime();
        return userDao.save(user);
    }

    /**
     * @Description: update a user's avatar
     * @param user  User object
	 * @param imageFile MultipartFile object
	 * @param realRootPath  String, absolute path of source folder,return from controller
     * @return neu.edu.model.User
     * @date 2020/4/9 15:53
     */
    public User updateUserAvatar(User user,  MultipartFile imageFile, String realRootPath) throws IOException {
        // Delete old avatar if exist
        if (user.getProfileImagePath() != null && !user.getProfileImagePath().equals("")) {
            String defaultAvatarPath = "images/userAvator.jpg";
            if (!user.getProfileImagePath().equals(defaultAvatarPath)) {
                // Only delete file if the avatar is not the default one
                CommonUtils.deleteFile(realRootPath + user.getProfileImagePath());
            }
        }

        String dirPath = "images/avatar";
        String fileName = UUID.randomUUID().toString() + "_" + imageFile.getOriginalFilename();
        // Convert MultipartFile to File
        File uploadFile = CommonUtils.multipartToFile(imageFile, realRootPath + dirPath, fileName);

        user.setProfileImagePath(dirPath + "/" + fileName);
        return updateUser(user);
    }

    /**
     * @Description: encrypt a password with PasswordEncoder
     * @param user User object
	 * @param password  String, password which has not been encrypted
     * @return neu.edu.model.User
     * @date 2020/4/9 15:55
     */
    public User encryptUserPassword(User user, String password) {
        user.setPassword(passwordEncoder.encode(password));

        return user;
    }

    /**
     * @Description: return whether a username exist
     * @param username username used to registration
     * @return boolean
     * @date 2020/4/1 11:43
     */
    public boolean isUserExist(String username) {
        return findUserByUsername(username) != null;
    }
    
    /**
     * @Description: return whether a email exist
     * @param email email used to registration
     * @return boolean
     * @date 2020/4/1 11:43
     */
    public boolean isEmailExist(String email) {
        return findUserByEmail(email) != null;
    }
    
    /**
     * @Description: search a User via username
     * @param username username
     * @return neu.edu.model.User
     * @date 2020/4/1 11:44
     */
    public User findUserByUsername(String username) {
        return userDao.findUserByUsername(username);
    }

    /**
     * @Description: search a User via email
     * @param email email
     * @return neu.edu.model.User
     * @date 2020/4/1 11:44
     */
    public User findUserByEmail(String email) {
        return userDao.findUserByEmail(email);
    }
}
