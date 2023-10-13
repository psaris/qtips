# Q Tips

This project contains the source files for "Q Tips: Fast, Scalable and
Maintainable Kdb+".[^fn1]

## The Book

**Q Tips** can be purchased on [Amazon][BOOK].  A [Kindle
version][KINDLE] is also available.  Books may be purchased in
quantity and/or special sales by contacting the publisher, [Vector
Sigma][VECSIG].  Read a [review][REVIEW] by [Yang Guo][YANGGUO]
published by [Vector][VECTOR], the Journal of the British APL
Association.


[BOOK]: http://www.amazon.com/Tips-Fast-Scalable-Maintainable-Kdb/dp/9881389909 "Q Tips book"
[KINDLE]: http://www.amazon.com/Tips-Fast-Scalable-Maintainable-Kdb-ebook/dp/B00UZ8OMME "Q Tips e-book"
[VECSIG]: mailto:sales@vector-sigma.com "Vector Sigma e-mail"
[REVIEW]: https://vector.org.uk/book-review-q-tips-fast-scalable-and-maintainable-kdb-2/ "Q Tips book review"
[YANGGUO]: https://www.linkedin.com/in/yang-guo-19494ba/ "Yang Guo"
[VECTOR]: https://vector.org.uk/ "Vector - Journal of the British APL Association"


Check out Kx System's [press release][PRESS].

[PRESS]: https://kx.com/news/q-tips-offers-practical-guidance-for-financial-big-data-analytics/ "Q Tips press release"

## The Source

Install `q` from Kx System's kdb+ [download page][DOWNLOAD] and grab a
copy of the **Q Tips** [source]({{site.github.repository_url}}).

[DOWNLOAD]: https://kx.com/developers/download-licenses/ "Download Q"


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

## The Swag

Swag can be found on the [Vector Sigma Spring site][SPRING].

[SPRING]: https://vectorsigma.creator-spring.com/ "Vector Sigma Swag"


<!----- Footnotes ----->

[^fn1]: More presentations, competitions and books by Nick Psaris can
    be found at <https://nick.psaris.com>
