package com.nutridish.services;

import com.nutridish.entities.FavoriteEntity;
import com.nutridish.entities.RecipeEntity;
import com.nutridish.entities.UserEntity;
import com.nutridish.pojos.JsonRes;
import com.nutridish.repositories.FavoriteRepository;
import com.nutridish.repositories.RecipeRepository;
import com.nutridish.repositories.UserRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class FavoriteService {
    final FavoriteRepository favoriteRepository;
    final UserRepository userRepository;
    final RecipeRepository recipeRepository;

    public FavoriteService(FavoriteRepository favoriteRepository, UserRepository userRepository, RecipeRepository recipeRepository) {
        this.favoriteRepository = favoriteRepository;
        this.userRepository = userRepository;
        this.recipeRepository = recipeRepository;
    }

    public List<RecipeEntity> getUserFavourite(Long userId) {
        List<FavoriteEntity> favoriteEntities = favoriteRepository.findByUserId(userId);

        for (FavoriteEntity favoriteEntity : favoriteEntities) {
            favoriteEntity.getRecipe().setFavorite(true);
        }

        return favoriteEntities.stream()
                .map(FavoriteEntity::getRecipe)
                .toList();
    }

    public List<RecipeEntity> getRecipesByMealTypeAndFavorite(Long userId, String mealType) {
        List<RecipeEntity> recipes = recipeRepository.findByMealType(mealType);
        UserEntity user = userRepository.findById(userId).orElse(null);

        if (user != null) {
            List<FavoriteEntity> userFavorites = favoriteRepository.findByUser(user);
            List<Long> favoriteRecipeIds = userFavorites.stream()
                    .map(FavoriteEntity::getRecipe)
                    .map(RecipeEntity::getId)
                    .toList();

            for (RecipeEntity recipe : recipes) {
                recipe.setFavorite(favoriteRecipeIds.contains(recipe.getId()));
            }
        }

        return recipes;
    }

    public JsonRes<FavoriteEntity> addRecipeToFavorites(Long userId, Long recipeId) {

        UserEntity user = userRepository.findById(userId)
                .orElse(null);

        RecipeEntity recipe = recipeRepository.findById(recipeId)
                .orElse(null);

        boolean isAlreadyFavorite = favoriteRepository.existsByUserAndRecipe(user, recipe);
        if (isAlreadyFavorite) {
            return new JsonRes<>(false, 400, "Recipe is already in favorites", null);
        }

        FavoriteEntity favorite = new FavoriteEntity();
        favorite.setUser(user);
        favorite.setRecipe(recipe);

        FavoriteEntity fr = favoriteRepository.save(favorite);

        return new JsonRes<>(true, 200, "Recipe added to favorites", fr);

    }

    /*public List<RecipeEntity> getAllRecipesWithFavoriteIndicator(Long userId) {
        List<RecipeEntity> recipes = recipeRepository.findAll();

        UserEntity user = userRepository.findById(userId).orElse(null);
        if (user != null) {
            List<FavoriteEntity> userFavorites = favoriteRepository.findByUser(user);

            List<Long> favoriteRecipeIds = userFavorites.stream()
                    .map(FavoriteEntity::getRecipe)
                    .map(RecipeEntity::getId)
                    .toList();

            for (RecipeEntity recipe : recipes) {
                recipe.setFavorite(favoriteRecipeIds.contains(recipe.getId()));
            }
        }

        return recipes;
    }*/

}
