---
title: "How I Became a Developer"
date: 2017-02-26 00:00
---
<br>

At University I studied Economics.  I was always good at maths and always had an interest in money so the choice was pretty natural.  I attempted to learn a programming language on my own during my junior year, but the rigidities of syntax gave me a lot of trouble. I thought to myself, "...this just isn't for me," and I gave up without any regret. The next year I began consulting for a mobile innovation agency in the UK called [Takeout](http://welcometotakeout.com/). During projects I had the opportunity to work alongside designers and developers and in doing so, I quickly became enamored by the process of creating a product.

When I graduated my goal was to work somewhere creative and inspiring, although what I didn't know was where I best fit in.

**<center>* * * * *</center>**

January 31, 2017 was my last day working [Artsy](http://artsy.net). I arrived at the company as a clueless college graduate and was leaving an eager developer. This had a lot to due with the kindness of my Artsy coworkers.  When I started to learn to code I was interested in how other developers had gotten their start. The engineers seemed so naturally intelligent. Code flowed effortlessly from them and it seemed impossible that they had ever experienced the struggles I was facing.

I was a Digital Marketing Intern. I didn't know much about Marketing but I was very eager to get involved in projects in and outside my team.  At the end of the first week I scored an invite to a Gallery Insights meeting (Artsy's content marketing section). The upcoming article was a guest piece by Magnus Resch, an art market economist who had just released Management of Art Galleries. One task for our team was to adapt charts and analysis from Magnus’ book for use in the article.

Here was my chance to do something cool! I started with a treemap depicting the annual revenue of the global art market in 2014. So far, so good. Then I had an idea. I knew some JavaScript from Codeacademy, and I had recently stumbled across D3.js (Data-Driven Documents). I thought to myself. . . What if I made one of these charts interactive?

Some thoughts that crossed my mind:

- no one will go for it

- I cannot do this

- I am not a developer

Thankfully, I shunned my self-doubt for just enough time to develop a prototype. When I presented it at our next meeting, my boss went for it. I worked with a designer to make it on brand, and an engineer who helped me integrate the static files onto the website for anyone to see. Take a look [here](https://www.artsy.net/article/elena-soboleva-advice-from-the-art-world-s-most-controversial-economist).
I was so incredibly happy when the article was published. Had I become a great developer? Of course not! Objectively I was terrible, but, I was passionate, and passion is often a greater power than talent. 

My code is an embarrasing joy to look back at.

<center>**CSS - The Wrong Way**</center>

**Goal**

When the user scrolls over a bar the data point should appear above the bar.

<center>![](/images/bar_graph.png)</center>

**Code**

<center>![](/images/bar_graph_css.png)</center>
<br/><br/>
<center>**JavaScript - Ever heard of parameters?**</center>

**Goal**

When the user clicks a country button, the bars pertaining to that country data should become highlighted.

<center>![](/images/bar_graph2.png)</center>

**Code**

<center>![](/images/bar_graph2_js.png)</center>
<br/><br/>

Ok — that’s enough. Obviously, this isn’t how CSS or JavaScript were made to be used. The CSS is finicky and I should have based the positions of the data points on the relative position of the bar. The JavaScript is repetitive, because I had a clicked() function for each country, which all did the same thing. There should be one function that takes a country parameter. However, the end product works perfectly fine, and I learned a boatload of things while writing this ugly code.

But, most importantly, I learned that programming is not some elusive realm only for people who studied Computer Science in at university. I proved that to myself.

**<center>* * * * *</center>**

I continued to develop interactive charts for Gallery Insights. See [here](https://www.artsy.net/article/elena-soboleva-art-fair-insights-for-galleries-part-i) and [here](https://www.artsy.net/article/elena-soboleva-art-fair-insights-for-galleries-part-ii-03-24-16).

After my internship ended, I continued to work for Artsy for another year as a freelance developer, expanding my skills. Now, I am learning about Swift and iOS development at Flatiron School in New York City.
