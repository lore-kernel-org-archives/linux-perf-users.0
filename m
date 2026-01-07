Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978CA23EA8A;
	Wed,  7 Jan 2026 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767812515; cv=none; b=UKOz+KLRwBW+8R3nDFZpbjCYHj4C2cCOJ/TTUSlvJn42QfrxYuU6jvqYYbexwv+beKQ7J1IfbfZLhRTWOfIK13mbx1Xghjmygva6oeUufG+adMJMqpsH8QQVe52ST9wVB56cmggvK91VlNN7MF1qSqlCkZ/qfWEgZHFEw1UR5DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767812515; c=relaxed/simple;
	bh=CLHFm3nfs416qgLWTf/K7UEEl7cdApXhZslt27YRNJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRcqx/538Snfdrz2yUjzu2Jh3xmVlID7XDehd3/qLu0HSLLGK8kaCYADdLYxQ7hMGokK1Z2O7kZQNhaCqWFXJasLhRLseaOAm4fretZnJLivN41rOro42iGZ0OpGkx85BWz3I90DfoQcDP1aEiwez/U5sBzbPVFIG/LMt+chloI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMrf5RjD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMrf5RjD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9389C16AAE;
	Wed,  7 Jan 2026 19:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767812515;
	bh=CLHFm3nfs416qgLWTf/K7UEEl7cdApXhZslt27YRNJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMrf5RjDgs3SRuJ1VX34nW2mwyaKuB9N+e0+Ztj4416on1MPDoZNdZVSYakgRs+Pz
	 OulxYVxYLdEvSDaJULgXeh+szgeNX3BBTFl8DWKedLWqLQvxMIsaspTK//wXEsTnNs
	 UemZACLBGQxshR0gkkeArmOgvCQAkOVEKi/YeR0IIWWD8ucFQz09Dc5gcRz1kHihLq
	 PlOhwhXVuiyZpVcfPiYjNdXqQqutpHe/N9q2sJXJEbC1jgxJaXVDfu1YF0gWEeZAWi
	 zbe0kuPcfaVc8JU4vk2ltF43buXkSUoXoPyLpFlZkN12VhPjkO/M//zzZ+9cLy0NLu
	 NigpAwMJfBuxw==
Date: Wed, 7 Jan 2026 11:01:53 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] perf/core: Task stuck on global_ctx_data_rwsem
Message-ID: <aV6toexK5LMc1MNY@google.com>
References: <aUnVfxDtLNUDJM_v@google.com>
 <aUnWFc_mILUDFavi@google.com>
 <aV2OACqA5OpmoeF0@google.com>
 <20260107091652.GB3707891@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260107091652.GB3707891@noisy.programming.kicks-ass.net>

On Wed, Jan 07, 2026 at 10:16:52AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 06, 2026 at 02:34:40PM -0800, Namhyung Kim wrote:
> > Hello,
> > 
> > On Mon, Dec 22, 2025 at 03:36:53PM -0800, Namhyung Kim wrote:
> > > On Mon, Dec 22, 2025 at 03:34:23PM -0800, Namhyung Kim wrote:
> > > > Hello,
> > > > 
> > > > I got a report that a task is stuck in perf_event_exit_task() waiting
> > > > for global_ctx_data_rwsem.  On large systems, it'd have performance
> > > > issues when it grabs the lock to iterate all threads in the system to
> > > > allocate the context data.  And it'd block task exit path which is
> > > > problematic especially under memory pressure.
> > > > 
> > > >   perf_event_open
> > > >     perf_event_alloc
> > > >       attach_perf_ctx_data
> > > >         attach_global_ctx_data
> > > >           percpu_down_write (global_ctx_data_rwsem)
> > > >             for_each_process_thread
> > > >               alloc_task_ctx_data
> > > >                                                do_exit
> > > >                                                  perf_event_exit_task
> > > >                                                    percpu_down_read (global_ctx_data_rwsem)
> > > > 
> > > > I think attach_global_ctx_data() should skip tasks with PF_EXITING and
> > > > it'd be nice if perf_event_exit_task() could release the ctx_data
> > > > unconditionally.  But I'm not sure how to synchronize them properly.
> > > > 
> > > > Any thoughts?
> > 
> > I'm curious if this makes any sense..  I feel like it needs to check the
> > flag again before allocation.
> > 
> > Thanks,
> > Namhyung
> > 
> > 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 376fb07d869b8b50..2a8847e95d7eb698 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -5469,6 +5469,8 @@ attach_global_ctx_data(struct kmem_cache *ctx_cache)
> >  	/* Allocate everything */
> >  	scoped_guard (rcu) {
> >  		for_each_process_thread(g, p) {
> > +			if (p->flags & PF_EXITING)
> > +				continue;
> >  			cd = rcu_dereference(p->perf_ctx_data);
> >  			if (cd && !cd->global) {
> >  				cd->global = 1;
> 
> I suppose this makes sense.
> 
> > @@ -14563,7 +14565,6 @@ void perf_event_exit_task(struct task_struct *task)
> >  	/*
> >  	 * Detach the perf_ctx_data for the system-wide event.
> >  	 */
> > -	guard(percpu_read)(&global_ctx_data_rwsem);
> >  	detach_task_ctx_data(task);
> >  }
> 
> This would need a comment; something like:
> 
> 	/*
> 	 * This can be done without holding global_ctx_data_rwsem
> 	 * because this is done after setting PF_EXITING such that
> 	 * attach_global_ctx_data() will skip over this task.
> 	 */
> 	WARN_ON_ONCE(!(task->flags & PF_EXITING))
> 
> But yes, I suppose this can do. The question is however, how do you get
> into this predicament to begin with? Are you creating and destroying a
> lot of global LBR events or something?

I think it's just because there are too many tasks in the system like
O(100K).  And any thread going to exit needs to wait for
attach_global_ctx_data() to finish the iteration over every task.

> 
> Would it make sense to delay detach_global_ctx_data() for a second or
> so? That is, what is your event creation pattern?

I don't think it has a special pattern, but I'm curious how we can
handle a race like below.

  attach_global_ctx_data
    check p->flags & PF_EXITING
                                              do_exit
    (preemption)                                set PF_EXITING
                                                detach_task_ctx_data()
    check p->perf_ctx_data
    attach_task_ctx_data()   ---> memory leak

Thanks,
Namhyung

