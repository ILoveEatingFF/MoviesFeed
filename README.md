Movies feed.
This application uses TMDB API key to get content.

Pods used:
Kingfisher — используется для получения изображения по url, асинхронно подкачивает изображение, делает несколько запросов + он их кеширует, поэтому его удобно использовать в CollectionView или TableView(метод dequeueReusableCell будет доставать его из кэша, а не скачивать при каждом срабатывании по url). 
