### 1. Introduction

First of all, regardless of the outcome, I would dare to say that this has been the best experience and feeling I have ever had, and for that, I am immensely grateful for the opportunity you have given me with this invitation to step out of my comfort zone. 
As a man of purpose, I felt a profound self-realization as I improved my weaknesses and grew inwardly.

I received the email about the programming test late at the institute and got very excited. When I read the repository, I knew it would be a challenging 7 days, but I was also completely willing to face it and try to do a good job. I wasn't entirely sure if I could do something decent, as I had only been discovering my passion for the world of programming for about 6 months, and this was a big challenge.

As for the experience, I started with long and comprehensive courses on YouTube about HTML, CSS, and JavaScript almost a year ago (August 2023), but I had a break until December, when I got into Next.js.

### 2. Learning Journey

Regarding the learning process, I took it to another level. It was 7 long days of work where, error after error, I started to notice, towards the end, how everything was fitting together. I invested many hours in the test, but many more in learning this completely new language for me and, above all, in studying the also new architecture on which it is based.

The video of your first Flutter app helped me a lot to get into the language. Also, I had to watch the clean architecture video several times during the project, as I didn't quite understand anything, to be honest.

On the other hand, I made the mistake of relying too much on ChatGPT at the beginning. The ease with which it gave me a UI, for example, isolated me from understanding, by programming myself, the Dart syntax, which I had to pay for later.

Finally, I want to highlight the great wisdom I have acquired about the architecture used. Although at first, when I understood practically nothing, I came to think that it was a bit silly to separate the code so much for an apparently simple page, in the end, I understood that it was the best thing that could be done from the beginning. I have learned the lesson that what is written must be written in the best possible way. Specifically, besides "clean" I would use: maintainable, readable, testable, consistent, safe, performant, understandable, or many other adjectives to define the architecture that, thanks to you, I have learned.

### 3. Challenges Faced

Throughout the project, I had problems that at the time seemed like they would stop me prematurely. However, my persistence ended each one through understanding what I was doing.

First of all, I want to highlight how difficult it was for me to do the setup. I can't quite remember the exact errors, as my head has been bursting with information in recent days, but I basically spent the first 2 days without being able to really program, doing the setup. I didn't quite understand what I needed to start programming, I wasted time with Xcode, endless package installations to solve also endless errors. I didn't understand, for example, why I got an error when trying to create the iOS app with flutterfire configure, so I ended up doing it only for Android.

It got so complicated that it was a great achievement to even initialize the app with the emulator without strange errors or errors I simply didn't understand because everything was new. It was also a great achievement to finally understand the data flow through the different layers. The problem is that this understanding came at the end, after many errors, which makes me think that if I started the project again, I would do everything much better and with more knowledge.

I have always believed that real learning is in the whole process of trial and error before the much-desired result. This has been magnified with this project. I feel helpless seeing now, in retrospect, how I could have done everything much better from the beginning. This, more than an excuse or justification, is a demonstration of my interest in continuing to learn and improve with more time.

Then, there are some minor errors I would like to describe. One problem I encountered was not being able to correctly display the properties of the created articles. I didn't have time to get involved in how the articles were being handled in the article_tile, and what was causing some things like the timestamp or the author's name not to be displayed. Since they were correctly saved in Firestore, I decided not to waste time on that, as it would be too complex for the minor detail it meant to fix it.

I also struggled with Bloc to correctly display the UI that the user sees after authenticating. At first, the state was only set by manually restarting the app, but by better understanding the listeners and events, I managed to have it display automatically.

I'm sure I'm forgetting many things, but I have gained so much information and it has been so intense that it's hard to remember everything important.

### 4. Reflection and Future Directions

The above introduces this topic. I will not hesitate, as soon as I send this, to start again and surpass myself, even if it's for personal growth and won't serve to present the project in a better way in the entrance test. Actually, I liked Flutter more than I expected, coming from React. I will continue learning on my own, although I might take a short break, as I have been very obsessed these days and haven't had time to meditate.

If I already loved programming, having had the opportunity to glimpse this new world motivates me even more to build something great through this.

As for the project, time has run short, as naturally, I started fitting the puzzle pieces together as time was running out. That's why I would have loved, for example, to implement a better, more realistic Firestore with the schema supported on the SCHEMA_DB.md file.

On the other hand, it would be great to somehow publish the article so that, along with good authentication, it could receive likes from other users. For my part, in the end, I could only implement sign-up and log-out, due to a Firebase error that appeared when trying to do so on an already existing account. I'm sure it could be achieved.


### 5. Proof of the project
As an evidence, I made a screen recording through the app.

[Screen Recording](docs/appTour2.mp4)


### 6. Overdelivery
The main implemented feature that was not strictly necessary was authentication. I created an "auth" feature that allowed conditional rendering and showing or allowing different things to the user, such as denying them the ability to create articles if not authenticated. The bad taste in my mouth, and potentially good future application, was not being able to really link the users to their articles. Without a doubt, that would have been perfect, as different users would have their created articles. This is better explained in the schema section, talking about the complexity of different options.

As a minor feature, I went through nearly all of Diego's comments in the Figma prototypes. In the video I did not show all of them.

As another extension, I tried to be able to delete my articles as well, but I couldn't, as it was not possible to convert the string type of the article returned by Firestore to the int type of the id in the ArticleEntity. I tried changing the latter to String, which fixed that problem, but caused others in the local database, such as the saveArticle function no longer working.

### 7. Conclusion

To conclude, I want to say that this experience has been very gratifying for me. I have learned so much that I could now apply an idea that I really like: if you do something and later see it thinking about the thousand ways in which you would improve it, you haven't lost by believing you made mistakes, but rather you have gained something very valuable during these days: learning. In this case, it accurately represents the project because after a whole week of complete immersion, the understanding of the code at the beginning has nothing to do with the understanding at the end.