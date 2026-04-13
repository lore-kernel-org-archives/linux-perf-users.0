Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E2731354F;
	Mon, 13 Apr 2026 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776116605; cv=none; b=VaiFovSOv6FvWyJDYGyv1vOMfWKJCxPYGrAJ6TpHUEHLKyco9IXELBmOjy0BJkGVIIIj4rrZ3Qc62JxcTsWP0p4BeuuKH0UWuTPp0Edtw0ITyqKj+tiMiHOAHILWe1pdhfQGnUNPAlYPvwJzJbgib9S/KDfF0M7Dnaeb4djNwZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776116605; c=relaxed/simple;
	bh=1iHlGppiEXtzNWnLwNq4X/Dkeax9YpKMiynLLQomu+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3mv5XhVMSOteNAaBNFaHFNbSS6moEjf24zeVcHhiYY0EcMQ45pskIZKKT5RiczyMfhghcmyUJUuYwxKWXLgRCW28Ijb+WHNVP6T7Ip/bSQl9IbJKRRdF4bQsCdl1uni/gWlJNX2SpGOcA8SfmIi8M0WqTtTy/8mFOLyX6ctXmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBkULrhj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBkULrhj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C76C2BCAF;
	Mon, 13 Apr 2026 21:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776116604;
	bh=1iHlGppiEXtzNWnLwNq4X/Dkeax9YpKMiynLLQomu+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sBkULrhj6DL91An0Zug73cQ3C7221vWOWBHGroJC3+zlnD82xHSYE6vQZ4pHfxPGT
	 Py5CA2MACm/Whg1CRHtqGhjaX8VwaUbM/AX5A7dnp9bAChrD0L76mGdFxcE/Jgt5X/
	 ERujDCgwXDCg+IZJ/Cp+ttwPcfnO0lo29aLmJlRLwlUYnzLmFkX4GLWqgyg5Dugiaq
	 ByWclwP3mwrPSzTFGOJTxNwgotTqA8nhCZOS4pamtD9O80+cw8KQt7q9gY4YI3wFP5
	 D7A2vHQi/P0SwMHDzT+nskUCop+oseUcYiqCYhl+dF8VLxmOjek6SIPEwXpXXrAfj1
	 3bS8kWmtugi0Q==
Date: Mon, 13 Apr 2026 14:43:22 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko@lists.linux.dev
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] Performance events changes for v7.1
Message-ID: <ad1jeq0HC6Sa0wE0@google.com>
References: <adynEfZ0r_GIu06k@gmail.com>
 <20260413094110.C3CAAC116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260413094110.C3CAAC116C6@smtp.kernel.org>

Hello,

It seems sashio removes receipients in a reply.  Added PeterZ.

On Mon, Apr 13, 2026 at 09:41:09AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [Critical] Pre-existing Stack Buffer Overflow in AMD IBS NMI handler on CPUs supporting `IBS_CAPS_OPDATA4`.
> - [High] Reference count leak of `perf_ctx_data` in `attach_global_ctx_data()` when racing with a concurrent non-global context creation.
> --
> 
> commit 167b4d230f2ffe8284d5afdbd849ef2f4f05ef9a
> Author: Ingo Molnar <mingo@kernel.org>
> 
> Performance events changes for v7.1
> 
> This commit pulls in various performance event changes for v7.1. It includes
> an optimization to allocate task_ctx_data quickly on large systems, updates
> and fixes for the AMD PMU driver IBS support, Intel PEBS constraint
> validation, and MSR driver changes.
> 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -5487,6 +5487,12 @@ attach_global_ctx_data(struct kmem_cache *ctx_cache)
> >  					cd = NULL;
> >  			}
> >  			if (!cd) {
> > +				/*
> > +				 * Try to allocate context quickly before
> > +				 * traversing the whole thread list again.
> > +				 */
> > +				if (!attach_task_ctx_data(p, ctx_cache, true, GFP_NOWAIT))
> > +					continue;
> >  				get_task_struct(p);
> >  				goto alloc;
> >  			}
> 
> Could the new GFP_NOWAIT fast-path in attach_global_ctx_data() leak the
> perf_ctx_data reference if it races with a concurrent non-global context
> creation?
> 
> If attach_task_ctx_data() races with a per-task event attaching a non-global
> context, it will find an existing context where old is not NULL. It increments
> old->refcount and returns 0, but intentionally ignores the global argument
> and does not set old->global to 1.
> 
> Because it returns success, attach_global_ctx_data() executes continue and
> skips to the next thread. The context for the thread is left with an
> extra reference but global remains 0.

Right, it looks like an existing problem.  It should set the old->global
like below:

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 95d7a3e57268b6b4..af773bc750495706 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5447,6 +5447,8 @@ attach_task_ctx_data(struct task_struct *task, struct kmem_cache *ctx_cache,
                }
 
                if (refcount_inc_not_zero(&old->refcount)) {
+                       if (global)
+                               old->global = 1;
                        free_perf_ctx_data(cd); /* unused */
                        return 0;
                }

> 
> Later, when the global context is detached, __detach_global_ctx_data()
> iterates over all threads and only calls detach_task_ctx_data(p) if
> cd and cd->global are true. Since cd->global is 0, the context is skipped,
> permanently leaking the perf_ctx_data allocation.
> 
> > @@ -5497,7 +5503,7 @@ attach_global_ctx_data(struct kmem_cache *ctx_cache)
> >  
> >  	return 0;
> >  alloc:
> > -	ret = attach_task_ctx_data(p, ctx_cache, true);
> > +	ret = attach_task_ctx_data(p, ctx_cache, true, GFP_KERNEL);
> >  	put_task_struct(p);
> >  	if (ret) {
> >  		__detach_global_ctx_data();
> 
> Can this result in a double-increment leak? If the same race occurs,
> attach_task_ctx_data() bumps the refcount without setting global to 1 and
> returns success. Then goto again restarts the loop.
> 
> When the loop reaches the thread again, it evaluates:
> 
> 	cd = rcu_dereference(p->perf_ctx_data);
> 	if (cd && !cd->global) {
> 		cd->global = 1;
> 		refcount_inc_not_zero(&cd->refcount);
> 	}
> 
> This bumps the refcount a second time. Since __detach_global_ctx_data()
> only decrements once, the extra reference is leaked.

Looks correct and should be fixed by the above change as well.  I'll
send a formal patch if you're ok.

Thanks,
Namhyung
