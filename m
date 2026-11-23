Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420809;
	b=XgKqOxM7T9/Bb2A3Wt9CF3the7H+hOaIT6kGZPcskq40rcNLcCwakH1fsNtTJ9T3bhqQ
	 XjB/3LHgy2XTlNPiAi/7IUl95IwigsAm3TP6Cla35fZNNifmZQPwLFcALyVZPjsS1VwKW
	 ZtrPDSsyOMueqtgNaEIkIUxjCRuvwB+6/HSXMRJohsjgKVadpG0yeVEczor/rFCebkZup
	 AvrODJOpIZUuOEl/T1/Zah34Dm+8yIoFsR827pIZkHuaOTRjkN+AykR6vQZhgNnEsEqJX
	 V7bWfJB+9EJu4xCsSSEw26bMHU073Y7tFEtTggA04oXBs3Mz5XJ+CzXbQn8mJfAE+tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420809;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Mk4DQm2jAX4gDzyeQWRK15cPk3Iw+5QhRs9/8wSGVdM=;
	b=emvBDdJcgkHPhsRSJA43DtOvKqlqTjQzOvbWlZ5cStMgE6vB6SDh4KrkDiTUdpMfw7Yq
	 p2kfsHJb7Mlote+pmaFVDhgfNztDf4dFPsTVwU5HUr60mRGSY/QooMI9QkwlcpMizvDv4
	 7loWXugcDh6pGU25gu/prSBGPQrOXlgjdwZbkb7KEUyWspiMs+8UwnU0lA2aAbNJZlHg3
	 Y+Zze8bTTO6zAE3inizX9ksu2vC6EXmEUpYdpUxnRcDXcZsGnRbIgFppO5lZdL3qQVU/d
	 WuH/N8PnuA+vww5N5IRQMIoSoSLUF600pmMoS1FoAKEUKmuyOUNRgi5fGjxvalxw/ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=SpJTyz0i;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=6hhvwfsC;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C4E606A6B8;
	Mon, 23 Nov 2026 08:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8C4E606A6B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=SpJTyz0i;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=6hhvwfsC
Date: Mon, 23 Nov 2026 09:00:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795420805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mk4DQm2jAX4gDzyeQWRK15cPk3Iw+5QhRs9/8wSGVdM=;
	b=SpJTyz0isns1q2npfFqyFozdkPgvX8XPoACR8r7YljMxvbBNCBHxGg/cMa7tH+Ubm7QH1r
	rYNVBRq6RkxDVed9pc4Ax8PmFldjr+YPvs8s28c8uZk8DwyTaDM4isr+VDjUUif2WocM7f
	3iZ+TFwnqjS/IoyP1v4GLvrLfHTjqLhOdgz62kw6zqiSNk8IYP50qt4aT/ucEJXjtWebiV
	iluzIlihNh6jiKfYQA5gF74z4tDvHX/IFfaWllnptzxS1vUnlYi3/PeISmXLACFJvQ6oUb
	ZlM7LySbnippR9OxzQKf4D1bYCmEJ5RsSTAJgw1u7uk3wK3OQm6hvWTPeNZ2NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795420805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mk4DQm2jAX4gDzyeQWRK15cPk3Iw+5QhRs9/8wSGVdM=;
	b=6hhvwfsC5xJ5jd1o8hGvQWgbzQOcTvdxbedbL9/B0GG44YST1CZY/eDxgCQ/RPSrUR4Rdy
	Agsvq+eeB9e/9UCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tengda Wu <wutengda@huaweicloud.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] perf/core: Prevent duplicate sigtrap task work
 enqueue
Message-ID: <20261123080004.MKzgHQ3W@linutronix.de>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>
 <20261120154457.GZ2668564@noisy.programming.kicks-ass.net>
 <20261120154959.zw08JC0V@linutronix.de>
 <20261120160140.GR2668804@noisy.programming.kicks-ass.net>
 <20261120162604.GL2669272@noisy.programming.kicks-ass.net>
 <20261120172831.5XwELZY5@linutronix.de>
 <20261120174942.GU2668804@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120174942.GU2668804@noisy.programming.kicks-ass.net>

On 2026-11-20 18:49:42 [+0100], Peter Zijlstra wrote:
> From: Tengda Wu <wutengda@huaweicloud.com>
> 
> The sigtrap handling in __perf_event_overflow() checks
> event->pending_work before calling task_work_add(), but only sets
> pending_work after the task work has been queued.
> 
> This leaves a window where an NMI can interrupt task_work_add() and
> re-enter __perf_event_overflow() for the same (software/tracepoint)
> event. Since pending_work is still zero, the nested invocation can
> enqueue the same pending_task again.
> 
> The re-entrant call path looks like this:
> 
>   __perf_event_overflow()
>     task_work_add()
>       <NMI>
>         __perf_event_overflow()
>           task_work_add()
> 
> The nested invocation may enqueue pending_task before the outer
> invocation does. When the outer invocation resumes, it inserts the
> same task work entry again, potentially creating a cycle in the task
> work list.
> 
> As a result, perf_pending_task() may be executed repeatedly, leading
> to unbalanced event reference counting.
> 
> Fix this by atomically claiming pending_work with cmpxchg_local()
> before calling task_work_add(). This ensures that only one invocation
> can enqueue the task work, even when another overflow occurs
> re-entrantly from an NMI.
> 
> Notably: sigtrap events must be per-task, meaning that the there is no
> concurrency, only re-entrancy.
> 
> [peterz: clarify and rewrite]
> Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This looks good. Shouldn't we insert also

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e870f12c3ad81..edadc34f065fc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7776,8 +7776,8 @@ static void perf_pending_task(struct callback_head *head)
 	rctx = perf_swevent_get_recursion_context();
 
 	if (event->pending_work) {
-		event->pending_work = 0;
 		perf_sigtrap(event);
+		WRITE_ONCE(event->pending_work, 0);
 		local_dec(&event->ctx->nr_no_switch_fast);
 	}
 	put_event(event);

To ensure the ::pending_work is reset after perf_sigtrap() is done?

Sebastian
