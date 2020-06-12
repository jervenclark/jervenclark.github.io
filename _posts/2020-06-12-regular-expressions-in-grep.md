---
title: Regular Expressions in Grep
date: 2020-06-12 22:09:42 +0800
modified: 2020-06-12 22:09:42 +0800
tags: [llnux, cli, sh, grep]
description:
series: Searching and Substitution
---

In the previous post, we dealt with simple text matching using grep but to truly unlock the power of grep, we have to leverage the power of regular expressions. In particular, we will be dealing with POSIX BRE and ERE constructs.

Regular expressions are notations that lets you search for text that fits a particular criterion, such as "starts with letter a" or "repeating letter c". The notation can also let you write a single expression that can select or match multiple strings.

Beyond the traditional UNIX regex notations, POSIX regex flavor lets you write regular expressions that express locale-specific character sequence orderings and equivalencies. Consequently, this frees the user from the underlying character set of the system. And because fregular expressions are central to UNIX use, it pays a lot to master them.

In terms of the nuts and bolts, regexes are built from two basic components: literal characters and meta characters. A meta character is a special character with a predefined meaning in regular expressions. A literal character is any character that isn't a meta character.

| Character | BRE/ERE | Meaning                                                                                 |
| \         | Both    | Used to toggle between the special meaning or the literal meaning of characters         |
| .         | Both    | Match any single character except NUL. Some programs also prevent matching with newline |
| *         | Both    | Match any numbber of single character that immediately precedes it                      |
| ^         | Both    | Match the following regular expression at the start of the line/string                  |
| $         | Both    | Match the following regular expressionn at the end of the line/string                   |
| [ and ]   | Both    | Matches any one of the enclosed characters.                                             |
| {n,m}     | ERE     | Matches a range of occurennces of the single character that immediately precedes it     |
| ( and )   | BRE     | Save the pattern enclosed between the parentheses                                       |
| \n        | BRE     | Replay the nth subpattern enclosed in parentheses. n is any number from 1-9             |
| +         | ERE     | Match one or more instances of preceding regular expression                             |
| ?         | ERE     | Match zero or one instances of preceding regular expression.                            |
| \|        | ERE     | Match the regular expression specified before or after                                  |

