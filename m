Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B25396572;
	Mon, 18 May 2026 21:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779140507; cv=none; b=q6B2UQn7gquNOp6eq9i/p9zXHcOMiFFQn/+iUg7hA7Kz3OXxKwbrb6XrVyYGnB2gXC+2yR911yDU2ewajBXnbxQZ9tTr22SMl3hd78Z/0PlrgLX8imILmih1AvgWcY0HmIoYhpB2VnzaIZaaB6dXIH1zx2K8aTs+xLKjgWpqBDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779140507; c=relaxed/simple;
	bh=oZBeInOYDOPK0NTsNQGsA7zf1MCFDyCmLbggLwSo5lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h10EXx3aensvnsZLdUa4AUp7+KTKZu6gLjn9WA1ZE38FmEZB9cU40Fu14V1HwRe1RudLmDGG+Rie2EAjgVC79rGtotkiYaJWJEdldp5Uf4RC45bVCDvC4Y1Fzab+OYXPwwIDZd3gPZapVaduZE1bWyObKKKUtPdoQiFXvxt4yMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LHos9Rtp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LHos9Rtp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=sxs5zNbGs5J/jp4BoRyNAGaFyHvLDwSDdje5doHAm0s=; b=LHos9RtpNRaIK8IKRns5dStvhw
	UDItcXJ0ZfMjOchtwO4olnfe1IK+0pMIAB+WIziSBmims0SavDajbCuxc3E104H75SIUEO9M1cu8R
	DskM9EVrhTDFYXA+ucnYH0jeCtdgqVmXcjncTCM6GZI0gGBZz09x2f3ZD9hj+5//3DemFKhbdrmQ0
	8TjmmNCfO/zOwIxzFsOLcdDD/qOFVQ1Vy5NQj3c3K2LVtZ33qVXdiT+E2txDspfs/gP3doTme4+mP
	5rjmqL/bDG9ysUakaBxuphK2o+VokYcBMcNyHn+XHKXar75i7AZ4EQcl2/r+9RNlvHlTtyvtXqyr/
	yheGwa9g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP5i9-0000000COlz-0lq7;
	Mon, 18 May 2026 21:41:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 44749300182; Mon, 18 May 2026 23:41:16 +0200 (CEST)
Date: Mon, 18 May 2026 23:41:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 2/3] perf: enable unprivileged syscall tracing with
 perf trace
Message-ID: <20260518214116.GZ3102624@noisy.programming.kicks-ass.net>
References: <20260515194010.93725-2-ashelat@redhat.com>
 <20260515194010.93725-4-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515194010.93725-4-ashelat@redhat.com>

On Fri, May 15, 2026 at 03:40:06PM -0400, Anubhav Shelat wrote:
> Allow unprivileged users to trace their own processes' syscalls using
> perf trace, similar to strace without the intrusive overhead of ptrace().
> 
> Currently, perf trace requires CAP_PERFMON or paranoid level ≤ 1 even
> though the kernel has existing infrastructure (TRACE_EVENT_FL_CAP_ANY)
> specifically designed to mark syscall tracepoints as safe for
> unprivileged access. To fix this:
> 
> 1. Loosen the condition in perf_event_open() which requires privileges
>    for all events with exclude_kernel=0. This allows perf_event_open() to
>    bypass the paranoid check for task-attached tracepoint events. Ensure
>    that sample types which can expose kernel addresses to unprivileged
>    users are blocked. Ensure the PERF_SECURITY_KERNEL LSM hook is
>    preserved.
> 
> 2. Make the format and id tracefs files world-readable only for tracepoints
>    with TRACE_EVENT_FL_CAP_ANY, allowing unprivileged users to see syscall
>    tracepoint ids without exposing sensitive information.
> 
> 3. Add a check to perf_trace_event_perm() to block PERF_SAMPLE_IP on
>    kernel tracepoints for unprivileged users to prevent KASLR bypass. We do
>    this here rather than in kaddr_leak because perf_trace_event_perm() can
>    distinguish between kernel tracepoints and uprobe tracepoints, where the
>    IP is a safe user space address and is necessary for uprobe
>    functionality.
> 
> 4. Restrict pure counting events (no PERF_SAMPLE_RAW) to
>    TRACE_EVENT_FL_CAP_ANY tracepoints preventing unprivileged users from
>    counting internal kernel tracepoints while preserving current
>    behavior for exclude_kernel=1 events.

Typically patches are supposed to a single thing, you're listing 4
things. What gives?

