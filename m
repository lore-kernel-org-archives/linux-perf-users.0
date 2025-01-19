Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DA21A725C
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Jan 2025 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737283861; cv=none; b=KozZpodBrX/iJ58Qej73VKPv6+6p2KQM1y8KY4bs/VyKZLpVyT4Kd7oLWPvzIGANo5KbvvO57ivnELfN+HEKhaGetADICnytLqXBIK3jmfMWVhvLOSnYfGUsWZK9+2mCkDRmkNCZUMjKjuAL/0Ba+E+uUQ5PhkSwvzK6E3p2A3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737283861; c=relaxed/simple;
	bh=l8xHmcozjwkFVe5OrhojQaoKC6AFn/TcpXmPy2vzE38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWLh5JhWOEalxkikL/DBopwbn1FEL4lZesvZpRv+sTKXzwIOjY34ITOOaCXEpr+du2r5oVHa9jqIMBhY6iRDC/Deg/tMyrPChQxqd0lgcHq3bSn2SYjDPxbqk5cMqTMs1jOwxhE8YHw5XlwQP5xZe0tJjfHHetrPlEcQgvq3FAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OhRxm47h; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OhRxm47h"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30036310158so30067591fa.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Jan 2025 02:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737283857; x=1737888657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MveSsjd8YRrqYFlGsRr+4I/Nl3vjM8Oh/69WD3GQB88=;
        b=OhRxm47h8xtMg5354yJoX2IMoPc8HjnLRRxP0yPe4BjZSlbetq1MYc5qXZeGBY4aQP
         LsNwouqTuIuazanaMEYIMw74n2ji2U4UPelPaYsGUmHb2URMoJEES0rPbz5uSQZNgIKA
         IKJmyylKKoV5PFzN0Gg6cQuOMFirm8n9MOdKasY2LvdQWu0K/kg5EOimTHFRrA3H7Z4s
         oqR2iQMWYWSe1cDUrdoHXwHK0VvYuEg/PlHhdCvZ72M/y1fnhq23UcRuSbytGm9cXyUK
         kT98QSMgdIXIoznTkU9glokzF788iDq+3QksYYPKgYMnUudQhxX5bvz1L01Ica4mGgoY
         H++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737283857; x=1737888657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MveSsjd8YRrqYFlGsRr+4I/Nl3vjM8Oh/69WD3GQB88=;
        b=fVb/q55BankIPCFcj+4sEHMejDJcTP0U3LQs3doAZop7vTpKKlAxZDD2S+vOgQkUaf
         zQ37NwEuzzNWfgaiKhaecns48z9uS37cOPQ+7nIUGk8Jda+z7mNXxVEnaEL2HFiPRAR3
         BeFNdsc21HgcEV/AQzDmZXHzLeAC6wbL4WCah08bzdCazoPcO01sns8nzzwPa5veAvle
         /3NFNs2cNF5B0H7t9RPMYSHtjOqh/pvLT+TNjBsn7mfvTQHBKpHwXud8cmJH3dhtjres
         E9ZQg0ds8tNGLpoWdC7rbT9VpLyhIJwUKT+2gIMQphFwzKfpvYB5c1pizeNfyyeoWNlB
         e1ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUV4gUA7qDttVb68yfbI5TdPlgYppsQSkMD0uNvpk2c6sBZevG0MqPNgKdYF8GNASCZKcwDUPjcmraA/mLbrvvZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3YMBn2UWUS2HOb1Xln5lrE3UHchkR670K4K1TWrvPiWdRVYvH
	NsMcUnF0Qz0oN7D5YESgdeS63lC46T9NxzawcLu6k4nB0CypYkgHz4D2yS2MJE1Z+cH5aFL7eOA
	vW+0Fr5Gw/wopRVVldCcd6k+yVJk5aSoXc5om
X-Gm-Gg: ASbGncuTn5z/Xc9mUoC9N5/J/TJLUs3fEOaTfyypraq+7bQ1UkTpU17IziAmbKl2qqv
	2EagK0G0GS4Zt+todYV8KD4Pn1bR8Jqmq4Uhqkkh3Hm1A1n7zIcnG10v2GjOyN5jQ4HPGqcMB6A
	mXQEAoZMQw
