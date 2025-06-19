Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBFA21B199;
	Thu, 19 Jun 2025 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750349251; cv=pass; b=Z03e2xrFB/pT1FAoGBhEtWsv+tTHuZmTMnBfwtxbKMLPiC/trTCkFYYuZEuJSGrlGEStz+Zq/d9EFUD5pOdm+7CbxD/BNXe1+J1n14uPoISUlJ2IUqss3SLrbgDWDrYew9UYTxgI1l6z6FguX2D5FBQszRrA9ujcBkYeaQCZJ6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750349251; c=relaxed/simple;
	bh=3+Xuhdf6Kssq1TFc5oYH23jd0qOsfvjkWvNPq+buGZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeCZoi1YtrMhuALRF+Inmv1o6OLjURqxhUUtqpsgg3kebvF+560hA4lL0jABqmZIK7+ksH5SOUtw5jeyW1uak0Yl7mH5VW6f+96zDPhdNGEH/GhbwlzM+1Q1m1YnnQmVbDVejI5pD5Ori2Re2bcfUs2xpTLtIYgmLOGaIbj6xzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Fft7ZU7C; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Fft7ZU7C"
ARC-Seal: i=1; a=rsa-sha256; t=1750349217; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HwjYJLfVxixp1rFTfPhG7wRVgRniGhGZF10AkIWW+5YvDAZw9ToN65eUJNuplOGigAlXVNq07uJCg0zVTQZCeiXILdoNf71m8eo1CfHofBC6VZASSdnQwyvlAj24GSrKLlu2EZEAxS3NxAnTo1GgA+FjYbeqyimcOUlEZ6bl7Pc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750349217; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pxqu3E44/0GSwwJ5PYf0KhqaPMCtqpMk6nn3VAYANHo=; 
	b=WXWSFnGTEg40bxzmDhiVz3ATOaNyc9Mu+J4kPnFv64rZSyfQKlNfYCKoz+7t83wrZBJGJpp7d8LcDbyqCj+G1W8r5/dYIyrbQacFLjg3Lo4xr6Vw70r/k+YfWdpbsd3TqrjveHb6mP+QM82AvAcvxUbx+Ur/tI+JF1TITuYoK2g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750349217;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=pxqu3E44/0GSwwJ5PYf0KhqaPMCtqpMk6nn3VAYANHo=;
	b=Fft7ZU7CRLfKtrqQkGh+o1TXMCMaOtIuDxlw55uqwJcdWl7HrhKqf1otg7PR+m+L
	3z0dR5P084iANTkftTFXL2XC73xXlsbNcdoJLIZMl5Q38d5bpDsd0GDr2Uqx+4FcLeV
	xzsoHj8uyA8ZTxqfVmJ6wGmSGlt5qcOQJQSkaCFQ=
Received: by mx.zohomail.com with SMTPS id 1750349214510263.96755658893346;
	Thu, 19 Jun 2025 09:06:54 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, kernel@collabora.com,
 Jonathan Corbet <corbet@lwn.net>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/headers: Document PERF_PMU_CAP capability flags
Date: Thu, 19 Jun 2025 18:06:50 +0200
Message-ID: <2518748.tdWV9SEqCh@workhorse>
In-Reply-To: <20250619145044.GL1613376@noisy.programming.kicks-ass.net>
References:
 <20250618-perf-pmu-cap-docs-v1-1-0d34387d6e47@collabora.com>
 <20250619145044.GL1613376@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hello,

On Thursday, 19 June 2025 16:50:44 Central European Summer Time Peter Zijlstra wrote:
> 
> Mark just linked this thread from another thread:
> 
>   https://lkml.kernel.org/r/20250619144254.GK1613376@noisy.programming.kicks-ass.net
> 
> 
> On Wed, Jun 18, 2025 at 09:08:34PM +0200, Nicolas Frattaroli wrote:
> 
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index ec9d96025683958e909bb2463439dc69634f4ceb..7d749fd5225be12543df6e475277563bf16c05b1 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -294,16 +294,90 @@ struct perf_event_pmu_context;
> >  /**
> >   * pmu::capabilities flags
> >   */
> > +
> > +/**
> > + * define PERF_PMU_CAP_NO_INTERRUPT - \
> > + *    PMU is incapable of generating hardware interrupts
> > + */
> >  #define PERF_PMU_CAP_NO_INTERRUPT	0x0001
> 
> This is not quite right; CAP_NO_INTERRUPT means it is not able to
> generate samples.
> 
> While not being able to generate interrupts and not being able to
> generate sample is more or less the same for CPU PMU drivers, this is
> not true for uncore drivers. Even if an uncore driver has interrupt
> capacility to help with counter overflow, it cannot generate samples.

I'll send a follow-up v2 to fix this, though just to make sure I
understand this right, I have some questions for clarification.

Does "uncore" in this context mean PMU drivers for counters that are not
tied to the CPU instruction flow, but are counting other things like
interconnect statistics?

Also, am I correct in assuming "sample" in this context means the
concept represented by struct perf_sample_data, i.e. what appears to be
a snapshot of current process context, including registers and stack
information? Which would then mean going by my understanding of uncore
that basically every uncore driver should set this capability flag, as
they're not performance counter registers on a CPU that are intimately
tied to the ISAs execution state.

