Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196235;
	b=fuWVF9tAyR5fS1GS65Ir9KJDW9tdqraqaGOsNmJQWZm7vySKtqmuZwiKp/Zh5PPwYMh+
	 Sb5/CaCq4nmlBeb5RzSSTjSET8o8mEWQbg5vOwnU+O8siYEvDp98zEj6i0atybXP7ch88
	 X00iyDZ5bqvrfX+KFiM6+YvuULSK7kMKtGa9b4Q3U5g1BVcsNU7+pVUxWpWGdP1AbwboE
	 fFoGSZNQRZjckAhfD49x9emIyv8zE4IciX6ZzJIZpvu6d1etN8FB4Jaa3NBTpwSkBpUJn
	 +6ZubNYRrtx0OoVyrm63Y7Y2nTieQbcPZsWna+tTe0ZkrEhyhqNaa6v9n9wbPasypTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196235;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=+42UsbmhgpxbuaJKcUURUX+gKeWtmbkUWsQ2W7y6aOI=;
	b=pycemQFaZNCRA/qwf7xkObk1kbANu0PzYFGtpJIXjck62xQWGhA4J61vwFon0GePM+54
	 zBjWHcE7/vGcuDlaRiH1v8f6F2N2ZDufBtBqlVAYlfvJS96RUyo+MggzIoq6UgU/cIXO6
	 l+RCt/6O4mkUbnow2SV5r8sDw+AVYg5FLF85NZDBWb36bjEWSxrWM7m8T75D3RPnuUW4B
	 8uW1dTJtUBsutQKIS5UB8MbP6sIYjo6qTnE4AOhvmG1LELrejlGyoavjmTNeu6CYy4DFB
	 loE9B+h4K/2xm8gM6WEDDjdIEqnpm3GqJg8tiEcLdXXJ9hFemSm9OdE3SOdtKIBn6EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=GlPRubVH;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CFC60A2603;
	Fri, 20 Nov 2026 17:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40CFC60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=GlPRubVH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+42UsbmhgpxbuaJKcUURUX+gKeWtmbkUWsQ2W7y6aOI=; b=GlPRubVHSfQVvXjPL8nqDPaaNw
	sHA1FCAHNiSJEK6Qq31udKnRjEF9PkuEYCYsfKOlpKBpPsIswMeyD+8Xn5BpXBi6du6C+NTQNhTbm
	G6K0LWFA4QDse2kKi3y66+7cthVFRqwa3HtxW9NfH8+x/tJGhY2tCXU3r6T8weaOZJeRfIt4kuTfg
	X4kO7EajIhjM0+TSgQOmmz0fG5I4Ixk1F8vCtO3UDDCVCXpMJubdCDo6PStvuw65I2zyIRmBE0xD8
	9SZyAQg7hYk+bTV/l9QY+MtnGt/FXA5uDo7Y6JEf/2L4QpoOb6QZ0kpwAK0lPl0MQ0MXLK94fTx3g
	KYU/47hQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSXr-00000008yuJ-0F6n;
	Fri, 20 Nov 2026 17:37:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 19FC63008D6; Fri, 20 Nov 2026 18:37:06 +0100 (CET)
Date: Fri, 20 Nov 2026 18:37:06 +0100
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
Message-ID: <20261120173706.GC2668564@noisy.programming.kicks-ass.net>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <55b1a2845b0ad34a874a7653644e34af9eb068d3.1795053619.git.wutengda@huaweicloud.com>
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
In-Reply-To: <55b1a2845b0ad34a874a7653644e34af9eb068d3.1795053619.git.wutengda@huaweicloud.com>

On Thu, Nov 19, 2026 at 09:51:01AM +0000, Tengda Wu wrote:
> perf_sigtrap() contains:
> 
> 	WARN_ON_ONCE(event->ctx->task != current)
> 
> The warning assumes that an event's ctx->task always matches the task
> that ends up running the pending task_work. That assumption can be
> broken by the context fast-swap path.
> 
> The failure sequence is:
> 
>   1. A -> B switch, perf_event_context_sched_out() takes the fast path
>      and does WRITE_ONCE(ctx->task, next) / WRITE_ONCE(next_ctx->task, task).
>      An NMI then hits while the context is swapped, and
>      __perf_event_overflow() queues pending task_work on the *current*
>      task (A), even though the event now belongs to B's swapped-in
>      context view.
> 
>   2. B -> A switch. Because A now has pending task_work,
>      nr_no_switch_fast is non-zero, so the slow path is taken and
>      ctx->task is *not* swapped back.
> 
>   3. A returns to user mode, task_work runs perf_pending_task() ->
>      perf_sigtrap(), and event->ctx->task no longer equals current,
>      tripping the WARN_ON_ONCE().
> 
> The context fast-swap path was already excluded for events that need
> stable task association (inherit + sample read). sigtrap events have
> the same requirement: the SIGTRAP is targeted at ctx->task and must not
> be delivered after ctx->task has been swapped to another task.

Oh gawd, let me guess, another one of those tracepoint events, right?

Must be someone that doesn't respect perf_ctx_disable(). Fixing that
will close this hole.