X-Google-Smtp-Source: AGHT+IH2wJoN376VDvjwNVv8KoGoVXc6gD1Gdia0oj/bYZwKGr+zZIVM9oAqk5gU6SL2NUJLuRZsu+9jyL4PZaQo920=
X-Received: by 2002:a05:651c:b26:b0:302:336a:8ada with SMTP id
 38308e7fff4ca-3072cb21c89mr30962771fa.27.1737283856759; Sun, 19 Jan 2025
 02:50:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACT4Y+b4WYa9TSqKtDKTJNgXth1U30=KddutfSdp5gmXVOV_jA@mail.gmail.com>
 <20250113134022.2545894-1-dvyukov@google.com> <Z4XDJyvjiie3howF@google.com>
 <CACT4Y+b96xynNaZoBHP72-4tJM5Nzo3MBRW19_E7JsMKRWYCzg@mail.gmail.com> <Z4cBqGBzZI8VqtIx@google.com>
In-Reply-To: <Z4cBqGBzZI8VqtIx@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sun, 19 Jan 2025 11:50:45 +0100
X-Gm-Features: AbW1kvbBBWQ_xX-psCmmj1S1ivvVnCfpaiSWiyu7Dgrurkqe3C76vUuD5ds1_90
Message-ID: <CACT4Y+bv5bMkpnZM1=VXCt5=tUxKxv21N6B2mTB9UqqOYa0g0g@mail.gmail.com>
Subject: Re: [PATCH v2] perf report: Add wall-clock and parallelism profiling
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eranian@google.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Jan 2025 at 01:30, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Tue, Jan 14, 2025 at 09:26:57AM +0100, Dmitry Vyukov wrote:
> > On Tue, 14 Jan 2025 at 02:51, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hello,
> > >
> > > On Mon, Jan 13, 2025 at 02:40:06PM +0100, Dmitry Vyukov wrote:
> > > > There are two notions of time: wall-clock time and CPU time.
> > > > For a single-threaded program, or a program running on a single-core
> > > > machine, these notions are the same. However, for a multi-threaded/
> > > > multi-process program running on a multi-core machine, these notions are
> > > > significantly different. Each second of wall-clock time we have
> > > > number-of-cores seconds of CPU time.
> > > >
> > > > Currently perf only allows to profile CPU time. Perf (and all other
> > > > existing profilers to the be best of my knowledge) does not allow to
> > > > profile wall-clock time.
> > > >
> > > > Optimizing CPU overhead is useful to improve 'throughput', while
> > > > optimizing wall-clock overhead is useful to improve 'latency'.
> > > > These profiles are complementary and are not interchangeable.
> > > > Examples of where wall-clock profile is needed:
> > > >  - optimzing build latency
> > > >  - optimizing server request latency
> > > >  - optimizing ML training/inference latency
> > > >  - optimizing running time of any command line program
> > > >
> > > > CPU profile is useless for these use cases at best (if a user understands
> > > > the difference), or misleading at worst (if a user tries to use a wrong
> > > > profile for a job).
> > > >
> > > > This patch adds wall-clock and parallelization profiling.
> > > > See the added documentation and flags descriptions for details.
> > > >
> > > > Brief outline of the implementation:
> > > >  - add context switch collection during record
> > > >  - calculate number of threads running on CPUs (parallelism level)
> > > >    during report
> > > >  - divide each sample weight by the parallelism level
> > > > This effectively models that we were taking 1 sample per unit of
> > > > wall-clock time.
> > >
> > > Thanks for working on this, very interesting!
> > >
> > > But I guess this implementation depends on cpu-cycles event and single
> > > target process.
> >
> > Not necessarily, it works the same for PMU events, e.g. again from perf make:
>
> Of course it would work with other events.  But the thing is how to
> interprete the result IMHO.
>
> >
> > Samples: 481K of event 'dTLB-load-misses', Event count (approx.): 169413440
> > Overhead  Wallclock  Command          Symbol
> >    5.34%     16.33%  ld               [.] bfd_elf_link_add_symbols
> >    4.14%     14.99%  ld               [.] bfd_link_hash_traverse
> >    3.53%     10.87%  ld               [.] __memmove_avx_unaligned_erms
> >    1.61%      0.05%  cc1              [k] native_queued_spin_lock_slowpath
> >    1.47%      0.09%  cc1              [k] __d_lookup_rcu
> >    1.38%      0.55%  sh               [k] __percpu_counter_sum
> >    1.22%      0.11%  cc1              [k] __audit_filter_op
> >    0.95%      0.08%  cc1              [k] audit_filter_rules.isra.0
> >    0.72%      0.47%  sh               [k] pcpu_alloc_noprof
> >
> > And also it works well for multi-process targets, again most examples
> > in the patch are from kernel make.
>
> It's the single-origin case.  I'm curious about the multiple-origin
> cases like profiling two or more existing processes together.  How do
> you determine the initial parallelism?

