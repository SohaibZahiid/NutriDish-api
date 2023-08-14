package com.nutridish.services;

import com.nutridish.entities.FavoriteEntity;
import com.nutridish.entities.RecipeEntity;
import com.nutridish.entities.UserEntity;
import com.nutridish.repositories.FavoriteRepository;
import com.nutridish.repositories.RecipeRepository;
import com.nutridish.repositories.UserRepository;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class RecipeService {
    private final RecipeRepository recipeRepository;




    public RecipeService(RecipeRepository recipeRepository) {
        this.recipeRepository = recipeRepository;
    }

    public List<RecipeEntity> getRecipes(String searchKey) {
        if(searchKey.equals("")) {
            return recipeRepository.findAll();
        } else {
            return recipeRepository.findByNameContainingIgnoreCase(searchKey);
        }
    }

    public List<RecipeEntity> getRecipesByType(String searchKey, String type) {
        if(searchKey.equals("")) {
            return recipeRepository.findByMealType(type);
        } else {
            return recipeRepository.findByNameContainingIgnoreCaseAndMealType(searchKey, type);
        }
    }

    public RecipeEntity getRecipeById(Long id) {
        return recipeRepository.findById(id).orElse(null);
    }

    public List<RecipeEntity> getRecipesFeatured() {
        return recipeRepository.findTop4ByFeaturedTrue();
    }


}