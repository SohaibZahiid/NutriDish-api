package com.nutridish.repositories;

import com.nutridish.entities.FavoriteEntity;
import com.nutridish.entities.RecipeEntity;
import com.nutridish.entities.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FavoriteRepository extends JpaRepository<FavoriteEntity, Long> {

    List<FavoriteEntity> findByUserId(Long id);


    List<FavoriteEntity> findByUser(UserEntity user);

    boolean existsByUserAndRecipe(UserEntity user, RecipeEntity recipe);
}
