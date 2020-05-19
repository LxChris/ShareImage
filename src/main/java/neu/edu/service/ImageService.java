package neu.edu.service;

import neu.edu.dao.CommentDao;
import neu.edu.dao.ImageDao;
import neu.edu.dao.UserDao;
import neu.edu.model.Comment;
import neu.edu.model.Image;
import neu.edu.model.User;
import neu.edu.util.CommonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Service
public class ImageService {
    @Autowired
    CommentDao commentDao;

    @Autowired
    UserDao userDao;

    @Autowired
    ImageDao imageDao;

    @Autowired
    CommentService commentService;

    /**
     * @Description: Save image to DB (first time)
     * @param image a Image object
     * @return neu.edu.model.Image
     * @date 2020/4/1 11:45
     */
    // TODO used for test only remove in future
    public Image saveImageForTest(Image image) {
        image.setCreateTime();
        image.setCreateTime();

        if (image.getUser() == null || image.getUsername() == null) {
            return null;
        }

        return imageDao.save(image);
    }
    
    /**
     * @Description: save image to db (first time)
     * @param image Image object
	 * @param foundUser User object, return by Dao
	 * @param imageFile MultipartFile, uploaded image file
	 * @param realRootPath  String, absolute path of root dir
     * @return neu.edu.model.Image
     * @date 2020/4/16 1:55
     */
    public Image saveImage(Image image, User foundUser, MultipartFile imageFile, String realRootPath) throws IOException {
        image.setCreateTime();
        image.setCreateTime();
        image.setType(CommonUtils.getFileExtension(imageFile.getOriginalFilename()));

        // TODO remove in the future wether need to judge if the user exist or not?
        if (image.getUser() == null || image.getUsername() == null) {
            return null;
        }


        String dirPath = "images/img";
        String fileName = UUID.randomUUID().toString() + "_" + imageFile.getOriginalFilename();
        File uploadFile = CommonUtils.multipartToFile(imageFile, realRootPath + dirPath, fileName);
        BufferedImage bufferedImage = ImageIO.read(uploadFile);
        image.setResolutionW(bufferedImage.getWidth());
        image.setResolutionH(bufferedImage.getHeight());
        image.setPath(dirPath + "/" + fileName);
        image = imageDao.save(image);
        foundUser.getImages().add(image);
        foundUser = userDao.save(foundUser);
        return image;
    }

    /**
     * @Description: Update Image Object to DB (after init save)
     * @param image Image object return by Dao
     * @return neu.edu.model.Image
     * @date 2020/4/11 22:12
     */
    public Image updateImage(Image image) {
        image.setUpdateTime();
        return imageDao.save(image);
    }

    /**
     * @Description: search Image via imageId
     * @param imageId String, imageId
     * @return neu.edu.model.Image
     * @date 2020/4/1 11:46
     */
    public Image findImageById(String imageId) {
        return imageDao.findByImageId(imageId);
    }
    
    /**
     * @Description: delete a image object
     * @param image a Image object return by DAO
     * @return void
     * @date 2020/4/1 11:46
     */
    public void deleteImage(Image image, String realRootPath) {
        List<Comment> comments = commentDao.findAllByImageId(image.getImageId());

        for (Comment comment : comments) {
            commentService.deleteComment(comment);
        }
        // Remove the image from the user
        User foundUser = userDao.findUserByUsername(image.getUsername());
        foundUser.getImages().remove(image);
        userDao.save(foundUser);
        image.setUser(null);
        // Delete the file
        CommonUtils.deleteFile(realRootPath + image.getPath());
        image = imageDao.save(image);
        imageDao.delete(image);
    }

    /**
     * @Description: increment the number of views when retrieving the image via GET request
     * @param image Image object return by Dao
     * @return neu.edu.model.Image
     * @date 2020/4/14 20:16
     */
    public Image imageGetView(Image image) {
        image.setViews(image.getViews() + 1);
        return updateImage(image);
    }

    /**
     * @Description: Return the most viewd images
     * @param pageNum   Page<Image>, a list of images
	 * @param pageSize  int, size of the page
     * @return org.springframework.data.domain.Page<neu.edu.model.Image>
     * @date 2020/4/19 11:13
     */
    public Page<Image> findAllImageByPage(int pageNum, int pageSize) {
        Sort sort = Sort.by(Sort.Direction.DESC, "views");

        PageRequest pageRequest = PageRequest.of(pageNum, pageSize, sort);
        Page<Image> imagePage = imageDao.findAll(pageRequest);

        return imagePage;
    }

    /**
     * @Description: Return a user's upload image
     * @param username  String, username
	 * @param pageNum   int, the number of current page
	 * @param pageSize  int, size of images per page
     * @return org.springframework.data.domain.Page<neu.edu.model.Image>
     * @date 2020/4/19 11:14
     */
    public Page<Image> findAllImageByUsernameAtPage(String username, int pageNum, int pageSize) {
        PageRequest pageRequest = PageRequest.of(pageNum, pageSize);
        Page<Image> imagePage = imageDao.findByUsernameContainingIgnoreCase(username, pageRequest);

        return imagePage;
    }
    
    /**
     * @Description: Return a list of image whose title contains the keyword
     * @param title String, title of the image
	 * @param pageNum   int, the number of current page
	 * @param pageSize  int, size of images per page
     * @return org.springframework.data.domain.Page<neu.edu.model.Image>
     * @date 2020/4/19 11:15
     */
    public Page<Image> findAllImageByTitleAtPage(String title, int pageNum, int pageSize) {
        PageRequest pageRequest = PageRequest.of(pageNum, pageSize);
        Page<Image> imagePage = imageDao.findByTitleContainingIgnoreCase(title, pageRequest);

        return imagePage;
    }

    /**
     * @Description:    Return a list of image whose tags contains the keyword
     * @param tag   String, a tag
     * @param pageNum   int, the number of current page
     * @param pageSize  int, size of images per page
     * @return org.springframework.data.domain.Page<neu.edu.model.Image>
     * @date 2020/4/19 11:16
     */
    public Page<Image> findAllImagesByTagAtPage(String tag, int pageNum, int pageSize) {
        PageRequest pageRequest = PageRequest.of(pageNum, pageSize);
        Page<Image> imagePage = imageDao.findByTagsContainingIgnoreCase(tag, pageRequest);

        return imagePage;
    }

    public void increaseNumOfDownload(Image image) {
        image.setDownloads(image.getDownloads() + 1);
        updateImage(image);
    }

}
