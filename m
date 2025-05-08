Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AF52CCC0;
	Thu,  8 May 2025 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746720192; cv=none; b=jI44SEU34bW7QZ3nrKgKd3Wi/uB09ZVMRwl0loHWGLKBs0TxOxyuyIsu9CEpoU4sZp/2bQ0O0CgVlbtgb5IBZu+NSaxIQvK+9JWnuQ+oLj/uLxVkicES5qaFQFP1fKmQyoWXP3xvQCqCDYtyEeYkg438NI3wRx5+YnRweX0QohE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746720192; c=relaxed/simple;
	bh=CDfe11rcN0+pev+XPdEEOzZuVEPrSuLFZ/WBZH4YLkM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlhA8m/br3FVIHbgSfdTXXAvZ0r4ITte/zhRDhL/baHrcHdS5aAx6eOvjSF0/0m1zO22GzMoBejusReXv1bpDTuJWt5dS4cFG+UysQoB1ZCiHM9EVHIf3ocIPvpRPWaXkYpwhACfl7F9T/e2rrAh1yJwo02CmjWTMy/C884Fg4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18695C4CEEB;
	Thu,  8 May 2025 16:03:09 +0000 (UTC)
Date: Thu, 8 May 2025 12:03:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Namhyung Kim <namhyung@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, x86@kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark Brown
 <broonie@kernel.org>, linux-toolchains@vger.kernel.org, Jordan Rome
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Jens Remus <jremus@linux.ibm.com>, Florian
 Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, Weinan Liu
 <wnliu@google.com>, Blake Jones <blakejones@google.com>, Beau Belgrave
 <beaub@linux.microsoft.com>, "Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH v5 13/17] perf: Support deferred user callchains
Message-ID: <20250508120321.20677bc6@gandalf.local.home>
In-Reply-To: <20250424162633.390748816@goodmis.org>
References: <20250424162529.686762589@goodmis.org>
	<20250424162633.390748816@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 12:25:42 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> +static void perf_event_callchain_deferred(struct callback_head *work)
> +{
> +	struct perf_event *event = container_of(work, struct perf_event, pending_unwind_work);
> +	struct perf_callchain_deferred_event deferred_event;
> +	u64 callchain_context = PERF_CONTEXT_USER;
> +	struct unwind_stacktrace trace;
> +	struct perf_output_handle handle;
> +	struct perf_sample_data data;
> +	u64 nr;
> +
> +	if (!event->pending_unwind_callback)
> +		return;
> +
> +	if (unwind_deferred_trace(&trace) < 0)
> +		goto out;
> +
> +	/*
> +	 * All accesses to the event must belong to the same implicit RCU
> +	 * read-side critical section as the ->pending_unwind_callback reset.
> +	 * See comment in perf_pending_unwind_sync().
> +	 */
> +	guard(rcu)();
> +
> +	if (!current->mm)
> +		goto out;
> +
> +	nr = trace.nr + 1 ; /* '+1' == callchain_context */

Hi Namhyung,

Talking with Beau about how Microsoft does their own deferred tracing, I
wonder if the timestamp approach would be useful.

This is where a timestamp is taken at the first request for a deferred
trace, and this is recorded in the trace when it happens. It basically
states that "this trace is good up until the given timestamp".

The rationale for this is for lost events. Let's say you have:

  <task enters kernel>
    Request deferred trace

    <buffer fills up and events start to get lost>

    Deferred trace happens (but is dropped due to buffer being full)

  <task exits kernel>

  <task enters kernel again>
    Request deferred trace  (Still dropped due to buffer being full)

    <Reader catches up and buffer is free again>

    Deferred trace happens (this time it is recorded>
  <task exits kernel>

How would user space know that the deferred trace that was recorded doesn't
go with the request (and kernel stack trace) that was done initially)?

If we add a timestamp, then it would look like:

  <task enters kernel>
    Request deferred trace
    [Record timestamp]

    <buffer fills up and events start to get lost>

    Deferred trace happens with timestamp (but is dropped due to buffer being full)

  <task exits kernel>

  <task enters kernel again>
    Request deferred trace  (Still dropped due to buffer being full)
    [Record timestamp]

    <Reader catches up and buffer is free again>

    Deferred trace happens with timestamp (this time it is recorded>
  <task exits kernel>

Then user space will look at the timestamp that was recorded and know that
it's not for the initial request because the timestamp of the kernel stack
trace done was before the timestamp of the user space stacktrace and
therefore is not valid for the kernel stacktrace.

The timestamp would become zero when exiting to user space. The first
request will add it but would need a cmpxchg to do so, and if the cmpxchg
fails, it then needs to check if the one recorded is before the current
one, and if it isn't it still needs to update the timestamp (this is to
handle races with NMIs).

Basically, the timestamp would replace the cookie method.

Thoughts?

-- Steve


> +
> +	deferred_event.header.type = PERF_RECORD_CALLCHAIN_DEFERRED;
> +	deferred_event.header.misc = PERF_RECORD_MISC_USER;
> +	deferred_event.header.size = sizeof(deferred_event) + (nr * sizeof(u64));
> +
> +	deferred_event.nr = nr;
> +
> +	perf_event_header__init_id(&deferred_event.header, &data, event);
> +
> +	if (perf_output_begin(&handle, &data, event, deferred_event.header.size))
> +		goto out;
> +
> +	perf_output_put(&handle, deferred_event);
> +	perf_output_put(&handle, callchain_context);
> +	perf_output_copy(&handle, trace.entries, trace.nr * sizeof(u64));
> +	perf_event__output_id_sample(event, &handle, &data);
> +
> +	perf_output_end(&handle);
> +
> +out:
> +	event->pending_unwind_callback = 0;
> +	local_dec(&event->ctx->nr_no_switch_fast);
> +	rcuwait_wake_up(&event->pending_unwind_wait);
> +}
> +
