package neu.edu.dao;

import neu.edu.model.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository
public interface CommentDao extends JpaRepository<Comment, String> {
    Comment findByCommentId(String commentId);
    List<Comment> findAllByImageId(String imageId);
}
