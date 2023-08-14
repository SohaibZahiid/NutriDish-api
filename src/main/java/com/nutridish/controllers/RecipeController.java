package com.nutridish.controllers;

import com.nutridish.entities.RecipeEntity;
import com.nutridish.pojos.JsonRes;
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
    public List<RecipeEntity> getRecipes(@RequestParam(defaultValue = "") String searchKey) {
        return this.recipeService.getRecipes(searchKey);
    }

    @GetMapping("/recipes/{type}")
    public List<RecipeEntity> getRecipesByType(@RequestParam(defaultValue = "") String searchKey, @PathVariable String type) {
        return this.recipeService.getRecipesByType(searchKey, type);
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
