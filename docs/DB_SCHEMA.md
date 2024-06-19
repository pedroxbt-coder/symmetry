### Explanation of the Initial Schema Implementation and Its Limitations

When I initially designed the database schema for our app, due to time constraints and limited foresight, I implemented a very basic and limited schema for storing articles. Here is the schema I used:

#### Current Schema

json

Copy code

`{
  "Articles": {
    "articleId_001": {
      "title": "Example Title",
      "content": "Example Content",
      "authorName": "John Doe"
    },
    "articleId_002": {
      "title": "Another Title",
      "content": "More Content",
      "authorName": "Jane Smith"
    }
  }
}` 

### Limitations of the Current Schema

1.  **Lack of Direct Association with Users:**
    
    -   No user ID is included, making it difficult to link articles to specific users.
    -   Retrieving all articles by a particular user requires scanning every document, leading to an inefficient `O(n)` operation.
2.  **Inefficient Queries:**
    
    -   Firestore doesn't support native text-based search, so finding articles by `authorName` requires filtering all documents.
    -   This method is slow and costly as the number of articles grows, resulting in increased latency and higher read costs.
3.  **Difficulty in Maintenance and Scaling:**
    
    -   As the app grows, efficiently associating articles with users becomes critical.
    -   The current schema lacks flexibility, making it challenging to add new features like user-specific dashboards or personalized article lists.


Without a doubt, the following explains the best option in the case that I had been able to link the created articles to their respective users. This question is discussed showing 2 aparently good options.

# **Why the First Schema is Worse Than the Second Schema**

When designing a Firestore schema, it's crucial to consider efficiency and scalability to ensure smooth performance as the number of reads and writes grows. Let's compare two possible schemas for storing articles and explain why the first one is worse than the second one.

**Schema 1: Articles Collection with Separate Documents**
    
{

"Articles": {
    articleId: {
        title,
        content,
        authorId,
        authorName,
        createdAt,
    }
}

}
  

**Schema 2: Articles Nested Under User IDs**

{
    "Articles": {
        userId: {
            articleId: {
                title,
                content,
                authorName,
                createdAt
            }
        }
    }
}


## Arguments Against Schema 1

**1. Inefficiency in Querying Articles by User**

In Schema 1, if you want to retrieve all articles written by a specific user, you would have to query the entire Articles collection and filter the results by authorId. This means you have to scan through potentially millions of documents, leading to significant inefficiencies. The query might look something like this:


firestore.collection('Articles').where('authorId', '==', 'userId_12345').get();
  

While Firestore is optimized for such queries to some extent, the performance can degrade as the number of articles grows. The operation becomes an O(n) complexity, where n is the total number of articles in the collection. For a small number of documents, this inefficiency is negligible, but as your application scales, the impact on performance becomes more pronounced.

  

**2. Increased Latency and Cost**

As the number of articles increases, the time it takes to scan through all documents to find those that match a specific authorId increases. This not only leads to higher latency but also increased read costs, as Firestore charges for each document read. This can become a significant cost factor in applications with high read volumes.

  

## Arguments for Schema 2

**1. Direct Access to User Articles**

In Schema 2, articles are nested under their respective user IDs. This structure allows for direct and efficient access to a user's articles without scanning the entire Articles collection. Retrieving articles for a specific user involves a single document read, making it an O(1) operation:

  

firestore.collection('Articles').doc('userId_12345').get();

  

This method is inherently more efficient because it leverages the hierarchical nature of Firestore, providing immediate access to the nested documents.

  

**2. Improved Scalability and Performance**

By organizing articles under user IDs, Schema 2 ensures that each user’s articles are isolated within their own document. This isolation helps in maintaining quick access times regardless of the total number of articles in the database. It prevents performance degradation as the application scales, making it more suitable for applications expected to handle large volumes of data.

  

**3. Cost-Effectiveness**

Schema 2 minimizes the number of reads needed to retrieve a user's articles, reducing overall read costs. This efficiency is particularly beneficial for applications with frequent read operations, helping to keep operational costs lower.

  

**

## Conclusion

**

While Schema 1 may work well for applications with a small number of articles, it becomes inefficient and costly as the data volume grows. In contrast, Schema 2 offers a more scalable and efficient approach by organizing articles under user IDs, ensuring quick access and better performance in the long run. Therefore, for applications expected to handle a growing number of reads and writes, Schema 2 is the superior choice.

