---
title: Text Search with Grep
date: 2020-06-11 10:47:13 +0800
modified: 2020-06-11 10:47:13 +0800
tags: [llnux, cli, sh, grep]
description:
series: Searching and Substitution
---

Two of the fundamental operations you encounter repeatedly in shell scripting are 'searching' and 'substituion'. The UNIX programmers, after all, prefer to work on lines of text. This is because textual data is very flexible and is a lot more manageable than binary data. In this post, we will look at how to accomplish this with tools shipped with your system.

One of the staple tools used to match text is `grep`. Traditionally, there are three separate programs for searching through text files:

- grep: the original text-matching program which uses Basic Regular Expression (BREs) as defined by the POSIX standard
- egrep: an extended version of grep uses Extended Regular Expression (EREs) which are more powerful but are more computationally expensive to execute
- fgrep: fast grep is a variant of grep that matches fixed strings instead of regular expressions using an optimized algorithm for fixed-string matching

## Simple Grep

The simplest use of grep is with constant strings. Suppose we have the command `ls -1` which outputs the following:

```shell
$ ls -1
2019-04-22-monitoring-docker-with-prometheus.md
2019-05-07-aggregate-functions-using-pandas.md
2019-05-13-natural-language-processing-on-twitter-part-1.md
2019-05-22-natural-language-processing-on-twitter-part-2.md
2019-05-23-cidr-network-notation.md
2019-05-30-python-design-patterns-template-method.md
2019-10-21-memoization.md
2019-10-23-python-iterables.md
2020-05-30-basics-of-shell-scripting.md
2020-05-31-shell-scripting-constructs.md
2020-06-01-experimental-analysis-of-algorithms.md
2020-06-01-process-management-and-job-control.md
2020-06-03-configuring-shell-hooks.md
2020-06-04-docker-resrouce-limits.md
2020-06-05-limiting-cpu-usage-using-systemd-cgroups.md
2020-06-07-file-manipulation-utilities.md
2020-06-09-shell-functions.md
2020-06-11-searching-and-substitution.md
```

to filter the results, say we only want file names with python, we can pipe ls to grep like so:

<div class="language-shell highlighter-rouge">
  <div class="highlight">
    <pre class="highlight"><code>$ ls -1 | grep -F python
2019-05-30-<b>python</b>-design-patterns-template-method.md
2019-10-23-<b>python</b>-iterables.md</code></pre>
  </div>
</div>

Now, that's a manageable result. This example uses the `-F` flag which searches for the fixed string `python` but it can be omitted. As long as your pattern does not contain any regex metacharacters, it will work as if it you are passing the `-F` option:

<div class="language-shell highlighter-rouge">
  <div class="highlight">
    <pre class="highlight"><code>$ ls -1 | grep -F python
2019-05-30-<b>python</b>-design-patterns-template-method.md
2019-10-23-<b>python</b>-iterables.md</code></pre>
  </div>
</div>

Grep doesn't only work for piped output, but it caan also be used to search the contents of a file. For example, suppose we want to look for the occurence of the word `gem` inside the `Gemfile`:

<div class="language-text highlighter-rouge">
  <div class="highlight"><pre class="highlight"><code>$ grep gem Gemfile
source "https://ruby<b>gem</b>s.org"
<b>gem</b> "jekyll", "~&gt; 4.1.0"
  <b>gem</b> "jekyll-feed", "~&gt; 0.12"
  <b>gem</b> 'jekyll-sitemap'
  <b>gem</b> 'jekyll-sass-converter', '~&gt; 2.1.0'
  <b>gem</b> 'jekyll-compose'
  <b>gem</b> 'jekyll-postfiles', '~&gt; 3.0'
  <b>gem</b> 'rouge', '~&gt; 3.19'</code></pre>
  </div>
</div>

## Ignoring Case

By default, grep matches are case sensitive. We can, however, instruct it to ignore case by passing in the `-i` flag. Now, suppose we have a file with the following content.

