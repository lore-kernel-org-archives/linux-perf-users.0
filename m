Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E1C1C3BE3
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736870849; cv=none; b=DGAnJfbMyjtNZkQBVWaAaEdII3b5bDBK1maTa8/u9o0cyK/feS1amLSonaOr+rfcMSoB2ADMMFvSixmfg+XbHXc4qGHYuZmHp7l4m1H15+fLm+xxE/qjDS4iqNtXfek6EwlHqFfkuo3ZtN9IV+U12ldBUF5oHNCxGMp6eMphKqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736870849; c=relaxed/simple;
	bh=lYid5DSTaSkr2w2p3h5+0qDWLUOqcUx7izwJFbHIF8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uv5J4t+tY23QkyL9Z0Q1W7y91/pGQ4DC7HgkLhUZRae4F2qIo25l5fsaz5HATUEAeu9EBJ8xaY0Caz/b+9xpK/OQJtlJnMPu9btpVljOfKoOsCQ5to09kM3AEP6JOe4ID0E9ICvpLITNAUwm1F4sx4C0IspwiUKwaPieG02ifMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r7+eTIeS; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r7+eTIeS"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-305d843d925so44257821fa.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 08:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736870846; x=1737475646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgqIuuCRKFpDOhU/WOjT9SEzKRiqGwWC6SvRmB9S2Mc=;
        b=r7+eTIeStmJWhkZHaPhASge+rrzr0k81kS9QFDn9lv7/aghqj4IluXHxaZ8KTVdSMz
         3vHBCNLOI0fnxa5g69nFLLGnvHM557jfh1av3aAKX70owqgbOsBhdvsckCdNVL2blqmL
         ytSAhdJcknDWEGQlXxjr3Y9E79B6TjsmkvXLvsv6E10raV7KKict20mi/aAeY3HeoG/T
         YsOWrz4mTGpwDUQUluJNFblNQIotg0XZJfgdMaHT6HkKrD9QaOLWkEfq9+Cp2y3bYoat
         Hnyj96KfFUVbQHsVadbtJVDL4+4OMFaNEB28s/yYAdyXXNgyYrmHRuJ12W41dalVQlEG
         v+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736870846; x=1737475646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgqIuuCRKFpDOhU/WOjT9SEzKRiqGwWC6SvRmB9S2Mc=;
        b=bTbvX3xDCqKPW07GQly7A04BUrKEOOcwFo6GgGpUuUc8XrbEsDCu77EeOciOErV/l/
         U5Y4+yn/i/0ZQ+sV4XDuyBVnoybE6oTfMe2lJU0rY8x1hbBGWerpj8opf0tE+eGw/KuZ
         hww7LtpMQjG97V1FM0ARqDiH9kn1rcCp/2OuQMKse4d8plW5CxgcW5guO9awGUJiufWF
         xTpAZXhHKb+7crFOozqmpd9tFBCm8XAL6FK8D2pS5PZymmix4Z65tyhljcNwNx/HOuLV
         9wQ9bdXl9B1wwFB82MnF0iLnh+Y/p6Lz96RWfANCi3y5li6hTLWRNgOu5VtjK9ZFYLEV
         hvrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWPMeXdilSbLS2Unc+7YmAUZVnb6doIp+RwkPnTGJoyWZDfY/Nd/zTFmzqWaJDNlzt9/pTtkT3JyCPe8tAx7It@vger.kernel.org
X-Gm-Message-State: AOJu0YzXcQyc9XlHqQdhi86auLslwhd8zjrz3C/4pWdMnQUg8MaMT1PF
	DDHnod3cGJJWO9K7n3VXN6xozxPW4WmBWIh0sfGa9yOBhXsQ1bZZKRIzmBRa+8VG8fR+p/R9d4s
	qHqv8T1CxkURB1sNcgG2IAvfzcRF2oRBSWBPg
