package com.nutridish.services;

import com.nutridish.entities.FavoriteEntity;
import com.nutridish.entities.RecipeEntity;
import com.nutridish.entities.UserEntity;
import com.nutridish.repositories.FavoriteRepository;
import com.nutridish.repositories.RecipeRepository;
import com.nutridish.repositories.UserRepository;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class RecipeService {
    private final RecipeRepository recipeRepository;
    private final UserRepository userRepository;

    private final FavoriteRepository favoriteRepository;

    public RecipeService(RecipeRepository recipeRepository, UserRepository userRepository, FavoriteRepository favoriteRepository) {
        this.recipeRepository = recipeRepository;
        this.userRepository = userRepository;
        this.favoriteRepository = favoriteRepository;

    }

    public List<RecipeEntity> getRecipes() {
        return recipeRepository.findAll();
    }

    public List<RecipeEntity> getRecipesByType(String type) {
        return recipeRepository.findByMealType(type);
    }

    public RecipeEntity getRecipeById(Long id) {
        return recipeRepository.findById(id).orElse(null);
    }

    public List<RecipeEntity> getRecipesFeatured() {
        return recipeRepository.findTop4ByFeaturedTrue();
    }


    public List<RecipeEntity> getAllRecipesWithFavoriteIndicator(Long userId) {
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
    }
}