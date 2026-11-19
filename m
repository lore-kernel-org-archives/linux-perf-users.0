Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090309;
	b=A2MSQcDVltKgVz9DJVJzYcCMv5ejvukqt2t+TVIW6v5FHmMzhuomswUiLEHz55sghOD3
	 cK5xOyYo14RqYQnOtHC+G4rSGvMqCR5DB1nQ02OhWBaZ3aYSojdLbFwFKOG7L76As48ac
	 QlLaj0T5ZCd4isK5URSzKbOR3+RU011vT3R1szHDve6l8bXvY03E8WMjd8Ba80J33lrCz
	 WdKnCC4eYdBMfeO/904AgWDyEkOHUq6TkYzn91wd7CQpO30y1j3Rw3eEnWKJzFLKjpHzm
	 8vCcjkAy4XFnym1eDszWU5Y3Bx/2M24s25hjpBmXnmBy/W5W75ve/EMOqLvpwqq/bFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090309;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=tviNPhPwnA+DcuN7jiTb3/ChTOP03GVBQlXgko6Vksw=;
	b=sDpYneAw+vfmWfWM3nT0z+EZ8TL56ADOMsZtOEdOcK7Z69z1GJtTjwy9jdfD5oq0YBZG
	 QqCcxeyBle6LtbNTXuCtuEoHrpewluVoyxpAo6tO92ZAPXueF8TjyTS8C/GmrtfbQ7+7Q
	 qD3pnxXoJ60e2uhGBL2lR0eltmQnQVWEiGkJgEvDbJ2SGJl0b2HnHex4++kf4EXCudjwC
	 AaPXb5qVZWGVlpKalGNoOwp1ek9PVjSOem9rHbljWw97segrNjJYYwVlA73VIdyagFeHs
	 rCf19ZMtRFQeb/DKGFYcRim7uudvuo6zbRheubmVawBdtp+MNo7e1A08HBxY3b2I/SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=FmiA2j2A;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=jsbH2bQW;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A6E606A320;
	Thu, 19 Nov 2026 12:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57A6E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=FmiA2j2A;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=jsbH2bQW
Date: Thu, 19 Nov 2026 13:11:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795090305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tviNPhPwnA+DcuN7jiTb3/ChTOP03GVBQlXgko6Vksw=;
	b=FmiA2j2AzJSODsQsLsNYbNDKMLYUpbKXvzK/lYnAYSyceszJmq9FDHSi0Z9B+KwVikWliZ
	59z5FgmwTVNwgTMCnt0WnjhdVWRmiXlTh1DukoqR7e2M++NHLVYG/uTzb2wWI7ZOnyGKy8
	d/mMkCap2qJA7Sp8Pxh9fOaSgN5j95BynTdzVGnIUW3PpdfjIqLQbu6IRisAnIZvUb8ySf
	2b9evXbNC9S3pqfMCGQCB3B3PvGAbqFDdxM4kakTzIP8P6KkS2+cwJX0YWIGB5tyFx/apK
	v5fenoQr5fabm5Ssd8Y5TrN/xsvSYYk/CKpKq9DB0pZ2V5jg1HIEs40BDOK0AQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795090305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tviNPhPwnA+DcuN7jiTb3/ChTOP03GVBQlXgko6Vksw=;
	b=jsbH2bQWd6KWdja4ws2J9jG13bc+NY/bspaQsVtbdbhwZDyM7G/5aF1o6y099Y1gOTq8uD
	hbFgK9zwrHMDxqAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20261119121143.pJrJE7qs@linutronix.de>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55b1a2845b0ad34a874a7653644e34af9eb068d3.1795053619.git.wutengda@huaweicloud.com>

On 2026-11-19 09:51:01 [+0000], Tengda Wu wrote:
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
> 
> Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

This makes sense. How did you run into this? Is it possible to make a
testcase out of it?

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
