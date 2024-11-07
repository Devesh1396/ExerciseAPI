// Helper function to get placeholder image URLs for each category
String getCategoryImage(String category) {
  switch (category) {
    case "cardio":
      return "https://www.shutterstock.com/image-photo/group-young-athlete-male-female-600nw-2187804365.jpg";
    case "back":
      return "https://e1.pxfuel.com/desktop-wallpaper/957/831/desktop-wallpaper-man-gym-muscle-physical-exercise-human-back-barbell-athletic-gym-men.jpg";
    case "chest":
      return "https://img-aws.ehowcdn.com/750x428p/photos.demandstudios.com/getty/article/217/99/615732150.jpg";
    case "lower arms":
      return "https://hips.hearstapps.com/hmg-prod/images/arm-exercises-with-weights-668d2259826b5.jpg";
    case "lower legs":
      return "https://i0.wp.com/www.muscleandfitness.com/wp-content/uploads/2019/06/2-walking-lunge-1109.jpg?quality=86&strip=all";
    case "neck":
      return "https://www.laspine.com/wp-content/uploads/2018/05/Neck-Exercises.jpg";
    case "shoulders":
      return "https://www.trxtraining.com/cdn/shop/articles/woman-doing-barbell-squats.png?v=1683922507";
    case "upper arms":
      return "https://hips.hearstapps.com/hmg-prod/images/bodybuilder-doing-push-ups-royalty-free-image-1660237338.jpg?crop=0.670xw:1.00xh;0.188xw,0&resize=640:*";
    case "upper legs":
      return "https://c4.wallpaperflare.com/wallpaper/700/955/627/legs-workout-fitness-gym-wallpaper-preview.jpg";
    case "waist":
      return "https://media-cldnry.s-nbcnews.com/image/upload/t_social_share_1024x512_center,f_auto,q_auto:best/rockcms/2022-09/15-waist-slimming-exercises-zz-220926-021483.jpg";
    default:
      return "";
  }
}