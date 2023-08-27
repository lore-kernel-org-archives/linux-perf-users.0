Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC44C83F16
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Aug 2023 11:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjH0LvK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Aug 2023 07:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjH0Lus (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Aug 2023 07:50:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4340E19A
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Aug 2023 04:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6AZBdh/XEDaA5kGBJST50i9hlDPyoWJs0bfL8AH3skI=; b=tQClh/kgCfLePckoa3SHirtrku
        eMUZbfMPiFVC+jI00sELBWt2jmlDmtdF7FQr9h070OvviYn/TNGJsN8iX7L9MvKdQqZYJj/EQkHxd
        qFbBBdy82TS+f7T77VpRK12Z0Bj7EVxt35Y/4/9pMHxPKxKfbEGN2sxuXeESMYf08XSzJRcpWrmLn
        BjbtEBvSVbB/jv6vf1JjDVm0r1MZX56YBqrhxfo1UTpDWytdnkalnBu7sJabNvJUCbgWRlIUik5Ba
        C/nArOEUzfi3ub60QcLQAx2m8OKpfMxUKXXXKseZ5F68wfwa6Um3XGH3l3hz0zZasw2aGS1N2uK+M
        8lghF+pA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qaEHr-00BS80-El; Sun, 27 Aug 2023 11:50:35 +0000
Date:   Sun, 27 Aug 2023 12:50:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        urezki@gmail.com, hch@infradead.org
Subject: Re: [RFC PATCH 4/4] perf: Use folios for the aux ringbuffer &
 pagefault path
Message-ID: <ZOs4i4SPH6y2HE+R@casper.infradead.org>
References: <20230821202016.2910321-1-willy@infradead.org>
 <20230821202016.2910321-5-willy@infradead.org>
 <5231893a-e5a5-4544-a6d2-2c98cbebca09@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5231893a-e5a5-4544-a6d2-2c98cbebca09@lucifer.local>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Aug 27, 2023 at 09:01:04AM +0100, Lorenzo Stoakes wrote:
> On Mon, Aug 21, 2023 at 09:20:16PM +0100, Matthew Wilcox (Oracle) wrote:
> > -	if (page && order) {
> > -		/*
> > -		 * Communicate the allocation size to the driver:
> > -		 * if we managed to secure a high-order allocation,
> > -		 * set its first page's private to this order;
> > -		 * !PagePrivate(page) means it's just a normal page.
> > -		 */
> > -		split_page(page, order);
> > -		SetPagePrivate(page);
> > -		set_page_private(page, order);
> 
> I'm guessing this was used in conjunction with the page_private() logic
> that existed below and can simply be discarded now?

As far as I can tell, yes.

> > -	}
> > +		folio = __folio_alloc_node(PERF_AUX_GFP, order, node);
> > +	} while (!folio && order--);
> >
> > -	return page;
> > +	if (order)
> > +		folio_ref_add(folio, (1 << order) - 1);
> 
> Can't order go to -1 if we continue to fail to allocate a folio?

Hm, yes.

> > @@ -707,17 +696,21 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
> >
> >  	rb->free_aux = event->pmu->free_aux;
> >  	for (rb->aux_nr_pages = 0; rb->aux_nr_pages < nr_pages;) {
> > -		struct page *page;
> > -		int last, order;
> > +		struct folio *folio;
> > +		unsigned int i, nr, order;
> > +		void *addr;
> >
> >  		order = min(max_order, ilog2(nr_pages - rb->aux_nr_pages));
> > -		page = rb_alloc_aux_page(node, order);
> > -		if (!page)
> > +		folio = rb_alloc_aux_folio(node, order);
> > +		if (!folio)
> >  			goto out;
> > +		addr = folio_address(folio);
> > +		nr = folio_nr_pages(folio);
> 
> I was going to raise the unspeakably annoying nit about this function returning
> a long, but then that made me wonder why, given folio->_folio_nr_pages is an
> unsigned int folio_nr_pages() returns a long in the first instance?

Futureproofing the API.  While I don't expect us to be allocating
order-32 folios any time soon, and x86 has excluded p4d-sizes from the
architecture, I don't want to have to go through and audit everywhere
when it turns out we do want to support such a thing on some architecture.

(on x86 PMD - order 9, PUD - order 18, P4D - order 27, so we'd need a
hypothetical P5D level, or a machine with, say 16k pages, which would
go PMD-11, PUD-22, P4D-33, and be managing a folio of size 2^57 bytes)

But supporting nr_pages stored directly in the otherwise wasted space
in the folio seemed like a cheap win, and there was no reason to take
up the extra 32 bits.

Anyway, here, we know we're not getting back an arbitrary folio that
somebody else allocated, we're allocating for ourselves, and we know we're
allocating something rather smaller than that, so it's fine to calculate
in terms of unsigned int.  If I were writing in rust, I'd use usize,
but since nobody's done the work to make rust types available in C yet,
I haven't done that either.

We actually use usize as a variable name in a couple of hundred places,
so turning it into a generally available type is harder than one might
like.

