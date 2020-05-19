package neu.edu.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.apache.tomcat.jni.Local;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "comments")
public class Comment {
    @Id
    @GenericGenerator(name = "idGenerator", strategy = "uuid")
    @GeneratedValue(generator = "idGenerator")
    private String commentId;

    @ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.MERGE })
    @JoinColumn(name="user")
    @JsonIgnore
    private User user;

    @Column(name = "username")
    private String username;

    @Column(name = "createTime")
    @JsonFormat(pattern="MMM dd yyyy")
    private LocalDateTime createTime;

    @Column(name = "updateTime")
    @JsonFormat(pattern="MMM dd yyyy")
    private LocalDateTime updateTime;

    @Column(name = "content")
    private String content;

    @Column(name = "imageId")
    private String imageId;

    public Comment() {}

    public Comment(User user, String imageId, String content) {
        this.user = user;
        this.username = user.getUsername();
        this.imageId = imageId;
        this.content = content;
    }

    public String getUsername() { return username; }

    public void setUsername(String userId) { this.username = userId; }

    public String getCommentId() {
        return commentId;
    }

    public void setCommentId(String id) {
        this.commentId = id;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime() {
        this.createTime = LocalDateTime.now();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public User getUser() { return user; }

    public void setUser(User user) { this.user = user; }

    public String getImageId() {
        return imageId;
    }

    public void setImageId(String imageId) {
        this.imageId = imageId;
    }

    public LocalDateTime getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime() {
        this.updateTime = LocalDateTime.now();
    }
}
