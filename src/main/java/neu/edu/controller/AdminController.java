package neu.edu.controller;


import neu.edu.model.Comment;
import neu.edu.model.Image;
import neu.edu.service.CommentService;
import neu.edu.service.ImageService;
import neu.edu.service.UserService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class AdminController {
    @Autowired
    private UserService userService;

    @Autowired
    private ImageService imageService;

    @Autowired
    private CommentService commentService;

    @RequestMapping(value = "/v1/admin/deleteImage/{imageId}", method = RequestMethod.DELETE)
    public ResponseEntity<?> deleteImage(@PathVariable String imageId, Authentication authentication,
                                         HttpServletRequest request) {
        String currentUser = authentication.getName();
        if (!currentUser.equals("admin")) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }

        String realRootPath = request.getSession().getServletContext().getRealPath("/");
        Image foundImage = imageService.findImageById(imageId);
        if (foundImage != null) {
                imageService.deleteImage(foundImage, realRootPath);
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            // Image does not exist
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("errorMessage", "The image is not exist");
            jsonObject.put("test","test");
            return new ResponseEntity<>(jsonObject.toString(), HttpStatus.NOT_FOUND);
        }
    }

    @RequestMapping(value = "/v1/admin/deleteComment/{commentId}", method = RequestMethod.DELETE)
    public ResponseEntity<?> deleteComment(@PathVariable String commentId, Authentication authentication,
                                         HttpServletRequest request) {
        String currentUser = authentication.getName();
        if (!currentUser.equals("admin")) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }

        Comment foundComment = commentService.findCommentByCommentId(commentId);
        if (foundComment != null) {
                commentService.deleteComment(foundComment);
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            // Comment does not exist
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("errorMessage", "The comment is not exist");
            return new ResponseEntity<>(jsonObject.toString(), HttpStatus.NOT_FOUND);
        }
    }
}
