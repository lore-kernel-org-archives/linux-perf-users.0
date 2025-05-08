Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD05D1990A7;
	Thu,  8 May 2025 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746729885; cv=none; b=SnJAxoo/Elh9ihd7m5+GnJZ/S3wXrKxw0f8X+pNk67bxe3VWs+cwNsF5Ug1vfDkyNihC/q2g6U0kj4DwEQp3uT7JslyxpPl7m+dSvMvT/bpDMv5tDEX8Ucch+skNfcH9PtozfHBUNTOyVTr3rdrBV2RtDJIeyFSMbZjgO5gCu4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746729885; c=relaxed/simple;
	bh=dqRqSBnC3dwidCawRqS5Y1XwJ/+DedVPHUqrvOth/Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFzA8p2ULFwPOVCKYM73nl6OoZ9FR1dQxnyVrvcbh20WH9BiZQXch1yfHEOM0M4g/d7mGrtXjQfHQbhlfqYWA7jvB4CeCprJ0Q+lsHx6CgybtIKRpiUudKxX0YilksTWvUhojnP1s56MvuiDKwKacg1htt+b5xXm6atVV/I7Pvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBOSApEK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBOSApEK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD5AC4CEE7;
	Thu,  8 May 2025 18:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746729885;
	bh=dqRqSBnC3dwidCawRqS5Y1XwJ/+DedVPHUqrvOth/Hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IBOSApEKlDdxaoRxoCJRhA1Ceqmo4rvxVWyvoH+ZtUWyzwSfJKMlLRyPOvF3XnM+q
	 2u6WiATBqZOxx0sox2pmXBcjxlTIb2t+32noNT8ntSEtseMZgjU7Oz5I2qtANrFDKZ
	 NFBY2b1gosS8U3rRU++AgssunSJ2+12tyRHd/5W6VVErtEBxrQpOThJya7PNyQfHLf
	 ERKDo+XZHQ9SO74GIvJhwDWLQdmrIW1Kz96OMOG4Jfdq1z1LKsrBaVItfFhKZv5SC8
	 sLvpb58QoA9U0qwThc7EopU7cnwX4Hq/aNbI+K0Ml+GnUcVQeEZJKyTDqiv+rk0n7Q
	 l5vFfwErF5flA==
Date: Thu, 8 May 2025 11:44:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>,
	Blake Jones <blakejones@google.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH v5 13/17] perf: Support deferred user callchains
Message-ID: <aBz7mvEQwtlgNUjI@google.com>
References: <20250424162529.686762589@goodmis.org>
 <20250424162633.390748816@goodmis.org>
 <20250508120321.20677bc6@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250508120321.20677bc6@gandalf.local.home>

Hi Steve,

On Thu, May 08, 2025 at 12:03:21PM -0400, Steven Rostedt wrote:
> On Thu, 24 Apr 2025 12:25:42 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > +static void perf_event_callchain_deferred(struct callback_head *work)
> > +{
> > +	struct perf_event *event = container_of(work, struct perf_event, pending_unwind_work);
> > +	struct perf_callchain_deferred_event deferred_event;
> > +	u64 callchain_context = PERF_CONTEXT_USER;
> > +	struct unwind_stacktrace trace;
> > +	struct perf_output_handle handle;
> > +	struct perf_sample_data data;
> > +	u64 nr;
> > +
> > +	if (!event->pending_unwind_callback)
> > +		return;
> > +
> > +	if (unwind_deferred_trace(&trace) < 0)
> > +		goto out;
> > +
> > +	/*
> > +	 * All accesses to the event must belong to the same implicit RCU
> > +	 * read-side critical section as the ->pending_unwind_callback reset.
> > +	 * See comment in perf_pending_unwind_sync().
> > +	 */
> > +	guard(rcu)();
> > +
> > +	if (!current->mm)
> > +		goto out;
> > +
> > +	nr = trace.nr + 1 ; /* '+1' == callchain_context */
> 
> Hi Namhyung,
> 
> Talking with Beau about how Microsoft does their own deferred tracing, I
> wonder if the timestamp approach would be useful.
> 
> This is where a timestamp is taken at the first request for a deferred
> trace, and this is recorded in the trace when it happens. It basically
> states that "this trace is good up until the given timestamp".
> 
> The rationale for this is for lost events. Let's say you have:
> 
>   <task enters kernel>
>     Request deferred trace
> 
>     <buffer fills up and events start to get lost>
> 
>     Deferred trace happens (but is dropped due to buffer being full)
> 
>   <task exits kernel>
> 
>   <task enters kernel again>
>     Request deferred trace  (Still dropped due to buffer being full)
> 
>     <Reader catches up and buffer is free again>
> 
>     Deferred trace happens (this time it is recorded>
>   <task exits kernel>
> 
> How would user space know that the deferred trace that was recorded doesn't
> go with the request (and kernel stack trace) that was done initially)?

Right, this is a problem.

> 
> If we add a timestamp, then it would look like:
> 
>   <task enters kernel>
>     Request deferred trace
>     [Record timestamp]
> 
>     <buffer fills up and events start to get lost>
> 
>     Deferred trace happens with timestamp (but is dropped due to buffer being full)
> 
>   <task exits kernel>
> 
>   <task enters kernel again>
>     Request deferred trace  (Still dropped due to buffer being full)
>     [Record timestamp]
> 
>     <Reader catches up and buffer is free again>
> 
>     Deferred trace happens with timestamp (this time it is recorded>
>   <task exits kernel>
> 
> Then user space will look at the timestamp that was recorded and know that
> it's not for the initial request because the timestamp of the kernel stack
> trace done was before the timestamp of the user space stacktrace and
> therefore is not valid for the kernel stacktrace.

IIUC the deferred stacktrace will have the timestamp of the first
request, right?

> 
> The timestamp would become zero when exiting to user space. The first
> request will add it but would need a cmpxchg to do so, and if the cmpxchg
> fails, it then needs to check if the one recorded is before the current
> one, and if it isn't it still needs to update the timestamp (this is to
> handle races with NMIs).

Yep, it needs to maintain an accurate first timestamp.

> 
> Basically, the timestamp would replace the cookie method.
> 
> Thoughts?

Sounds good to me.  You'll need to add it to the
PERF_RECORD_DEFERRED_CALLCHAIN.  Probably it should check if sample_type
has PERF_SAMPLE_TIME.  It'd work along with PERF_SAMPLE_TID (which will
be added by the perf tools anyway).
 
Thanks,
Namhyung

> 
> > +
> > +	deferred_event.header.type = PERF_RECORD_CALLCHAIN_DEFERRED;
> > +	deferred_event.header.misc = PERF_RECORD_MISC_USER;
> > +	deferred_event.header.size = sizeof(deferred_event) + (nr * sizeof(u64));
> > +
> > +	deferred_event.nr = nr;
> > +
> > +	perf_event_header__init_id(&deferred_event.header, &data, event);
> > +
> > +	if (perf_output_begin(&handle, &data, event, deferred_event.header.size))
> > +		goto out;
> > +
> > +	perf_output_put(&handle, deferred_event);
> > +	perf_output_put(&handle, callchain_context);
> > +	perf_output_copy(&handle, trace.entries, trace.nr * sizeof(u64));
> > +	perf_event__output_id_sample(event, &handle, &data);
> > +
> > +	perf_output_end(&handle);
> > +
> > +out:
> > +	event->pending_unwind_callback = 0;
> > +	local_dec(&event->ctx->nr_no_switch_fast);
> > +	rcuwait_wake_up(&event->pending_unwind_wait);
> > +}
> > +
