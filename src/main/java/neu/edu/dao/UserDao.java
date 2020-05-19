package neu.edu.dao;

import neu.edu.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserDao extends JpaRepository<User, String> {
    User findUserByUsername(String username);
    User findUserByEmail(String email);

}
