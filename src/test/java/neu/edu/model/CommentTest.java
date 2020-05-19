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
public class CommentTest {
    User user;
    Comment comment;

    @Before
    public void init() {
        String username = "test";
        String password = "test";
        String email = "test@gmail.com";
        user = new User(username, email, password);
        String imageId = "00001";
        String content = "content";
        comment = new Comment(user, imageId, content);
    }

    @After
    public void clean() {
        user = null;
        comment = null;
    }

    @Test
    public void createComment() {
        String imageId = "00001";
        String content = "content";
        Comment newComment = new Comment(user, imageId, content);
        assertEquals(user, newComment.getUser());
        assertEquals(imageId, newComment.getImageId());
        assertEquals(content, newComment.getContent());
    }

    @Test
    public void setCommentAttrs() {
        // username
        String username = "user1";
        String usernameExp = "user1";
        comment.setUsername(username);
        assertEquals(usernameExp, comment.getUsername());

        // createTime
        // TODO Fix in the future
        /*LocalDateTime createTime = comment.getCreateTime();
        comment.setCreateTime();
        assertNotEquals(createTime, comment.getCreateTime());*/

        // updateTime
        // TODO Fix in the future
        /*LocalDateTime updateTime = comment.getCreateTime();
        comment.setUpdateTime();
        assertNotEquals(updateTime, comment.getUpdateTime());*/

        // content
        String content = "newContent";
        String contentExp = "newContent";
        comment.setContent(content);
        assertEquals(contentExp, comment.getContent());

        // imageId
        String imageId = "00002";
        String imageIdExp = "00002";
        comment.setImageId(imageId);
        assertEquals(imageIdExp, comment.getImageId());
    }
}
