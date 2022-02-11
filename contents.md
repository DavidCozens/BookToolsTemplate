# Headings (Heading 1)

Some text for the body of the paragraph.

## Heading 2

Some text for the body of the paragraph.

### Heading 3

Some text for the body of the paragraph.

#### Heading 4

Some text for the body of the paragraph.

##### Heading 5

Some text for the body of the paragraph.

###### Heading 6

Some text for the body of the paragraph.

# Emphasis

Lets try *italic*, **bold**, ***bold italic***

# Block Quotes

A normal paragraph

> some quoted
> 
> text spanning a few lines
>
>> with nested quotes
>
> - and nested items *Some formating works inside blockquotes*

# Lists

## Ordered

1. first item
1. second item
1. third item
 1. indented 
1. fourth item

## Unordered

- first item
- second item

  indented paragraph inside the list

- third item
 - indented item
- fourth item

# Code Blocks

a code block can be done by indenting 4 spaces

    <html>
      <head>
        <title>Test</title>
    
      </head>

# Images

Images can be embedded

 ![A test image](testimage.png)

 Titles can be added that show as tooltips

 ![A test image](testimage.png "optional title")

 To control size you have to use html.

# Code

 Place code inline `printf("Hello World");` using back quotes ``

# Horizontal Lines

A horizontal line can be drawn with three underscores

---

Like that

# Links

External links [Google](https://google.com)

With a tool tip [Google](https://google.com "A search engine")

An explicit link <https://google.com>

Email <fred.blogs@example.com>

A reference link can be linked like this [reference link][1], the only difference is where the target is specified. The reference link can be any identifier

[1]: https://google.com

# Extensions

Not all processors support extensions, the common ones are included here to see how they render.

## Tables

| column header| second column |
| ------------ | ------------- |
| item 1 | aaa |
| item 2 | bbb |

## Aligned tables

| Left | Centre | Right |
|:---  | :---:  | ---: |
| aa | aa | aa |
| bb | bb | bb |

## Fenced code blocks

Plain

```
int main()
{
    printf("Hello World");
}
```

With syntax highlighting

```c
int main()
{
    printf("Hello World");
}
```

## Footnotes

This paragraph has a footnote [^1], and another[^fn], and a big one [^big].

Then place the footnotes where you want them

[^1]: First footnote

[^fn]: Any text can be used as the footonote id

[^big]: Footnotes can span multiple lines

  Indent paragraphas that form part of the footnote

## Heading IDs {#SpecialHeadingId}

When supported the id is included in the output htmp allowing for custom formatting

You can link to a heading ID [like this](#SpecialHeadingId)

## Definition Lists

A definition list is specified using :

First Term
: Definition of the first term

Second Term
: Definition of second term
: a second definition of the second term

## Check List

-[x] A checked item
-[ ] Unchecked

## Strike Through

Text ~~can be struck out ~~ using two ~ characters. 


## Emojis

Shortcodes can be used like this :happy face: to embed emojis

## Highlight

Some processors ==Highlight== items surrounded by two = characters.

## Subscript

Subscripts, when supported are done using ~ H~2~O, however some processors use this for strike through, in which case use HTML H<sub>2</sub>O

## Superscript

Use ^ for superscript X^2^, or X<sup>2<sup>

## Underline

We have to resort to HTML to <ins>underline</ins> words.

## Centered

AQgain we have to use HTML, and the tag is deprecated

<centre>Is the centred?</centre>

## Comments

We can comment our markdown

[With text that is invisible]: #

# Final summary

Summary text
