package neu.edu.service;

import neu.edu.dao.UserDao;
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

import javax.transaction.Transactional;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {
        "file:src/main/webapp/WEB-INF/dispatcher-servlet.xml",
        "file:src/main/webapp/WEB-INF/spring-security.xml"
})
@Transactional
public class UserServiceTest {
    private User user;

    @Autowired
    UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder;


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
    public void saveUser() {
        String username = "test";
        String password = "test";
        String email = "test@gmail.com";
        user = userService.saveUser(user);
        assertNotNull("userId should not be empty", user.getUserId());
        assertEquals(username, user.getUsername());
        assertNotEquals("password should be encrypted", password, user.getPassword());
        assertEquals("email should save correctly", email, user.getEmail());
    }

    @Test
    public void updateUser() {
        user = userService.saveUser(user);
        String firstName = "chow";
        String lastName = "li";
        String email = "test1@gmail.com";
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user = userService.updateUser(user);

        assertEquals(firstName, user.getFirstName());
        assertEquals(lastName, user.getLastName());
        assertEquals(email, user.getEmail());
    }
}
