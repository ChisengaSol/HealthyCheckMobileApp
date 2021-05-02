class Meal {
  final String mealTime, name, imagePath, kiloCaloriesBurnt, timeTaken;
  final String preparation;
  final List ingredients;

  Meal({this.mealTime, this.name, this.imagePath, this.kiloCaloriesBurnt, this.timeTaken, this.preparation, this.ingredients});
}

final meals = [
  Meal(
      mealTime: "BREAKFAST",
      name: "Fruit Granola",
      kiloCaloriesBurnt: "271",
      timeTaken: "10",
      imagePath: "assets/fruit_granola.jpg",
      ingredients: [
        "1 cup of granola",
        "1 banana",
        "1/2 cup of raisins",
        "1 tbsp of honey",
      ],
      preparation:
          '''Method
STEP 1
Heat oven to 160C/fan 140C/gas 3. Heat the oil, honey and maple syrup together in a pan. Mix the oats, almonds, pine nuts, puffed rice and sesame seeds in a large mixing bowl. Pour over the honey mix, stir well to coat, then tip onto a large baking tray. Bake for 15 mins until everything is golden and crisp.

STEP 2
Take the tray from the oven, leave to cool, then break up any big clumps. Mix together with the dried fruit and coconut shavings. Serve with Greek yogurt and fresh raspberries. The rest of the granola can be stored in a sealed jar and enjoyed over the next 2 weeks.'''),
  Meal(
      mealTime: "DINNER",
      name: "Pesto Pasta",
      kiloCaloriesBurnt: "612",
      timeTaken: "15",
      imagePath: "assets/pesto_pasta.jpg",
      ingredients: [
        "1 cup of granola",
        "1 banana",
        "1/2 cup of raisins",
        "1 tbsp of honey",
      ],
      preparation:
          '''As I said above, making pesto pasta is easy. Here’s all you need to do:

Blend up a batch of my 6-ingredient basil pesto, or use store-bought pesto in a pinch.
Cook your pasta in a large pot of salted boiling water according to the package directions.
Before draining the pasta, reserve some of the starchy pasta water. Then, add 1/4 cup of this pasta water back into the pot with your pesto, and stir to thin the pesto.
Toss in the cooked pasta, and mix until the pesto thoroughly coats it.
Add a big handful of arugula and toss until it’s barely wilted.
Finish everything with a big squeeze of lemon, salt, pepper, red pepper flakes, and toasted pine nuts.'''),
  Meal(
      mealTime: "SNACK",
      name: "Keto Snack",
      kiloCaloriesBurnt: "414",
      timeTaken: "16",
      imagePath: "assets/keto_snack.jpg",
      ingredients: [
        "1 cup of granola",
        "1 banana",
        "1/2 cup of raisins",
        "1 tbsp of honey",
      ],
      preparation:
          '''Bake at 350°F (180°C) for about 15–20 minutes, or until set.

Exact nutrition information varies depending on what you add to your recipe. One frittata (170 grams) may provide up to 320 calories, 14 grams of protein, and 21 grams of fat (1Trusted Source).

Store them in the refrigerator so you can easily grab a couple on your way out, or bake a few batches and freeze them for later.'''),
];