> Example usage after this change:
>   $ perf trace ls          # works as unprivileged user
>   $ perf trace             # system-wide, still requires privileges
>   $ perf trace -p 1234     # requires ptrace permission on pid 1234
> 
> Assisted-by: Claude:claude-sonnet-4.5
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  kernel/events/core.c            | 28 +++++++++++++++++++++++++---
>  kernel/trace/trace_event_perf.c | 21 ++++++++++++++++++++-
>  kernel/trace/trace_events.c     | 16 ++++++++++++++--
>  3 files changed, 59 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7935d5663944..ff2d1e9a0b79 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13873,9 +13873,31 @@ SYSCALL_DEFINE5(perf_event_open,
>  		return err;
>  
>  	if (!attr.exclude_kernel) {
> -		err = perf_allow_kernel();
> -		if (err)
> -			return err;
> +		bool tp_bypass = false;
> +
> +		/* Check unprivileged tracepoints */
> +		if (attr.type == PERF_TYPE_TRACEPOINT && pid != -1) {
> +			/*
> +			 * Block sample types that expose kernel addresses to
> +			 * prevent KASLR bypass
> +			 */
> +			u64 kaddr_leak = PERF_SAMPLE_CALLCHAIN |
> +					 PERF_SAMPLE_BRANCH_STACK |
> +					 PERF_SAMPLE_ADDR |
> +					 PERF_SAMPLE_REGS_INTR;

PERF_SAMPLE_IP should be here too, no?

And I'm not sure if tracepoints can trigger it, but PHYS_ADDR also seems
something we shouldn't allow.

And we're sure RAW doesn't include pointers?

> +
> +			tp_bypass = !(attr.sample_type & kaddr_leak);
> +		}
> +
> +		if (!tp_bypass) {
> +			err = perf_allow_kernel();
> +			if (err)
> +				return err;
> +		} else {
> +			err = security_perf_event_open(PERF_SECURITY_KERNEL);
> +			if (err)
> +				return err;
> +		}
>  	}
>  
>  	if (attr.namespaces) {
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index a6bb7577e8c5..466007ed2869 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -72,9 +72,28 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
>  			return -EINVAL;
>  	}
>  
> +	/*
> +	 * PERF_SAMPLE_IP on kernel tracepoints exposes a kernel text
> +	 * address, weakening KASLR. Block for unprivileged users unless
> +	 * the tracepoint is a uprobe (userspace IP, safe to expose).
> +	 */
> +	if ((p_event->attr.sample_type & PERF_SAMPLE_IP) &&
> +	    !p_event->attr.exclude_kernel &&
> +	    !(tp_event->flags & TRACE_EVENT_FL_UPROBE) &&
> +	    sysctl_perf_event_paranoid > 1 && !perfmon_capable())
> +		return -EACCES;
> +
>  	/* No tracing, just counting, so no obvious leak */
> -	if (!(p_event->attr.sample_type & PERF_SAMPLE_RAW))
> +	if (!(p_event->attr.sample_type & PERF_SAMPLE_RAW)) {
> +		/* Prevent unprivileged users from counting kernel tracepoints */
> +		if (!p_event->attr.exclude_kernel &&
> +		    sysctl_perf_event_paranoid > 1 && !perfmon_capable()) {
> +			if (!(p_event->attach_state == PERF_ATTACH_TASK &&
> +			      (tp_event->flags & TRACE_EVENT_FL_CAP_ANY)))
> +				return -EACCES;
> +		}
>  		return 0;
> +	}

Maybe use less AI and try and type this yourself. I think you'll find
that repeating the same clauses over and over gets tiresome. IIRC they
invented something for that in the 60s or so :/

>  	/* Some events are ok to be traced by non-root users... */
>  	if (p_event->attach_state == PERF_ATTACH_TASK) {
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index c46e623e7e0d..cbd07e2ec528 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3050,7 +3050,13 @@ static int event_callback(const char *name, umode_t *mode, void **data,
>  	struct trace_event_call *call = file->event_call;
>  
>  	if (strcmp(name, "format") == 0) {
> -		*mode = TRACE_MODE_READ;
> +		/*
> +		 * Make format tracefs file world readable for tracepoints with
> +		 * TRACE_EVENT_FL_CAP_ANY
> +		 */
> +		*mode = (call->flags & TRACE_EVENT_FL_CAP_ANY) ?
> +			(TRACE_MODE_READ | 0004) :
> +			TRACE_MODE_READ;
>  		*fops = &ftrace_event_format_fops;
>  		return 1;
>  	}
> @@ -3086,7 +3092,13 @@ static int event_callback(const char *name, umode_t *mode, void **data,
>  #ifdef CONFIG_PERF_EVENTS
>  	if (call->event.type && call->class->reg &&
>  	    strcmp(name, "id") == 0) {
> -		*mode = TRACE_MODE_READ;
> +		/*
> +		 * Make id tracefs file world readable for tracepoints with
> +		 * TRACE_EVENT_FL_CAP_ANY
> +		 */
> +		*mode = (call->flags & TRACE_EVENT_FL_CAP_ANY) ?
> +			(TRACE_MODE_READ | 0004) :
> +			TRACE_MODE_READ;
>  		*data = (void *)(long)call->event.type;
>  		*fops = &ftrace_event_id_fops;
>  		return 1;

Again, you're doing the same thing in multiple places. If only there was
something to re-use a previous expression.

None of this gives me warm and fuzzy feelings.