```
book
boom
boot
boOT
bOot
BOOT
boon
boob
boor
boos
boost
booth
booze
booty
booby
boody
boomy
booms
boons
books
booed
boogy
boobs
boots
boozy
boors
```

If we pass in the ignore flag, we're left with this:

<div class="language-text highlighter-rouge">
  <div class="highlight"><pre class="highlight"><code>$ grep -i boot file
<b>boot</b>
<b>boOT</b>
<b>bOot</b>
<B>BOOT</B>
<b>boot</b>h
<b>boot</b>y
<b>boot</b>s</code></pre>
  </div>
</div>

## Word Match

If we want to match only full words, there is a `-w` flag for that:

<div class="language-text highlighter-rouge">
  <div class="highlight"><pre class="highlight"><code>$ grep -w boot file
<b>boot</b></code></pre>
  </div>
</div>

## Match Line Number

We can even throw in a `-n` flag to print which line is the match

<div class="language-text highlighter-rouge">
  <div class="highlight"><pre class="highlight"><code>$ grep -n boot file
<i>3</i>:<b>boot</b>
<i>12</i>:<b>boot</b>h
<i>14</i>:<b>boot</b>y
<i>24</i>:<b>boot</b>y</code></pre>
  </div>
</div>

## Invert Search

Moreover, we can also invert our condition to only retrieve those that does not match the pattern:

```shell
$ grep -v boo file
boOT
bOot
BOOT
```

## Multiple and Recursive Search

Suppose we want to search for the word `item` for multiple files, we can use a wildcard instead:

<div class="language-text highlighter-rouge">
  <div class="highlight"><pre class="highlight"><code>$ grep item _posts/_*.md
_posts/2020-06-11-searching-and-substitution.md:  gem 'jekyll-s<b>item</b>ap'
_posts/2020-06-09-shell-functions.md:There are, however, leg<b>item</b>ate inst...
_posts/2019-10-23-python-iterables.md:You can read <b>item</b>s from it one by one:
_posts/2019-10-23-python-iterables.md:for <b>item</b> in sample_list:
_posts/2019-10-23-python-iterables.md:    print(<b>item</b>)
_posts/2019-10-23-python-iterables.md:This process of going over each <b>item</b>...
_posts/2019-10-23-python-iterables.md: ... the <b>item</b>s one by one. Iterat...
_posts/2019-10-23-python-iterables.md:    for <b>item</b> in range(3):
_posts/2019-10-23-python-iterables.md:         yield <b>item</b> * <b>item</b>
_posts/2019-10-23-python-iterables.md:    for <b>item</b> in range(1, n):
_posts/2019-10-23-python-iterables.md:        yield sum(range(<b>item</b>))</code></pre>
  </div>
</div>

Alternatively, we can pass in the directory with a `-r` flag which instructs grep to recursively check all files inside.

<div class="language-text highlighter-rouge">
  <div class="highlight"><pre class="highlight"><code>$ grep -r item _posts_
_posts/2020-06-11-searching-and-substitution.md:  gem 'jekyll-s<b>item</b>ap'
_posts/2020-06-09-shell-functions.md:There are, however, leg<b>item</b>ate inst...
_posts/2019-10-23-python-iterables.md:You can read <b>item</b>s from it one by one:
_posts/2019-10-23-python-iterables.md:for <b>item</b> in sample_list:
_posts/2019-10-23-python-iterables.md:    print(<b>item</b>)
_posts/2019-10-23-python-iterables.md:This process of going over each <b>item</b>...
_posts/2019-10-23-python-iterables.md: ... the <b>item</b>s one by one. Iterat...
_posts/2019-10-23-python-iterables.md:    for <b>item</b> in range(3):
_posts/2019-10-23-python-iterables.md:         yield <b>item</b> * <b>item</b>
_posts/2019-10-23-python-iterables.md:    for <b>item</b> in range(1, n):
_posts/2019-10-23-python-iterables.md:        yield sum(range(<b>item</b>))</code></pre>
  </div>
</div>
