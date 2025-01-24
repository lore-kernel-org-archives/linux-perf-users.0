Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4681AA783;
	Fri, 24 Jan 2025 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737741401; cv=none; b=DXOvI6CDPCGPY33qZrFFRbHT4MKkDro7ntGxmGKXqOq/T9XiNU3ecRZ0i2rfXeez/V9EltOTdeX0YhrEJfY0P/VhQShCKRfJ7SoStACR8yX+LiSErmGY1dkf4cADe/0aCV5Z55CcIAhpQr15wiUwoFZ/1ar+O6PI5N/Xw/vxPJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737741401; c=relaxed/simple;
	bh=y5xs0g5+5uK1pKvR//CNx+aUr5I9591zqgOWvFaVt+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUFmnTNSIS+XHs7pOPvDDsDxQrcwvaDwscmS1A96irZBsmHBRLc2kHX3YoflCvdaGzin6/t95QAfxbkYgnBzkXs5u2QNCBL0LPHXbeFOtIi1TCwlFz4br1NArZCGdf31HrBKtWvXsYuWkKj4Jdg8wZuNJnv4TU4Ek1nWe1YM6sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVHm+82m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVHm+82m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3B0C4CED2;
	Fri, 24 Jan 2025 17:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737741400;
	bh=y5xs0g5+5uK1pKvR//CNx+aUr5I9591zqgOWvFaVt+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SVHm+82myyvlB9VN1i0fsWyKcR/JNy88XK/xQr0fjLXT5H4aufa6FpNTgr7eP/BJP
	 UdU4iBfrsci9zM2eyVEJ9n9d8tUE4vb2qJ/4N5+2Y2u+56S0TE4Vs7L1mvGn0Sak+h
	 meiZn2Sscv+fW4uLBAFtfY4m76sG+1x6DV6b/tfYVFQid6h7dkol3dFAWxgRntBDoI
	 C31Dkecc19TsInjsn8F7nll9lNO6EOZ0MWG55OQ0fELmthdUH6Pf2vqXl92Wx78ZII
	 5hemIjxMldeiaJYRo7UG/KWeBYPAENVUTW/tjJPLlZSvjCAcNy8U2Em4vqzb8x24R8
	 /+h9RkHKm6WBA==
Date: Fri, 24 Jan 2025 09:56:38 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, eranian@google.com
Subject: Re: [PATCH v2] perf report: Add wall-clock and parallelism profiling
Message-ID: <Z5PUViSUMRsJSIHX@google.com>
References: <CACT4Y+b4WYa9TSqKtDKTJNgXth1U30=KddutfSdp5gmXVOV_jA@mail.gmail.com>
 <20250113134022.2545894-1-dvyukov@google.com>
 <Z4XDJyvjiie3howF@google.com>
 <CACT4Y+b96xynNaZoBHP72-4tJM5Nzo3MBRW19_E7JsMKRWYCzg@mail.gmail.com>
 <Z4cBqGBzZI8VqtIx@google.com>
 <CACT4Y+bv5bMkpnZM1=VXCt5=tUxKxv21N6B2mTB9UqqOYa0g0g@mail.gmail.com>
 <CACT4Y+bA=NdTBjJRCGPr-HPe0=qBKfz5=afr3d+HJ_xLZZ_mKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+bA=NdTBjJRCGPr-HPe0=qBKfz5=afr3d+HJ_xLZZ_mKA@mail.gmail.com>

On Fri, Jan 24, 2025 at 11:46:01AM +0100, Dmitry Vyukov wrote:
> What are the next steps for this patch?
> 
> I don't have any action items on my side. Am I missing any? Ready to be merged?

I'll review the change today.

Thanks,
Namhyung

