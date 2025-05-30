Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B1227CB00;
	Fri, 30 May 2025 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748642717; cv=none; b=UL7Ju7DAT/Am0rU7QArZGwSE8xrHYNxq/dBQgpN6bQ2AfIkUpFiuW905HlqjJktmH0dUUJZ5gfHQmAqHTktAkprBl8p+1D7JC0WfpBpKXMdQEZmdVJL1KyVONRKUAB+2hDBhwFcLax4a+yVY8Is5Flb+yYk3bMXB0S7TnBWiaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748642717; c=relaxed/simple;
	bh=m0WCNGg7GP03EuO2g57uHWZ6ar2232B0Js8dpfGYe28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL0+joQoEN0KDfJ+2BTcYVUgNRjZF6iqBnswVI8FQmrdhmS1Rt1QBfG7Sr/XmBTs/aH/Lo6k5cvC0+H0Ze2k8EWXJCyEVPphglByKVgq2VsKOGr/tGZ5IrVPJhiZHDBDBgDzpMfCrVngsSakxYNcmZkzVtrYYlQMOVDnajFMP14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foOGBwcr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foOGBwcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E30C4CEE9;
	Fri, 30 May 2025 22:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748642717;
	bh=m0WCNGg7GP03EuO2g57uHWZ6ar2232B0Js8dpfGYe28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=foOGBwcrg4ySA7QCCz9iHxF18qsk6PjbgIbT7uZZ6+r0ZBec2IInfUU9KoyL6JBMd
	 xCAfbHt4MFOGNYL1NAEOUfvPiXJPlQDlu16jp3r9//DWQNOhe13fzor3hZdQDrhgMI
	 RdCBAECQX6CgC9VQ2z97t/w47H+80on7Jc4NbxeJ+u/6JFtbV2rf5GpkR+IomrsChb
	 SzEcBJ8kciJlUxO2ngHsmU0LcUwsFr7XXWNAMoGV5mc3/sBCmcE1reKqAE3+lx64pg
	 af4dy2evmHrPyl9VZgEici6OxrSMI0l/a/BUVK3taCJ/kcXfFjtS7jXhtSmSvmTGvO
	 Ye6IqYliodn3Q==
Date: Fri, 30 May 2025 15:05:15 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC/PATCH] perf report: Support latency profiling in
 system-wide mode
Message-ID: <aDormwKnOYm_-Jgs@google.com>
References: <CACT4Y+YacgzrUL1uTqxkPOjQm6ryn2R_nPs8dgnrP_iKA9yasQ@mail.gmail.com>
 <aCdo6Vz2MVv3N0kk@google.com>
 <CACT4Y+YHxXjCU2jySTUO5kH=xC8scdzTTuP2qEBc5zMber44Aw@mail.gmail.com>
 <aCveO4qQGy03ow5p@google.com>
 <CACT4Y+YdnQebkGTQJ9yhLs2j12WBYk2ReiBAq5cE+wtu1RRU5A@mail.gmail.com>
 <aC0HH45JCBTchZMc@google.com>
 <CACT4Y+apAJ_m9W=P2hsGvWrGZnTzxB+9qgJg=ujjU8OWCVcUoQ@mail.gmail.com>
 <CACT4Y+Z3Bbn3KcwhjOYAmzHWqRSZ4ywCrw8FNNxj5MrDUzFtVg@mail.gmail.com>
 <aDdYEH3lIYHAB-lk@google.com>
 <CACT4Y+Y=1aXG_25ONnfD4TxMbsrnW3uFOOL9yrcP+LYeh4pHpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y=1aXG_25ONnfD4TxMbsrnW3uFOOL9yrcP+LYeh4pHpg@mail.gmail.com>

On Fri, May 30, 2025 at 07:50:45AM +0200, Dmitry Vyukov wrote:
> On Wed, 28 May 2025 at 20:38, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Tue, May 27, 2025 at 09:14:34AM +0200, Dmitry Vyukov wrote:
> > > On Wed, 21 May 2025 at 09:30, Dmitry Vyukov <dvyukov@google.com> wrote:
> > > >
> > > > > Maybe we can use this
> > > > > only for the frequency mode which means user didn't use -c option or
> > > > > similar in the event description.
> > >
> > >
> > > All-in-all I think the best option for now is using CPU IDs to track
> > > parallelism as you suggested, but be more precise with idle detection.
> > > 2 passes over the trace may be fine to detect idle points. I see the
> > > most time now spent in hist_entry__cmp, which accesses other entries
> > > and is like a part of O(N*logN) processing, so a simple O(N) pass
> > > shouldn't slow it down much.
> > > That's what I would try. But I would also try to assess the precision
> > > of this approach by comparing with results of using explicit switch
> > > events.
> >
> > It's not clear to me how you want to maintain the idle info in the 2
> > pass approach.  Please feel free to propose something based on this
> > work.
> 
> 
> What part of it is unclear?
> 
> Basically, in the first pass we only mark events as sched_out/in.
> When we don't see samples on a CPU for 2*period, we mark the previous
> sample on the CPU as sched_out:
> 
>   // Assuming the period is stable across time and CPUs.
>   for_each_cpu(cpu) {
>       if (current[cpu]->last_timestamp + 2*period < sample->timestamp) {
>           if (current[cpu]->thread != idle)
>               current[cpu]->last_sample->sched_out = true;
>       }
>   }
> 
>   leader = machine__findnew_thread(machine, sample->pid);
>   if (current[sample->cpu]->thread != leader) {
>     current[sample->cpu]->last_sample->sched_out = true;
>     sample->sched_in = true;
>   }
>   current[sample->cpu]->thread = leader;
>   current[sample->cpu]->last_sample = sample;
>   current[sample->cpu]->last_timestamp = sample->timestamp;

Oh, you wanted to save the info in the sample.  But I'm afraid it won't
work since it's stack allocated for one-time use in the
perf_session__deliver_event().

> 
> 
> On the second pass we use the precomputed sched_in/out to calculate parallelism:
> 
>   leader = machine__findnew_thread(machine, sample->pid);
>   if (sample->sched_in)
>     leader->parallelism++;
>   sample->parallelism = leader->parallelism;
>   if (sample->sched_out)
>     leader->parallelism--;
> 
> This is more precise b/c we don't consider a thread running for
> 2*period after it stopped running.

IIUC it can make some samples have less parallelism right before
they go to idle.

 
> A more precise approach would probably be to consider the thread
> running for 0.5*period after the last sample (and similarly for
> 0.5*period before the first sample), but it would require injecting
> sched_in/out events into the trace at these points.

Yep, that will fix the issue.  But then how to inject the events is the
problem.

Thanks,
Namhyung

