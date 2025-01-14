Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF6F284A5B
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736843234; cv=none; b=ilyb801Y01qfz+rDb5ITDSMBtt1mMigBtQm9rzzTXtoi9yaLHAzPNCYiB9oxjNoTZJYeg/he702qEfbs/UAuoB/ydfola0NC4yYShdlVw5VVEn1wge+GvBzyZNnDr+zajy8fDIvH5aMNWre2KOayJW7bZvUgVQ5kEt76fGAu7TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736843234; c=relaxed/simple;
	bh=alQhx/HidHOuDkSoWj9O6s8MbEAAMi4h0ucFoJa2PpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEa2Q7rKPhgzB9oTjjcSVXUSbFYGqjNtxANPlTdhXVuMTNMof9vKjleu8aU4JNsEH+vRNNCu6f9fxMZHxDMnQhjlnCbvVE8dYK6ACpUX1/SgAedez2x58yQn7OrGnxfAEh59xrpsRRArzSy8W2y+nYiKDoqODV+lBoRYCjny3/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lTLZF4XF; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lTLZF4XF"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3011c7b39c7so47678481fa.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 00:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736843229; x=1737448029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bqsVz3khWPf+VC7qfdwlncs454IG/BHSA8BMC4Zu7hk=;
        b=lTLZF4XFjfO05jXkyAuqFsJrrxGaH+WZ8LlczxqbMXtfB0rJ+jVbpghGNGa/4x/zBK
         DqkdLdjDkp2J7xNUxaBVGFDclk61Al9A4exWl0s9nhPK9wBQ1siOn1r2ATKSNCYwwtK7
         EWk2uCcOkeFpyW9Vo/t+fO4UPhyUfXXJ1sOfjMhfAhi8X0XXRgN7/vCr2FMLMD/iAE5/
         9CqcM44JQPqIYgjNIP/2vLx4jIf+ot2NORL/WTZvfIxUsVQnKTRYOgPHqAAMmcJB805Q
         hk7hkhH/ZM7UG0ejN9/fSgltWw71GueK+U/OiXZQHxtwWuD4fBLZZuc0r2wh6w0fOvAu
         P7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736843229; x=1737448029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqsVz3khWPf+VC7qfdwlncs454IG/BHSA8BMC4Zu7hk=;
        b=V1S+xDwi1x4BM09szYBg7OS9uHRqkpQZxYxH2bk3Iu3dHLoc6gxzKmgbq0Vl28f/El
         P5fDg8lqdDT2Lj2Vl3cI1LugsU9Bzf+RA/wu0GxaHaLhfDpOQssIOsVZ+n9YR4L4CuOp
         jEuWqzJuOEtmU2SlpCsyLjls8yX2ot6q5otNn2jJAZJx2fLJj8/rLagw2JzOy4dikWOE
         oMOF2NGrmWLNp+Mq1s2NkPAdEMTXsDuqYbWurIn9EdUplJBfVz2GgVK4W+LiPeXoxIWx
         /zTDK1QNlMHp/GE0MgEXbyVrbzPFqotMoCM9g4XnZQrhDXxB1sQqSgFRSAAbUSxhpCAb
         CMTw==
X-Forwarded-Encrypted: i=1; AJvYcCV6YneMO4XArDDvwdAc6Ppbyce4WpNuz1J6DVxWmnN3BhtDqKgem5I3/BRf1g3pzTR6OU5WNUUptg1PPefhEX8g@vger.kernel.org
X-Gm-Message-State: AOJu0YwFBJ74/L76WcWtEIHo/M8VA0nisbN8TVpTp3WLUYpn+3jEzPZv
	pqSmIPQfZ6WUWSrmDKRWNU2UZuR3PfldhZ+4+ZMNEX74RvlWFA7h7nk7VJXquS7FtGO8KnFKP8E
	Xi+Q5SdQVTMX9aOd7Pc84AyqfJo8mLwwwMNJPf5CdZGJ8Re8KRpUr
X-Gm-Gg: ASbGnct2IAYBjg35CZmZ2pBviHAVg+nUqlpZwfkWnCfUxorDF7oqEy34hSkRnaQdSyu
	28S/0s0UYHQdBgl3tJfMpReH/pkYkTHKb97mxSipFzGerNekfvTI9J5c1CRPWFD8VqV/hoQ==
