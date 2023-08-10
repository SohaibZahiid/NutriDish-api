package com.nutridish.controllers;

import com.nutridish.entities.RecipeEntity;
import com.nutridish.services.RecipeService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api")
public class RecipeController {
    private final RecipeService recipeService;

    public RecipeController(RecipeService recipeService) {
        this.recipeService = recipeService;
    }

    @GetMapping("/recipes")
    public List<RecipeEntity> getRecipes() {
        return this.recipeService.getRecipes();
    }

    @GetMapping("/recipes/{type}")
    public List<RecipeEntity> getRecipesByType(@PathVariable String type) {
        return this.recipeService.getRecipesByType(type);
    }

    @GetMapping("/recipe/{id}")
    public RecipeEntity getRecipeById(@PathVariable Long id) {
        return this.recipeService.getRecipeById(id);
    }

    @GetMapping("/recipes/featured")
    public List<RecipeEntity> getRecipesFeatured () {
        return this.recipeService.getRecipesFeatured();
    }
}
