Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194391;
	b=pTDBmjuZ2AcPklFCuz5NwzIpJjFSEuCGmXKmkbX/m+1SpQLh6lvgDPQXIOFyu6JaHGcB
	 MXl7Je81QgufMscoVkT6msTuBigedIWpNGPjQzbPUw0k8cKlTQuu6dYjqvx7pedKiGqRE
	 S+XfZSt5HZ5wlj0lbUgBYa6jXcV3adgbWut5utZ+0OVQ8mZYCQzCR4XtANM/jmYcUe9LN
	 ZCnCB+NSfCUFM/D0MGQXIhMe41BYOlf8XameVMLRHa+l28k2abOBJ5ZLDA1A6OOOZ8IZZ
	 BbrUgFrt36MA0FDAVEpvWx+T4kIQolZb7X+FjEVJHhr8jun+NPU9QJL7urnc9ItXFEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194391;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=DBlfurCWGJdBCpli2KRVhIoTmkGr5UAgzRmQZc42bUM=;
	b=QHu2zGTy3SIA398l7FEJeqRce3MlenTpot656yCSq1M/VhHCbYWw2kpc2EgWfR2ObI4j
	 g0Oep29DtQnPNbEsZpuZTOBOErpM5KQpKdpUS9NI0jL5a0fcwihwULjMoapFjm1Mw/7et
	 kqK8T1EXvAnA7fB5kLlz9k6xcDaQw24Ygfy9XVYwo4BIqLbkNe92Q8GSPvDn1/t3l+my6
	 daClB4peCCYbVOAYWvFrdV3ezo1hsSy8KdULMN3bxD0UrPfirdMClb0UkWm19lyrKlfWw
	 wdrRHUvaroJXHYiw4ltO68hlbRhRXTxm5lMZ9UJslUf/AWBLblJNHkJYOQxbolAiStw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=aMIBuiMI;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=eX4fFQ4b;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F26060A2622;
	Fri, 20 Nov 2026 17:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F26060A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=aMIBuiMI;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=eX4fFQ4b
Date: Fri, 20 Nov 2026 18:06:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795194388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DBlfurCWGJdBCpli2KRVhIoTmkGr5UAgzRmQZc42bUM=;
	b=aMIBuiMIBgA7ZLU/k6EnLspsmBvQaCZ40RR4J2Ug5QWgQ9LAP5oOu7ND+Zd2FrtXH+q/ZL
	tlV73mCU55ZE/36mISBFLkAOArPbwy54vEhyNjxOJwv5G+MtJIKcbgVnM6JcAmnIUG2UFS
	6esCW9hPrcHWaor9nIcXCOQ5Aa/QnqBwm10pCzjWUvPW3o8dBXrIE+lOSRnvy3OhJ8A69s
	xvVjTTYv2r9W6X+KfmXzx051OH+VA5TnuV4aKYMM0vemBUBr/XpWVCP6mdCqXwRIYctYs3
	Jhr9AmiiX7x/n5mbonEo+LbFM2XKambAEsl7feGNqqS3X9Ozt2pJQkL/G4JNrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795194388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DBlfurCWGJdBCpli2KRVhIoTmkGr5UAgzRmQZc42bUM=;
	b=eX4fFQ4bVdEWiSEyOI3kQZxclNOnzO280oiFwp3P2zJwfnEY62z9MWAnjI72SliC6ipg37
	U1P/6KVqSRDFG0DQ==
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
Subject: Re: [PATCH v5 2/2] perf/core: Disable context fast-swap for sigtrap
 events
Message-ID: <20261120170626.1UyR31Sg@linutronix.de>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <55b1a2845b0ad34a874a7653644e34af9eb068d3.1795053619.git.wutengda@huaweicloud.com>
 <20261120163007.GB2668564@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20261120163007.GB2668564@noisy.programming.kicks-ass.net>

On 2026-11-20 17:30:07 [+0100], Peter Zijlstra wrote:
> This patch cannot be right, because it leaves in place the existing
> sigtrap / nr_no_switch_fast bits.

I said the same thing and then sashiko came with
	https://lore.kernel.org/all/sashiko-outbox-218736@kernel.org/

| [Severity: Medium]
| Can ctx->nr_no_switch_fast drop to zero while event->pending_task is still
| queued if the sigtrap event is detached before perf_pending_task() runs?
| 
| Detaching an event does not cancel or flush event->pending_task; instead,
| pending_task holds a reference to the event until the task returns to user
| space.  When a parent event with attr.inherit and attr.sigtrap is closed while
| a child event has pending_task queued, perf_event_release_kernel() detaches the
| child events from their cloned contexts without uncloning them:
| 
| CPU0 (task A)                     CPU1
| __perf_event_overflow(child_A)
|   task_work_add(A, &child_A->pending_task)
|                                   perf_event_release_kernel(parent)
|                                     perf_remove_from_context(child_A, ...)
|                                       list_del_event(child_A, ctx_A)
|                                         local_dec(&ctx_A->nr_no_switch_fast)
|                                     perf_remove_from_context(child_B, ...)
|                                       list_del_event(child_B, ctx_B)
|                                         local_dec(&ctx_B->nr_no_switch_fast)
| schedule() (A -> B)
|   perf_event_context_sched_out(A, B)
|     /* context_equiv(ctx_A, ctx_B) && nr_no_switch_fast == 0 */
|     WRITE_ONCE(ctx_A->task, B)
| ...
| perf_pending_task(&child_A->pending_task)
|   perf_sigtrap(child_A)
|     WARN_ON_ONCE(event->ctx->task != current)  <-- trips WARN, drops SIGTRAP
| 
| Keeping the increment in __perf_event_overflow() and decrement in
| perf_pending_task() alongside list_add_event() and list_del_event() would keep
| nr_no_switch_fast elevated until pending_task completes.  Note that because
| list_add_event() and list_del_event() can run on a remote CPU under ctx->lock
| while __perf_event_overflow() or perf_pending_task() runs on ctx->task's CPU
| without ctx->lock, nr_no_switch_fast would also need to be atomic_t rather than
| CPU-local local_t.

Sebastian