X-Google-Smtp-Source: AGHT+IGOGoFA8xLyTYmbh7lsP9eNkpgL/I1kJbLf4BJ/SRACx4vgk5Gnv9IWlrz5VWr0FdrJeOwUjPNAJa6mKIuNIXY=
X-Received: by 2002:a05:651c:a0a:b0:300:360b:bc3f with SMTP id
 38308e7fff4ca-305f4543372mr75241131fa.15.1736843229172; Tue, 14 Jan 2025
 00:27:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACT4Y+b4WYa9TSqKtDKTJNgXth1U30=KddutfSdp5gmXVOV_jA@mail.gmail.com>
 <20250113134022.2545894-1-dvyukov@google.com> <Z4XDJyvjiie3howF@google.com>
In-Reply-To: <Z4XDJyvjiie3howF@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 14 Jan 2025 09:26:57 +0100
X-Gm-Features: AbW1kvbze9XZQFH84FDb-omaE5OkiVew0biJD3z7b3Mpr5fS0tQijzDH_DgHaeY
Message-ID: <CACT4Y+b96xynNaZoBHP72-4tJM5Nzo3MBRW19_E7JsMKRWYCzg@mail.gmail.com>
Subject: Re: [PATCH v2] perf report: Add wall-clock and parallelism profiling
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eranian@google.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Jan 2025 at 02:51, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Mon, Jan 13, 2025 at 02:40:06PM +0100, Dmitry Vyukov wrote:
> > There are two notions of time: wall-clock time and CPU time.
> > For a single-threaded program, or a program running on a single-core
> > machine, these notions are the same. However, for a multi-threaded/
> > multi-process program running on a multi-core machine, these notions are
> > significantly different. Each second of wall-clock time we have
> > number-of-cores seconds of CPU time.
> >
> > Currently perf only allows to profile CPU time. Perf (and all other
> > existing profilers to the be best of my knowledge) does not allow to
> > profile wall-clock time.
> >
> > Optimizing CPU overhead is useful to improve 'throughput', while
> > optimizing wall-clock overhead is useful to improve 'latency'.
> > These profiles are complementary and are not interchangeable.
> > Examples of where wall-clock profile is needed:
> >  - optimzing build latency
> >  - optimizing server request latency
> >  - optimizing ML training/inference latency
> >  - optimizing running time of any command line program
> >
> > CPU profile is useless for these use cases at best (if a user understands
> > the difference), or misleading at worst (if a user tries to use a wrong
> > profile for a job).
> >
> > This patch adds wall-clock and parallelization profiling.
> > See the added documentation and flags descriptions for details.
> >
> > Brief outline of the implementation:
> >  - add context switch collection during record
> >  - calculate number of threads running on CPUs (parallelism level)
> >    during report
> >  - divide each sample weight by the parallelism level
> > This effectively models that we were taking 1 sample per unit of
> > wall-clock time.
>
> Thanks for working on this, very interesting!
>
> But I guess this implementation depends on cpu-cycles event and single
> target process.

Not necessarily, it works the same for PMU events, e.g. again from perf make:

Samples: 481K of event 'dTLB-load-misses', Event count (approx.): 169413440
Overhead  Wallclock  Command          Symbol
   5.34%     16.33%  ld               [.] bfd_elf_link_add_symbols
   4.14%     14.99%  ld               [.] bfd_link_hash_traverse
   3.53%     10.87%  ld               [.] __memmove_avx_unaligned_erms
   1.61%      0.05%  cc1              [k] native_queued_spin_lock_slowpath
   1.47%      0.09%  cc1              [k] __d_lookup_rcu
   1.38%      0.55%  sh               [k] __percpu_counter_sum
   1.22%      0.11%  cc1              [k] __audit_filter_op
   0.95%      0.08%  cc1              [k] audit_filter_rules.isra.0
   0.72%      0.47%  sh               [k] pcpu_alloc_noprof

And also it works well for multi-process targets, again most examples
in the patch are from kernel make.

> Do you think if it'd work for system-wide profiling?

Currently it doesn't b/c system-wide emits PERF_RECORD_SWITCH_CPU_WIDE
instead of PERF_RECORD_SWITCH which this patch handles.

