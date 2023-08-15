package com.nutridish.services;

import com.nutridish.entities.FavoriteEntity;
import com.nutridish.entities.RecipeEntity;
import com.nutridish.entities.UserEntity;
import com.nutridish.pojos.JsonRes;
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

    public List<RecipeEntity> getRecipes(String searchKey, List<String> tags) {
        if (searchKey.isEmpty() && tags.isEmpty()) {
            return recipeRepository.findAll();
        } else if (tags.isEmpty()) {
            return recipeRepository.findByNameContainingIgnoreCase(searchKey);
        } else if (searchKey.isEmpty()) {
            return recipeRepository.findByDietaryTypeIgnoreCaseIn(tags);
        } else {
            return recipeRepository.findByNameContainingIgnoreCaseAndDietaryTypeIgnoreCaseIn(searchKey, tags);
        }
    }

    public List<RecipeEntity> getRecipesByType(String searchKey, List<String> tags, String type) {
        if (searchKey.equals("")) {
            if (tags.isEmpty()) {
                return recipeRepository.findByMealType(type);
            } else {
                return recipeRepository.findByMealTypeAndDietaryTypeIn(type, tags);
            }
        } else {
            if (tags.isEmpty()) {
                return recipeRepository.findByNameContainingIgnoreCaseAndMealType(searchKey, type);
            } else {
                return recipeRepository.findByNameContainingIgnoreCaseAndDietaryTypeInAndMealType(searchKey, tags, type);
            }
        }


    }

    public RecipeEntity getRecipeById(Long id) {
        return recipeRepository.findById(id).orElse(null);
    }

    public List<RecipeEntity> getRecipesFeatured() {
        return recipeRepository.findTop4ByFeaturedTrue();
    }


}