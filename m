Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D1C2F7EFC;
	Wed, 12 Aug 2026 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539711; cv=none; b=sLKBUUD3J4psjB5Uhbju9c9+F+Ai+KVk6mFgchCfjr4p33EXIDi+snjN5Xxrgb9kf4w1i+NzyOMph6718XHQY84QTdrfcocckU6/zSJKO04SmY2Vmue0WhWKbbXdmyVJTofSvc3jCF1RjRWfrei/HYN9xgDvTtw7Q7ZWlrRQxUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539711; c=relaxed/simple;
	bh=oAio7SaX+DKJEm58p4011mb4b07usAsY/fvtGvneJgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGkyXB7qLfyec9dcP3mR/MS8kgYYg0mGIdAbgs1/WBceWpo4+sSsgLqotRoMZAwBzvTViU9aS047jGoZkvIwnQxryK8ETaDrUJmbR77XxqQLNFbXSCxQvGpS6zGPGYKvIAIGOm/7IRZK2N/2AADK1tQJSaKpJvk48OdTFOpGJiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hx0vAFXq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hx0vAFXq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6189B1F000E9;
	Wed, 12 Aug 2026 13:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786539709;
	bh=3mTWZ2A5uVTMEYK/8FxrEdOAhaPVuayMpkK8JjoS38A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hx0vAFXqDxFep7R8Lt1orkQa9QQfbVDwnLbm2IG7PU+zwLbye+bWCtclJK39QaMe9
	 b9AeC1pM5AyNvz/ZXXDGfRB9PxVziw/BWHfmQ79uceGx+p4y2lKQK0Sd8NV8A+juKn
	 t1pqnsVOWx8glFMsTW+3wtiwOlCNFtPeQSkfAJHjxOOTPTfUHJUziqc4xkbTGCJltr
	 9sLVVRRDMOHNiytrYectFmsIdN911jlpwMHopszAGXV1BPtzTJJhOYIGgofXpvdK7t
	 B5WeKfksH/9OeSbNQZ3CQiO7jS2iZ0xyCK3Ormfqj5ee2XA07EXkXt7WiuMa4xiIZm
	 91JnaWl0t1tQA==
Date: Wed, 12 Aug 2026 22:01:45 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Jiebin Sun <jiebin.sun@intel.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v8 6/9] perf c2c: add function view hierarchy entry
 creation
Message-ID: <anxuuXWGv-S73bXG@google.com>
References: <20260810052647.588867-1-jiebin.sun@intel.com>
 <20260810052647.588867-7-jiebin.sun@intel.com>
 <20260810054945.82FFE1F000E9@smtp.kernel.org>
 <anvQpSM9wXgnrbSA@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anvQpSM9wXgnrbSA@google.com>

On Wed, Aug 12, 2026 at 10:47:17AM +0900, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Aug 10, 2026 at 05:49:44AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] Deleting a function-view child entry causes an out-of-bounds heap read in `free_callchain()` because the child entry is allocated without trailing `callchain_root` memory.
> > --
> > 
> > --- Patch [6]: [PATCH v8 6/9] perf c2c: add function view hierarchy entry creation ---
> > commit 3fbce53bcfd8d8abeda29f9eded35e05dfc305f5
> > Author: Jiebin Sun <jiebin.sun@intel.com>
> > 
> > perf c2c: add function view hierarchy entry creation
> >     
> > This patch adds the entry-creation layer for the function view hierarchy.
> > It implements level-1/2/3 lookup-or-create functions and synthetic child
> > allocation logic, reusing cacheline_idx to preserve source entry identity.
> > 
> > > diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
> > > index 4bf8406fde556..4099d4c7e7b44 100644
> > > --- a/tools/perf/ui/browsers/c2c-function.c
> > > +++ b/tools/perf/ui/browsers/c2c-function.c
> > 
> > [ ... ]
> > 
> > > @@ -847,6 +865,259 @@ static int __maybe_unused c2c_he__prune_empty_writers(struct hist_entry *l1_he)
> > >  	return surviving;
> > >  }
> > >  
> > > +static void *c2c_function_he_zalloc(size_t size)
> > > +{
> > > +	struct c2c_hist_entry *c2c_he = zalloc(sizeof(*c2c_he) + size);
> > > +
> > > +	if (!c2c_he)
> > > +		return NULL;
> > > +
> > > +	init_stats(&c2c_he->cstats.lcl_hitm);
> > > +	init_stats(&c2c_he->cstats.rmt_hitm);
> > > +	init_stats(&c2c_he->cstats.lcl_peer);
> > > +	init_stats(&c2c_he->cstats.rmt_peer);
> > > +	init_stats(&c2c_he->cstats.load);
> > > +
> > > +	return &c2c_he->he;
> > > +}
> > > +
> > > +/* Entry operations for function view */
> > > +static struct hist_entry_ops c2c_function_entry_ops = {
> > > +	.new	= c2c_function_he_zalloc,
> > > +	.free	= c2c_function_he_free,
> > > +};
> > > +
> > > +static struct c2c_hist_entry *
> > > +c2c_child_entry__alloc(struct hist_entry *parent_he, struct hist_entry *src_he,
> > > +		       int depth, u64 ip)
> > > +{
> > > +	struct c2c_hist_entry *child_c2c;
> > > +	struct hist_entry *child_he;
> > > +
> > > +	/* Function-view children never own or display callchains. */
> > > +	child_he = c2c_function_he_zalloc(0);
> > > +	if (!child_he)
> > > +		return NULL;
> > 
> > [Severity: Medium]
> > Will this cause an out-of-bounds memory read when the entry is freed?
> > 
> > If perf c2c report is run with callchains enabled (symbol_conf.use_callchain
> > is true), this entry is allocated with 0 extra bytes for the callchain.
> > 
> > When this undersized entry is deleted on the error path below or during
> > cleanup via c2c_he__free_hierarchy(), hist_entry__delete() accesses
> > he->callchain based on the global symbol_conf.use_callchain flag:
> > 
> > tools/perf/util/hist.c:hist_entry__delete() {
> >     ...
> >     if (symbol_conf.use_callchain)
> >         free_callchain(he->callchain);
> >     ...
> > }
> > 
> > Could this read past the end of the c2c_hist_entry structure and dereference
> > garbage memory in free_callchain_node()?
> 
> It looks like a real issue.  Can you please fix?  I'm not sure if c2c
> uses the callchains.

Oh, I saw it's handled in the patch 8.

Thanks,
Namhyung