It can be made to work, I just didn't want to complicate this patch more.
It can work as is, if the system activity includes mostly a single
task, e.g. you run something on command line, it's taking too long, so
you decide to do perf record -a in parallel to see what it's doing.

For system-wide profiling we do Google (GWP), it may need some
additional logic to make it useful. Namely, the system-wide
parallelism is not useful in multi-task contexts. But we can extend
report to allow us to calculate parallelism/wall-clock overhead for a
single multi-threaded process only. Or, if we auto-matically
post-process system-wide profile, then we can split the profile
per-process and calculate parallelism for each of them.

I am also not sure if we use perf report for GWP, or do manual trace
parsing. When/if this part is merged, we can think of the system-wide
story.

TODO: don't enable context-switch recording for -a mode.


> How do you define wall-clock overhead if the event counts something
> different (like the number of L3 cache-misses)?

It's the same. We calculate CPU overhead for these. Wallclock overhead
is the same, it's just the weights are adjusted proportionally.

Physical meaning is similar:
CPU overhead: how much L3 misses affect throughput/cpu consumption
Wallclock overhead: how much L3 misses affect latency


> Also I'm not sure about the impact of context switch events which could
> generate a lot of records that may end up with losing some of them.  And
> in that case the parallelism tracking would break.

I've counted SAMPLE/SWITCH events on perf make:

perf script --dump-unsorted-raw-trace | grep PERF_RECORD_SAMPLE | wc -l
813829
perf script --dump-unsorted-raw-trace | grep PERF_RECORD_SWITCH | wc -l
46249

And this is for:
perf record -e L1-dcache-load-misses,dTLB-load-misses make

perf script --dump-unsorted-raw-trace | grep PERF_RECORD_SAMPLE | wc -l
1138615
perf script --dump-unsorted-raw-trace | grep PERF_RECORD_SWITCH | wc -l
115433

Doesn't pretend to be scientifically accurate, but gives some idea
about proportion.
So for the number of samples that's 5% and 10% respectively.
SWITCH events are smaller (24 bytes vs 40 bytes for SAMPLE), so for
ring size it's 3-6%.

FWIW I've also considered and started implementing a different
approach where the kernel would count parallelism level for each
context and write it out with samples:
https://github.com/dvyukov/linux/commit/56ee1f638ac1597a800a30025f711ab496c1a9f2
Then sched_in/out would need to do atomic inc/dec on a global counter.
Not sure how hard it is to make all corner cases work there, I dropped
it half way b/c the perf record post-processing looked like a better
approach.

Lost SWITCH events may be a problem. Perf report already detects and
prints a warning about lost events. Should we stop reporting
parallelism/wall-clock if any events are lost? I just don't see it in
practice.
Kernel could write-out a bitmask of types of lost events in PERF_RECORD_LOST.




> > The feature is added on an equal footing with the existing CPU profiling
> > rather than a separate mode enabled with special flags. The reasoning is
> > that users may not understand the problem and the meaning of numbers they
> > are seeing in the first place, so won't even realize that they may need
> > to be looking for some different profiling mode. When they are presented
> > with 2 sets of different numbers, they should start asking questions.
>
> I understand your point but I think it has some limitation so maybe it's
> better to put in a separate mode with special flags.

I hate all options.

The 3rd option is to add a _mandary_ flag to perf record to ask for
profiling mode. Then the old "perf record" will say "nope, you need to
choose, here are your options and explanation of the options".

If we add it as a new separate mode, I fear it's doomed to be
unknown/unused and people will continue to not realize what they are
profiling, meaning of numbers, and continue to use wrong profiles for
the job.

I consider latency/wall-clock profiling as useful and as fundamental
as the current bandwidth profiling for parallel workloads (more or
less all workloads today). Yet we are in 2025 and no profilers out
there support latency profiling. Which suggests to me there is a
fundamental lack of understanding of the matter, so new optional mode
may not work well.

If you are interested for context, I used a similar mode (for pprof at
the time) to optimize TensorFlow latency (people mostly care about
latency). All existing profilers said it's 99% highly optimized and
parallelized matrix multiplication, we are done here. Yet, the
wallclock profile said, nope, it's 45% Python interpreter, which
resulted in this fix:
https://github.com/soumith/convnet-benchmarks/commit/605988f847fcf261c288abc2351597d71a2ee149
Full story and examples of these profiles are here:
https://github.com/dvyukov/perf-load
