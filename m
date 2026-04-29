Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A643783C0
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 22:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777500542; cv=none; b=UEJ/aIPssUXG24wLxIW6E1MY5VlzVnqXLJmFmjSgTrfTdZOLPQiY00OGf6ZMyS2rGhNfO/4SWM0tiol2BqCdpbpKdby3p0ITa+Z2afKiG51OoWBYa/9BD8O5vnEN6FK3I+dNY1tP0yrF/hAbx0FhIRqgn7o8MAAjWG/QOo0HnnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777500542; c=relaxed/simple;
	bh=fmC8hPt0PqoJ0yDnqCyUXJ5uhT7agsMopwRc0E9GcYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtNn60jgt/NaBSktKBU73+EEfNge/dXUTvO8ybI/yx/5PIDpQysKJKdvTSnifRCrnsCefrRpzdN86v6fBUUQ1uvGaT0wLvl9PapdU8Q02eevzT7Pewv8ae6Eou+SyISuMOCLb7Ssq/xoz+xjLGHLwNCLnN9xJzIruFIrQfvxD4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=Z9+KOtSk; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="Z9+KOtSk"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso338009eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 15:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1777500540; x=1778105340; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qvYg/ixIZDCkI7U8fGtAX/BRgdyvNJxMZeX0/fD9pIc=;
        b=Z9+KOtSktVUKzW1FN9ARHwMZeVlAt7kkIKnACaWLkNoeMPGWkP6RQPiSCv1P7Lx6H/
         19BnMx7l3X3QFrRiJIBwbEWTZPNivU+5+GHtYs7Qh42CYb3242UsbqGre/IMyDRw1+eI
         JznANtOIjp97kITyzZGgASOSgj0+vkL/r1u8yBFRc+AC0BiIu+tCmfQZOFeMBfjwJ/ag
         LfwKupC9oYbZPCLvqra2oxETiGGfz3XKjU66eJiPny24PwhKEgJ2WIFmjhY/lPyFGXMo
         WZBsr+cAsf4ytF43PIMu8KYgaaF/U0bEteyz+2tJXhz9JCg+Y7leWtu+rxoA0FxuZuef
         qtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777500540; x=1778105340;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvYg/ixIZDCkI7U8fGtAX/BRgdyvNJxMZeX0/fD9pIc=;
        b=NiBArCIV5A+M7owwbBT18d7XcgdYlPeJoATJCA/AunotZZgMH1VMM6+/nFVkAWzn3R
         yngGCg4OGQmqWbo1YKvtYLATVHapY0F+vcSB4ECtqfYgwYX0jOa8DinY5PU08sSRGSE6
         9dWU4IRSIVlR5M+9r8j01RUBpfGNRXgmNnq2vcolfzSPARIakvVhf1DDTZ5ICtHOEMYz
         yJ4aAyQ6bKade4X0bQaY12+5vuHOyIbdBQDCYCE4NeUnc/qzHfQooF/38fNQoLkDJGBM
         RDP1HYEcPqJJE7JiKzWtdQbi6n/JNGhckCyAMnqTtN2NnmAd9cotxNZfhuWe4kW5TrL5
         EMcw==
X-Gm-Message-State: AOJu0YymJh2/J379761jsSaEqdzCas82/vbMhb33Q5wY4/KzDzImvzSK
	kiEIMQLf23SfUcE3vFOMcoUeeeeaNIlKXcZEK94XqCw30juDIy6fzwNaqd5FjAfOZ90=
X-Gm-Gg: AeBDiev2NswShSXppo3IawynZnCeLxppobit6bBRGv9I63hg5rIdYefr+kd/RYn0eh2
	RyO7UxDzX283H0OfaVV22nt413Ai25nWkLHINfn/3rYz7N0XaXjpmEWZDCfQobRZjmvYob1ZQ56
	7jTtbPifKkuUTFLPQMMl/gj+xz6hCAJ3GdPPWQWVN7ZanbDficXBvrJMbkrtRqpjz7PIBGYjA2T
	2CODcTUDoeIUegbtNvQXzmxZdSRhT3iE8sV8blrJD9zECw1taqQxqwYhvqMzyR46qTf9PgNzTaB
	U9v5URggbBcV/L8R30gwPhY8vK2WsQx97s81PRcfXLbfINzEJdcFiXA0pL66ysl1rDIPraBiSBh
	Xh57BlKcqS6BRA3f8MiHnNbGZECMTr3e8hSXC+PQk1RqrH3K6xRWvfMbfOE7Xmm7UjZnx/HEATM
	a1XDRBns8zBf30PFrDCpnlzRcKwxGbwnjtMfte
