# Introducing Flowchartviz

This is my 1st attempt at writing a flowchart generator.

## Example 1

    require 'flowchartviz' 

    s = "
    if a then
      go left
      keep walking
    else
      go right
    end
    "

    fm = Flowchartviz.new(s)
    fm.export

Here's the PNG file of the exported file after it has been passed to the Graphvizml gem:
![](http://www.jamesrobertson.eu/r/images/2017/sep/02/gvml.png)


## Example 2

    require 'flowchartviz'

    s = "
    if a then
      go left
      keep walking
    else
      go right
      if raining?
        take an umbrella
    end
    "

    fm = Flowchartviz.new(s)
    fm.export

In the above example a nested if statement was added. Here's the PNG file produced having passed the gvml.xml to the Graphvizml gem:

![](http://www.jamesrobertson.eu/r/images/2017/sep/02/gvml2.png)

## Resources

* flowchartviz https://rubygems.org/gems/flowchartviz
flowchart gem flowchartviz graphviz pxgraphviz
