Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8654241139;
	Wed,  7 Jan 2026 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777422; cv=none; b=HFI4fpbdruJKTkR8FFPzR4LHwgIFx0mVBpHY1Paqvawu1a86vVEuj2HjG9VrTV1W3b33s9o5GDDANHV6HEI4n9b/wql0DdpSA4XvbwhjIWxZ+1bdyylROyBfv0PnFjMYOXodcd88POpF46SzoRtJuBPl5R1+1ciHrwzMGtY4xzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777422; c=relaxed/simple;
	bh=3otYGtdS+u+00PAEZ0SIOpXWoCv6ClN/Oeog/yibKiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TppLJvhXlh854s2BfZUsm1kVNUPk5hB+PFOooAwDuKtVogw0UhgZSYtxyEE4gEkMW+QwI1CgHlniK8yBYM86kvOvaGFit919IAGcKpMFXrf6GlDeW3pR7YbREo9J4G0LjzFBvN1yyfxgwsRgr1kSkmvyxBV4SmlowYs0eE5Ux4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mGknHyCD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mGknHyCD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oAUzauUGyZWcAhjUNVxBcRjHqiLd6AQpeI8ke2cG5o8=; b=mGknHyCDvLmW0OTNSFS6fOafEs
	9KjoSo6zVPdn7UwsKEja4Wad2DrcnVQDgumkR4CvqtkVmpHWODZHIxlkzQPYRvI4eJWG0NFOKaDHQ
	53aMtFN4MHpqTgrT9BM8rScMCXZjwyxnLSzlosFSdTS2w+ct93DZUv4vEpJ8ctUdnhARZFg33WLvy
	yRAYhy0l7AVrm6KUwJewbIZyDVHR/VyjMIIUU3vrblbR+fQa4kpcQiicL1dXMepEpuS7EBRl5xOs6
	Zv6T2bRJYZYMqIS2JOP92s+eSIuB4ZSMnVb5WQFYN4s2jmbeT/lXIhn7zLMw3TlpkFw0c876Wbx92
	nix70yww==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdPev-0000000B2iu-0yKP;
	Wed, 07 Jan 2026 09:16:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3FAD130056B; Wed, 07 Jan 2026 10:16:52 +0100 (CET)
Date: Wed, 7 Jan 2026 10:16:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] perf/core: Task stuck on global_ctx_data_rwsem
Message-ID: <20260107091652.GB3707891@noisy.programming.kicks-ass.net>
References: <aUnVfxDtLNUDJM_v@google.com>
 <aUnWFc_mILUDFavi@google.com>
 <aV2OACqA5OpmoeF0@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV2OACqA5OpmoeF0@google.com>

On Tue, Jan 06, 2026 at 02:34:40PM -0800, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Dec 22, 2025 at 03:36:53PM -0800, Namhyung Kim wrote:
> > On Mon, Dec 22, 2025 at 03:34:23PM -0800, Namhyung Kim wrote:
> > > Hello,
> > > 
> > > I got a report that a task is stuck in perf_event_exit_task() waiting
> > > for global_ctx_data_rwsem.  On large systems, it'd have performance
> > > issues when it grabs the lock to iterate all threads in the system to
> > > allocate the context data.  And it'd block task exit path which is
> > > problematic especially under memory pressure.
> > > 
> > >   perf_event_open
> > >     perf_event_alloc
> > >       attach_perf_ctx_data
> > >         attach_global_ctx_data
> > >           percpu_down_write (global_ctx_data_rwsem)
> > >             for_each_process_thread
> > >               alloc_task_ctx_data
> > >                                                do_exit
> > >                                                  perf_event_exit_task
> > >                                                    percpu_down_read (global_ctx_data_rwsem)
> > > 
> > > I think attach_global_ctx_data() should skip tasks with PF_EXITING and
> > > it'd be nice if perf_event_exit_task() could release the ctx_data
> > > unconditionally.  But I'm not sure how to synchronize them properly.
> > > 
> > > Any thoughts?
> 
> I'm curious if this makes any sense..  I feel like it needs to check the
> flag again before allocation.
> 
> Thanks,
> Namhyung
> 
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 376fb07d869b8b50..2a8847e95d7eb698 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5469,6 +5469,8 @@ attach_global_ctx_data(struct kmem_cache *ctx_cache)
>  	/* Allocate everything */
>  	scoped_guard (rcu) {
>  		for_each_process_thread(g, p) {
> +			if (p->flags & PF_EXITING)
> +				continue;
>  			cd = rcu_dereference(p->perf_ctx_data);
>  			if (cd && !cd->global) {
>  				cd->global = 1;

I suppose this makes sense.

> @@ -14563,7 +14565,6 @@ void perf_event_exit_task(struct task_struct *task)
>  	/*
>  	 * Detach the perf_ctx_data for the system-wide event.
>  	 */
> -	guard(percpu_read)(&global_ctx_data_rwsem);
>  	detach_task_ctx_data(task);
>  }

This would need a comment; something like:

	/*
	 * This can be done without holding global_ctx_data_rwsem
	 * because this is done after setting PF_EXITING such that
	 * attach_global_ctx_data() will skip over this task.
	 */
	WARN_ON_ONCE(!(task->flags & PF_EXITING))

But yes, I suppose this can do. The question is however, how do you get
into this predicament to begin with? Are you creating and destroying a
lot of global LBR events or something?

Would it make sense to delay detach_global_ctx_data() for a second or
so? That is, what is your event creation pattern?
