Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C4A21CC5A;
	Mon, 13 Oct 2025 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364500; cv=none; b=ieA3DpAtpICLWU6gXdthZhlLwAsoLC3j4EbA1YLMGu+49hoksqcOqbUR16+aWn102M8wj2Np9DxOPIMHYxLh2CdBV9WzoKZj8aEnT59xRa7INXOb5s1LX6o6pDNkukIaeWdDklOzISEkz8oo513ARbGv/E8/Ki300KMDY2p3WzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364500; c=relaxed/simple;
	bh=n4t1L41H56J0vcyR3xg+yB4DbK/M+Dk+u5XSWCSoDU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbosDdEFz++3dLtggFfouekEldied6HLWPxBNIB/eq8fwQfHhCcsnI9dXwNt9viuLZBy1UmeOaIgijH21Gpj+fyNxaYhJPbhQo5uTbhN12riq26jjJ3wy0oHU40tUp1kVh7omUtj2OfhRTZmhBdJudw62KPVZKGQ4mEw57da630=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ah1eyi9X; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ah1eyi9X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n3EzzB7tDGwyWDHfDiZdQ+jZEyjpAJ4TMuhOM2fZyG4=; b=Ah1eyi9XciJh69e/MF64VzPxLX
	kifFZkegVGOseOs803JqKgrjw4dcOcQvg1XG7v/l3+qBe4ac9tk3mi++AOGKnyBzXF0dQ5EE61Mux
	B8Oly1gXQPc3wwut2TCE2dvrwd+CjbLs07jMqVrLp9SSTeyZflfbN759XXfugYjAO9+g3AufRIcKc
	sXFF5VnhjeOCzFHMQcKfXCXIQbY0xOP4Q6qQQkve9KjBFE+tF58asI54B7JC54YNRg/nHTDtJ3Rlw
	5c8VH+Z0MtV02FmEO3sJDiyojOfwUgTMGi6Yldc0hG8ad+4xhX5HQQsmdBw/aDcrFWCM1ut34WBFv
	z+OYc9WQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8JDb-00000004Mnz-2OJA;
	Mon, 13 Oct 2025 14:08:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 72A19300325; Mon, 13 Oct 2025 16:08:06 +0200 (CEST)
Date: Mon, 13 Oct 2025 16:08:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thaumy Cheng <thaumy.love@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] perf/core: Fix missing read event generation
 on task exit
Message-ID: <20251013140806.GL3245006@noisy.programming.kicks-ass.net>
References: <20251008163530.810407-1-thaumy.love@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008163530.810407-1-thaumy.love@gmail.com>

On Thu, Oct 09, 2025 at 12:35:30AM +0800, Thaumy Cheng wrote:

> @@ -13995,13 +13997,16 @@ static void sync_child_event(struct perf_event *child_event)
>  }
> 
>  static void
> -perf_event_exit_event(struct perf_event *event,
> -		      struct perf_event_context *ctx, bool revoke)
> +perf_event_detach_event(struct perf_event *event,
> +		      struct perf_event_context *ctx, bool revoke, bool exit)
>  {
>  	struct perf_event *parent_event = event->parent;
> -	unsigned long detach_flags = DETACH_EXIT;
> +	unsigned long detach_flags = 0;
>  	unsigned int attach_state;
> 
> +	if (exit)
> +		detach_flags |= DETACH_EXIT;
> +

Urgh, at that point just pass in the right DETACH_flag directly,
something like:

perf_event_detach_event(struct perf_event *event,
			struct perf_event_context *ctx,
			unsigned long detach_flags);

	perf_event_detach_event(event, ctx, DETACH_EXIT);

	perf_event_detach_event(event, ctx, DETACH_REVOKE);



>  	if (parent_event) {
>  		/*
>  		 * Do not destroy the 'original' grouping; because of the
> @@ -14077,6 +14082,17 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
>  	 */
>  	mutex_lock(&ctx->mutex);
> 
> +	/*
> +	 * Report the task dead after unscheduling the events so that we
> +	 * won't get any samples after PERF_RECORD_EXIT. We can however still
> +	 * get a few PERF_RECORD_READ events.
> +	 */
> +	if (exit)
> +		perf_event_task(task, ctx, 0);
> +
> +	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
> +		perf_event_detach_event(child_event, ctx, false, exit);
> +
>  	/*
>  	 * In a single ctx::lock section, de-schedule the events and detach the
>  	 * context from the task such that we cannot ever get it scheduled back

This can't be right; read the comment you moved and then look where we
unschedule the event.