> 
> 
> 
> On Sun, 19 Jan 2025 at 11:50, Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Wed, 15 Jan 2025 at 01:30, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > On Tue, Jan 14, 2025 at 09:26:57AM +0100, Dmitry Vyukov wrote:
> > > > On Tue, 14 Jan 2025 at 02:51, Namhyung Kim <namhyung@kernel.org> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > On Mon, Jan 13, 2025 at 02:40:06PM +0100, Dmitry Vyukov wrote:
> > > > > > There are two notions of time: wall-clock time and CPU time.
> > > > > > For a single-threaded program, or a program running on a single-core
> > > > > > machine, these notions are the same. However, for a multi-threaded/
> > > > > > multi-process program running on a multi-core machine, these notions are
> > > > > > significantly different. Each second of wall-clock time we have
> > > > > > number-of-cores seconds of CPU time.
> > > > > >
> > > > > > Currently perf only allows to profile CPU time. Perf (and all other
> > > > > > existing profilers to the be best of my knowledge) does not allow to
> > > > > > profile wall-clock time.
> > > > > >
> > > > > > Optimizing CPU overhead is useful to improve 'throughput', while
> > > > > > optimizing wall-clock overhead is useful to improve 'latency'.
> > > > > > These profiles are complementary and are not interchangeable.
> > > > > > Examples of where wall-clock profile is needed:
> > > > > >  - optimzing build latency
> > > > > >  - optimizing server request latency
> > > > > >  - optimizing ML training/inference latency
> > > > > >  - optimizing running time of any command line program
> > > > > >
> > > > > > CPU profile is useless for these use cases at best (if a user understands
> > > > > > the difference), or misleading at worst (if a user tries to use a wrong
> > > > > > profile for a job).
> > > > > >
> > > > > > This patch adds wall-clock and parallelization profiling.
> > > > > > See the added documentation and flags descriptions for details.
> > > > > >
> > > > > > Brief outline of the implementation:
> > > > > >  - add context switch collection during record
> > > > > >  - calculate number of threads running on CPUs (parallelism level)
> > > > > >    during report
> > > > > >  - divide each sample weight by the parallelism level
> > > > > > This effectively models that we were taking 1 sample per unit of
> > > > > > wall-clock time.
> > > > >
> > > > > Thanks for working on this, very interesting!
> > > > >
> > > > > But I guess this implementation depends on cpu-cycles event and single
> > > > > target process.
> > > >
> > > > Not necessarily, it works the same for PMU events, e.g. again from perf make:
> > >
> > > Of course it would work with other events.  But the thing is how to
> > > interprete the result IMHO.
> > >
> > > >
> > > > Samples: 481K of event 'dTLB-load-misses', Event count (approx.): 169413440
> > > > Overhead  Wallclock  Command          Symbol
> > > >    5.34%     16.33%  ld               [.] bfd_elf_link_add_symbols
> > > >    4.14%     14.99%  ld               [.] bfd_link_hash_traverse
> > > >    3.53%     10.87%  ld               [.] __memmove_avx_unaligned_erms
> > > >    1.61%      0.05%  cc1              [k] native_queued_spin_lock_slowpath
> > > >    1.47%      0.09%  cc1              [k] __d_lookup_rcu
> > > >    1.38%      0.55%  sh               [k] __percpu_counter_sum
> > > >    1.22%      0.11%  cc1              [k] __audit_filter_op
> > > >    0.95%      0.08%  cc1              [k] audit_filter_rules.isra.0
> > > >    0.72%      0.47%  sh               [k] pcpu_alloc_noprof
> > > >
> > > > And also it works well for multi-process targets, again most examples
> > > > in the patch are from kernel make.
> > >
> > > It's the single-origin case.  I'm curious about the multiple-origin
> > > cases like profiling two or more existing processes together.  How do
> > > you determine the initial parallelism?
> >
> > What is the "multiple-origin case"? How is it different from multiple processes?
> >
> > > Also I think the parallelism is defined in a process (group).  Does it
> > > still make sense in system-wide profiling?
> >
> > I've tried to answer this here:
> >
> > > It can work as is, if the system activity includes mostly a single
> > > task, e.g. you run something on command line, it's taking too long, so
> > > you decide to do perf record -a in parallel to see what it's doing.
> > >
> > > For system-wide profiling we do Google (GWP), it may need some
> > > additional logic to make it useful. Namely, the system-wide
> > > parallelism is not useful in multi-task contexts. But we can extend
> > > report to allow us to calculate parallelism/wall-clock overhead for a
> > > single multi-threaded process only. Or, if we auto-matically
> > > post-process system-wide profile, then we can split the profile
> > > per-process and calculate parallelism for each of them.
> >
> > Additionally we could add a process filter that will calculate
> > parallelism only with the given set of processes (specified by PIDs or
> > comm names). I.e. one profiled the whole system, but then says "I am
> > really interested only in processes X and Y".
> >
> >
> >
> > > > > Do you think if it'd work for system-wide profiling?
> > > >
> > > > Currently it doesn't b/c system-wide emits PERF_RECORD_SWITCH_CPU_WIDE
> > > > instead of PERF_RECORD_SWITCH which this patch handles.
> > > >
> > > > It can be made to work, I just didn't want to complicate this patch more.
> > >
> > > Ok.
> > >
> > > > It can work as is, if the system activity includes mostly a single
> > > > task, e.g. you run something on command line, it's taking too long, so
> > > > you decide to do perf record -a in parallel to see what it's doing.
> > > >
> > > > For system-wide profiling we do Google (GWP), it may need some
> > > > additional logic to make it useful. Namely, the system-wide
> > > > parallelism is not useful in multi-task contexts. But we can extend
> > > > report to allow us to calculate parallelism/wall-clock overhead for a
> > > > single multi-threaded process only. Or, if we auto-matically
> > > > post-process system-wide profile, then we can split the profile
> > > > per-process and calculate parallelism for each of them.
> > > >
> > > > I am also not sure if we use perf report for GWP, or do manual trace
> > > > parsing. When/if this part is merged, we can think of the system-wide
> > > > story.
> > > >
> > > > TODO: don't enable context-switch recording for -a mode.
> > > >
> > > >
> > > > > How do you define wall-clock overhead if the event counts something
> > > > > different (like the number of L3 cache-misses)?
> > > >
> > > > It's the same. We calculate CPU overhead for these. Wallclock overhead
> > > > is the same, it's just the weights are adjusted proportionally.
> > >
> > > I got this part but ...
> > >
> > > >
> > > > Physical meaning is similar:
> > > > CPU overhead: how much L3 misses affect throughput/cpu consumption
> > > > Wallclock overhead: how much L3 misses affect latency
> > >
> > > I'm not sure if it's correct.  The event would tell where you get the L3
> > > miss mostly.  It doesn't necessarily mean latency.  IOW more L3 miss
> > > doesn't mean more CPU time.  I guess that's why perf doesn't say it as
> > > "CPU overhead".
> >
> > Yes, I agree, it does not directly translate to increased CPU
> > consumption or latency.
> > But the point is: whatever was the effect on CPU consumption, it's
> > rescaled to latency.
> >
> >
> > > Hmm.. maybe you could rename it differently?
> >
> > You mean the "perf report" help page, right?
> >
> > Yes, strictly speaking it's not "CPU overhead" and "Wall-clock
> > overhead", but rather "Overhead in CPU time" and "Overhead in
> > wall-clock time". Does it look better to you?
> >
> >
> > > > > Also I'm not sure about the impact of context switch events which could
> > > > > generate a lot of records that may end up with losing some of them.  And
> > > > > in that case the parallelism tracking would break.
> > > >
> > > > I've counted SAMPLE/SWITCH events on perf make:
> > > >
> > > > perf script --dump-unsorted-raw-trace | grep PERF_RECORD_SAMPLE | wc -l
> > > > 813829
> > > > perf script --dump-unsorted-raw-trace | grep PERF_RECORD_SWITCH | wc -l
> > > > 46249
> > > >
> > > > And this is for:
> > > > perf record -e L1-dcache-load-misses,dTLB-load-misses make
> > > >
> > > > perf script --dump-unsorted-raw-trace | grep PERF_RECORD_SAMPLE | wc -l
> > > > 1138615
> > > > perf script --dump-unsorted-raw-trace | grep PERF_RECORD_SWITCH | wc -l
> > > > 115433
> > > >
> > > > Doesn't pretend to be scientifically accurate, but gives some idea
> > > > about proportion.
> > > > So for the number of samples that's 5% and 10% respectively.
> > >
> > > I think it depends on the workload.  In a very loaded system with short
> > > timeslice or something, you could get a lot more sched switches.  In
> > > your workload, `make` may have a long single-threaded portion.
> >
> > Unfortunately this is likely to be true.
> >
> > > > SWITCH events are smaller (24 bytes vs 40 bytes for SAMPLE), so for
> > > > ring size it's 3-6%.
> > > >
> > > > FWIW I've also considered and started implementing a different
> > > > approach where the kernel would count parallelism level for each
> > > > context and write it out with samples:
> > > > https://github.com/dvyukov/linux/commit/56ee1f638ac1597a800a30025f711ab496c1a9f2
> > > > Then sched_in/out would need to do atomic inc/dec on a global counter.
> > >
> > > It seems you counted parallelism in an event (including inherited ones).
> > > But usually perf tool opens a separate FD on each CPU for an event (like
> > > cycles), then you need to adjust the value across all CPUS.  I'm not
> > > sure if it's doable in this approach.
> >
> > Right, this is probably when I gave up on that approach -- when I
> > observed the counter has a value of 1 at most.
> >
> > > > Not sure how hard it is to make all corner cases work there, I dropped
> > > > it half way b/c the perf record post-processing looked like a better
> > > > approach.
> > >
> > > Probably.
> > >
> > > >
> > > > Lost SWITCH events may be a problem. Perf report already detects and
> > > > prints a warning about lost events. Should we stop reporting
> > > > parallelism/wall-clock if any events are lost? I just don't see it in
> > > > practice.
> > >
> > > It happens quite often when there are many activities.  Probably we can
> > > consider stopping when it detects some lost records.
> > >
> > >
> > > > Kernel could write-out a bitmask of types of lost events in PERF_RECORD_LOST.
> > >
> > > It'd be nice, but given the rate of sched switch I guess it'd most
> > > likely contain some.
> >
> > What's an easy way to get lost events? Normally on my machine I never see them.
> > Is there some parameter to make the buffer very small, or something?
> >
> >
> > > > > > The feature is added on an equal footing with the existing CPU profiling
> > > > > > rather than a separate mode enabled with special flags. The reasoning is
> > > > > > that users may not understand the problem and the meaning of numbers they
> > > > > > are seeing in the first place, so won't even realize that they may need
> > > > > > to be looking for some different profiling mode. When they are presented
> > > > > > with 2 sets of different numbers, they should start asking questions.
> > > > >
> > > > > I understand your point but I think it has some limitation so maybe it's
> > > > > better to put in a separate mode with special flags.
> > > >
> > > > I hate all options.
> > > >
> > > > The 3rd option is to add a _mandary_ flag to perf record to ask for
> > > > profiling mode. Then the old "perf record" will say "nope, you need to
> > > > choose, here are your options and explanation of the options".
> > > >
> > > > If we add it as a new separate mode, I fear it's doomed to be
> > > > unknown/unused and people will continue to not realize what they are
> > > > profiling, meaning of numbers, and continue to use wrong profiles for
> > > > the job.
> > >
> > > I think people will find it out if it really works well! :)
> >
> > Yes, but it may take 10 years for the word to spread :)
> > I am afraid the main problem is that people don't know they need to be
> > looking for something. We had 20 years of widespread multi-CPU/core
> > systems and no profiler supporting latency profiling.
> >
> > But as I said, I am open to options (at least I will know it's there
> > for my purposes :)).
> >
> >
> > > > I consider latency/wall-clock profiling as useful and as fundamental
> > > > as the current bandwidth profiling for parallel workloads (more or
> > > > less all workloads today). Yet we are in 2025 and no profilers out
> > > > there support latency profiling. Which suggests to me there is a
> > > > fundamental lack of understanding of the matter, so new optional mode
> > > > may not work well.
> > >
> > > I'm open to make it default if we can make sure it works well and have a
> > > clear interpretation of the result.
> > >
> > > >
> > > > If you are interested for context, I used a similar mode (for pprof at
> > > > the time) to optimize TensorFlow latency (people mostly care about
> > > > latency). All existing profilers said it's 99% highly optimized and
> > > > parallelized matrix multiplication, we are done here. Yet, the
> > > > wallclock profile said, nope, it's 45% Python interpreter, which
> > > > resulted in this fix:
> > > > https://github.com/soumith/convnet-benchmarks/commit/605988f847fcf261c288abc2351597d71a2ee149
> > > > Full story and examples of these profiles are here:
> > > > https://github.com/dvyukov/perf-load
> > >
> > > Great examples!  I'll take a look later.
> > >
> > > Thanks,
> > > Namhyung
> > >
