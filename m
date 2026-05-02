Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEB821ADA4
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777715577; cv=none; b=BVOqUkD7Z1OzgUIKfETw10lly9iBbIOdIQdKoh09C76qIrXQUpOd5df/D6v1EsCaysIWRjGe+aIzXEVkcEMOVNf+Gyx9YmthLw0Qu3ZLbmeLx/59LHd1PqanaU7gTXjkxFCaL8E2sG5d17TwJVqFk/LEsZ0cuvUk2JZRoRGt4b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777715577; c=relaxed/simple;
	bh=QHxTTD8XmSQIWUwHp1JDnPI2CIMaAel74hPOzsukc6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QA6Sxq3hi7TaJsVYMrebWviucYCho/L0TCmlsPKyXo2aHs5OHRheRMfhXxwODbJD3bpb6eW9REqVX04dwxDuab+X8q/kU0ukUhZNbaWZbfNLiybM6ZmjH+etPE83S+pOgz8SQA9LprWzO54JDfgU1G8b72nRensJ+Hgplrg0CUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=KpvtoQAG; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="KpvtoQAG"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c565dd3a7so4652281c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 02:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1777715575; x=1778320375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6cz43294rAwuqF9v3n0mSR+gWBTXJraUWX5QFwj+ydc=;
        b=KpvtoQAGri5v3j5zaSJX6ext9chjIOdVBJaHID6SbcPyp2D8kLN7U9g7qhfLb0o7AY
         vRIqUYAbqX5DqcRo6yPYTHdEU4rdYdWAROTNt9F84szI7rdkFu/YOawvuiAWEPMJmttQ
         dbwOU7/uS3btSvUXVUCAnwk8A+xmR/zq4v3oG7gDwmeWjuyhuZxMOoYEHqJGrbnMHnjw
         TwZBo0LrvMLj4Iib9ZtZ+Sol8AP1w+QtUob+5S+EPvaRw/B5A0RZbuTt10KE1vUCebbT
         4wBJ9j/sCa3Pw1FzJmp/ZyynyGfpIF8SqsHge8BLVLhQckuvxpCm85a2VXZMIX2sdD4K
         mLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777715575; x=1778320375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cz43294rAwuqF9v3n0mSR+gWBTXJraUWX5QFwj+ydc=;
        b=PkzEpG9/MKUn0UhhP3CzHwFpg0yVnsk556Nxixqbd+XFmuD6mkorSIlMyKcEd1imwP
         UBxiFbDurFUrilFRAHK5aXWogJg83iLQrCEmctC7ivSdz5MlvDQtvtNkJW6CUtdbrmhT
         Lsmw4aWkmsFGOU/DE3c7L5FZGqiqsYdIHle067VIzUeskg2/hIz5BWR4cwbbmxnxo+on
         Pk8vcAIWJC6ZMkchUlkiZ6vp7an/Fve8FU2H0aRjJvgLjMCBhgQgrsCs2n+qqTKSGuuN
         6Qjj6y8yNQELJQHI8yNgyYX5NDdti2NbMVgvU3yAv/kb/agpZHzKmuTuVqMGkjGH5fON
         jkNQ==
X-Forwarded-Encrypted: i=1; AFNElJ81PNGpgjZJ0UY+QZ+VVvWieynYIsB3szWgSc83rtlPjdQn5Powx9hoeUjwyCLhsPMpwKGYxYhWLHb7nLvU6nVe@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf5fWyboPsx1SqlxZjCkT7IpPL5ixHu5R1TAE3XUTxO0sGJRvW
	udQMRrRP9hOjKwoe/l9A9zGVdinBkke9QwhyVeNBv8WOzmV6QzolsGDpMg2Es11Wc7g=
X-Gm-Gg: AeBDies/BeofKGclMeWtsBU1QtAjOD6hKekeYiVIFHKUyDwUQDhYsmfX2wUn+B34MuF
	E2rnviINpqDiKjxJVJZD/EJiba3UMYHb4R90jDxhIYmV8fSzj+z+5JMghucwKdtkTeR0mbaCbA9
	31xCuOSwmzDjgg12WSENj4QsqfXD+QynMQ6Xe8cf2+cbPxvcaumeeR38ZUCAtDK+gPI4SZCrP2v
	SpGX35P4WDm7SmfIOSyk2zDfxXPmIHLWEv2wldeBpAHlVxBCrsjmLp9ZeVQSrcyf8K7XFFYlOg5
	eyHdb85HWXbxwiY49JlPcUMzHD65Yuk9gyF28V+q+hd8bTRqGkaJUWCXl592TJjk3CmWjOjUKYF
	Bp+lCU3oKact73mq0qiUadXsGcw40jYTQPZQmRJhDAhL0g9sCEAhjT33ZTt4JQv3Vl9H1eLtPEp
	u0MrFo4tVLC/ZxheLT1wI38ccrNQ7sbuEjgkRxoVucw31k1C4=
