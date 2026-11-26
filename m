Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707646;
	b=VyoKDAtRkinVLaTwGFqF27DBvkCa6xr5SIeGSjcbXbxBABp8XCX4fjJo7v0a/Luu41Ox
	 YEzdyR6kPnPBHK8KSzepmnTGCeTxcHTn3cXhZJfHvbFEdt9hQczeDQzBrv7kUdDKV9kDI
	 SKOZfcvk9uIxp51DAf68iwdIOu+OSPCaZ+lzbYj0aX+7o55DrJsxJtTH20HpdRFBy0aOH
	 FZaudX7gIVkFKwU1u9IQwzrFDoz3SofU3hj9DBzNse+FrLkGsq04ywlB/C0RRuSjFa03b
	 2JdPLRoqu+jWouDyiZXTKf9TM+m8xuBTNHOtWrQ506yKIVJOdwrsYKn1KhpPf7QQvsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707646;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=p00VxTiGOpViwP+yiHZZnvcXAmwYh4g3z9+pDFjv8bk=;
	b=FvZ9tERmbZSgmbJcoYLYAVEGwGCc0dQvAbwnam/G5GhPfGlxaafpwoou+oDIp8stqowF
	 r75PjMrd7AdHhqdx0TWBIT+SROH9Px4aVS95Gy+V4Yq1+aq3tlIrdTedGX4/LnFpEuxe/
	 R8YP43otPjANs1+urR6PsyKnHQebQP4Iij5iwC/zG+sHokDrFhQ0ffrh2UOhiKnFx2Scd
	 SUT+tH4aC+XZXxaNyIb39XRukQg7WX9XkXF1pm74GxQ29p+CYyh5K39j/QOpIEwO2evCX
	 FN0t3+taoy2irKj0nLxQ3P8MC7PPpX2YPTw5sTKfRH4fKBg10f6VK7Eu7fpzn0c6U2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Y8uQWJq2;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1A2606A31C;
	Thu, 26 Nov 2026 15:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE1A2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Y8uQWJq2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p00VxTiGOpViwP+yiHZZnvcXAmwYh4g3z9+pDFjv8bk=; b=Y8uQWJq2qqRhqdQCHKhIDZvzue
	+5GWDxQKJIPt5BLSKw8uoLCR/Q/wB1tsjHMfkK4fX3XDa61P0TtpRDWsNsnruhITqT+CnK9rSfgi4
	i/KZrCbQ8BJAh3BxhkgCqBU1a4/Wq2EK5s5DZrV95FAAQroUYQAUf9dMx9ZUyHr9+Hdl0nE0oiobB
	Jt3ImGw3+hTiSzxiUvprrYF1LSiBWywB5TNMTlvNoV+i6ARyHm5hYRdOZk0TV81NCkdlst64eaGla
	nhUKp/mWtBrLqipWLivpcPIu1kEwa5H5sBEYAWEjfaNG5VfsBxcI6TjZbhwxaK9aioGMO+4A9TVfE
	ycJ0g2hA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWbaU-00000006oqb-0UAg;
	Thu, 26 Nov 2026 15:40:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1E61C302186; Thu, 26 Nov 2026 16:40:41 +0100 (CET)
Date: Thu, 26 Nov 2026 16:40:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dominik Maier <dmnk@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, dmnk+artist@google.com
Subject: Re: [PATCH v2] perf/core: check perf_allow_kernel() in
 PERF_EVENT_IOC_SET_FILTER
Message-ID: <20261126154041.GJ49833@noisy.programming.kicks-ass.net>
References: <20261124180611.75836-1-dmnk@google.com>
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
In-Reply-To: <20261124180611.75836-1-dmnk@google.com>

On Tue, Nov 24, 2026 at 06:06:11PM +0000, Dominik Maier wrote:
> Under perf_event_paranoid = 2, an unprivileged caller can open a
> task-scoped counting trace event (including tracepoints and tracefs
> uprobes) with attr.exclude_kernel = 1 and attach trace event filters via
> PERF_EVENT_IOC_SET_FILTER without passing perf_allow_kernel(). Trace
> event filter predicates are parsed by create_filter() and support kernel
> symbol and address matching (such as the .function modifier), exposing
> kernel address information to callers that are not allowed kernel
> profiling.
> 
> Require perf_allow_kernel() before applying trace event filters in
> perf_event_set_filter().
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Dominik Maier <dmnk@google.com>
> ---
> v2:
> - Gate trace event filtering in perf_event_set_filter() with
>   perf_allow_kernel() instead of only checking kallsyms_show_value() on
>   numeric .function predicates in trace_events_filter.c (Steven Rostedt).
> - v1: https://lore.kernel.org/linux-trace-kernel/20261119192233.2664654-1-dmnk@google.com/
> 
> Found with AI-assisted code review; tested in QEMU across root and
> unprivileged callers at perf_event_paranoid = 1 and 2, and build-tested
> with CONFIG_EVENT_TRACING both enabled and disabled.

Does this want a Fixes tag? Or should I stick this in perf/core for the
next cycle?

>  kernel/events/core.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index e870f12c3ad8..e053de4c164c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -12371,22 +12371,28 @@ static int perf_event_set_filter(struct perf_event *event, void __user *arg)
>  
>  #ifdef CONFIG_EVENT_TRACING
>  	if (perf_event_is_tracing(event)) {
> -		struct perf_event_context *ctx = event->ctx;
> +		ret = perf_allow_kernel();
> +		if (!ret) {
> +			struct perf_event_context *ctx = event->ctx;
>  
> -		/*
> -		 * Beware, here be dragons!!
> -		 *
> -		 * the tracepoint muck will deadlock against ctx->mutex, but
> -		 * the tracepoint stuff does not actually need it. So
> -		 * temporarily drop ctx->mutex. As per perf_event_ctx_lock() we
> -		 * already have a reference on ctx.
> -		 *
> -		 * This can result in event getting moved to a different ctx,
> -		 * but that does not affect the tracepoint state.
> -		 */
> -		mutex_unlock(&ctx->mutex);
> -		ret = ftrace_profile_set_filter(event, event->attr.config, filter_str);
> -		mutex_lock(&ctx->mutex);
> +			/*
> +			 * Beware, here be dragons!!
> +			 *
> +			 * the tracepoint muck will deadlock against ctx->mutex,
> +			 * but the tracepoint stuff does not actually need it.
> +			 * So temporarily drop ctx->mutex. As per
> +			 * perf_event_ctx_lock() we already have a reference on
> +			 * ctx.
> +			 *
> +			 * This can result in event getting moved to a different
> +			 * ctx, but that does not affect the tracepoint state.
> +			 */
> +			mutex_unlock(&ctx->mutex);
> +			ret = ftrace_profile_set_filter(event,
> +							event->attr.config,
> +							filter_str);
> +			mutex_lock(&ctx->mutex);
> +		}
>  	} else
>  #endif
>  	if (has_addr_filter(event))
> -- 
> 2.56.1.831.g720f3f5937-goog
> 
