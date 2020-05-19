package neu.edu.model;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import javax.transaction.Transactional;
import java.time.LocalDateTime;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {
        "file:src/main/webapp/WEB-INF/dispatcher-servlet.xml",
        "file:src/main/webapp/WEB-INF/spring-security.xml"
})
@Transactional
public class UserTest {
    private User user;
    @Before
    public void init() {
        String username = "test";
        String password = "test";
        String email = "test@gmail.com";
        user = new User(username, email, password);
    }

    @After
    public void clean() {
        user = null;
    }

    @Test
    public void createUser() {
        String username = "test";
        String password = "test";
        String email = "test@gmail.com";
        User tempUser = new User(username, email, password);
        assertEquals(username, tempUser.getUsername());
        // For here, password will not be encrypted.
        // Only save user object using UserService will use BCEncrypt to encrypt the password
        assertEquals(password, tempUser.getPassword());
        assertEquals(email, tempUser.getEmail());
    }

    @Test
    public void setUserAttrs() {
        // password
        String password = "newPass";
        String passwordExp = "newPass";
        user.setPassword(password);
        assertEquals(passwordExp, user.getPassword());

        // profileImagePath
        String profileImagePath = "img/1.jpg";
        String profileImagePathExp = "img/1.jpg";
        user.setProfileImagePath(profileImagePath);
        assertEquals(profileImagePathExp, user.getProfileImagePath());

        // firstName
        String firstName = "firstName";
        String firstNameExp = "firstName";
        user.setFirstName(firstName);
        assertEquals(firstNameExp, user.getFirstName());

        // lastName
        String lastName = "lastName";
        String lastNameExp = "lastName";
        user.setLastName(lastName);
        assertEquals(lastNameExp, user.getLastName());

        // gender
        String gender = "Male";
        String genderExp = "Male";
        user.setGender(gender);
        assertEquals(genderExp, user.getGender());

        // updateTime
        // TODO Fix in the future
        /*LocalDateTime updateTime = user.getUpdateTime();
        user.setUpdateTime();
        user.setUpdateTime();
        assertNotEquals(updateTime, user.getUpdateTime());*/

        // Image
        Image image = new Image();
        user.getImages().add(image);
        int imagesSizeExp = 1;
        assertEquals(imagesSizeExp, user.getImages().size());

        // Comment
        Comment comment = new Comment();
        user.getComments().add(comment);
        int commentsSizeExp = 1;
        assertEquals(commentsSizeExp, user.getComments().size());
    }
}