X-Received: by 2002:a05:7022:61a:b0:12b:ec67:3529 with SMTP id a92af1059eb24-12dfd7fc727mr1112526c88.14.1777715575210;
        Sat, 02 May 2026 02:52:55 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:cc0a:f07d:c605:769f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df828849dsm6105405c88.5.2026.05.02.02.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 02:52:54 -0700 (PDT)
Date: Sat, 2 May 2026 02:52:51 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 2/2] perf: Don't throttle based on NMI watchdog events
Message-ID: <afXJc2iftqAgc0Er@mozart.vkv.me>
References: <cover.1777483573.git.calvin@wbinvd.org>
 <33d87384aa5f96af76949d1399476779dd4f4fce.1777483573.git.calvin@wbinvd.org>
 <20260501205401.GI1026330@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260501205401.GI1026330@noisy.programming.kicks-ass.net>

On Friday 05/01 at 22:54 +0200, Peter Zijlstra wrote:
> On Wed, Apr 29, 2026 at 10:36:11AM -0700, Calvin Owens wrote:
> > The throttling logic in perf_sample_event_took() assumes the NMI is
> > running at the maximum allowed sample rate. While this makes sense most
> > of the time, it wildly overestimates the runtime of the NMI for the perf
> > hardware watchdog:
> > 
> >     # bpftrace -e 'kprobe:perf_sample_event_took { \
> > 	    printf("%s: cpu=%02d time_taken=%dns\n", \
> > 	    strftime("%H:%M:%S.%f", nsecs), cpu(), arg0); }'
> >     03:12:13.087003: cpu=00 time_taken=3190ns
> >     03:12:13.486789: cpu=01 time_taken=2918ns
> >     03:12:18.075288: cpu=03 time_taken=3308ns
> >     03:12:19.797207: cpu=02 time_taken=2581ns
> >     03:12:23.110317: cpu=00 time_taken=2823ns
> >     03:12:23.510308: cpu=01 time_taken=2943ns
> >     03:12:29.229348: cpu=03 time_taken=3669ns
> >     03:12:31.656306: cpu=02 time_taken=3262ns
> > 
> > The NMI for the watchdog runs for 2-4us every ten seconds, but the
> > math done in perf_sample_event_took() concludes it is running for
> > 200-400ms every second!
> 
> For arguments sake, lets say this is an even 3us, this means we can run:
> 
>   250ms / 3us = 83333
> 
> such NMIs every second to consume 25% of CPU time. Which is in line with
> the numbers it then reports no?

The watchdog NMI latency is not remotely predictive of the "real" NMI
latency in the way I think you're assuming.

These are watchdog NMIs on a znver4 machine:

    17:50:15.322551: cpu=11 time_taken=3878ns
    17:50:15.624184: cpu=02 time_taken=3547ns
    17:50:15.756226: cpu=15 time_taken=3817ns
    17:50:15.826175: cpu=19 time_taken=3386ns

...vs the "real thing" with perf running on the same machine:

    02:21:02.801929: cpu=13 time_taken=321ns
    02:21:02.801937: cpu=24 time_taken=270ns
    02:21:02.801966: cpu=23 time_taken=461ns
    02:21:02.801971: cpu=12 time_taken=310ns

This machine ends up with a lower perf_event_max_sample_rate when the
hardware watchdog is enabled, because of this effect (which obviously
varies a lot with what options you pass to perf).

But the point I was trying to make is that perf_event_max_sample_rate is
completely orthogonal to the 0.1hz watchdog NMI.

The current logic updates a sysctl that can have no possible effect on
the watchdog, based on an extrapolated worst case from the watchdog,
that cannot possibly actually occur with the watchdog. That seems
fundamentally silly to me.

I only actually care because it is user visible in the form of the
random confusing throttling messages. I don't care that
perf_event_max_sample_rate ends up artifically lower, and I didn't try
to fix that.

