package neu.edu.controller;

import neu.edu.model.Image;
import neu.edu.service.CommentService;
import neu.edu.service.ImageService;
import neu.edu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;

@Controller
public class MainController {

    @Autowired
    UserService userService;

    @Autowired
    ImageService imageService;

    @Autowired
    CommentService commentService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String defaultIndex() {
        return "index";
    }

    @RequestMapping(value = "*", method = RequestMethod.GET)
    public String defaultUnMatch() {
        return "404";
    }

    @RequestMapping(value = "/v1/index", method = RequestMethod.GET)
    public String indexPage() {
        return "index";
    }

    @RequestMapping(value = "/v1/view/404", method = RequestMethod.GET)
    public String notFound() {
        return "404";
    }

    @RequestMapping(value = "/v1/view/adminTool", method = RequestMethod.GET)
    public String adminTool(Authentication authentication) {
        String currentUser = authentication.getName();
        if (!currentUser.equals("admin")) {
            return "redirect:/v1/view/404";
        }

        return "adminTool";
    }

    @RequestMapping(value = "/v1/view/image/{imageId}", method = RequestMethod.GET)
    public String viewImage(HttpSession httpSession, @PathVariable String imageId) {
        Image foundImage = imageService.findImageById(imageId);
        if (foundImage == null) {
            return "redirect:/v1/view/404";
        }
        httpSession.setAttribute("imageId", imageId);

        return "imageDetail";
    }

    @RequestMapping(value = "/v1/view/image/update/{imageId}", method = RequestMethod.GET)
    public String updateImage(HttpSession httpSession, @PathVariable String imageId, Authentication authentication) {
        Image foundImage = imageService.findImageById(imageId);
        if (foundImage == null) {
            // Image not exist
            return "redirect:/v1/view/404";
        }

        if (!authentication.getName().equals(foundImage.getUsername())) {
            // Current user is not the image owner
            return "redirect:/v1/view/404";
        }

        httpSession.setAttribute("imageId", imageId);

        return "updateImage";
    }

    @RequestMapping(value = "/v1/view/login", method = RequestMethod.GET)
    public String loginPage() {
        return "loginPage";
    }

    @RequestMapping(value = "/v1/view/profile", method = RequestMethod.GET)
    public String profile() {
        return "profile";
    }

    @RequestMapping(value = "/v1/view/register", method = RequestMethod.GET)
    public String register() {
        return "register";
    }

    @RequestMapping(value = "/v1/view/search", method = RequestMethod.GET)
    public String searchImage(){
        return "search";
    }

    @RequestMapping(value = "/v1/view/self/images", method = RequestMethod.GET)
    public String getSelfImages() {
        return "myImage";
    }

    @RequestMapping(value = "/v1/view/uploadImage", method = RequestMethod.GET)
    public String uploadImage() {
        return "uploadImage";
    }
}
