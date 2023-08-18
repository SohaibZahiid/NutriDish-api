package com.nutridish.entities;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class IngredientWithQuantity {
    private Long id;
    private String name;
    private String unit;
    private BigDecimal quantity;
}