What is the "multiple-origin case"? How is it different from multiple processes?

> Also I think the parallelism is defined in a process (group).  Does it
> still make sense in system-wide profiling?

I've tried to answer this here:

> It can work as is, if the system activity includes mostly a single
> task, e.g. you run something on command line, it's taking too long, so
> you decide to do perf record -a in parallel to see what it's doing.
>
> For system-wide profiling we do Google (GWP), it may need some
> additional logic to make it useful. Namely, the system-wide
> parallelism is not useful in multi-task contexts. But we can extend
> report to allow us to calculate parallelism/wall-clock overhead for a
> single multi-threaded process only. Or, if we auto-matically
> post-process system-wide profile, then we can split the profile
> per-process and calculate parallelism for each of them.

Additionally we could add a process filter that will calculate
parallelism only with the given set of processes (specified by PIDs or
comm names). I.e. one profiled the whole system, but then says "I am
really interested only in processes X and Y".



> > > Do you think if it'd work for system-wide profiling?
> >
> > Currently it doesn't b/c system-wide emits PERF_RECORD_SWITCH_CPU_WIDE
> > instead of PERF_RECORD_SWITCH which this patch handles.
> >
> > It can be made to work, I just didn't want to complicate this patch more.
>
> Ok.
>
> > It can work as is, if the system activity includes mostly a single
> > task, e.g. you run something on command line, it's taking too long, so
> > you decide to do perf record -a in parallel to see what it's doing.
> >
> > For system-wide profiling we do Google (GWP), it may need some
> > additional logic to make it useful. Namely, the system-wide
> > parallelism is not useful in multi-task contexts. But we can extend
> > report to allow us to calculate parallelism/wall-clock overhead for a
> > single multi-threaded process only. Or, if we auto-matically
> > post-process system-wide profile, then we can split the profile
> > per-process and calculate parallelism for each of them.
> >
> > I am also not sure if we use perf report for GWP, or do manual trace
> > parsing. When/if this part is merged, we can think of the system-wide
> > story.
> >
> > TODO: don't enable context-switch recording for -a mode.
> >
> >
> > > How do you define wall-clock overhead if the event counts something
> > > different (like the number of L3 cache-misses)?
> >
> > It's the same. We calculate CPU overhead for these. Wallclock overhead
> > is the same, it's just the weights are adjusted proportionally.
>
> I got this part but ...
>
> >
> > Physical meaning is similar:
> > CPU overhead: how much L3 misses affect throughput/cpu consumption
> > Wallclock overhead: how much L3 misses affect latency
>
> I'm not sure if it's correct.  The event would tell where you get the L3
> miss mostly.  It doesn't necessarily mean latency.  IOW more L3 miss
> doesn't mean more CPU time.  I guess that's why perf doesn't say it as
> "CPU overhead".

Yes, I agree, it does not directly translate to increased CPU
consumption or latency.
But the point is: whatever was the effect on CPU consumption, it's
rescaled to latency.


> Hmm.. maybe you could rename it differently?

You mean the "perf report" help page, right?

Yes, strictly speaking it's not "CPU overhead" and "Wall-clock
overhead", but rather "Overhead in CPU time" and "Overhead in
wall-clock time". Does it look better to you?


> > > Also I'm not sure about the impact of context switch events which could
> > > generate a lot of records that may end up with losing some of them.  And
> > > in that case the parallelism tracking would break.
> >
> > I've counted SAMPLE/SWITCH events on perf make:
> >
> > perf script --dump-unsorted-raw-trace | grep PERF_RECORD_SAMPLE | wc -l
> > 813829
> > perf script --dump-unsorted-raw-trace | grep PERF_RECORD_SWITCH | wc -l
> > 46249
> >
> > And this is for:
> > perf record -e L1-dcache-load-misses,dTLB-load-misses make
> >
> > perf script --dump-unsorted-raw-trace | grep PERF_RECORD_SAMPLE | wc -l
> > 1138615
> > perf script --dump-unsorted-raw-trace | grep PERF_RECORD_SWITCH | wc -l
> > 115433
> >
> > Doesn't pretend to be scientifically accurate, but gives some idea
> > about proportion.
> > So for the number of samples that's 5% and 10% respectively.
>
> I think it depends on the workload.  In a very loaded system with short
> timeslice or something, you could get a lot more sched switches.  In
> your workload, `make` may have a long single-threaded portion.

