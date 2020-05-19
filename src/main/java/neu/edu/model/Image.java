package neu.edu.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "images")
public class Image {
    @Id
    @GenericGenerator(name = "idGenerator", strategy = "uuid")
    @GeneratedValue(generator = "idGenerator")
    private String imageId;

    @ManyToOne()
    @JoinColumn(name="user")
    @JsonIgnore
    private User user;

    @Column(name = "title")
    private String title;

    @Column(name = "path")
    private String path;

    @Column(name = "type")
    private String type;

    @Column(name = "resolutionW")
    private int resolutionW;

    @Column(name = "resolutionH")
    private int resolutionH;

    @Column(name = "views")
    private int views;

    @Column(name = "downloads")
    private int downloads;

    @Column(name = "tags")
    private String tags;

    @Column(name = "description")
    private String description;

    @Column(name = "username")
    private String username;

    @Column(name = "createTime")
    @JsonFormat(pattern="MMM dd yyyy")
    private LocalDateTime createTime;

    @Column(name = "updateTime")
    @JsonFormat(pattern="MMM dd yyyy")
    private LocalDateTime updateTime;

    @Column(name = "numComments")
    private int numComments;

    public Image() {

    }

    public Image(User user) {
        this.user = user;
        this.username = user.getUsername();
        this.setCreateTime();
        this.setUpdateTime();
    }

    public Image(User user, String title, String tags, String description) {
        this.user = user;
        this.username = user.getUsername();
        this.title = title != null ? title : "";
        this.tags = tags != null ? tags : "";
        this.description = description != null ? description : "";
        this.setCreateTime();
        this.setUpdateTime();
    }

    public String getImageId() {
        return imageId;
    }

    public void setImageId(String imageId) {
        this.imageId = imageId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String name) {
        this.title = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getResolutionW() {
        return resolutionW;
    }

    public void setResolutionW(int resolutionW) {
        this.resolutionW = resolutionW;
    }

    public int getResolutionH() {
        return resolutionH;
    }

    public void setResolutionH(int resolutionH) {
        this.resolutionH = resolutionH;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public int getDownloads() {
        return downloads;
    }

    public void setDownloads(int downloads) {
        this.downloads = downloads;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime() {
        this.createTime = LocalDateTime.now();
    }

    public LocalDateTime getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime() {
        this.updateTime = LocalDateTime.now();
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getNumComments() {
        return numComments;
    }

    public void setNumComments(int numComments) {
        this.numComments = numComments;
    }
}
