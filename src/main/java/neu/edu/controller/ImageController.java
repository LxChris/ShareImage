package neu.edu.controller;

import neu.edu.model.Comment;
import neu.edu.model.Image;
import neu.edu.model.User;
import neu.edu.service.CommentService;
import neu.edu.service.ImageService;
import neu.edu.service.UserService;
import neu.edu.util.CommonUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Controller
public class ImageController {
    @Autowired
    private UserService userService;

    @Autowired
    private ImageService imageService;

    @Autowired
    private CommentService commentService;

    @RequestMapping(value = "/v1/image/{imageId}/comment", method = RequestMethod.POST)
    public ResponseEntity<?> postComment(HttpServletRequest request, HttpServletResponse response,
                                         Authentication authentication, @PathVariable String imageId) {
        String username = authentication.getName();
        User foundUser = userService.findUserByUsername(username);
        Image foundImage = imageService.findImageById(imageId);
            if (foundImage != null) {
                String content = request.getParameter("commentContent");
                Comment comment = new Comment(foundUser, imageId, content);
                comment = commentService.saveComment(comment);

                return new ResponseEntity<>(comment, HttpStatus.OK);
            } else {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
    }

    @RequestMapping(value = "/v1/image", method = RequestMethod.POST)
    public ResponseEntity<?> postImage(HttpServletRequest request, HttpServletResponse response,
                                       @RequestParam(name="image", required = true) MultipartFile imageFile,
                                       Authentication authentication) throws IOException {
        String realRootPath = request.getSession().getServletContext().getRealPath("/");

        if (!CommonUtils.isValidImageFormat(imageFile.getOriginalFilename())) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("errorMsg", "please choose a valid image file");
            return new ResponseEntity<>(jsonObject.toMap(), HttpStatus.BAD_REQUEST);
        }

        String username = authentication.getName();
        User foundUser = userService.findUserByUsername(username);
        String title = request.getParameter("title");
        String tags = request.getParameter("tags");
        String description = request.getParameter("description");

        Image image = new Image(foundUser, title, tags, description);
        image = imageService.saveImage(image, foundUser, imageFile, realRootPath);
        return new ResponseEntity<>(image, HttpStatus.OK);
    }

    @RequestMapping(value = "/v1/image", method = RequestMethod.PUT)
    public ResponseEntity<?> updateImage(HttpServletRequest request, Authentication authentication) {
        String imageId = request.getParameter("imageId");
        Image foundImage = imageService.findImageById(imageId);
        String currentUsername = authentication.getName();
        String imageOwnerUsername = foundImage.getUsername();

        if (imageId != null) {
            if (foundImage != null) {
                if (currentUsername.equals(imageOwnerUsername)) {
                    String title = request.getParameter("title");
                    String tags = request.getParameter("tags");
                    String description = request.getParameter("description");

                    tags = tags != null ? tags : "";
                    description = description != null ? description : "";

                    foundImage.setTitle(title);
                    foundImage.setTags(tags);
                    foundImage.setDescription(description);
                    return new ResponseEntity<>(imageService.updateImage(foundImage), HttpStatus.OK);
                } else {
                    return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
                }
            } else {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
        } else {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }


    @RequestMapping(value = "/v1/image/{imageId}", method = RequestMethod.GET)
    public ResponseEntity<?> getImage(HttpServletRequest request, HttpServletResponse response,
                                        @PathVariable String imageId) {
        Image foundImage = imageService.findImageById(imageId);
        if (foundImage != null) {
            return new ResponseEntity<>(imageService.imageGetView(foundImage), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @RequestMapping(value = "/v1/image/download/{imageId}", method = RequestMethod.GET)
    public void downloadImage(HttpServletRequest request, HttpServletResponse response,
                              @PathVariable String imageId) {
        String realRootPath = request.getSession().getServletContext().getRealPath("/");
        Image foundImage = imageService.findImageById(imageId);
        if (foundImage != null) {
            Path filePath = Paths.get(realRootPath, foundImage.getPath());
            if (Files.exists(filePath)) {
                response.setContentType("image/" + foundImage.getType());
                response.addHeader("Content-Disposition", "attachment; filename=" + foundImage.getImageId() + "." + foundImage.getType());
                imageService.increaseNumOfDownload(foundImage);
                try {
                    Files.copy(filePath, response.getOutputStream());
                    response.getOutputStream().flush();;
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @RequestMapping(value = "/v1/image/{imageId}", method = RequestMethod.DELETE)
    public ResponseEntity<?> deleteImage(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication, @PathVariable String imageId) {
        String realRootPath = request.getSession().getServletContext().getRealPath("/");
        String username = authentication.getName();
        Image foundImage = imageService.findImageById(imageId);
        if (foundImage != null) {
            if (foundImage.getUser().getUsername().equals(username)) {
                imageService.deleteImage(foundImage, realRootPath);
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            } else {
                // UNAUTHORIZED
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
        } else {
            // Image does not exist
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @RequestMapping(value = "/v1/image/{imageId}/allComment", method = RequestMethod.GET)
    public ResponseEntity<?> getAllCommentsOfaImage(HttpServletRequest request, HttpServletResponse response,
                                                    @PathVariable String imageId) {
        Image foundImage = imageService.findImageById(imageId);
        if (foundImage != null) {
            return new ResponseEntity<>(commentService.findAllCommentOfaImageByUpdateTimeDesc(imageId), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @RequestMapping(value = "/v1/image/all/{pageNum}", method = RequestMethod.GET)
    public ResponseEntity<?> getAllImageByPagePer12(@PathVariable int pageNum) {
        return new ResponseEntity<>(imageService.findAllImageByPage(pageNum, 12), HttpStatus.OK);
    }

    @RequestMapping(value = "/v1/image/search", method = RequestMethod.GET)
    public ResponseEntity<?> searchImage(HttpServletRequest request) {
        String searchType = request.getParameter("searchType");
        String keyword = request.getParameter("keyword");
        int pageNum = request.getParameter("pageNum") == null ? 0 : Integer.parseInt(request.getParameter("pageNum"));
        int pageSize = 12;
        if (searchType != null && keyword != null) {
            switch (searchType) {
                case "tag":
                    // Search by tag
                    return new ResponseEntity<>(imageService.findAllImagesByTagAtPage(keyword, pageNum, pageSize), HttpStatus.OK);
                case "username":
                    // Search by username
                    return new ResponseEntity<>(imageService.findAllImageByUsernameAtPage(keyword, pageNum, pageSize), HttpStatus.OK);
                default:
                    // Search by title
                    return new ResponseEntity<>(imageService.findAllImageByTitleAtPage(keyword, pageNum, pageSize), HttpStatus.OK);
            }
        } else {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }

    }
}
