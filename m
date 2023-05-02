Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334E7C77B7E
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 May 2023 17:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjEBRX1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 May 2023 13:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjEBRX0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 May 2023 13:23:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28606E43;
        Tue,  2 May 2023 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C6e/8ch2eiLA3MhI/SDDmmseytmUgb05EwRd/AY6faE=; b=lYH/Im62obo8CLQo3d1z7OxM7G
        zg20c66BCFqbOPkxy7fYV/VkvAd9TfywyQ9BqaGqllwMiqAMKqdwKmqUe9D6QDk9TGEaDNfLGHdvQ
        QhrXDgYDf5e4zXRxjfxjBHIHVnSZhzAJ6eKr2M1mEhiD+JJCRcMOFSNBo9S9vPZ9PpioWTkDWybas
        vo+c2F+r6FMmmafjil3/fr+u4sZJ6Y6ahyjePqfI6e54HOd+Ho2lChGO9p6QcxJY2stOHsGkkhj+e
        T5FjO7EWYn9pLEQv6lJFMKuughpqndTY0ADrd8LMAXZM3CGr6e4q00jkFAPORv4mtWidTcXEIOLQp
        7OWTpSKg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ptti1-008YU3-7O; Tue, 02 May 2023 17:22:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 20013300379;
        Tue,  2 May 2023 19:22:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 92DB726941AA0; Tue,  2 May 2023 19:22:32 +0200 (CEST)
Date:   Tue, 2 May 2023 19:22:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Topel <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Mika Penttila <mpenttil@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, Peter Xu <peterx@redhat.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v7 3/3] mm/gup: disallow FOLL_LONGTERM GUP-fast writing
 to file-backed mappings
Message-ID: <20230502172231.GH1597538@hirez.programming.kicks-ass.net>
References: <cover.1683044162.git.lstoakes@gmail.com>
 <b3a4441cade9770e00d24f5ecb75c8f4481785a4.1683044162.git.lstoakes@gmail.com>
 <1691115d-dba4-636b-d736-6a20359a67c3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1691115d-dba4-636b-d736-6a20359a67c3@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 02, 2023 at 07:13:49PM +0200, David Hildenbrand wrote:
> [...]
> 
> > +{
> > +	struct address_space *mapping;
> > +
> > +	/*
> > +	 * GUP-fast disables IRQs - this prevents IPIs from causing page tables
> > +	 * to disappear from under us, as well as preventing RCU grace periods
> > +	 * from making progress (i.e. implying rcu_read_lock()).
> > +	 *
> > +	 * This means we can rely on the folio remaining stable for all
> > +	 * architectures, both those that set CONFIG_MMU_GATHER_RCU_TABLE_FREE
> > +	 * and those that do not.
> > +	 *
> > +	 * We get the added benefit that given inodes, and thus address_space,
> > +	 * objects are RCU freed, we can rely on the mapping remaining stable
> > +	 * here with no risk of a truncation or similar race.
> > +	 */
> > +	lockdep_assert_irqs_disabled();
> > +
> > +	/*
> > +	 * If no mapping can be found, this implies an anonymous or otherwise
> > +	 * non-file backed folio so in this instance we permit the pin.
> > +	 *
> > +	 * shmem and hugetlb mappings do not require dirty-tracking so we
> > +	 * explicitly whitelist these.
> > +	 *
> > +	 * Other non dirty-tracked folios will be picked up on the slow path.
> > +	 */
> > +	mapping = folio_mapping(folio);
> > +	return !mapping || shmem_mapping(mapping) || folio_test_hugetlb(folio);
> 
> "Folios in the swap cache return the swap mapping" -- you might disallow
> pinning anonymous pages that are in the swap cache.
> 
> I recall that there are corner cases where we can end up with an anon page
> that's mapped writable but still in the swap cache ... so you'd fallback to
> the GUP slow path (acceptable for these corner cases, I guess), however
> especially the comment is a bit misleading then.
> 
> So I'd suggest not dropping the folio_test_anon() check, or open-coding it
> ... which will make this piece of code most certainly easier to get when
> staring at folio_mapping(). Or to spell it out in the comment (usually I
> prefer code over comments).

So how stable is folio->mapping at this point? Can two subsequent reads
get different values? (eg. an actual mapping and NULL)

If so, folio_mapping() itself seems to be missing a READ_ONCE() to avoid
the compiler from emitting the load multiple times.
