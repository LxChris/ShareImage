package neu.edu.controller;

import neu.edu.model.Comment;
import neu.edu.service.CommentService;
import neu.edu.service.UserService;
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
public class CommentController {
    @Autowired
    private CommentService commentService;

    @Autowired
    private UserService userService;

    // todo need to do something
    @RequestMapping(value = "/v1/comment/{commentId}", method = RequestMethod.GET)
    public ResponseEntity<?> getComment(HttpServletRequest request, HttpServletResponse response,
                                        @PathVariable String commentId) {
        Comment foundComment = commentService.findCommentByCommentId(commentId);
        if (foundComment != null) {
            return new ResponseEntity<>(foundComment, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @RequestMapping(value = "/v1/comment/{commentId}", method = RequestMethod.DELETE)
    public ResponseEntity<?> deleteComment(HttpServletRequest request, HttpServletResponse response,
                                           Authentication authentication, @PathVariable String commentId) {
        String username = authentication.getName();
        Comment foundComment = commentService.findCommentByCommentId(commentId);
        if (foundComment != null) {
            if (foundComment.getUsername().equals(username)) {
                commentService.deleteComment(foundComment);
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            } else {
                // UNAUTHORIZED
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
        } else {
            // Comment does not exist
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}
