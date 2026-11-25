Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597700;
	b=P4Bc+m4hoB/vasT4OiBbnLp1WDqVvbHgZz8RqauJPm8ZU2lOt8h2P7vwqGMMVkpeba2H
	 +zD+5ew3KU8dBOfSLV/uxxhFO1jqXYo8c+P4Gj6AFOWVf4k20WK0dWeqTfpA3wOn1Xwfs
	 YmYuKxJ4ORUmL5dv/flovy9DxXOKI44rGBy8Ygj/GlYVfGIb9c6y5krsu/UWZxp1vyUi5
	 EFh1FyYSCGaILtE6HlAmOhYcVnFkKPE3Nr7s3lFoTKEyh2vmC/0W4y3+rd+cXDlas1Y7k
	 /E6fiGww0Kl3D/7Gjc7t81ZVlj7RFxgkkLmfAR6bOrJNfc9WRTlB98PK8uNtRl3JmOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597700;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Vjbu/iMYrWhNQcMaUHplZZYJfNd7GrBnxsa1ipva2/M=;
	b=TxxIffhg4ATgYSwmTC/XXFVnbDJ1kCKDDgZosTdyxs52Se2duUIFdw9BCjnjTul3U9FH
	 dQ/MB3YM3D+xXBCXpFEKnNfcUnF6cabPykpxZDCZ3TF+WOvKa5oL6NYz+xOcezrA/Zz/L
	 rrdl5qoE7f/DV1CvmlPgKIMy+hAbIC2HajDI1C7Gpga9lIQnMIj/9MOFZnnG8swd2Vdww
	 ZgZinLbYtoaIXzxzrOTY9vN0YEwlylsAZExKBdEuJ0Zg9qz0xm8JRuh5K+rx7afS4fA16
	 8InI7f1RaIRKYP4HUHqPDnGk1bYYZxdfD6wRrK2ybv4eAHSxxW6FjxHOjF0nbV/WzUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b="VdqZ/3VT";
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B6606A321;
	Wed, 25 Nov 2026 09:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 846B6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=VdqZ/3VT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Vjbu/iMYrWhNQcMaUHplZZYJfNd7GrBnxsa1ipva2/M=; b=VdqZ/3VTouo4N9Va9u8pgH7q7H
	ExcqyZjOUOKFXVcT0MUQrj2jFItYDhnOMd5e+/QstJV8D08EjZNRVrWpdlXDGwFialQpfc38pD30w
	rr2TnGguWHfw7IKuVF9/lOa3yRuHHYwd4GgY3HDVx61bjhCR+30DMBDYFkvW3voIKfiC/Bd6+wIGO
	DeSkkTse2lo7IcNFZVlidJRM7nWEVWiUHPrI3gwnMX7D/Q5dnh8QxYTAYB7v1Ii21wReo9dO07NCZ
	J7Q8vyLEgVnpLhqi0zpdZDcI2I/5yjUr1gCGP+HrMardUqWDQWwO7KQVx3kndPHXnZiC8HjUl0vSi
	LAB1RG6Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW8z4-00000009NxT-1kBh;
	Wed, 25 Nov 2026 09:08:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 83142302186; Wed, 25 Nov 2026 10:08:09 +0100 (CET)
Date: Wed, 25 Nov 2026 10:08:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] perf/core: Disable context fast-swap for sigtrap
 events
Message-ID: <20261125090809.GW2668804@noisy.programming.kicks-ass.net>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <55b1a2845b0ad34a874a7653644e34af9eb068d3.1795053619.git.wutengda@huaweicloud.com>
 <20261120173706.GC2668564@noisy.programming.kicks-ass.net>
 <20261120174606.GM2669272@noisy.programming.kicks-ass.net>
 <5507e48c-4e98-4e76-8d3f-4630a2655085@huaweicloud.com>
 <c9ff579b-a7eb-481f-bb8d-489a4469c397@huaweicloud.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9ff579b-a7eb-481f-bb8d-489a4469c397@huaweicloud.com>

On Tue, Nov 24, 2026 at 04:42:34PM +0800, Tengda Wu wrote:

> From the stack, we can see:
> 
> perf_event_context_sched_out
>         // fast path
>         perf_ctx_enable(ctx, 0);
>                 perf_pmu_enable
>                         if (!--(*count))  // equals 0
>                                 pmu->pmu_enable(pmu);
>                                         __intel_pmu_enable_all.constprop
>                                                 do_trace_write_msr
>                                                         perf_tp_event
> 
> In perf_tp_event():
>         if (perf_tp_event_match(event, &raw, regs)) {
>                 if (!perf_pmu_enabled(event->pmu)) return 0; // not satisfied, continue downward
>                 perf_swevent_event
>                         __perf_event_overflow
>                                 task_work_add  // event->ctx->task mismatches 'current'
>         }
> 
> Because pmu_disable_count is already 0, the subsequent perf_tp_event_match()
> cannot block it via perf_pmu_enabled(), so the problem can be reproduced.

Right, but at this point there isn't really a problem, all the pointers
have been swapped already and state should be consistent again.

I *think* the problem is that task_work_add() is using current while it
should be using ctx->task. In that case the above will enqueue on the
next task, which is correct.

But also, we could probably write this to do:

	if (*count == 1) {
		pmu->pmu_enable(pmu);
		barrier();
		(*count)--;
	}

> Maybe my original nr_no_switch_fast approach is still worth considering.
> -- it would account for sigtrap events at attach time and keep them off
> the fast path entirely, rather than trying to filter the overflow after
> the swap has already happened.

Disabling switch_fast really hurts performance; doing that should be a
last resort. I think I can fix this. Let me try and see if the
reproducer works for me so I can more easily poke at this.


