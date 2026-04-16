Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BFC3A7F50;
	Thu, 16 Apr 2026 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776352296; cv=none; b=QJBhxw1R2ph3jI6/fJwvpF+H6hl63hT7gSMq+ab2OEyQfTOWjjuwj/pJVuaB6P1tXsYLedgaqVC3Fuk0U+ORq33gvNLAl6wuTF9C3M8fK8gokLtpM1/Wu3HBVStwSnYwO/NrhuPoS+NpInAewFQRpaudLgw6Ybj8ZDSCgTaIt2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776352296; c=relaxed/simple;
	bh=VW7LlkXvkacJQVvvguP5uS0I0c0tHqOdhNJP6DiAy18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maSXdXaIdIgrw/t7nc9m6BgrY6NygNHWj1yyZeRy1rjk0Kkhl6UfLIBf0baN9wvMteJiEw43d4AHe4x8BlhSV49K+jZC94LQzg5O4wuTUEzmRxzXXHCI8Ni/behq8M5Jk0XkUKo66jyq6CtFnuzjVxO2mwv2GA4hJsnI0ZAtApU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEWInt2F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEWInt2F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AA9C2BCAF;
	Thu, 16 Apr 2026 15:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776352296;
	bh=VW7LlkXvkacJQVvvguP5uS0I0c0tHqOdhNJP6DiAy18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MEWInt2Fzzw3c+0IeWC7n/mDr9qwi1gVXN6V478h5qw7lDI4JPTAsoksFh6oiGJZZ
	 JshCFs27ukaJp6L7J54CsB/bb3T+FPCidSi/NS9e5MJxyod58Vz/D/xVs2JYtmq2hy
	 ec/sl35U60lAHedggPJ1fh5UF7Kz06CvYaEZN4f34GqIqzDVeoRSznOTWYeo7ZVq3Z
	 fRywerMxXM7/nQ/+m8dcrTv1GvfDChs3mYzpg4N2UDOzEdWzcQg4XxOT8k/9Q9nfpc
	 4mqe3e1VV+HgxgUfxbH9NXpQ0OJ61SQ54GMaUgLx3d4HdwZd/gGlekv3B8LuzeYgEa
	 noRF6MU46OYPg==
Date: Thu, 16 Apr 2026 12:11:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 3/5] perf header: Sanity check HEADER_EVENT_DESC
Message-ID: <aeD8I8IYFuyk9GL2@x1>
References: <20260416001424.362797-4-acme@kernel.org>
 <20260416015456.40645C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416015456.40645C19424@smtp.kernel.org>

On Thu, Apr 16, 2026 at 01:54:55AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 3 potential issue(s):
> - [Critical] An integer overflow in `nre + 1` causes a 0-byte allocation, leading to a massive heap out-of-bounds write.
> - [Critical] `perf_event__attr_swap()` reads and writes out-of-bounds on the heap due to an unvalidated internal `attr->size` field.
> - [High] The expression `sz + sizeof(u32)` can overflow to zero on 32-bit architectures, causing a division by zero crash.
> --
> 
> commit b80424f0e9f35df0a96f24ae74fd6b6f3c4d97e2
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> perf header: Sanity check HEADER_EVENT_DESC
> 
> This commit adds bounds checks to read_event_desc() to prevent large
> allocations or excessive loop iterations by validating sizes against the
> section size.
> 
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index f8acd06ae9235..696f19739074e 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> [ ... ]
> > @@ -2101,6 +2101,13 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
> >  	if (do_read_u32(ff, &sz))
> >  		goto error;
> >  
> > +	/*
> > +	 * The minimum section footprint per event is sz bytes for the attr
> > +	 * plus a u32 for the id count, check that nre events fit.
> > +	 */
> > +	if (sz == 0 || sz > ff->size || nre > (ff->size - ff->offset) / (sz + sizeof(u32)))
> > +		goto error;
> > +
> 
> Can the expression sz + sizeof(u32) overflow to zero on 32-bit architectures?
> 
> Since sz is a u32 read directly from the file, if an attacker crafts a file
> where sz is UINT32_MAX - 3 (0xFFFFFFFC), the addition wraps around to exactly 0
> in 32-bit arithmetic. This would cause the bounds check to divide by zero.
> 
> The preceding sz > ff->size check might not prevent this because ff->size is
> read from the file header and could be arbitrarily large.
> 
> >  	/* buffer to hold on file attr struct */
> >  	buf = malloc(sz);
> >  	if (!buf)
> >  		goto error;
> >  
> >  	/* the last event terminates with evsel->core.attr.size == 0: */
> >  	events = calloc(nre + 1, sizeof(*events));
> 
> Could nre + 1 wrap around to 0 if nre is UINT32_MAX?

Will fix
 
> The new bounds check restricts nre based on ff->size, but if ff->size is
> controlled by the file and set to UINT64_MAX, nre can still be 0xFFFFFFFF.
> 
> If nre + 1 wraps to 0, calloc returns a minimal valid 0-byte allocation. The
> loop below would then write out of bounds on its first iteration:
> 
>     for (i = 0, evsel = events; i < nre; evsel++, i++) {
>         evsel->core.idx = i;
>         ...
> 
> >  	if (!events)
> >  		goto error;
> >  
> >  	msz = sizeof(evsel->core.attr);
> >  	if (sz < msz)
> >  		msz = sz;
> >  
> >  	for (i = 0, evsel = events; i < nre; evsel++, i++) {
> >  		evsel->core.idx = i;
> >  
> >  		/*
> >  		 * must read entire on-file attr struct to
> >  		 * sync up with layout.
> >  		 */
> >  		if (__do_read(ff, buf, sz))
> >  			goto error;
> >  
> >  		if (ff->ph->needs_swap)
> >  			perf_event__attr_swap(buf);
> 
> Is it possible for perf_event__attr_swap() to read and write beyond the buf
> allocation here?
> 
> The buf allocation is sized using the user-provided sz. When
> perf_event__attr_swap(buf) executes, it byte-swaps the attr->size field inside
> the buffer, and then uses the newly swapped attr->size to determine how many
> subsequent fields to byte-swap.
> 
> If sz is small, but the embedded attr->size in the payload is large,
> perf_event__attr_swap() will swap fields based on the larger internal size
> instead of the allocated sz bytes, causing an out-of-bounds access.

So this is valid but pre-existing, no? I'll cover this in an upcoming
patch series.

- Arnaldo
 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260416001424.362797-1-acme@kernel.org?part=3
