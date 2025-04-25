Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF5E27510A;
	Fri, 25 Apr 2025 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745594690; cv=none; b=fjm8ZPKlNtkK4L4Pg/hS38ve1wKQAFvEZhtIGnASuek2dZ7yqYStqqVE+NL+1EwQxkgVvc6rdwRn9n5GrEkdzadSbXRbs6AgRIMR7NWIEKhUykdaKOpwLIWWNjVnwgRgLw13XqbZIsXJ4kfaePNh28vulkDCckgQ2HEh33ARCH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745594690; c=relaxed/simple;
	bh=qPvnM3EKUYoNLWDnvqtQ432uJqwoJBBR6RNInTDcYaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjAWf4qY8tFObQ6G3T/pLlTozb8NRtSmdWlsYh6bcQXDvgh5qKxz2y7v8eOGnQs4TH9jvNEp8/6GZ2hQbQwTf+ofdR/nJJOdEwql31Vggnsg2CvLNDOjYyp4lNseR15/8tR1H7JFi4JGAMJdp9LFZdbPKVwVVzprsrTKYbuIc0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbyP1r3x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbyP1r3x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AEBC4CEE4;
	Fri, 25 Apr 2025 15:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745594689;
	bh=qPvnM3EKUYoNLWDnvqtQ432uJqwoJBBR6RNInTDcYaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kbyP1r3x6TUAAC2Dc4CO+WjUXQog6vDK6gh3IVudZQSuRK4x6WJcgQwgnaqSR8r5H
	 ZL5LA4ba72Zk47hdETBuQc/OFxK6lxs0tHxd9QXOwbTRdeNEFqvTDS7+lcsF/Wra4E
	 FPOPUvlcYpi+d37dUPZH38AGXIsLs29gjzRWFy1DG2HXfq/apUhcOAfP0d8APcBTwY
	 /DOnd3vGK0r7spWri6Gn0SGgUogiYbqkHGwGjr9CgzuX2k1wOHeTbOfAZUdvkQCoe3
	 MZZNbcdTmmS1eCOes/N4NHgepqFcGzKDWMuD7hYZfgv9EwzlMPioD5q/mgSJHbSOrL
	 XftNxoYMYbPXg==
Date: Fri, 25 Apr 2025 08:24:47 -0700
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
Message-ID: <aAupP56jOM_wul_8@google.com>
References: <20250424162529.686762589@goodmis.org>
 <20250424162633.390748816@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424162633.390748816@goodmis.org>

Hello,

On Thu, Apr 24, 2025 at 12:25:42PM -0400, Steven Rostedt wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Use the new unwind_deferred_trace() interface (if available) to defer
> unwinds to task context.  This will allow the use of .sframe (when it
> becomes available) and also prevents duplicate userspace unwinds.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
[SNIP]
> +/*
> + * Returns:
> +*     > 0 : if already queued.
> + *      0 : if it performed the queuing
> + *    < 0 : if it did not get queued.
> + */
> +static int deferred_request(struct perf_event *event)
> +{
> +	struct callback_head *work = &event->pending_unwind_work;
> +	int pending;
> +	int ret;

I'm not sure if it works for per-CPU events.  The event is shared so any
task can request the deferred callchains.  Does it handle if task A
requests one and scheduled out before going to the user mode, and task B
on the CPU also requests another after that?  I'm afraid not..

> +
> +	if (!current->mm || !user_mode(task_pt_regs(current)))
> +		return -EINVAL;

Does it mean it cannot use deferred callstack when it's in the kernel
mode like during a syscall?

Thanks,
Namhyung

> +
> +	if (in_nmi())
> +		return deferred_request_nmi(event);
> +
> +	guard(irqsave)();
> +
> +        /* callback already pending? */
> +        pending = READ_ONCE(event->pending_unwind_callback);
> +        if (pending)
> +                return 1;
> +
> +        /* Claim the work unless an NMI just now swooped in to do so. */
> +        if (!try_cmpxchg(&event->pending_unwind_callback, &pending, 1))
> +                return 1;
> +
> +        /* The work has been claimed, now schedule it. */
> +        ret = task_work_add(current, work, TWA_RESUME);
> +        if (WARN_ON_ONCE(ret)) {
> +                WRITE_ONCE(event->pending_unwind_callback, 0);
> +                return ret;
> +        }
> +	return 0;
> +}
