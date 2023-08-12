package com.nutridish.entities;


import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;
import java.util.List;


@Entity
@Table(name = "recipes")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class RecipeEntity implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "name")
    @NotBlank(message = "Name is required")
    private String name;

    @Column(name = "description")
    @NotBlank(message = "Description is required")
    private String description;

    @Column(name = "meal_type")
    @NotBlank(message = "Meal type is required")
    private String mealType;

    @Column(name = "created_by")
    @NotBlank(message = "Created by is required")
    private String createdBy;

    @Column(name = "total_time")
    @NotBlank(message = "Total time is required")
    private int totalTime;

    @Column(name = "servings")
    @NotBlank(message = "Servings is required")
    private int servings;

    @Column(name = "image")
    @NotBlank(message = "Image is required")
    private String image;

    @Column(name = "featured")
    @NotBlank(message = "Featured is required")
    private boolean featured;

    @Column(name = "dietary_type")
    @NotBlank(message = "Dietary type is required")
    private String dietaryType;

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(
            name = "recipes_ingredients",
            joinColumns = @JoinColumn(name = "recipe_id"),
            inverseJoinColumns = @JoinColumn(name = "ingredient_id")
    )
    private List<IngredientEntity> ingredients;

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(
            name = "recipe_tags",
            joinColumns = @JoinColumn(name = "recipe_id"),
            inverseJoinColumns = @JoinColumn(name = "tag_id")
    )
    private List<TagEntity> tags;


    @Transient
    private boolean favorite;

}
