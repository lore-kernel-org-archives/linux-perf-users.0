Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3765578C9A;
	Fri,  7 Jun 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752782; cv=none; b=OvP4AfralGXGrI0dRhZwkEbhGGDo3SGwM12Uy+duvH36K0zbfjaozlkJM+iMXYNEhZU56v/9blLBpJnmTRy+tKn1eGcG7/1mxcRskG9lKuY9ptlKlshAQBk6Hpmp193D1VM3ZAHLE6OVreW1PyA/Rva/Y9ICqZCrUUgQag1xiYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752782; c=relaxed/simple;
	bh=YwZQL96Sr6Wg4n/MXoBB/SdxflmBRDM7A6rSw2lWBfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6cIoal/C97yj3+YxvLtFdiA/mm2Z8XQTibIDCgWV5lT+HAaeW20oqq2nMB4r7GwQfcwUCh7p/OKb4U8mtEeLkggLxZ6M4oEN5WhsoBZLaNicxQjdHaMTK1uLOcWTpZJkFqHf3Z8PK4agt3sX/8DNNncNqSmHxAW8ZQkm+z5xhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AvRW6NBs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AvRW6NBs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gWnrC7NDDktySlmiwzkRSDu8snwjoIIvcpKg/dauVxw=; b=AvRW6NBswRQlMvSZORf258DJSA
	TF7SutfyxKVrrkm7N7gJDKgs9JGCVm6xj9QhNcTJMwl1Uq09l5iAhEeItmifKVx5jd0TUy8RIjWaf
	TTS2dorjk/0lWWG1Npp8e/A6lQnyHIDwsWS3gQIrtUfHl6qmABXA8/LB0mJB7BZSzwmWFzNiZcAr1
	95slUe9f9ooB775eW78RDLmiG+8BktmaQ+NAqy7NS8UiUeYW5zsqfFy59PRgfPR6uir5nIqzb9Pyu
	7Q7kZi9hNN/xcA8T6Rs+5G3V1ZKGDxXirIpeGaV3dsy3sdghoFCtzlQbt3JPp5+Av15OlHZkyH45i
	80726C/w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFVxv-00000004gtr-1KVQ;
	Fri, 07 Jun 2024 09:32:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EC32D30047C; Fri,  7 Jun 2024 11:32:54 +0200 (CEST)
Date: Fri, 7 Jun 2024 11:32:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ben Gainey <ben.gainey@arm.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	james.clark@arm.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/4] perf: Support PERF_SAMPLE_READ with inherit
Message-ID: <20240607093254.GN8774@noisy.programming.kicks-ass.net>
References: <20240606144059.365633-1-ben.gainey@arm.com>
 <20240606144059.365633-2-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606144059.365633-2-ben.gainey@arm.com>

On Thu, Jun 06, 2024 at 03:40:56PM +0100, Ben Gainey wrote:
> This change allows events to use PERF_SAMPLE READ with inherit
> so long as PERF_SAMPLE_TID is also set.
> 
> In this configuration, an event will be inherited into any
> child processes / threads, allowing convenient profiling of a
> multiprocess or multithreaded application, whilst allowing
> profiling tools to collect per-thread samples, in particular
> of groups of counters.

Perhaps a few words on *WHY* this is important.

> The read_format field of both PERF_RECORD_READ and PERF_RECORD_SAMPLE
> are changed by this new configuration, but calls to `read()` on the same
> event file descriptor are unaffected and continue to return the
> cumulative total.

This is unfortunate. Up to this point they were the same. Also, I see no
change to the uapi file. So were you trying to say that only
read_format::value is changed to be the thread local value as opposed to
the hierarchy total?

Please fix the wording to be unambiguous as to what is actually meant.
Also try and justify why it is okay to break this symmetry.

> @@ -3532,11 +3544,18 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
>  			perf_ctx_disable(ctx, false);
>  
>  			/* PMIs are disabled; ctx->nr_pending is stable. */
> -			if (local_read(&ctx->nr_pending) ||
> +			if (ctx->nr_inherit_read ||
> +			    next_ctx->nr_inherit_read ||
> +			    local_read(&ctx->nr_pending) ||
>  			    local_read(&next_ctx->nr_pending)) {

This seems unfortunate, nr_pending and nr_inherit_read are both used
exclusively to inhibit this context switch optimization. Surely they can
share the exact same counter.

That is, rename nr_pending and use it for both?

>  				/*
>  				 * Must not swap out ctx when there's pending
>  				 * events that rely on the ctx->task relation.
> +				 *
> +				 * Likewise, when a context contains inherit +
> +				 * SAMPLE_READ events they should be switched
> +				 * out using the slow path so that they are
> +				 * treated as if they were distinct contexts.
>  				 */
>  				raw_spin_unlock(&next_ctx->lock);
>  				rcu_read_unlock();
> @@ -4552,11 +4571,19 @@ static void __perf_event_read(void *info)
>  	raw_spin_unlock(&ctx->lock);
>  }
>  
> -static inline u64 perf_event_count(struct perf_event *event)
> +static inline u64 perf_event_count_cumulative(struct perf_event *event)

I don't think you need this -- overly long and hard to type function
name...

>  {
>  	return local64_read(&event->count) + atomic64_read(&event->child_count);
>  }
>  
> +static inline u64 perf_event_count(struct perf_event *event, bool self_value_only)
> +{
> +	if (self_value_only && has_inherit_and_sample_read(&event->attr))
> +		return local64_read(&event->count);

... if this @self_value_only argument was actually used as such -- it
isn't, see how you use 'from_sample' which is something else entirely.
Which then also caused to you fix it up and make a mess with that &&
has_inherit_and_sample_read() nonsense. (also, shorter function names,
more good)

> +
> +	return perf_event_count_cumulative(event);
> +}

That is, I would really rather you had:

static inline u64 perf_event_count(struct perf_event *event, bool self)
{
	if (self)
		return local64_read(&event->count);

	return local64_read(&event->count) + local64_read(&event->child_count);
}

And then actually use that argument as intended.

> @@ -7205,13 +7232,14 @@ void perf_event__output_id_sample(struct perf_event *event,
>  
>  static void perf_output_read_one(struct perf_output_handle *handle,
>  				 struct perf_event *event,
> -				 u64 enabled, u64 running)
> +				 u64 enabled, u64 running,
> +				 bool from_sample)
>  {
>  	u64 read_format = event->attr.read_format;
>  	u64 values[5];
>  	int n = 0;
>  
> -	values[n++] = perf_event_count(event);
> +	values[n++] = perf_event_count(event, from_sample);

...observe the fail... from_sample != self-value-only

>  	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED) {
>  		values[n++] = enabled +
>  			atomic64_read(&event->child_total_time_enabled);