X-Received: by 2002:a05:7300:c8c:b0:2d3:9c91:6c45 with SMTP id 5a478bee46e88-2ed3dcb9f72mr68746eec.6.1777500539760;
        Wed, 29 Apr 2026 15:08:59 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:e0e9:7085:c58e:926d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1bf6d391sm5594338eec.6.2026.04.29.15.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 15:08:59 -0700 (PDT)
Date: Wed, 29 Apr 2026 15:08:55 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <afKBd87b4AKbCYuL@mozart.vkv.me>
References: <cover.1777483573.git.calvin@wbinvd.org>
 <33d87384aa5f96af76949d1399476779dd4f4fce.1777483573.git.calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33d87384aa5f96af76949d1399476779dd4f4fce.1777483573.git.calvin@wbinvd.org>

On Wednesday 04/29 at 20:38 +0000, sashiko-bot@kernel.org wrote:
> > @@ -636,6 +639,19 @@ void perf_sample_event_took(u64 sample_len_ns)
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
> 
> On 32-bit architectures, is it safe to use __this_cpu_cmpxchg() on a 64-bit
> value in NMI context?
>
> For architectures like 32-bit x86, the generic fallback implementation
> achieves atomicity by disabling interrupts, which does not mask NMIs. If a
> nested NMI interrupts the sequence halfway through reading or writing the
> 32-bit halves of the u64, could this result in a torn read or write?
> 
> A corrupted timestamp could cause a massive wrap-around in the time gap
> calculation, perpetually satisfying the > NSEC_PER_SEC bypass condition and
> silently disabling PMU throttling for all events on that CPU.
> 
> > +	    now - last > NSEC_PER_SEC && sample_len_ns < NSEC_PER_SEC)

If this is a problem, isn't it also a problem for the 64-bit store after
updating the EWMA just above this?

I guess last_throttle_clock could be a u32 and use the low clock bits,
that's sufficient with the one second limit... but I would appreciate a
real human opinion :)

> The comment indicates the intent is to skip throttling if the prior NMI
> occurred more than one second before this NMI began.

My comment is not very clear, I suppose. It should say:

    "...skip throttling if the prior attempt to throttle occurred more
    than one second ago, and the current NMI runtime was less than one
    second. But never skip throttling if NMIs are nesting."

> However, local_clock() is sampled at the end of the current NMI, so now
> includes the current NMI's duration.
> 
> If an NMI takes a very long time (e.g., 900ms) but started only 200ms after
> the previous NMI ended, the true gap before it began is 200ms. Because now
> includes the 900ms duration, now - last evaluates to 1100ms, which bypasses
> the throttling.
> 
> Could this artificially inflate the time gap for long-running NMIs,
> directly defeating the throttling mechanism?

I think it's just saying "the code doesn't do what the comment says",
which is true. But what it is describing is sort of addressed below too.

> Additionally, is it possible for user-defined PMU events with expensive
> overhead (like heavy eBPF programs attached to slow tracepoints) to exploit
> this hardcoded frequency bypass?

No, I don't think ebpf programs run in NMI context?

> If an event triggers slower than 1Hz but takes a very long time to execute
> (e.g., 999ms), both now - last > NSEC_PER_SEC and sample_len_ns <
> NSEC_PER_SEC will be true.
> 
> Such an event would bypass the moving average calculation and never be
> throttled, allowing it to consume nearly 100% of the CPU while it runs and
> violating the default 25% CPU time limit set by
> sysctl_perf_cpu_time_max_percent.

No matter where the limit is defined, NMIs firing at just under that
limit will skip throttling. But I guess it could be something like:

    now - last > NSEC_PER_SEC && sample_len_ns < NSEC_PER_MSEC

...to sort of costrain the worst case.

But this all feels really arbitrary. I thought about using the watchdog
interval sysctl minus some padding as the upper bound, but that seemed
unnecessarily complicated.

Maybe this second patch is just more trouble than its worth...
especially if, as Andi noted earlier, the PMU watchdog is not long for
this world...

Thanks,
Calvin

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1777483573.git.calvin@wbinvd.org?part=2