Unfortunately this is likely to be true.

> > SWITCH events are smaller (24 bytes vs 40 bytes for SAMPLE), so for
> > ring size it's 3-6%.
> >
> > FWIW I've also considered and started implementing a different
> > approach where the kernel would count parallelism level for each
> > context and write it out with samples:
> > https://github.com/dvyukov/linux/commit/56ee1f638ac1597a800a30025f711ab496c1a9f2
> > Then sched_in/out would need to do atomic inc/dec on a global counter.
>
> It seems you counted parallelism in an event (including inherited ones).
> But usually perf tool opens a separate FD on each CPU for an event (like
> cycles), then you need to adjust the value across all CPUS.  I'm not
> sure if it's doable in this approach.

Right, this is probably when I gave up on that approach -- when I
observed the counter has a value of 1 at most.

> > Not sure how hard it is to make all corner cases work there, I dropped
> > it half way b/c the perf record post-processing looked like a better
> > approach.
>
> Probably.
>
> >
> > Lost SWITCH events may be a problem. Perf report already detects and
> > prints a warning about lost events. Should we stop reporting
> > parallelism/wall-clock if any events are lost? I just don't see it in
> > practice.
>
> It happens quite often when there are many activities.  Probably we can
> consider stopping when it detects some lost records.
>
>
> > Kernel could write-out a bitmask of types of lost events in PERF_RECORD_LOST.
>
> It'd be nice, but given the rate of sched switch I guess it'd most
> likely contain some.

What's an easy way to get lost events? Normally on my machine I never see them.
Is there some parameter to make the buffer very small, or something?


> > > > The feature is added on an equal footing with the existing CPU profiling
> > > > rather than a separate mode enabled with special flags. The reasoning is
> > > > that users may not understand the problem and the meaning of numbers they
> > > > are seeing in the first place, so won't even realize that they may need
> > > > to be looking for some different profiling mode. When they are presented
> > > > with 2 sets of different numbers, they should start asking questions.
> > >
> > > I understand your point but I think it has some limitation so maybe it's
> > > better to put in a separate mode with special flags.
> >
> > I hate all options.
> >
> > The 3rd option is to add a _mandary_ flag to perf record to ask for
> > profiling mode. Then the old "perf record" will say "nope, you need to
> > choose, here are your options and explanation of the options".
> >
> > If we add it as a new separate mode, I fear it's doomed to be
> > unknown/unused and people will continue to not realize what they are
> > profiling, meaning of numbers, and continue to use wrong profiles for
> > the job.
>
> I think people will find it out if it really works well! :)

Yes, but it may take 10 years for the word to spread :)
I am afraid the main problem is that people don't know they need to be
looking for something. We had 20 years of widespread multi-CPU/core
systems and no profiler supporting latency profiling.

But as I said, I am open to options (at least I will know it's there
for my purposes :)).


> > I consider latency/wall-clock profiling as useful and as fundamental
> > as the current bandwidth profiling for parallel workloads (more or
> > less all workloads today). Yet we are in 2025 and no profilers out
> > there support latency profiling. Which suggests to me there is a
> > fundamental lack of understanding of the matter, so new optional mode
> > may not work well.
>
> I'm open to make it default if we can make sure it works well and have a
> clear interpretation of the result.
>
> >
> > If you are interested for context, I used a similar mode (for pprof at
> > the time) to optimize TensorFlow latency (people mostly care about
> > latency). All existing profilers said it's 99% highly optimized and
> > parallelized matrix multiplication, we are done here. Yet, the
> > wallclock profile said, nope, it's 45% Python interpreter, which
> > resulted in this fix:
> > https://github.com/soumith/convnet-benchmarks/commit/605988f847fcf261c288abc2351597d71a2ee149
> > Full story and examples of these profiles are here:
> > https://github.com/dvyukov/perf-load
>
> Great examples!  I'll take a look later.
>
> Thanks,
> Namhyung
>
