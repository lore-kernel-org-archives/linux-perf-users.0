Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF525570;
	Sun, 15 Sep 2024 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726400299; cv=none; b=khg+y3vUPLvckVfbWLtqnknycMaQodlZEu86Lg9QcE/z5dgKBMyNzqjPdbd9tzLCfdMgkD6XSqYY528InAL3yhZgdb0n/yAlZMzHNsY3bstDiWIXWyCbnGnajIjg505zjEiOSAUEhuL+dWuQISZATuI7VO3mztHJDYL+r/IJRc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726400299; c=relaxed/simple;
	bh=BbCJXPb4X+AQIaVRj6FjpN5IHb5QS7ofyJqpYXqoZc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERojnnKxEF37nGLF7Gjq7cSv7YlKY75LLZLhKgHAI/b1uihFKO0AmtYqdoqzBq8hA/BPzXVO/oTW6QtBuol7WcMLYYVxX9kh/21rKe1znfEta8UZqCWUZFqf1CUHGfSwhLgUCDRgOZ8W3azDcm5LU/BbDR8gYGYUNWiZYUYD63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01FDC4CEC4;
	Sun, 15 Sep 2024 11:38:14 +0000 (UTC)
Date: Sun, 15 Sep 2024 07:38:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
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
Message-ID: <20240915073810.28b2f492@rorschach.local.home>
In-Reply-To: <20240915111111.taq3sb5xzqamhb7f@treble>
References: <cover.1726268190.git.jpoimboe@kernel.org>
	<20240914081246.1e07090c@rorschach.local.home>
	<20240915111111.taq3sb5xzqamhb7f@treble>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Sep 2024 13:11:11 +0200
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Sat, Sep 14, 2024 at 08:12:46AM -0400, Steven Rostedt wrote:
> > I think the unwinder should have an interface itself that provides the
> > deferred unwinding, instead of having all the tracers to implement
> > their own.
> > 
> > The user space unwinder (regardless of sframe or not) should provide a
> > way to say "I want a user space stack trace for here, but don't do it
> > yet. Just give me a cookie and then call my callback function with the
> > stack and cookie before going back to user space".  
> 
> We (Steven, Mathieu and I) have been discussing this at GNU Cauldron and
> I think we're in basic agreement on this.
> 
> I think the biggest tweak we decided on is that the context id (aka
> "cookie") would be percpu.  Its initial value is (cpuid << 48).  It gets
> incremented for every entry from user space.

Well, in concept it is incremented for every entry from user space, but
in reality it should only be incremented the first time it is
referenced when coming into user space. That is, if there's nothing
asking for a stack trace, then nothing should be incremented.

> 
> > That is, we should have an interface like:
> > 
> > typedef void (unwinder_callback_t)(struct user_space_stack *, u64 cookie);  
> 
> > struct unwinder_client {
> > 	struct list_head	list;
> > 	unwinder_callback_t	callback;  
> 
> I assume we want to allow tracers to pick sframes or FP (or auto).  If
> so we would need to add a user_unwind_type enum to this struct.

Actually, I don't think they should care. A stack trace should just be
passed to the callback. How that stack trace is created, is up to the
unwinder. sframe should be used if it's avaliable, otherwise it will
use the frame pointer. If neither is available, the callback could be
called with NULL for the stack trace and then it can figure out what to
do via pt_regs.

> 
> Then the question is, what to do if tracer A wants sframe and tracer B
> wants FP?  I'm thinking it's fine to allow that.  I assume the "multiple
> tracers unwinding user space" case isn't realistic so any extra overhead
> from these cases is the user's fault?
> 
> The unwinder would need two sets of callbacks and task work functions:
> one for sframe, one for FP.
> 
> The tracer would need to pass its &my_unwinder struct to
> unwinder_trigger() so the unwinder knows which task work function to
> activate.
> 
> 
> I thinking we also need a 'max_entries' field.  No need to keep
> unwinding if we've already reached the tracer's max.  If there are
> multiple callbacks then we'd have to get the max of the maxes, but
> that's easy enough.

We could set a max when the tracer registers a callback. It can be -1
to mean "no limit".

I was talking with Mathieu at lunch, and we talked about having the
stack information pointer be part of the task_struct.

That is, the first time the unwinder is triggered and its doing the
unwind (either sfarme or fp), it will allocate memory to store the
stack trace information. This information is what is sent to the
tracer's callbacks. Again, the tracers do not care how the stack frame
was created. This memory is then saved in the task struct (freed when
the task exits), and reused for future stack traces.

If a stack trace could not be created, the callback just gets NULL and
that will tell the tracer that nothing is available for the user space
stack trace, and it can try to do something else. But that's not some
the unwinder should care about.

> 
> 
> Mathieu had requested passing an opaque void * from the NMI to the
> callback, but I don't think that's possible with this scheme since the
> unwinder wouldn't know which callback to give it to.  Instead the tracer
> would have to keep track of its own data associated with the given
> cookie.
> 

Not sure what that means, but from NMI, I would see the tracer doing:


	u64 cookie;

	cookie = undwinder_trigger();


And then the tracer is responsible to do something with that cookie.
This would also trigger the "task_work()"  where the ptrace path is
entered when going back to user space, the unwinder will try to create a
stack trace (from sframe or fp), saving it in this allocated memory
that is then stored via a pointer on the task_struct so it only needs
to be allocated once (or if a stack trace is bigger than what was
allocated).

Then all the tracer callbacks will be called with the stack trace and
the cookie. The tracer will decided if it should use the stack trace
from the cookie, or just ignore it. But the tracer shouldn't care about
sframes or frame pointers. That's an implementation detail of the
unwinder.

-- Steve
