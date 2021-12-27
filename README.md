# Q Tips

This project contains the source files for "Q Tips: Fast, Scalable and Maintainable Kdb+".[^fn1]

## The Book

**Q Tips** can be purchased on [Amazon](http://www.amazon.com/Tips-Fast-Scalable-Maintainable-Kdb/dp/9881389909).
A [Kindle version](http://www.amazon.com/Tips-Fast-Scalable-Maintainable-Kdb-ebook/dp/B00UZ8OMME) is also available.
Books may be purchased in quantity and/or special sales by contacting the publisher,
[Vector Sigma](mailto:sales@vector-sigma.com).  Read a [review](https://vector.org.uk/book-review-q-tips-fast-scalable-and-maintainable-kdb-2/)
by [Yang Guo](https://www.linkedin.com/in/yang-guo-19494ba/) published by [Vector](https://vector.org.uk/), the Journal of British APL Association.

Check out Kx System's [press release](https://kx.com/news/q-tips-offers-practical-guidance-for-financial-big-data-analytics/).

## The Source

Install `q` from Kx System's kdb+ [download page](https://kx.com/developers/download-licenses/) and grab a copy of the **Q Tips** [source]({{site.github.repository_url}}).

```sh
$ git clone https://github.com/psaris/qtips
```

## The CEP Engine

The following command starts the CEP engine on port 5001, with a
maximum workspace size of 200 Mb, the timer set to run every 100 ms,
the end of day event set to run at 4:00 PM, and the directory to save
the price, quote and trade tables set to 'qdb'.

```sh
$ q cep.q -p 5001 -w 200 -t 100 -eod 16:00 -db qdb
```

## The Errors

Any typos or errors are listed [here](errata.adoc) and are
incorporated into recent printings of the book as well as the
Kindle version.

<!----- Footnotes ----->

[^fn1]: More presentations, competitions and books by Nick Psaris can be found at <https://nick.psaris.com>
