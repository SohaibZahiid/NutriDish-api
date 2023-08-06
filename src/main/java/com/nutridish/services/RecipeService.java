package com.nutridish.services;

import com.nutridish.entities.RecipeEntity;
import com.nutridish.repositories.RecipeRepository;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RecipeService {
    private final RecipeRepository recipeRepository;

    public RecipeService(RecipeRepository recipeRepository) {
        this.recipeRepository = recipeRepository;

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


}