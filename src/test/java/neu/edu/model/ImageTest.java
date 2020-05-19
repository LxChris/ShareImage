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
public class ImageTest {
    private User user;
    private Image image;

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
    public void createImage() {
        // Make sure title, tags, and description are saved correctly
        // Make sure createTime, updateTime will be set after initialization
        String title = "title";
        String tags = "tags";
        String description = "description";
        Image newImage = new Image(user, title, tags, description);
        assertEquals("title should be saved correctly", "title", newImage.getTitle());
        assertEquals("tags should be saved correctly", "tags", newImage.getTags());
        assertEquals("description should be saved correctly", "description", newImage.getDescription());
        assertNotNull("createTime should be set after initialization", newImage.getCreateTime());
        assertNotNull("updateTime should be set after initialization", newImage.getUpdateTime());
    }

    @Test
    public void createImageIfAttrNull() {
        // Make sure title, tags, and description will be set to "" if given params are null
        String title = "title";
        String tags = "tags";
        String description = "description";
        Image newImage = new Image(user, null, null, null);
        assertEquals("title should be ''", "", newImage.getTitle());
        assertEquals("tags should be ''", "", newImage.getTags());
        assertEquals("description should be ''", "", newImage.getDescription());
        assertNotNull("createTime should be set after initialization", newImage.getCreateTime());
        assertNotNull("updateTime should be set after initialization", newImage.getUpdateTime());
    }

    @Test
    public void setImageAttrs() {
        // Make sure other attributes are settable
        String title = "title";
        String tags = "tags";
        String description = "description";
        Image newImage = new Image(user, title, tags, description);

        // path
        String path = "/img/1.jpg";
        String pathExp = "/img/1.jpg";
        newImage.setPath(path);
        assertEquals(pathExp, newImage.getPath());

        // type
        String type = "png";
        String typeExp = "png";
        newImage.setType(type);
        assertEquals(typeExp, newImage.getType());

        // resolutionW
        int resolutionW = 1920;
        int resolutionWExp = 1920;
        newImage.setResolutionW(resolutionW);
        assertEquals(resolutionWExp, newImage.getResolutionW());

        // resolutionH
        int resolutionH = 1080;
        int resolutionHExp = 1080;
        newImage.setResolutionH(resolutionH);
        assertEquals(resolutionHExp, newImage.getResolutionH());

        // view
        int view = 1;
        int viewExp = 1;
        newImage.setViews(view);
        assertEquals(viewExp, newImage.getViews());

        // downloads
        int downloads = 1;
        int downloadsExp = 1;
        newImage.setDownloads(downloads);
        assertEquals(downloadsExp, newImage.getDownloads());

        // tags
        String newTags = "tags1";
        String tagsExp = "tags1";
        newImage.setTags(newTags);
        assertEquals(tagsExp, newImage.getTags());

        // description
        String newDesc = "desc1";
        String descExp = "desc1";
        newImage.setDescription(newDesc);
        assertEquals(descExp, newImage.getDescription());

        // username
        String username = "username";
        String usernameExp = "username";
        newImage.setUsername(username);
        assertEquals(usernameExp, newImage.getUsername());

        // numComments
        int numComments = 10;
        int numCommentsExp = 10;
        newImage.setNumComments(numComments);
        assertEquals(numCommentsExp, newImage.getNumComments());

        // createTime
        // TODO Fix in the future
//        LocalDateTime oldCreateTime = newImage.getCreateTime();
//        newImage.setCreateTime();
//        newImage.setCreateTime();
//        newImage.setCreateTime();
//        newImage.setCreateTime();
//        newImage.setCreateTime();
//        newImage.setCreateTime();
//        assertNotEquals(oldCreateTime, newImage.getCreateTime());
        // updateTime
        // TODO Fix in the future
//        LocalDateTime oldUpdateTime = newImage.getUpdateTime();
        // Add one more core to enlarge the execution time
//        newImage.setUpdateTime();
//        newImage.setUpdateTime();
//        newImage.setUpdateTime();
//        newImage.setUpdateTime();
//        newImage.setUpdateTime();
//        assertNotEquals(oldUpdateTime, newImage.getUpdateTime());
    }
}
