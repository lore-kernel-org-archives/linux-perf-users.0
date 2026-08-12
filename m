Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B522C1586;
	Wed, 12 Aug 2026 01:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786499242; cv=none; b=cYkDvrYB6LE7Sw92neGat83DDmjm75Ml3pqBMkKzNXJyL8ASySHDpaGT8hvuj6pTSiPuvhkZ+VVSiz/Z9EjgI1WlWIcETZi9OiMpsruYSiVrsNAo/pSb0a3Umj6BJGXxaJQc/rVtOeRQoUG1nqFJHCO30gepnNJeLT38xyLMihQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786499242; c=relaxed/simple;
	bh=mMHuIDMm0V4K2R/ySnWRxybMaES/DK1jGZPu+ny/8wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeLtqPmPMA1u+uGlrXAmKSkDQfp7C8LFLOKP3SPsc4MbLiQcK+XqwpfdAQmIkC99kY19pi+ngPZf+6c3EZ3tFpfVDmAqP7HlqqRpWYvE8x2Ro71lMOIS4sptA4qi2HInY68QktjUBJmj2BrV6wXZFiJSEYAsMiA+xJhlNykQNww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIT4qqOe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIT4qqOe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D671F000E9;
	Wed, 12 Aug 2026 01:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786499241;
	bh=Nhvy96ON6rcBD0rl5Mu8B9/2HOoeIA4Mll8is12rVEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PIT4qqOeaX8ETeGyNvvipwx2kRTngOLWrKRZpNTkwUV9VtfKxB2aWyCX/wlKSpkpO
	 tDl+dNogfxF2wKUMHGOzreEr7dQRUBsILXUHHgf6bJ3H/YaRkntxAUwCqOUiDF77jY
	 sAe6z268FKhsRZJZ7v9urZy0TgKSLHnWP4kV3WODlGqC/3Vo/+bjGLc/R6gZHhExUU
	 SRBtMCl9kLCoSdNjqTbBHP/wykQyAcxxomZozL9ibkvEpgVnN9F0OEMth1lRBb73Gj
	 lQNZrwmBP8UFG6BA2MhdVmQJ7svpNDwVqSGXBPA1UxAgYeQbbQhVjBq2TAL/4nvftr
	 mvgoKaLHSJg0A==
Date: Wed, 12 Aug 2026 10:47:17 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Jiebin Sun <jiebin.sun@intel.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v8 6/9] perf c2c: add function view hierarchy entry
 creation
Message-ID: <anvQpSM9wXgnrbSA@google.com>
References: <20260810052647.588867-1-jiebin.sun@intel.com>
 <20260810052647.588867-7-jiebin.sun@intel.com>
 <20260810054945.82FFE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260810054945.82FFE1F000E9@smtp.kernel.org>

Hello,

On Mon, Aug 10, 2026 at 05:49:44AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Deleting a function-view child entry causes an out-of-bounds heap read in `free_callchain()` because the child entry is allocated without trailing `callchain_root` memory.
> --
> 
> --- Patch [6]: [PATCH v8 6/9] perf c2c: add function view hierarchy entry creation ---
> commit 3fbce53bcfd8d8abeda29f9eded35e05dfc305f5
> Author: Jiebin Sun <jiebin.sun@intel.com>
> 
> perf c2c: add function view hierarchy entry creation
>     
> This patch adds the entry-creation layer for the function view hierarchy.
> It implements level-1/2/3 lookup-or-create functions and synthetic child
> allocation logic, reusing cacheline_idx to preserve source entry identity.
> 
> > diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
> > index 4bf8406fde556..4099d4c7e7b44 100644
> > --- a/tools/perf/ui/browsers/c2c-function.c
> > +++ b/tools/perf/ui/browsers/c2c-function.c
> 
> [ ... ]
> 
> > @@ -847,6 +865,259 @@ static int __maybe_unused c2c_he__prune_empty_writers(struct hist_entry *l1_he)
> >  	return surviving;
> >  }
> >  
> > +static void *c2c_function_he_zalloc(size_t size)
> > +{
> > +	struct c2c_hist_entry *c2c_he = zalloc(sizeof(*c2c_he) + size);
> > +
> > +	if (!c2c_he)
> > +		return NULL;
> > +
> > +	init_stats(&c2c_he->cstats.lcl_hitm);
> > +	init_stats(&c2c_he->cstats.rmt_hitm);
> > +	init_stats(&c2c_he->cstats.lcl_peer);
> > +	init_stats(&c2c_he->cstats.rmt_peer);
> > +	init_stats(&c2c_he->cstats.load);
> > +
> > +	return &c2c_he->he;
> > +}
> > +
> > +/* Entry operations for function view */
> > +static struct hist_entry_ops c2c_function_entry_ops = {
> > +	.new	= c2c_function_he_zalloc,
> > +	.free	= c2c_function_he_free,
> > +};
> > +
> > +static struct c2c_hist_entry *
> > +c2c_child_entry__alloc(struct hist_entry *parent_he, struct hist_entry *src_he,
> > +		       int depth, u64 ip)
> > +{
> > +	struct c2c_hist_entry *child_c2c;
> > +	struct hist_entry *child_he;
> > +
> > +	/* Function-view children never own or display callchains. */
> > +	child_he = c2c_function_he_zalloc(0);
> > +	if (!child_he)
> > +		return NULL;
> 
> [Severity: Medium]
> Will this cause an out-of-bounds memory read when the entry is freed?
> 
> If perf c2c report is run with callchains enabled (symbol_conf.use_callchain
> is true), this entry is allocated with 0 extra bytes for the callchain.
> 
> When this undersized entry is deleted on the error path below or during
> cleanup via c2c_he__free_hierarchy(), hist_entry__delete() accesses
> he->callchain based on the global symbol_conf.use_callchain flag:
> 
> tools/perf/util/hist.c:hist_entry__delete() {
>     ...
>     if (symbol_conf.use_callchain)
>         free_callchain(he->callchain);
>     ...
> }
> 
> Could this read past the end of the c2c_hist_entry structure and dereference
> garbage memory in free_callchain_node()?

It looks like a real issue.  Can you please fix?  I'm not sure if c2c
uses the callchains.

Thanks,
Namhyung

> 
> > +
> > +	child_c2c = container_of(child_he, struct c2c_hist_entry, he);
> > +	child_he->ops = &c2c_function_entry_ops;
> > +	map_symbol__copy(&child_he->ms, &src_he->ms);
> 
> [ ... ]
> 
> > +	return child_c2c;
> > +
> > +out_free:
> > +	hist_entry__delete(child_he);
> > +	return NULL;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260810052647.588867-1-jiebin.sun@intel.com?part=6