> > When it is the only PMU event running, it can take minutes to hours of
> > samples from the watchdog for the moving average to accumulate to
> > something near the real mean, which causes the same little "litany" of
> > sample rate throttles to happen every time Linux boots with the perf
> > hardware watchdog enabled:
> > 
> >     perf: interrupt took too long (2526 > 2500), lowering kernel.perf_event_max_sample_rate to 79000
> >     perf: interrupt took too long (3177 > 3157), lowering kernel.perf_event_max_sample_rate to 62000
> >     perf: interrupt took too long (3979 > 3971), lowering kernel.perf_event_max_sample_rate to 50000
> >     perf: interrupt took too long (4983 > 4973), lowering kernel.perf_event_max_sample_rate to 40000
> >
> > This serves no purpose: it doesn't actually affect the runtime of the
> > watchdog NMI at all. It confuses users, because it suggests their
> > machine is spinning its wheels in interrupts when it isn't.
> > 
> > Because the watchdog NMI is so infrequent, we can avoid throttling it by
> > making the throttling a two-step process: load and update a timestamp
> > whenever we think we need to throttle, and only actually proceed to
> > throttle if the last time that happened was less than one second ago.
> > 
> > This is inelegant, but it avoids touching the hot path and preserves
> > current throttling behavior for real PMU use, at the cost of delaying
> > the throttling by a single NMI.
> 
> This makes no sense, and it quite broken. There is no throttling and you
> still need to update the numbers.

The ewma is updated above the patch context, that behavior doesn't
change at all.

Are you seeing __report_avg below it? That's for the deferred printk().

I don't understand what "there is no throttling" means here, sorry.

In practice this all works exactly the way I'm describing, the
throttling happens immmediately the first time perf is actually used on
the system:

    10:24:55 mahler kernel: perf: interrupt took too long (2503 > 2500), lowering kernel.perf_event_max_sample_rate to 79000
    10:24:55 mahler kernel: perf: interrupt took too long (3178 > 3128), lowering kernel.perf_event_max_sample_rate to 62000
    10:24:55 mahler kernel: perf: interrupt took too long (3974 > 3972), lowering kernel.perf_event_max_sample_rate to 50000

...instead of randomly over the first hour of uptime like it does today:

    15:55:44 mahler kernel: perf: interrupt took too long (2518 > 2500), lowering kernel.perf_event_max_sample_rate to 79000
    16:00:23 mahler kernel: perf: interrupt took too long (3163 > 3147), lowering kernel.perf_event_max_sample_rate to 63000
    16:10:18 mahler kernel: perf: interrupt took too long (3978 > 3953), lowering kernel.perf_event_max_sample_rate to 50000

This random throttling after boot isn't unique to my machines: most bare
metal servers I've interacted with over 10+ years do this. If I had a
nickel for every time somebody asked me why it happens when perf isn't
running, I could almost afford to pay what it cost google to give us
that worthless LLM review :)

> I'm thinking less AI and more real human should be involved here. If you
> cannot make sense of neither the code nor the AI babbling, step away.

The only LLM involved at all here is this one autoreview bot from google
that didn't ask for my permission to be involved.

I was simply trying to be generous by engaging with it. Generally, I've
been impressed with it, but in this particular case I feel strongly it's
been actively worse than nothing.

I will ignore it completely in the future when sending you patches.

> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 6d1f8bad7e1c..c2a33cb194ce 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -623,6 +623,7 @@ core_initcall(init_events_core_sysctls);
> >   */
> >  #define NR_ACCUMULATED_SAMPLES 128
> >  static DEFINE_PER_CPU(u64, running_sample_length);
> > +static DEFINE_PER_CPU(u64, last_throttle_clock);
> >  
> >  static u64 __report_avg;
> >  static u64 __report_allowed;
> > @@ -643,6 +644,8 @@ void perf_sample_event_took(u64 sample_len_ns)
> >  	u64 max_len = READ_ONCE(perf_sample_allowed_ns);
> >  	u64 running_len;
> >  	u64 avg_len;
> > +	u64 last;
> > +	u64 now;
> >  	u32 max;
> >  
> >  	if (max_len == 0)
> > @@ -663,6 +666,19 @@ void perf_sample_event_took(u64 sample_len_ns)
> >  	if (avg_len <= max_len)
> >  		return;
> >  
> > +	/*
> > +	 * Very infrequent events like the perf counter hard watchdog
> > +	 * can trigger spurious throttling: skip throttling if the prior
> > +	 * NMI got here more than one second before this NMI began. But
> > +	 * never skip throttling if NMIs are nesting, or if any NMI runs
> > +	 * for longer than one second.
> > +	 */
> > +	now = local_clock();
> > +	last = __this_cpu_read(last_throttle_clock);
> > +	if (__this_cpu_cmpxchg(last_throttle_clock, last, now) == last &&
> > +	    now - last > NSEC_PER_SEC && sample_len_ns < NSEC_PER_SEC)
> > +		return;
> > +
> >  	__report_avg = avg_len;
> >  	__report_allowed = max_len;
> >  
> > -- 
> > 2.47.3
> > 
