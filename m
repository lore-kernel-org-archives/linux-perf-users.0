Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342DA2951AD;
	Wed,  7 May 2025 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746661400; cv=none; b=deiisyegaLef350J6VdjkmYhGxIRDUAzbTW8cndAVVYidxTvmeRvjgeSZDprOGC8Dxde55HzTh7uqyw7rF9L8AoDnOPIUjVsP0xNJYCcbAd4xKmXc9+48G1YhnUck39j7vAkguaWsNvVmH44Opjb++hVEhVwKSoLjrEKsSVR8yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746661400; c=relaxed/simple;
	bh=/BsSG3FylJbUfjpoVJ9Pn20AQV560RtWljBbtWQ5oVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhklmKEVoOh/ck3pRXOBSH4pE7fswdDmnLG2+Pm9SYB99HmIjJTfbyu5J4tRWavNpA4jyXBvdYIfywmqmhM5Kcror+4gWZcalR/WjfLfSyYxS9SufNjDEXfeQUYy38Reyk6/5Vm1CngfKTbNyPpGm+Tq8PNChV+3Pd0wEPc/aac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJmgu/6Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJmgu/6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBCFC4CEE2;
	Wed,  7 May 2025 23:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746661398;
	bh=/BsSG3FylJbUfjpoVJ9Pn20AQV560RtWljBbtWQ5oVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJmgu/6Qe22gk5ptBs+Q2Hrl3IaHGAakG+libRwjz5JVAaPrK2LQGUU9N5E3Oxcqx
	 0l2vLZqD2709yYc3iLACJkyyffPp1QdiZu2yX+fGWQLOz8mUG6asVd88eAPqJj2a52
	 kwNoI88Chpq5KvF71AzjGWMKf0k7Z0x1QWVR9Yfs1s5rvBQIAsLGy8MDKvqQEIfr3f
	 g9egfDqupNTW4E105+HSnI0Dbd5WxHpFUGNIl67FB/ZINSqa114MRuJ1VZxa0ImPpV
	 sBq4vtMA9E244B0BKVWtPzhDL17ekiwJpugS4/lNYD/NJ82zmmd/Ptv/zGJNC9TE7Y
	 PEQamyre2nAuA==
Date: Wed, 7 May 2025 16:43:16 -0700
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
Message-ID: <aBvwFPRwA2LVQJkO@google.com>
References: <20250503003620.45072-1-namhyung@kernel.org>
 <CACT4Y+Yr7vffLYG+YmyB=9Vn_oxdQqR_6U4d-_WeQoOtPXZ6iw@mail.gmail.com>
 <aBmei7cMf-MzzX5W@google.com>
 <CACT4Y+ameQFd3n=u+bjd+vKR6svShp3NNQzjsUo_UUBCZPzrBw@mail.gmail.com>
 <aBmvmmRKpeVd6aT3@google.com>
 <CACT4Y+bm4gCO_sGvEkxLQfw8JyrWvCzqV_H5h+oebt8kk1_Hwg@mail.gmail.com>
 <aBm1x2as1fraHXHz@google.com>
 <CACT4Y+aiU-dHVgTKEpyJtn=RUUyYJp8U5BjyWSOHm6b2ODp9cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+aiU-dHVgTKEpyJtn=RUUyYJp8U5BjyWSOHm6b2ODp9cA@mail.gmail.com>

On Tue, May 06, 2025 at 09:40:52AM +0200, Dmitry Vyukov wrote:
> On Tue, 6 May 2025 at 09:10, Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > Where does the patch check that this mode is used only for system-wide profiles?
> > > > > Is it that PERF_SAMPLE_CPU present only for system-wide profiles?
> > > >
> > > > Basically yes, but you can use --sample-cpu to add it.
> > >
> > > Are you sure? --sample-cpu seems to work for non-system-wide profiles too.
> >
> > Yep, that's why I said "Basically".  So it's not 100% guarantee.
> >
> > We may disable latency column by default in this case and show warning
> > if it's requested.  Or we may add a new attribute to emit sched-switch
> > records only for idle tasks and enable the latency report only if the
> > data has sched-switch records.
> >
> > What do you think?
> 
> Depends on what problem we are trying to solve:
> 
> 1. Enabling latency profiling for system-wide mode.
> 
> 2. Switch events bloating trace too much.
> 
> 3. Lost switch events lead to imprecise accounting.
> 
> The patch mentions all 3 :)
> But I think 2 and 3 are not really specific to system-wide mode.
> An active single process profile can emit more samples than a
> system-wide profile on a lightly loaded system.

True.  But we don't need to care about lightly loaded systems as they
won't cause problems.


> Similarly, if we rely on switch events for system-wide mode, then it's
> equally subject to the lost events problem.

Right, but I'm afraid practically it'll increase the chance of lost
in system-wide mode.  The default size of the sample for system-wide
is 56 byte and the size of the switch is 48 byte.  And the default
sample frequency is 4000 Hz but it cannot control the rate of the
switch.  I saw around 10000 Hz of switches per CPU on my work env.

> 
> For problem 1: we can just permit --latency for system wide mode and
> fully rely on switch events.
> It's not any worse than we do now (wrt both profile size and lost events).

This can be an option and it'd work well on lightly loaded systems.
Maybe we can just try it first.  But I think it's better to have an
option to make it work on heavily loaded systems.

> 
> For problem 2: yes, we could emit only switches to idle tasks. Or
> maybe just a fake CPU sample for an idle task? That's effectively what
> we want, then your current accounting code will work w/o any changes.
> This should help wrt trace size only for system-wide mode (provided
> that user already enables CPU accounting for other reasons, otherwise
> it's unclear what's better -- attaching CPU to each sample, or writing
> switch events).

I'm not sure how we can add the fake samples.  The switch events will be
from the kernel and we may add the condition in the attribute.

And PERF_SAMPLE_CPU is on by default in system-wide mode.

> 
> For problem 3: switches to idle task won't really help. There can be
> lots of them, and missing any will lead to wrong accounting.

I don't know how severe the situation will be.  On heavily loaded
systems, the idle task won't run much and data size won't increase.
On lightly loaded systems, increased data will likely be handled well.


> A principled approach would be to attach a per-thread scheduler
> quantum sequence number to each CPU sample. The sequence number would
> be incremented on every context switch. Then any subset of CPU should
> be enough to understand when a task was scheduled in and out
> (scheduled in on the first CPU sample with sequence number N, and
> switched out on the last sample with sequence number N).

I'm not sure how it can help.  We don't need the switch info itself.
What's needed is when the CPU was idle, right?

Thanks,
Namhyung

