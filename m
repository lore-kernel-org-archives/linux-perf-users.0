Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F376AEDEC50
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Sep 2023 13:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbjIMNbX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Sep 2023 09:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbjIMNbT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Sep 2023 09:31:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559F919B1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Sep 2023 06:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J02MLXhFSfuoyeCLtw6xtYkQzGZj8lJYYE1pS362z8A=; b=duYyjGYKubyex3PQdSScxDz1aF
        il/Q8YmExU9Mzldgx7QIP0lxDZPqy6BKP2nfpqXXo4on92wG7lMYwXtnn/cdM8QisxCBFT6/YVZp7
        zdZfdOVIGgZYiQ9OQzxzORBxaxYqIY2Aqu8zF9zRCoYsD3BLzfCPTTHyQmMbqdpEVR9JQxjyXAhR7
        V1G7uemUZylGxIk7FJGyeu6zb4o2kRARWmF7dEVgjF7IDvjpQqEQ3ErQbHcI0mZ8u7k7DZk7O9N3U
        JNkA5wdNK4IrPbz1xMZsZPwbhxk5Crk3YyatBBCP6invFKI4GX7UPE+Y1kUHz/EXIGQ6mQJiy/mwb
        ddkr3tGw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgPxR-00E5zI-Sx; Wed, 13 Sep 2023 13:31:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BA83300321; Wed, 13 Sep 2023 15:31:05 +0200 (CEST)
Date:   Wed, 13 Sep 2023 15:31:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        mingo@redhat.com, acme@kernel.org, urezki@gmail.com,
        hch@infradead.org
Subject: Re: [RFC PATCH 1/4] perf: Convert perf_mmap_(alloc,free)_page to
 folios
Message-ID: <20230913133105.GF22758@noisy.programming.kicks-ass.net>
References: <20230821202016.2910321-1-willy@infradead.org>
 <20230821202016.2910321-2-willy@infradead.org>
 <78cc53f6-3828-4802-afc5-abb71dc59627@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78cc53f6-3828-4802-afc5-abb71dc59627@lucifer.local>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Aug 27, 2023 at 08:33:39AM +0100, Lorenzo Stoakes wrote:

> > @@ -785,25 +785,23 @@ __perf_mmap_to_page(struct perf_buffer *rb, unsigned long pgoff)
> >  	return virt_to_page(rb->data_pages[pgoff - 1]);
> >  }
> >
> > -static void *perf_mmap_alloc_page(int cpu)
> > +static void *perf_mmap_alloc_page(int node)
> 
> Nitty point but since we're dealing with folios here maybe rename to
> perf_mmap_alloc_folio()?

Since it's an explicit order-0 allocation, does that really make sense?

> >  {
> > -	struct page *page;
> > -	int node;
> > +	struct folio *folio;
> >
> > -	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
> > -	page = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
> > -	if (!page)
> > +	folio = __folio_alloc_node(GFP_KERNEL | __GFP_ZERO, 0, node);
> > +	if (!folio)
> >  		return NULL;
> >
> > -	return page_address(page);
> > +	return folio_address(folio);
> >  }

