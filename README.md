# Q Tips

This project contains the source files for "Q Tips: Fast, Scalable and Maintainable Kdb+".

## The Book

**Q Tips** can be purchased on [Amazon](http://www.amazon.com/Tips-Fast-Scalable-Maintainable-Kdb/dp/9881389909).
A [Kindle version](http://www.amazon.com/Tips-Fast-Scalable-Maintainable-Kdb-ebook/dp/B00UZ8OMME) is also available.
Books may be purchased in quantity and/or special sales by contacting the publisher,
[Vector Sigma](mailto:sales@vector-sigma.com).  Read a [review](http://archive.vector.org.uk/art10501500)
by Yang Guo published by [Vector Magazine](https://sites.google.com/site/baavector/).

Check out Kx System's [press release](http://kx.com/press-releases-150325.php).

## The Source

Install `q` from Kx System's kdb+ download [page](http://kx.com/software-download.php) and grab a copy of the **Q Tips** source.

```sh
$ git clone https://github.com/psaris/qtips
```

## The CEP Engine

The following command starts the CEP engine on port 5001, 
with a maximum workspace size of 200 Mb, 
the timer set to run every 100 ms,
the end of day event set to run at 4:00 PM,
and the directory to save the price, quote and tradeq tables set to 'qdb'.

```sh
$ q cep.q -p 5001 -w 200 -t 100 -eod 16:00 -db qdb
```

## The Errors

Any typos and errors are listed [here](errata.adoc).  The Kindle version has been updated to include all corrections.