X-Gm-Gg: ASbGncvHk6QYmXrxfQZt9BBtMEbmwvs6zEul4b+g7vLITTkNv/qL0lUIC7uyaTrIw8N
	md8fVtHt9n3hV3adFPz5fE208hdstI6vZXY3s8tNfbJk2JN1LRXcmGzUcAe8HqfbsR2zS
X-Google-Smtp-Source: AGHT+IHK1TcpkDSHjtck4A5CO0VEMK3Yd32ta7zNxm/pMpv0Z+OR+BDcSfaMtospQXyIqABi/X9a+0vlaSc1pwCYUa8=
X-Received: by 2002:a2e:be09:0:b0:300:3a15:8f19 with SMTP id
 38308e7fff4ca-305f45dc70dmr88914411fa.32.1736870845315; Tue, 14 Jan 2025
 08:07:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACT4Y+b4WYa9TSqKtDKTJNgXth1U30=KddutfSdp5gmXVOV_jA@mail.gmail.com>
 <20250113134022.2545894-1-dvyukov@google.com> <Z4XDJyvjiie3howF@google.com>
 <CACT4Y+b96xynNaZoBHP72-4tJM5Nzo3MBRW19_E7JsMKRWYCzg@mail.gmail.com> <Z4aJSde5KXO-rqWM@x1>
