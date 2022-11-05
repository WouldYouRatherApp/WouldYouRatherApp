# Would You Rather

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)


## Overview
### Description
Users can create would you rather questions. Others can vote on the question and see results afterwards. Comments feature also implemented.

### Current Progress

<img src='https://imgur.com/Wl4yvZJ.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

### App Evaluation
- **Category:** Social Media App
- **Mobile:** A photo can be uploaded to give more context about the question/what made them think of the question.
- **Story:** Allows users to share posts which consist of a "would you rather" question which gets feedback from other online users. Create connections with friends over ThoughtProvoking questions 🤨💭
- **Market:** Anyone who likes exploring hypothetical situations. Tailored towards a large audience. 
- **Habit:** Users can post questions whenever they want and multiple times a day. A habit can be formed whenever they think of a controversial or interesting question. 
- **Scope:** Starting scope would be creating a general feed for everyone that displays the latest posts and showing percentages and comments after they vote. If we can, we would like to implement a "popular" page that shows posts that have gained lots of attention and maybe also a feed tailored towards the user's interests (posts from friends?). 


## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**
* [x] User can see a styled launch screen and app icon
* [x] Users can create an account and log in
* [x] User should be able to post would you rather questions
* [ ] User should be able to see posts on their feed
* [ ] User should be able to have the option to upload a photo with their question
* [ ] User should be able to vote on the poll
* [ ] User can upvote other peoples posts
* [ ] User can comment on other peoples posts
* [x] User can see two tabs, one main feed (latests posts) and another tab with trending posts (posts with the most amount of likes at the top)
* [ ] User can view results after answering a poll

**Optional Nice-to-have Stories**
* [ ] User can categorize "would you rathers" with a hashtag so any user can have "catered" questions
* [ ] Users can see profiles that shows questions they voted on, their question stats (how many votes they got, how many questions, etc)


### 2. Screen Archetypes

* Login screen
   * User can login
   * Design logo 🥸
* Main Feed Screen
   * Feed/Posts that are uploaded the most recently (chronological order)
   * can display posts from followed users
* Trending Feed Screen
   * User sees questions with the most popular questions (dictated by # of votes)
* Poll Creation Screen
    * User can create and the post a poll
* User Profiles
    * People can click on profiles from their feeds to see that user's posted questions and upvotes


### 3. Navigation

**Tab Navigation** (Tab to Screen)
* Main feed
* Trending feed
* Poll Creation
* User Profile

**Flow Navigation** (Screen to Screen)
* Login screen
   * segue to Main Feed after successful login
* Main Feed Screen (Tabs at Bottom Navi Bar)
   * Main Feed
   * Trending Feed
   * Profile Page
* Main Feed Screen (Top Corner Buttons)
   * Logout
   * Poll Creation

## Wireframes
![](https://i.imgur.com/qFfalHt.png)

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
### Models
| Property      | Type     | Description |
| ------------- | -------- | ------------|
| author        | Pointer to User| image author |
| objectId      | String   | unique id for the user post (default field) |
| username      | String   | string of username
| question      | String   | text question by author |
| choiceA       | String   | text for choice A |
| choiceB       | String   | text for choice B |
| bio           | String   | string of biography |
| comment       | String   | string of comment |
| commentsCount | Number   | number of comments that has been posted to an image |
| upvoteCount    | Number  | number of upvote for the post |
| downvoteCount | Number   | number of downvote for the post| 
| choiceACount  | Number   | number of votes for option A of the post |
| choiceBCount  | Number   | number of votes for option B of the post |
| createdAt     | DateTime | date when post is created (default field) |
| updatedAt     | DateTime | date when post is last updated (default field)
| profilePhoto  | File     | image to display for user profile |
| image         | File     | image that user posts |

### Networking
Network requests by screen
* Login Screen
    * (Create/POST) Create a username/password
    * (Create/POST) Create a profilePhoto
* Main Feed (followers)
    * (Read/GET) Query all posts where followers are authors 
    * (Update/PUT) Update upvote count by 1
    * (Update/PUT) Update downvote count by 1
    * (Create/POST) Create a new comment on post
    * (Update/PUT) Update comment (edit)
    * (Update/PUT) Update vote count on chosen option
    * (Delete) Delete existing comment
* Post Question
    * (Create/POST) Create a new post object
* User Profile
    * (Read/GET) Query logged in user object
    * (Update/PUT) Update user profile image
    * (Update/PUT) Update user bio
    * (Update/PUT) Update existing post
    * (Delete) Delete post
* Trending Feed
    * (Read/GET) Query all posts that have the highest amount of votes
    * (Create/POST) Create a comment under a post
    * (Update/PUT) Update upvote count by 1
    * (Update/PUT) Update downvote count by 1
    * (Update/PUT) Update comment string
    * (Delete) Delete existing comment
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]

### Progress

Launch Screen

![](https://i.imgur.com/TLyZW2E.png)

Login Screen

![](https://i.imgur.com/2wrxwuG.png)

Home Feed

<img width="388" alt="Screenshot 2022-10-28 at 12 37 21 AM" src="https://user-images.githubusercontent.com/77522068/198846875-7047a005-f34e-4945-a8a1-5f897acd5b55.png">
