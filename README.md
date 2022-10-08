# Would You Rather

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)


## Overview
### Description
Users can create would you rather questions. Others can vote on the question and see results afterwards. Comments feature also implemented.


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
* [ ] User should be able to post would you rather questions to the feed
* [ ] User should be able to have the option to upload a photo with their question
* [ ] User should be able to vote on the poll
* [ ] User can upvote other peoples posts
* [ ] User can comment on other peoples posts
* [ ] User can see two tabs, one main feed (latests posts) and another tab with trending posts (posts with the most amount of likes at the top)
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
[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