In-Reply-To: <Z4aJSde5KXO-rqWM@x1>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 14 Jan 2025 17:07:14 +0100
X-Gm-Features: AbW1kvYfuBfYuQ9-mVLjv_qtwqG1dEHZKlFfdj0T4oHZI9ZmYC0icMrMG5OE_RA
Message-ID: <CACT4Y+b6nbqNHt1MwT_KfWjNrMA_1qvMD=Gkk9gfZNXLL79xdQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf report: Add wall-clock and parallelism profiling
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, irogers@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eranian@google.com, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Jan 2025 at 16:57, Arnaldo Carvalho de Melo <acme@kernel.org> wr=
ote:
>
> Adding Ingo and PeterZ to the CC list.
>
> On Tue, Jan 14, 2025 at 09:26:57AM +0100, Dmitry Vyukov wrote:
> > On Tue, 14 Jan 2025 at 02:51, Namhyung Kim <namhyung@kernel.org> wrote:
> > > On Mon, Jan 13, 2025 at 02:40:06PM +0100, Dmitry Vyukov wrote:
> > > > There are two notions of time: wall-clock time and CPU time.
> > > > For a single-threaded program, or a program running on a single-cor=
e
> > > > machine, these notions are the same. However, for a multi-threaded/
> > > > multi-process program running on a multi-core machine, these notion=
s are
> > > > significantly different. Each second of wall-clock time we have
> > > > number-of-cores seconds of CPU time.
> > > >
> > > > Currently perf only allows to profile CPU time. Perf (and all other
> > > > existing profilers to the be best of my knowledge) does not allow t=
o
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
> > > > CPU profile is useless for these use cases at best (if a user under=
stands
> > > > the difference), or misleading at worst (if a user tries to use a w=
rong
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
>
> > > Thanks for working on this, very interesting!
>
> Indeed!
>
> > > But I guess this implementation depends on cpu-cycles event and singl=
e
> > > target process.
>
> > Not necessarily, it works the same for PMU events, e.g. again from perf=
 make:
>
> > Samples: 481K of event 'dTLB-load-misses', Event count (approx.): 16941=
3440
> > Overhead  Wallclock  Command          Symbol
> >    5.34%     16.33%  ld               [.] bfd_elf_link_add_symbols
> >    4.14%     14.99%  ld               [.] bfd_link_hash_traverse
> >    3.53%     10.87%  ld               [.] __memmove_avx_unaligned_erms
> >    1.61%      0.05%  cc1              [k] native_queued_spin_lock_slowp=
ath
> >    1.47%      0.09%  cc1              [k] __d_lookup_rcu
> >    1.38%      0.55%  sh               [k] __percpu_counter_sum
> >    1.22%      0.11%  cc1              [k] __audit_filter_op
> >    0.95%      0.08%  cc1              [k] audit_filter_rules.isra.0
> >    0.72%      0.47%  sh               [k] pcpu_alloc_noprof
>
> > And also it works well for multi-process targets, again most examples
> > in the patch are from kernel make.
>
> > > Do you think if it'd work for system-wide profiling?
>
> > Currently it doesn't b/c system-wide emits PERF_RECORD_SWITCH_CPU_WIDE
> > instead of PERF_RECORD_SWITCH which this patch handles.
>
> > It can be made to work, I just didn't want to complicate this patch mor=
e.
> > It can work as is, if the system activity includes mostly a single
> > task, e.g. you run something on command line, it's taking too long, so
> > you decide to do perf record -a in parallel to see what it's doing.
>
> > For system-wide profiling we do Google (GWP), it may need some
> > additional logic to make it useful. Namely, the system-wide
> > parallelism is not useful in multi-task contexts. But we can extend
> > report to allow us to calculate parallelism/wall-clock overhead for a
> > single multi-threaded process only. Or, if we auto-matically
> > post-process system-wide profile, then we can split the profile
> > per-process and calculate parallelism for each of them.
>
> > I am also not sure if we use perf report for GWP, or do manual trace
> > parsing. When/if this part is merged, we can think of the system-wide
> > story.
>
> > TODO: don't enable context-switch recording for -a mode.
>
> > > How do you define wall-clock overhead if the event counts something
> > > different (like the number of L3 cache-misses)?
>
> > It's the same. We calculate CPU overhead for these. Wallclock overhead
> > is the same, it's just the weights are adjusted proportionally.
>
> > Physical meaning is similar:
> > CPU overhead: how much L3 misses affect throughput/cpu consumption
> > Wallclock overhead: how much L3 misses affect latency
>
> > > Also I'm not sure about the impact of context switch events which cou=
ld
> > > generate a lot of records that may end up with losing some of them.  =
And
> > > in that case the parallelism tracking would break.
>
> > I've counted SAMPLE/SWITCH events on perf make:
>
> > perf script --dump-unsorted-raw-trace | grep PERF_RECORD_SAMPLE | wc -l
> > 813829
> > perf script --dump-unsorted-raw-trace | grep PERF_RECORD_SWITCH | wc -l
> > 46249
>
> > And this is for:
> > perf record -e L1-dcache-load-misses,dTLB-load-misses make
>
> > perf script --dump-unsorted-raw-trace | grep PERF_RECORD_SAMPLE | wc -l
> > 1138615
> > perf script --dump-unsorted-raw-trace | grep PERF_RECORD_SWITCH | wc -l
> > 115433
>
> > Doesn't pretend to be scientifically accurate, but gives some idea
> > about proportion.
>
> > So for the number of samples that's 5% and 10% respectively.
> > SWITCH events are smaller (24 bytes vs 40 bytes for SAMPLE), so for
> > ring size it's 3-6%.
>
> > FWIW I've also considered and started implementing a different
> > approach where the kernel would count parallelism level for each
> > context and write it out with samples:
> > https://github.com/dvyukov/linux/commit/56ee1f638ac1597a800a30025f711ab=
496c1a9f2
> > Then sched_in/out would need to do atomic inc/dec on a global counter.
> > Not sure how hard it is to make all corner cases work there, I dropped
> > it half way b/c the perf record post-processing looked like a better
> > approach.
>
> > Lost SWITCH events may be a problem. Perf report already detects and
> > prints a warning about lost events. Should we stop reporting
> > parallelism/wall-clock if any events are lost? I just don't see it in
> > practice.
>
> > Kernel could write-out a bitmask of types of lost events in PERF_RECORD=
_LOST.
>
> right
>
> > > > The feature is added on an equal footing with the existing CPU prof=
iling
> > > > rather than a separate mode enabled with special flags. The reasoni=
ng is
> > > > that users may not understand the problem and the meaning of number=
s they
> > > > are seeing in the first place, so won't even realize that they may =
need
> > > > to be looking for some different profiling mode. When they are pres=
ented
> > > > with 2 sets of different numbers, they should start asking question=
s.
> > >
> > > I understand your point but I think it has some limitation so maybe i=
t's
> > > better to put in a separate mode with special flags.
>
> > I hate all options.
>
> > The 3rd option is to add a _mandary_ flag to perf record to ask for
> > profiling mode. Then the old "perf record" will say "nope, you need to
> > choose, here are your options and explanation of the options".
>
> Well, we have a line for tips about perf usage at the botton, for
> instance, when I ran 'perf report' to check it it showed:
>
> Tip: Add -I to perf record to sample register values, which will be visib=
le in perf report sample context.
>
> We could add a line with:
>
> Tip: Use '-s wallclock' to get wallclock/latency profiling

Thanks for the review!

This is an option too.
I am not very strong about the exact option we choose, I understand
what I proposed has downsides too.
I am ready to go with a solution we will agree on here.

> And when using it we could have another tip:
>
> Tip: Use 'perf config report.mode=3Dwallclock' to change the default
>
> =E2=AC=A2 [acme@toolbox pahole]$ perf config report.mode=3Dwallclock
> =E2=AC=A2 [acme@toolbox pahole]$ perf config report.mode
> report.mode=3Dwallclock
> =E2=AC=A2 [acme@toolbox pahole]$
>
> Or something along these lines.
>
> Or we could have a popup that would appear with a "Important notice",
> explaining the wallclock mode and asking the user to opt-in to having
> both, just one or keep the old mode, that would be a quick, temporary
> "annoyance" for people used with the current mode while bringing this
> cool new mode to the attention of users.

Is there an example of doing something similar in the code?


> Another idea, more general, is to be able to press some hotkey that
> would toggle available sort keys, like we have, for instance, 'k' to
> toggle the 'Shared object' column in the default 'perf report/top'
> TUI while filtering out non-kernel samples.
>
> But my initial feeling is that you're right and we want this wallclock
> column on by default, its just a matter of finding a convenient/easy way
> for users to opt-in.
>
> Being able to quickly toggle ordering by the Overhead/Wallclock columns
> also looks useful.

I've tried to do something similar, e.g. filtering by parallelism
level on-the-fly, thus this patch:
https://lore.kernel.org/linux-perf-users/CACT4Y+b8X7PnUwQtuU2QXSqumNDbN8pWD=
m8EX+wnvgNAKbW0xw@mail.gmail.com/T/#t
But it turned out the reload functionality is more broken than working.

I agree it would be nice to have these usability improvements.
But this is also a large change, so I would prefer to merge the basic
functionality, and then we can do some improvements on top. This is
also the first time I am touching perf code, there are too many new
things to learn for me.

> > If we add it as a new separate mode, I fear it's doomed to be
> > unknown/unused and people will continue to not realize what they are
> > profiling, meaning of numbers, and continue to use wrong profiles for
> > the job.
>
> > I consider latency/wall-clock profiling as useful and as fundamental
> > as the current bandwidth profiling for parallel workloads (more or
> > less all workloads today). Yet we are in 2025 and no profilers out
> > there support latency profiling. Which suggests to me there is a
> > fundamental lack of understanding of the matter, so new optional mode
> > may not work well.
>
> > If you are interested for context, I used a similar mode (for pprof at
> > the time) to optimize TensorFlow latency (people mostly care about
> > latency). All existing profilers said it's 99% highly optimized and
> > parallelized matrix multiplication, we are done here. Yet, the
> > wallclock profile said, nope, it's 45% Python interpreter, which
> > resulted in this fix:
> > https://github.com/soumith/convnet-benchmarks/commit/605988f847fcf261c2=
88abc2351597d71a2ee149
> > Full story and examples of these profiles are here:
> > https://github.com/dvyukov/perf-load
>
> Cool, I'm about to start vacation till Feb, 4, so will not be able to
> test all your work, but its important work that we definetely have to
> test and help in getting merged.
>
> Thanks!
>
> - Arnaldo
