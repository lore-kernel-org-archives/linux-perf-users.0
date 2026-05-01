Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120BD4A35;
	Fri,  1 May 2026 20:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777668877; cv=none; b=uKfqqrBYVoZkd46UQdUVjKxEegmv0/xFqvjWyGtHi1mwBcFzzHuNvHXQdghGbH6KWlR3A4Aa4FwGLVSGfYe5JzaMDgLfftJBxtzRGA5oirPpiCtiv9VOo/m+tEeBx5chl2ii52RjslA1MOmMKndP7qWQxUAWMcuqystT8f+Hp9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777668877; c=relaxed/simple;
	bh=HUVArn+yfCpWumqSctKlFUNZQZ0Ky6U86a2WG5XUzHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ri/5WPvWVbvvISJ3h4llIbewwIJ/BjfjUX8J3VANsQ/jXMZbHcsiPakcBWVQwUuc73vKjPLFFGL0ys4J/jwyOS4SQdhjtpgWQCM4n9CpmrhoqDqjOXYXL0NfBAt2KZAF1a1f6A+cmRNBGZ6yeq/PAbM6r1qgSG9xQ3CrsaSoVIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KbkxJOZ7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KbkxJOZ7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WuSyULbCtlAm9fbBRSiRwS+XlWVAcSA0jLynjnVSMFI=; b=KbkxJOZ7D65HmJhLtWvDPUbjE3
	X5/GkmUnCQ1gvIt5TDSakMsFAU8NauRJk/9B1F9XM5vz61ty/f9dMbdBUjM8DPMpskTwsWzw3d+xd
	g4p87Ivrn4XWrkt+G2j4L8MsCVna8tSasmTOH5wtLWxijb4G50dK5npA43ElzXcNeEVsKhTyq+C+p
	bs/UH1FeWHcE2uzwoRb/Y7IrCJ/OT5nAcBfk6BKMo4ok0Wur+W6uIQdvqeR0BSAhOm8zL97vJnfI5
	j+BDH0B+R0XlrzmXgFYBrMP6LhlNYczsHhE4ojEyPUg7k5YWoz0j++GavsffgtCDIZ1poY50KsdGU
	npOSTkmQ==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIus5-00000009Q8h-3Pwv;
	Fri, 01 May 2026 20:54:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 231DE3008E2; Fri, 01 May 2026 22:54:01 +0200 (CEST)
Date: Fri, 1 May 2026 22:54:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Calvin Owens <calvin@wbinvd.org>
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
Message-ID: <20260501205401.GI1026330@noisy.programming.kicks-ass.net>
References: <cover.1777483573.git.calvin@wbinvd.org>
 <33d87384aa5f96af76949d1399476779dd4f4fce.1777483573.git.calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33d87384aa5f96af76949d1399476779dd4f4fce.1777483573.git.calvin@wbinvd.org>

On Wed, Apr 29, 2026 at 10:36:11AM -0700, Calvin Owens wrote:
> The throttling logic in perf_sample_event_took() assumes the NMI is
> running at the maximum allowed sample rate. While this makes sense most
> of the time, it wildly overestimates the runtime of the NMI for the perf
> hardware watchdog:
> 
>     # bpftrace -e 'kprobe:perf_sample_event_took { \
> 	    printf("%s: cpu=%02d time_taken=%dns\n", \
> 	    strftime("%H:%M:%S.%f", nsecs), cpu(), arg0); }'
>     03:12:13.087003: cpu=00 time_taken=3190ns
>     03:12:13.486789: cpu=01 time_taken=2918ns
>     03:12:18.075288: cpu=03 time_taken=3308ns
>     03:12:19.797207: cpu=02 time_taken=2581ns
>     03:12:23.110317: cpu=00 time_taken=2823ns
>     03:12:23.510308: cpu=01 time_taken=2943ns
>     03:12:29.229348: cpu=03 time_taken=3669ns
>     03:12:31.656306: cpu=02 time_taken=3262ns
> 
> The NMI for the watchdog runs for 2-4us every ten seconds, but the
> math done in perf_sample_event_took() concludes it is running for
> 200-400ms every second!

For arguments sake, lets say this is an even 3us, this means we can run:

  250ms / 3us = 83333

such NMIs every second to consume 25% of CPU time. Which is in line with
the numbers it then reports no?

> When it is the only PMU event running, it can take minutes to hours of
> samples from the watchdog for the moving average to accumulate to
> something near the real mean, which causes the same little "litany" of
> sample rate throttles to happen every time Linux boots with the perf
> hardware watchdog enabled:
> 
>     perf: interrupt took too long (2526 > 2500), lowering kernel.perf_event_max_sample_rate to 79000
>     perf: interrupt took too long (3177 > 3157), lowering kernel.perf_event_max_sample_rate to 62000
>     perf: interrupt took too long (3979 > 3971), lowering kernel.perf_event_max_sample_rate to 50000
>     perf: interrupt took too long (4983 > 4973), lowering kernel.perf_event_max_sample_rate to 40000
> 
> This serves no purpose: it doesn't actually affect the runtime of the
> watchdog NMI at all. It confuses users, because it suggests their
> machine is spinning its wheels in interrupts when it isn't.
> 
> Because the watchdog NMI is so infrequent, we can avoid throttling it by
> making the throttling a two-step process: load and update a timestamp
> whenever we think we need to throttle, and only actually proceed to
> throttle if the last time that happened was less than one second ago.
> 
> This is inelegant, but it avoids touching the hot path and preserves
> current throttling behavior for real PMU use, at the cost of delaying
> the throttling by a single NMI.

This makes no sense, and it quite broken. There is no throttling and you
still need to update the numbers.

I'm thinking less AI and more real human should be involved here. If you
cannot make sense of neither the code nor the AI babbling, step away.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 6d1f8bad7e1c..c2a33cb194ce 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -623,6 +623,7 @@ core_initcall(init_events_core_sysctls);
>   */
>  #define NR_ACCUMULATED_SAMPLES 128
>  static DEFINE_PER_CPU(u64, running_sample_length);
> +static DEFINE_PER_CPU(u64, last_throttle_clock);
>  
>  static u64 __report_avg;
>  static u64 __report_allowed;
> @@ -643,6 +644,8 @@ void perf_sample_event_took(u64 sample_len_ns)
>  	u64 max_len = READ_ONCE(perf_sample_allowed_ns);
>  	u64 running_len;
>  	u64 avg_len;
> +	u64 last;
> +	u64 now;
>  	u32 max;
>  
>  	if (max_len == 0)
> @@ -663,6 +666,19 @@ void perf_sample_event_took(u64 sample_len_ns)
>  	if (avg_len <= max_len)
>  		return;
>  
> +	/*
> +	 * Very infrequent events like the perf counter hard watchdog
> +	 * can trigger spurious throttling: skip throttling if the prior
> +	 * NMI got here more than one second before this NMI began. But
> +	 * never skip throttling if NMIs are nesting, or if any NMI runs
> +	 * for longer than one second.
> +	 */
> +	now = local_clock();
> +	last = __this_cpu_read(last_throttle_clock);
> +	if (__this_cpu_cmpxchg(last_throttle_clock, last, now) == last &&
> +	    now - last > NSEC_PER_SEC && sample_len_ns < NSEC_PER_SEC)
> +		return;
> +
>  	__report_avg = avg_len;
>  	__report_allowed = max_len;
>  
> -- 
> 2.47.3
> 
