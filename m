Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33B9AD23;
	Fri, 29 Nov 2024 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732870386; cv=none; b=Ws5klD5vV8ukb1XNwXu8GyJmio4NIMwYUD6692cKqNc0e5uRdJ/U1W9XqoqgDnLukIW3z0C9P00y+CItSDRcR5fSfLcm5I4AflV+c1x3rBcRs8KH5cUviqGNHq/wVHnxtW8jy4Q7MKLC5P4p2JAxXZLdzDRESZjzWnWxYsvPDNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732870386; c=relaxed/simple;
	bh=6LINW3jxC8Mcsa6gVCjAK7AkoVWx1o3h7v2jp6Hh1xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ/Mw03BukP9Ig6Htnk7JWoJB+6FtQg+NlvNntlszIREla0CJ3JSQFiKTWqwgzf6/gZ2gUZGv+rR/liReARGyzFgx97xO9QY20sRIwEqQOE+ayW3ww7lDiU7Vp7Dg5j8QazoXmwt2hpy3RV5Er6K/ETgNjx1v2pqgO+d+frOY8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fW2bCBua; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fW2bCBua"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O2+u05xTHSY3QQsq9FkC78F9fugOK9yNUXh05XJsWLw=; b=fW2bCBua7cQBQbDv2mHlhvAgNO
	mAKfin6cpSkjwFPWBU3Nzu4FaANef5HKnhrSqs2PpcgFQ1DMrgS5pgNc8Cq9CHUC/BiySjtgZKPD5
	EzBYw2lc2FXfuQhfKPKcE5kH0TaJRkVvVh2hfLyXW5SpR4R7T1H68yrL7dwUZ02iK4D/FK5erlmm+
	s9YEYwkF0bLmGFYJiqZIGGVJTcIbePY54Xl+5ZmY0BxjkMQpV93T9ycsTY3U9fXP8+N2ojnDQCj56
	Maxx7qYlvUkonf9I75sNAI86W3nyGrl7iv1d3q2Y3UQSCPu/5RM8IWG0stEaCMlilS0/qAJnTkGrN
	RUNuGeWg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGwk8-00000003nIg-0gqM;
	Fri, 29 Nov 2024 08:52:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A19BC30026A; Fri, 29 Nov 2024 09:52:52 +0100 (CET)
Date: Fri, 29 Nov 2024 09:52:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] perf: map pages in advance
Message-ID: <20241129085252.GA15382@noisy.programming.kicks-ass.net>
References: <20241128113714.492474-1-lorenzo.stoakes@oracle.com>
 <2550a3c6-b0d9-4ad2-ae04-5735d7b4cf5f@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2550a3c6-b0d9-4ad2-ae04-5735d7b4cf5f@lucifer.local>

On Thu, Nov 28, 2024 at 08:47:28PM +0000, Lorenzo Stoakes wrote:
> Peter - not sure whether it's easy for you to make a simple adjustment to this
> patch or if you want me to just send a v2, but I have to pop an #ifdef CONFIG_MMU
> into the code.
> 

> > +static int map_range(struct perf_buffer *rb, struct vm_area_struct *vma)
> > +{
> > +	unsigned long nr_pages = vma_pages(vma);
> > +	int err = 0;
> > +	unsigned long pgoff;
> > +
> > +	for (pgoff = 0; pgoff < nr_pages; pgoff++) {
> > +		unsigned long va = vma->vm_start + PAGE_SIZE * pgoff;
> > +		struct page *page = perf_mmap_to_page(rb, pgoff);
> > +
> > +		if (page == NULL) {
> > +			err = -EINVAL;
> > +			break;
> > +		}
> > +
> > +		/* Map readonly, perf_mmap_pfn_mkwrite() called on write fault. */
> > +		err = remap_pfn_range(vma, va, page_to_pfn(page), PAGE_SIZE,
> > +				      vm_get_page_prot(vma->vm_flags & ~VM_SHARED));
> > +		if (err)
> > +			break;
> > +	}
> > +
> 
> Need a:
> 
> #ifdef CONFIG_MMU
> > +	/* Clear any partial mappings on error. */
> > +	if (err)
> > +		zap_page_range_single(vma, vma->vm_start, nr_pages * PAGE_SIZE, NULL);
> #endif
> 
> Here to work around the wonders of nommu :)

All good, I'll edit the thing.
