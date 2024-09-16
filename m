Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160391591E3;
	Mon, 16 Sep 2024 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502592; cv=none; b=YUgrCQ68decKDrA3DTeKRK950i6u8SFEQAjTKEXww7N2dN3m7zeaSNhxB8B8NEI0Bng3kiM14VbAkWo80njq1d+pax1RjcyeWNG+I44sVK9NJHW6hmK8bHZhw5h1CSlIqBK6456l0zgMwYdvX9wZiXGnJudSDf9HPMuK+D9xXpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502592; c=relaxed/simple;
	bh=u1662HiCda+ve3938ZUL5Loi0C7HfAACBcd9KXaPmjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHpXdMmNhS0ONG39jWOVf0u8PNEjYmeOGbMgszcym/rqe+DU8ZReiwth1kFuPHSWJn4wxf7MVLgWY2ynfYa95dhMvCe12kaW0rkCK/zC1k0sQKMFzRShui3NCDPgfY8lwxXWfMb/oxlPDV8EdtuEagcKM/4YOXqQ5ypt8dnz0lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F008C4CEC4;
	Mon, 16 Sep 2024 16:03:07 +0000 (UTC)
Date: Mon, 16 Sep 2024 12:03:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Ingo Molnar
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
Message-ID: <20240916120302.0005b499@rorschach.local.home>
In-Reply-To: <20240916140856.GB4723@noisy.programming.kicks-ass.net>
References: <cover.1726268190.git.jpoimboe@kernel.org>
	<20240914081246.1e07090c@rorschach.local.home>
	<20240915111111.taq3sb5xzqamhb7f@treble>
	<20240916140856.GB4723@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Sep 2024 16:08:56 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > 
> > I think the biggest tweak we decided on is that the context id (aka
> > "cookie") would be percpu.  Its initial value is (cpuid << 48).  It gets
> > incremented for every entry from user space.  
> 
> Why? What's the purpose of the cookie? This scheme seems unsound, pin
> yourself on CPU0 and trigger 1<<48 unwinds while keeping CPU1 idle.
> 
> > > That is, we should have an interface like:
> > > 
> > > typedef void (unwinder_callback_t)(struct user_space_stack *, u64 cookie);  
> 
> Just make it a void* and let the consumer figure it out.

Let me try to explain the rationale for the "cookie". It's actually a "context_cookie".
The cookie is unique for every time user space enters the kernel.

Basically it's a "tag" (we could call it that too, but "cookie" seemed
more appropriate as it follows what web browsers do). The idea is this:

 * You're in interrupt context and want a user space back trace, and
   request to have a user stack trace when the task goes back to user
   space. Now the unwinder will return the current context cookie" and
   will use that same cookie when it creates the user stack on exit
   back to user space.

* If this happens in a long system call that does many stack traces
  (records the kernel stack and also wants the user stack), it does not
  record the user trace at the time it is requested. But we need a way
  to tag this event with the user stack trace that will happen when the
  user stack is recorded when going back to user space. We can't pin
  the task to the CPU when we want to profile it. The cookie/tag needs
  to be the same for every request that happens with a single entry
  into the kernel. It must be different for another entry into the
  kernel as the user stack will be different then.

  Basically think that each cookie represents a single user stack.

* When going back to user space, the ptrace path is taken and the user
  stack trace is recorded. It will then call the tracers that requested
  it with the stack trace and the cookie that represents it.

Here's an example:

system_call() {

	<interrupt> trigger user stack trace: assign cookie 123
		tracer records kernel stack trace and adds cookie 123.

	<interrupt> trigger user stack trace: assign cookie 123
		tracer records kernel stack trace and adds cookie 123.

	<interrupt> trigger user stack trace: assign cookie 123
		tracer records kernel stack trace and adds cookie 123.


	<return to user space, take ptrace path>

	<record user stack trace>
	call all the tracers with user stack trace with cookie 123.
}

system_call() {

	<interrupt> trigger user stack trace: assign cookie 124
		tracer records kernel stack trace and adds cookie 124.

	<return to user space, take ptrace path>

	<record user stack trace>
	call all the tracers with user stack trace with cookie 124.
}


Then the tracers can post process the events and append the user stack
trace with cookie 123 on top of the kernel stack events that had cookie
123, and append the user stack trace with cookie 124 on top of the
kernel stack events that had cookie 124.

-- Steve
