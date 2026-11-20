Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795192216;
	b=uk3q0ixHiOYltA3JYHuIQl8j2B8XbxyXb4ZNagM7JJ3ViKXQmpGuhHGGZchbSLEBXygG
	 jzvKNt9ZPravUwvFA+VF62M8eKvW8uASB/nEyMoUZsZIl0rYxiVNKKoyF8ck0Ii1iFI4F
	 F1IAXSefr2SucMh073ecjUaWiKaif4vVYy27GDlvdOGZzjAAqqIIrSY/q3YXiebXmtpya
	 x/k2AqSVupym+b/5E3X7bBWKAn8zy+fNSMuzYeoMCYWuK8RboweUUJKv9xmB8VFt27Prm
	 Pscy7D7bcqq8oeCqvzTk2EK8HS8lhpdbg2e65eA2lzgZ8+vmY1OstmWM9z7JYiiM1Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795192216;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=kBGFPo5POd3ZR4zYo+/j43H7x7GVDa6fWMGSwjCQ++4=;
	b=qwUsrrXDuZFam+SfSGIv5q+iswlG9o/NCRDn52hd2AdwwJGJW9EB8ACsmP1RtNq6Ulam
	 R3NDfThpQmPKJnXI40hOfZ1zXSwR+aY+HWHL429xgG9LBi2LssCM9dhq/Jq+lEeUtoe8k
	 nkFtWudDx/ZQFreRAusIqnsNyhUxuCtD3Kd1R60aZRFH1drj1frvzxW3aT31KTvSF3zdC
	 452tIcvExJ0gVsbUCzT7M3MGgu4PK97RX7V7s5FooRLeJaf05q7YySNJzeyw1/Ex0MpPA
	 ywgKvOcsWyp5A4Yx53drdlRMFKVOWgR1EVeBVa1tzrVB5ntHQbQ3JU7vMnAlwH22SIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=blssZUig;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FD9606A320;
	Fri, 20 Nov 2026 16:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5FD9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=blssZUig
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kBGFPo5POd3ZR4zYo+/j43H7x7GVDa6fWMGSwjCQ++4=; b=blssZUig1u0DYlUsq9w+8p2W5v
	HNSsDMUU8rp7jkKPp5NqsZvXG2iNZizpRvfj9hOoUfHBXizCdNMpnEAggFDQRRtrdLIzxpM9OZV1O
	93QeEqqiPgkMf/xAG4hhtWKXkGwP1a+0c2fJ739/ja18B0Ubp/hgvuqiHu6PYDI1KLq3j9Jl4JbEG
	OIaioyUAC9xqr9UucjOUDx4jqhpUQT64xNPC2eM6EXUE6X9xIUGugHZBoNqEQ+uH8quggHw5VXTMm
	Zu7g0ErNnVmU09VB7YpkhNMmUDCcummCsIp6TMFkXNVlXFKfxVojEkyWCSn64Za1yh5RnTicYDXp4
	XKCeZvfg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xURV2-00000000xQn-3HFY;
	Fri, 20 Nov 2026 16:30:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3F0733008D6; Fri, 20 Nov 2026 17:30:07 +0100 (CET)
Date: Fri, 20 Nov 2026 17:30:07 +0100
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
Message-ID: <20261120163007.GB2668564@noisy.programming.kicks-ass.net>
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
> 
> Fix this by also excluding events with attr->sigtrap from the fast-swap
> path, i.e. bump nr_no_switch_fast for sigtrap events in
> list_add_event()/list_del_event(), and update the comment describing
> the invariant accordingly.

This patch cannot be right, because it leaves in place the existing
sigtrap / nr_no_switch_fast bits.

Also, this is very sad; it might be better to try and fix up the special
case where the NMI hits the middle of context switch.
