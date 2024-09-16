Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2974965B;
	Mon, 16 Sep 2024 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726526816; cv=none; b=XPwtpWljN7FeCrdiub1WRHyDeziE95Y95TAHY9BeZ3K8baycL5jyzQu0dZ6jNkbOJfnRavloBAav9HzABxPg4L1vBioMdX1VQUBGJVBL6m8Q7x2fS2H5Z7xd3Zw6r+9uDb+iP/Rwi4VcscPbZnjaV0GxRxv+u8KiKERQ+AeTav0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726526816; c=relaxed/simple;
	bh=HjG2QWiADPExMSbk2jSCTIT1sb7d8dSYSOfgeedN5mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AS3k0N3c9jgwtX9Wb7zq85DvLCs+xptI6cGdKhQPl9fY6swa5PwwtkfQNqCCYV64cquuMQv3kkQgEh9P3/vukelahYih3lU/mZsplH4PATrcHrlvoKabE7gW0XxTZKc301+4jU0/6LRkNejHR6ArrUebkRqTJcdMvklJQ+asb90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67BCC4CEC4;
	Mon, 16 Sep 2024 22:46:50 +0000 (UTC)
Date: Mon, 16 Sep 2024 18:46:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, Ingo Molnar
 <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark
 Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, Jordan Rome
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 00/11] unwind, perf: sframe user space unwinding,
 deferred perf callchains
Message-ID: <20240916184645.142face1@rorschach.local.home>
In-Reply-To: <20240916181545.GD4723@noisy.programming.kicks-ass.net>
References: <cover.1726268190.git.jpoimboe@kernel.org>
	<20240914081246.1e07090c@rorschach.local.home>
	<20240915111111.taq3sb5xzqamhb7f@treble>
	<20240916140856.GB4723@noisy.programming.kicks-ass.net>
	<20240916153953.7fq5fmch5uqg7tjj@treble>
	<20240916181545.GD4723@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Sep 2024 20:15:45 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Sep 16, 2024 at 05:39:53PM +0200, Josh Poimboeuf wrote:
> 
> > The cookie is incremented once per entry from userspace, when needed.
> > 
> > It's a unique id used by the tracers which is emitted with both kernel
> > and user stacktrace samples so the userspace tool can stitch them back
> > together.  Even if you have multiple tracers triggering at the same time
> > they can all share a single user trace.  
> 
> But perf don't need this at all, right? It knows that the next deferred
> trace for that tid will be the one.

Is that because perf uses per task buffers? Will perf know this if it
uses a global buffer? What does perf do with "-a"?

> 
> > > This scheme seems unsound  
> 
> > > pin yourself on CPU0 and trigger 1<<48 unwinds while keeping CPU1 idle.  
> > 
> > Hm???  
> 
> The point being that it is possible to wrap one CPU into the id space of
> another CPU. It is not trivial, but someone who wants to can make it
> happen.
> 
> Combined I don't see the need to force this into this scheme, carry an
> opaque (void*) pointer and let the user do whatever it wants, perf for
> instance can pass NULL and not do anything like this.

That would put a huge burden on those tracers. Specifically ftrace.
Just because perf doesn't need it, it doesn't mean it can't be part of
the infrastructure. The cookie isn't even per-cpu. The counter is just
generated per cpu to avoid races. The cookie will have the CPU as part
of the bits, plus the per-cpu counter. This will give us a unique value
across all CPUs without having to do any atomic operations. It's just
that the cookie must be unique for every time a task enters the kernel,
and stay the same while it is in the kernel.

So if the task enters the kernel on CPU 1 and a trace is requested, the
tracer still needs to save that event when the request occurred (for
example, the kernel stack trace). It needs a unique identifier that
will be attached to the user stack trace when it is made, so that post
processing can tell where to append that stack.

Then the task can migrate to several other CPUs, but it will still have
the same cookie as when it received it on the first CPU. The cookie
only gets updated on the task when it goes back to user space.

ftrace allows for several instances that could be filtering on the same
or different tasks. One instance could filter 3 tasks, another 2 tasks,
where one of those tasks is in both instance. The user stack
infrastructure should give a way to easily map the request to the stack
via some kind of identifier.

What would perf do on dropped events? Say a system call happened, perf
requested a user stack trace, then the events were dropped, and when it
started again, it was in a system call, how would perf know it is in
the same system call? I guess the callback when the dropped user stack
trace occurred would tell perf to reset. Still it adds a pretty big
burden for the tracers to handle these corner cases whereas a simple
identifier is much more simple and robust.

-- Steve
