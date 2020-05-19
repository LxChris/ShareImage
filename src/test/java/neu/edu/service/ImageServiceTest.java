package neu.edu.service;

import neu.edu.model.Image;
import neu.edu.model.User;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {
        "file:src/main/webapp/WEB-INF/dispatcher-servlet.xml",
        "file:src/main/webapp/WEB-INF/spring-security.xml"
})
public class ImageServiceTest {
    private User user;
    private Image image;

    @Autowired
    UserService userService;

    @Autowired
    ImageService imageService;

    @Before
    public void init() {
//        String username = "test";
//        String password = "test";
//        String email = "test@gmail.com";
//        user = new User(username, email, password);
//        user = userService.saveUser(user);
//
//        String title = "title";
//        String tags = "tags";
//        String description = "description";
//        image = new Image(user, title, tags, description);
    }

    @After
    public void clean() {
//        user = null;
//        image = null;
    }

    @Test
    public void saveImage() {

    }

}
