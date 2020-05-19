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
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private ImageService imageService;

    @Autowired
    private CommentService commentService;

    @RequestMapping(value = "test", method = RequestMethod.GET)
    public ResponseEntity<?> test() {
        // TODO Remove test
        System.out.println("test");

        String email = "test@gmail.com";
        String username = "test";
        String password = "test";

        User user = new User(username, email, password);

        user = userService.saveUser(user);
        Image image = new Image(user);
        image = imageService.saveImageForTest(image);

        user.getImages().add(image);
        user = userService.updateUser(user);

        Comment comment = new Comment(user, image.getImageId(), "test content");
        comment = commentService.saveComment(comment);

        image.setNumComments(image.getNumComments() + 1);
        image = imageService.updateImage(image);

        user.getComments().add(comment);


        System.out.println("User id : " + user.getUserId());
        System.out.println("User image size: " + user.getImages().size());
        System.out.println("User comment size: " + user.getComments().size());

        System.out.println("test" + email + "," + username + "," + password);

        return new ResponseEntity<>(userService.updateUser(user), HttpStatus.CREATED);
    }

    @RequestMapping(value = "/v1/user/avatar/{username}", method = RequestMethod.GET)
    public ResponseEntity<?> getUserAvatarPath(@PathVariable String username) {
        User foundUser = userService.findUserByUsername(username);
        if (foundUser != null) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("userAvatarPath", foundUser.getProfileImagePath());
            return new ResponseEntity<>(jsonObject.toString(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @RequestMapping(value = "/v1/user", method = RequestMethod.POST)
    public ResponseEntity<?> createUser(HttpServletRequest request, HttpServletResponse response) {
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println("v1/user" + email + "," + username + "," + password);

        JSONObject jsonObject = new JSONObject();
        if (!CommonUtils.isValidEmail(email) || !CommonUtils.isValidUsername(username)) {
            jsonObject.put("errorMsg", "not valid username/email");
//            return "index";
            return new ResponseEntity<>(jsonObject.toMap(), HttpStatus.BAD_REQUEST);
        }

        // is username exist
        if (userService.isUserExist(username)) {
            jsonObject.put("errorMsg", "username exist!");
            return new ResponseEntity<>(jsonObject.toMap(), HttpStatus.BAD_REQUEST);
//            return "index";
        }

        // is email exist
        if (userService.isEmailExist(email)) {
            jsonObject.put("errorMsg", "username exist!");
            return new ResponseEntity<>(jsonObject.toMap(), HttpStatus.BAD_REQUEST);
//            return "index";
        }

        // is password valid len: 4-16 contains number, char, or '_'
        if (!CommonUtils.isPwdValid(password)) {
            jsonObject.put("errorMsg", "password is too weak!");
            return new ResponseEntity<>(jsonObject.toMap(), HttpStatus.BAD_REQUEST);
//            return "index";
        }

        User newUser = new User(username, email, password);

//        userService.saveUser(newUser);
        return new ResponseEntity<>(userService.saveUser(newUser), HttpStatus.CREATED);
//        return "index";
    }

    @RequestMapping(value = "/v1/user/self", method = RequestMethod.GET)
    public ResponseEntity<?> getUser(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) {
        String username = authentication.getName();

        return new ResponseEntity<>(userService.findUserByUsername(username), HttpStatus.OK);
    }

    @RequestMapping(value = "/v1/user/self", method = RequestMethod.PUT)
    public ResponseEntity<?> updateUser(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) {
        String username = authentication.getName();
        User foundUser = userService.findUserByUsername(username);
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        String password = request.getParameter("password");

        foundUser.setFirstName(firstName);
        foundUser.setLastName(lastName);
        if (gender != null && (gender.equals("Male") || gender.equals("Female"))) {
            foundUser.setGender(gender);
        }
        if (!password.equals("")) {
            userService.encryptUserPassword(foundUser, password);
        }

        return new ResponseEntity<>(userService.updateUser(foundUser), HttpStatus.NO_CONTENT);

    }

    @RequestMapping(value = "/v1/user/self/avatar", method = RequestMethod.POST)
    public String postUserAvatar(HttpServletRequest request, Authentication authentication,
                                @RequestParam(name="avatar", required = true)MultipartFile imageFile) throws IOException {
        String realRootPath = request.getSession().getServletContext().getRealPath("/");
        String username = authentication.getName();
        User foundUser = userService.findUserByUsername(username);
        JSONObject errorMessage = new JSONObject();
        if (CommonUtils.isValidImageFormat(imageFile.getOriginalFilename())) {
            userService.updateUserAvatar(foundUser, imageFile, realRootPath);
//            return new ResponseEntity<>(userService.updateUserAvatar(foundUser, imageFile, realRootPath), HttpStatus.OK);
        } else {
            errorMessage.put("Error", "The file you upload is not a image file.");
//            return new ResponseEntity<>(errorMessage.toString(), HttpStatus.BAD_REQUEST);
        }

        return "profile";
//        return new ResponseEntity<>(errorMessage.toString(), HttpStatus.BAD_REQUEST);
    }

}
