# Contour Plots

Roassal support for contour plots.

## How to install it?

To install `contour-plot`, go to the Playground (Ctrl+OW) in your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'AIContourPlot';
  repository: 'github://pharo-ai/contour-plot/src';
  load.
```

## How to depend on it?

If you want to add a dependency on `expectation-maximization` to your project, include the following lines into your baseline method:

```Smalltalk
spec
  baseline: 'AIContourPlot'
  with: [ spec repository: 'github://pharo-ai/contour-plot/src' ].
```

If you are new to baselines and Metacello, check out the [Baselines](https://github.com/pharo-open-documentation/pharo-wiki/blob/master/General/Baselines.md) tutorial on Pharo Wiki.

## How to use it?