To further my understanding: does this mean that
drivers/devfreq/event/rockchip-dfi.c (used for measuring memory
bandwidth) should set PERF_PMU_CAP_NO_INTERRUPT, since it's not a CPU
but a memory controller monitor?

In a more general sense, if anyone has any written resources on writing
PMU drivers, rather than perf from a userspace perspective, I'd be very
happy to get some pointers in their direction.

> 
> > +/**
> > + * define PERF_PMU_CAP_NO_NMI - \
> > + *    PMU is guaranteed to not generate non-maskable interrupts
> > + */
> >  #define PERF_PMU_CAP_NO_NMI		0x0002
> > +/**
> > + * define PERF_PMU_CAP_AUX_NO_SG - \
> > + *    PMU does not support using scatter-gather as the output
> > + *
> > + * The PERF_PMU_CAP_AUX_NO_SG flag indicates that the PMU does not support
> > + * scatter-gather for its output buffer, and needs a larger contiguous buffer
> > + * to output to.
> > + */
> >  #define PERF_PMU_CAP_AUX_NO_SG		0x0004
> > +/**
> > + * define PERF_PMU_CAP_EXTENDED_REGS - \
> > + *    PMU is capable of sampling extended registers
> > + *
> > + * Some architectures have a concept of extended registers, e.g. XMM0 on x86
> > + * or VG on arm64. If the PMU is capable of sampling these registers, then the
> > + * flag PERF_PMU_CAP_EXTENDED_REGS should be set.
> > + */
> >  #define PERF_PMU_CAP_EXTENDED_REGS	0x0008
> > +/**
> > + * define PERF_PMU_CAP_EXCLUSIVE - \
> > + *    PMU can only have one scheduled event at a time
> > + *
> > + * Certain PMU hardware cannot track several events at the same time. Such
> > + * hardware must set PERF_PMU_CAP_EXCLUSIVE in order to avoid conflicts.
> > + */
> >  #define PERF_PMU_CAP_EXCLUSIVE		0x0010
> > +/**
> > + * define PERF_PMU_CAP_ITRACE - PMU traces instructions
> > + *
> > + * Some PMU hardware does instruction tracing, in that it traces execution of
> > + * each instruction. Setting this capability flag makes the perf core generate
> > + * a %PERF_RECORD_ITRACE_START event, recording the profiled task's PID and TID,
> > + * to allow tools to properly decode such traces.
> > + */
> >  #define PERF_PMU_CAP_ITRACE		0x0020
> > +/**
> > + * define PERF_PMU_CAP_NO_EXCLUDE - \
> > + *    PMU is incapable of excluding events based on context
> > + *
> > + * Some PMU hardware will count events regardless of context, including e.g.
> > + * idle, kernel and guest. Drivers for such hardware should set the
> > + * PERF_PMU_CAP_NO_EXCLUDE flag to explicitly advertise that they're unable to
> > + * help themselves, so that the perf core can reject requests to exclude events
> > + * based on context.
> > + */
> >  #define PERF_PMU_CAP_NO_EXCLUDE		0x0040
> 
> More to the point might be saying that it will reject any event that
> has: perf_event_attr::exclude_{user,kernel,hv,idle,host,guest} set.

I'll reword it around that, thanks.

Kind regards,
Nicolas Frattaroli

> 
> > +/**
> > + * define PERF_PMU_CAP_AUX_OUTPUT - PMU non-AUX events generate AUX data
> > + *
> > + * Drivers for PMU hardware that supports non-AUX events which generate data for
> > + * AUX events should set PERF_PMU_CAP_AUX_OUTPUT. This flag tells the perf core
> > + * to schedule non-AUX events together with AUX events, so that this data isn't
> > + * lost.
> > + */
> >  #define PERF_PMU_CAP_AUX_OUTPUT		0x0080
> > +/**
> > + * define PERF_PMU_CAP_EXTENDED_HW_TYPE - \
> > + *    PMU supports PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
> > + */
> >  #define PERF_PMU_CAP_EXTENDED_HW_TYPE	0x0100
> > +/**
> > + * define PERF_PMU_CAP_AUX_PAUSE - \
> > + *    PMU can pause and resume AUX area traces based on events
> > + */
> >  #define PERF_PMU_CAP_AUX_PAUSE		0x0200
> > +/**
> > + * define PERF_PMU_CAP_AUX_PREFER_LARGE - PMU prefers contiguous output buffers
> > + *
> > + * The PERF_PMU_CAP_AUX_PREFER_LARGE capability flag is a less strict variant of
> > + * %PERF_PMU_CAP_AUX_NO_SG. PMU drivers for hardware that doesn't strictly
> > + * require contiguous output buffers, but find the benefits outweigh the
> > + * downside of increased memory fragmentation, may set this capability flag.
> > + */
> >  #define PERF_PMU_CAP_AUX_PREFER_LARGE	0x0400
> >  
> >  /**
> > 
> > ---
> > base-commit: 31d56636e10e92ced06ead14b7541867f955e41d
> > change-id: 20250618-perf-pmu-cap-docs-a13e4ae939ac
> > 
> > Best regards,
> 




