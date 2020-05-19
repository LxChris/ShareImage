package neu.edu.service;

import neu.edu.dao.CommentDao;
import neu.edu.dao.UserDao;
import neu.edu.model.Comment;
import neu.edu.model.Image;
import neu.edu.model.User;
import neu.edu.util.CommonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {
    @Autowired
    private CommentDao commentDao;

    @Autowired
    private UserDao userDao;

    @Autowired
    private UserService userService;

    @Autowired
    private ImageService imageService;

    /**
     * @Description: save Comment to database (first time)
     * @param comment a Comment object
     * @return neu.edu.model.Comment
     * @date 2020/4/1 10:30
     */
    public Comment saveComment(Comment comment) {
        // Save a new comment in db
        comment.setCreateTime();
        comment.setUpdateTime();
        if (comment.getUser() == null || comment.getUsername() == null) {
            return null;
        }

        Image foundImage = imageService.findImageById(comment.getImageId());
        if (foundImage != null) {
            // TODO Error handling
            foundImage.setNumComments(foundImage.getNumComments() + 1);
            imageService.updateImage(foundImage);
        }
        return commentDao.save(comment);
    }

    /**
     * @Description: find a Comment object by using a unique commentId
     * @param commentId unique comment identifier
     * @return neu.edu.model.Comment
     * @date 2020/4/1 10:31
     */
    public Comment findCommentByCommentId(String commentId) {
        return commentDao.findByCommentId(commentId);
    }

    /**
     * @Description: delete a comment
     * @param comment comment object return by DAO
     * @return void
     * @date 2020/4/1 10:35
     */
    public void deleteComment(Comment comment) {
        User foundUser = userDao.findUserByUsername(comment.getUsername());
        if (foundUser == null) {
            System.out.println("ERROR: dirty data found (no userId) commentId: " + comment.getCommentId());
            return;
        }
        // Remove relationship
        foundUser.getComments().remove(comment);
        userService.updateUser(foundUser);

        // Decrease the numComments of the image
        Image foundImage = imageService.findImageById(comment.getImageId());
        foundImage.setNumComments(foundImage.getNumComments() - 1);
        imageService.updateImage(foundImage);

        comment.setUser(null);
        comment = commentDao.save(comment);
        commentDao.delete(comment);
    }

    /**
     * @Description: update Comment information in DB
     * @param comment Comment object return by DAO
     * @return neu.edu.model.Comment
     * @date 2020/4/1 10:41
     */
    public Comment updateComment(Comment comment) {
        comment.setUpdateTime();
        return commentDao.save(comment);
    }
    
    /**
     * @Description: return a image's comments sorted by updateTime DESC
     * @param imageId String, imageId
     * @return java.util.List<neu.edu.model.Comment>
     * @date 2020/4/16 1:54
     */
    public List<Comment> findAllCommentOfaImageByUpdateTimeDesc(String imageId) {
        List<Comment> comments = commentDao.findAllByImageId(imageId);
        CommonUtils.commentsSortByUpdateTimeDesc(comments);
        return comments;
    }
}
