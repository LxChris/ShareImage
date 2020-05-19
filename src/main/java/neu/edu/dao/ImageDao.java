package neu.edu.dao;

import neu.edu.model.Image;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ImageDao extends JpaRepository<Image, String> {

    Image findByImageId(String imageId);

    Page<Image> findAll(Pageable pageable);

    Page<Image> findByUsernameContainingIgnoreCase(String username, Pageable pageable);

    Page<Image> findByTitleContainingIgnoreCase(String title, Pageable pageable);

    Page<Image> findByTagsContainingIgnoreCase(String tag, Pageable pageable);
}
