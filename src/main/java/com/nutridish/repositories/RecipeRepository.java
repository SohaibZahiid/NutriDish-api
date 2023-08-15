package com.nutridish.repositories;

import com.nutridish.entities.RecipeEntity;
import com.nutridish.entities.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RecipeRepository extends JpaRepository<RecipeEntity, Long> {

    List<RecipeEntity> findByMealType(String type);

    List<RecipeEntity> findTop4ByFeaturedTrue();

}
