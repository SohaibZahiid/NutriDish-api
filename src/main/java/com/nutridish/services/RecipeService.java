package com.nutridish.services;

import com.nutridish.dto.MealPlanDTO;
import com.nutridish.entities.FavoriteEntity;
import com.nutridish.entities.NutritionEntity;
import com.nutridish.entities.RecipeEntity;
import com.nutridish.entities.UserEntity;
import com.nutridish.pojos.JsonRes;
import com.nutridish.repositories.FavoriteRepository;
import com.nutridish.repositories.RecipeRepository;
import com.nutridish.repositories.UserRepository;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;
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

    public JsonRes<MealPlanDTO> getMealPlan(Long desiredCalories, String desiredDietaryType) {
        List<RecipeEntity> matchingRecipes = recipeRepository.findByDietaryTypeIgnoreCase(desiredDietaryType);
        List<MealPlanDTO> validMealPlans = new ArrayList<>();

        List<RecipeEntity> breakfastRecipes = matchingRecipes.stream()
                .filter(recipe -> recipe.getMealType().equalsIgnoreCase("breakfast"))
                .toList();

        List<RecipeEntity> lunchRecipes = matchingRecipes.stream()
                .filter(recipe -> recipe.getMealType().equalsIgnoreCase("lunch"))
                .toList();

        List<RecipeEntity> dinnerRecipes = matchingRecipes.stream()
                .filter(recipe -> recipe.getMealType().equalsIgnoreCase("dinner"))
                .toList();

        for (RecipeEntity breakfast : breakfastRecipes) {
            for (RecipeEntity lunch : lunchRecipes) {
                for (RecipeEntity dinner : dinnerRecipes) {
                    NutritionEntity breakfastNutrition = breakfast.getNutrition();
                    NutritionEntity lunchNutrition = lunch.getNutrition();
                    NutritionEntity dinnerNutrition = dinner.getNutrition();

                    long totalCalories = breakfastNutrition.getCalories()
                            + lunchNutrition.getCalories()
                            + dinnerNutrition.getCalories();

                    if (totalCalories == desiredCalories) {
                        MealPlanDTO mealPlan = new MealPlanDTO();
                        mealPlan.setRecipes(Arrays.asList(breakfast, lunch, dinner));

                        BigDecimal totalProtein = breakfastNutrition.getProtein()
                                .add(lunchNutrition.getProtein())
                                .add(dinnerNutrition.getProtein());

                        BigDecimal totalCarbohydrates = breakfastNutrition.getCarbohydrates()
                                .add(lunchNutrition.getCarbohydrates())
                                .add(dinnerNutrition.getCarbohydrates());

                        BigDecimal totalFats = breakfastNutrition.getFats()
                                .add(lunchNutrition.getFats())
                                .add(dinnerNutrition.getFats());

                        NutritionEntity combinedNutrition = new NutritionEntity(
                                totalCalories, totalProtein, totalCarbohydrates, totalFats);
                        mealPlan.setCombinedNutrition(combinedNutrition);

                        validMealPlans.add(mealPlan);
                    }
                }
            }
        }

        if (validMealPlans.isEmpty()) {
            return new JsonRes<>(false, 404, "Recipes not found", null);
        }

        MealPlanDTO selectedMealPlan = validMealPlans.get(new Random().nextInt(validMealPlans.size()));

        return new JsonRes<>(true, 200, "Recipes found", selectedMealPlan);
    }

}