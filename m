Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE473101A3;
	Thu,  8 Jan 2026 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767902221; cv=none; b=e3QZkXPp4cUu5CpZoYcFw+qDXHwvBMaU+ixMmEb1HxeWSaKklgR8qKmphhdUIRPR5osPYR0fhNOEZ4iStlMOSZb6GLXpPE6/RD1YrJNhmq87vHIGV/ubGFyNXZ2nUGMOuB70xrrUjKF7zjW0n1tHz10wP7h71Ywos5n2ib15jdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767902221; c=relaxed/simple;
	bh=DzoLsn54qNXGmunDlU26ADsHVkpZ+uQdBbfRL/gyEgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHrO3+XUAIHH0LJr8y/19KIOguDCgKXPSXIKEZWBS2dqJ41q52Jb8hsqf0eg0PDJt/uYbB2XiUkpA5TpFbZRLznAz0XnM8XWu+YRyQwWw58ekhRoqSgt0hAnTZliiCTon5YOA0FmJajq6TnVElZ1CwfPKdq/dwUUONPXYUX9d3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hu3xp77b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hu3xp77b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6625C116C6;
	Thu,  8 Jan 2026 19:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767902221;
	bh=DzoLsn54qNXGmunDlU26ADsHVkpZ+uQdBbfRL/gyEgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hu3xp77bSe+Dh3jUFL1YbdVl+7DOChiYIN3bVIPjP0a00cIdJsbvGXBYU9C3Lfovx
	 YbmiZJiwNHuPMGlv/DtHVQr51RHmtvQ6uchXEkcpleV3rSLaQ7BstutGJMjCVeMEfz
	 2M1+oMKBkakfdEPOLD0VdmcGKQ67z78ygECOBkbfZc1aC5hCi/9Jp6cYnRiPWDl/lb
	 kDOTKQ59y2eBFe4kSUGBxsl5OKva6UTbdxub9sQ0etmL+k6KyF34bISsqSkjjMKrqY
	 CbGdjhrxTypqiM/LGsw5sulmBC5svezv9YuabQDpsJX0naJQOA35dW2d3dvOGXVHGI
	 UNHJpXRfgiBKg==
Date: Thu, 8 Jan 2026 11:56:59 -0800
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
Message-ID: <aWAMC3HPskHNQeOs@google.com>
References: <aUnVfxDtLNUDJM_v@google.com>
 <aUnWFc_mILUDFavi@google.com>
 <aV2OACqA5OpmoeF0@google.com>
 <20260107091652.GB3707891@noisy.programming.kicks-ass.net>
 <aV6toexK5LMc1MNY@google.com>
 <20260107222823.GC694817@noisy.programming.kicks-ass.net>
 <20260107223256.GA807925@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260107223256.GA807925@noisy.programming.kicks-ass.net>

On Wed, Jan 07, 2026 at 11:32:56PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 07, 2026 at 11:28:24PM +0100, Peter Zijlstra wrote:
> > On Wed, Jan 07, 2026 at 11:01:53AM -0800, Namhyung Kim wrote:
> > 
> > > > But yes, I suppose this can do. The question is however, how do you get
> > > > into this predicament to begin with? Are you creating and destroying a
> > > > lot of global LBR events or something?
> > > 
> > > I think it's just because there are too many tasks in the system like
> > > O(100K).  And any thread going to exit needs to wait for
> > > attach_global_ctx_data() to finish the iteration over every task.
> > 
> > OMG, so many tasks ...
> > 
> > > > Would it make sense to delay detach_global_ctx_data() for a second or
> > > > so? That is, what is your event creation pattern?
> > > 
> > > I don't think it has a special pattern, but I'm curious how we can
> > > handle a race like below.
> > > 
> > >   attach_global_ctx_data
> > >     check p->flags & PF_EXITING
> > >                                               do_exit
> > >     (preemption)                                set PF_EXITING
> > >                                                 detach_task_ctx_data()
> > >     check p->perf_ctx_data
> > >     attach_task_ctx_data()   ---> memory leak
> > 
> > Oh right. Something like so perhaps?
> > 
> > ---
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 3c2a491200c6..e5e716420eb3 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -5421,9 +5421,19 @@ attach_task_ctx_data(struct task_struct *task, struct kmem_cache *ctx_cache,
> >  		return -ENOMEM;
> >  
> >  	for (;;) {
> > -		if (try_cmpxchg((struct perf_ctx_data **)&task->perf_ctx_data, &old, cd)) {
> > +		if (try_cmpxchg(&task->perf_ctx_data, &old, cd)) {
> >  			if (old)
> >  				perf_free_ctx_data_rcu(old);
> > +			/*
> > +			 * try_cmpxchg() pairs with try_cmpxchg() from
> > +			 * detach_task_ctx_data() such that
> > +			 * if we race with perf_event_exit_task(), we must
> > +			 * observe PF_EXITING.
> > +			 */
> > +			if (task->flags & PF_EXITING) {
> > +				task->perf_ctx_data = NULL;
> > +				perf_free_ctx_data_rcu(cd);
> 
> Ugh and now it can race and do a double free, another try_cmpxchg() is
> needed here.

Thanks!  Something like this?

Namhyung


diff --git a/kernel/events/core.c b/kernel/events/core.c
index 376fb07d869b8b50..cf252d8f49b2b259 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5421,9 +5421,20 @@ attach_task_ctx_data(struct task_struct *task, struct kmem_cache *ctx_cache,
 		return -ENOMEM;
 
 	for (;;) {
-		if (try_cmpxchg((struct perf_ctx_data **)&task->perf_ctx_data, &old, cd)) {
+		if (try_cmpxchg(&task->perf_ctx_data, &old, cd)) {
 			if (old)
 				perf_free_ctx_data_rcu(old);
+			/*
+			 * try_cmpxchg() pairs with try_cmpxchg() from
+			 * detach_task_ctx_data() such that
+			 * if we race with perf_event_exit_task(), we must
+			 * observe PF_EXITING.
+			 */
+			if (task->flags & PF_EXITING) {
+				/* detach_task_ctx_data() may free it already */
+				if (try_cmpxchg(&task->perf_ctx_data, &cd, NULL))
+					perf_free_ctx_data_rcu(cd);
+			}
 			return 0;
 		}
 
@@ -5469,6 +5480,8 @@ attach_global_ctx_data(struct kmem_cache *ctx_cache)
 	/* Allocate everything */
 	scoped_guard (rcu) {
 		for_each_process_thread(g, p) {
+			if (p->flags & PF_EXITING)
+				continue;
 			cd = rcu_dereference(p->perf_ctx_data);
 			if (cd && !cd->global) {
 				cd->global = 1;
@@ -14562,8 +14575,11 @@ void perf_event_exit_task(struct task_struct *task)
 
 	/*
 	 * Detach the perf_ctx_data for the system-wide event.
+	 *
+	 * Done without holding global_ctx_data_rwsem; typically
+	 * attach_global_ctx_data() will skip over this task, but otherwise
+	 * attach_task_ctx_data() will observe PF_EXITING.
 	 */
-	guard(percpu_read)(&global_ctx_data_rwsem);
 	detach_task_ctx_data(task);
 }
 
