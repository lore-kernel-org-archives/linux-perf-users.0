Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D0A535DC;
	Thu, 23 Jan 2025 04:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737605137; cv=none; b=TWkzRk6jgFaYSw+zNGrnk3BUqjo6IsgSP2xdnCihGthq9Etcwt0QED74VdWcpUngWa3CjNsi6rhBln2pUOKbYvCa3w/XHgrz9dimRuzvMtjlxnE+L83ZgSTbVx6sO1uDqQr4B/eaKydy76DrutVOC/7cVs/SxJKYnE8lwNaNmk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737605137; c=relaxed/simple;
	bh=QUDyLtwdaL0AnKR0mfDrPBFTHigx2V0hR/fDo6CLmwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhiKFsNBPabTqLYEmfEuEnZC3w1vFF++huhfdtu5cQ/dNJnUXu3koNxgijhY9C2rbZJnrSt1gjeVxWUpuDUuK9XVYs7vW84CgNHO0hTM4YX1evomzXGJq+61+v+3t9bOxb2034DQrdQoovHdDxcX1NDMfcBbcCSsGI+8zOpfdo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCQbEHmV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCQbEHmV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6691CC4CEDD;
	Thu, 23 Jan 2025 04:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737605136;
	bh=QUDyLtwdaL0AnKR0mfDrPBFTHigx2V0hR/fDo6CLmwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NCQbEHmVygDQSnk81oOEOJAcAjOeFhlXDHm/3WmOrrOA0zqPGZ8L/MeDY0/qaEHU2
	 ajbOoXkvLjjrp2RIlB2oD0YIOZaL1Z+N5L7Er5n8VkwIMYShAf0qdD3r7waj2nA9Pj
	 qXnGnBycfl5om52wCtGtTPuqkeD/lh75Na8SOfXzxbNini0RRxi4eFXisWiCmJVP5k
	 yJGpA1wvjG8Xr/NKhSO7lR+15gDsYkGrHDNVF0eSg4YdXe5rN9Yg/+zpICYgHuw2uC
	 01a0akEdgqzKEj0gI6g75yMKpQimwOsqyDKNgrbvTXqlLxkNH/VGFZniMmF5HQUFki
	 TrgtnB+KUeXxg==
Date: Wed, 22 Jan 2025 20:05:33 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 28/39] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250123040533.e7guez5drz7mk6es@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
 <e92fc832-ef46-4863-9316-24f30d8d82fd@efficios.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e92fc832-ef46-4863-9316-24f30d8d82fd@efficios.com>

On Wed, Jan 22, 2025 at 03:13:10PM -0500, Mathieu Desnoyers wrote:
> > +struct unwind_work {
> > +	struct callback_head		work;
> > +	unwind_callback_t		func;
> > +	int				pending;
> > +};
> 
> This is a lot of information to keep around per instance.
> 
> I'm not sure it would be OK to have a single unwind_work per perf-event
> for perf. I suspect it may need to be per perf-event X per-task if a
> perf-event can be associated to more than a single task (not sure ?).

For "perf record -g <command>", it seems to be one event per task.
Incidentally this is the mode where I did my perf testing :-/

But looking at it now, a global "perf record -g" appears to use one
event per CPU.  So if a task requests an unwind and then schedules out
before returning to user space, any subsequent tasks trying to unwind on
that CPU would be blocked until the original task returned to user.  So
yeah, that's definitely a problem.

Actually a per-CPU unwind_work descriptor could conceivably work if we
able to unwind at schedule() time.

But Steve pointed out that wouldn't work so well if the task isn't in
RUNNING state.

However... would it be a horrible idea for 'next' to unwind 'prev' after
the context switch???

> For LTTng, we'd have to consider something similar because of multi-session
> support. Either we'd have one unwind_work per-session X per-task, or we'd
> need to multiplex this internally within LTTng-modules. None of this is
> ideal in terms of memory footprint.
> 
> We should look at what part of this information can be made static/global
> and what part is task-local, so we minimize the amount of redundant data
> per-task (memory footprint).
> 
> AFAIU, most of that unwind_work information is global:
> 
>   - work,
>   - func,
> 
> And could be registered dynamically by the tracer when it enables
> tracing with an interest on stack walking.
> 
> At registration, we can allocate a descriptor ID (with a limited bounded
> max number, configurable). This would associate a work+func to a given
> ID, and keep track of this in a global table (indexed by ID).
> 
> I suspect that the only thing we really want to keep track of per-task
> is the pending bit, and what is the ID of the unwind_work associated.
> This could be kept, per-task, in either:
> 
> - a bitmap of pending bits, indexed by ID, or
> - an array of pending IDs.

That's basically what I was doing before.  The per-task state also had:

  - 'struct callback_head work' for doing the task work.  A single work
    function was used to multiplex the callbacks, as opposed to the
    current patches where each descriptor gets its own separate
    task_work.

  - 'void *privs[UNWIND_MAX_CALLBACKS]' opaque data pointers.  Maybe
    some callbacks don't need that, but perf needed it for the 'event'
    pointer.  For 32 max callbacks that's 256 bytes per task.

  - 'u64 last_cookies[UNWIND_MAX_CALLBACKS]' to prevent a callback from
    getting called twice.  But actually that may have been overkill, it
    should be fine to call the callback again with the cached stack
    trace.  The tracer could instead have its own policy for how to
    handle dupes.

  - 'unsigned int work_pending' to designate whether the task_work is
    pending.  Also probably not necessary, the pending bits could serve
    the same purpose.

So it had more concurrency to deal with, to handle the extra per-task
state.

It also had a global array of callbacks, which used a mutex and SRCU to
coordinate between the register/unregister and the task work.

Another major issue was that it wasn't NMI-safe due to all the shared
state.  So a tracer in NMI would have to schedule an IRQ to call
unwind_deferred_request().  Not only is that a pain for the tracers,
it's problematic in other ways:

  - If the NMI occurred in schedule() with IRQs disabled, the IRQ would
    actually interrupt the 'next' task.  So the caller would have to
    stash a 'task' pointer for the IRQ handler to read and pass to
    unwind_deferred_request().  (similar to the task_work bug I found)

  - Thus the deferred unwind interface would need to handle requests
    from non-current, introducing a new set of concurrency issues.

  - Also, while a tracer in NMI can unwind the kernel stack and send
    that to a ring buffer immediately, it can't store the cookie along
    with it, so there lie more tracer headaches.

Once I changed the interface to get rid of the global nastiness, all
those problems went away.

Of course that now introduces the new problem that each tracer (or
tracing event) needs some kind of per-task state.  But otherwise this
new interface really simplifies things a *lot*.

Anyway, I don't have a good answer at the moment.  Will marinate on it.

Maybe we could do something like allocate the unwind_work (or some
equivalent) on demand at the time of unwind request using GFP_NOWAIT or
GFP_ATOMIC or some such, then free it during the task work?

> Unregistration of unwind_work could iterate on all tasks and clear the
> pending bit or ID associated with the unregistered work, to make sure
> we don't trigger unrelated work after a re-use.

What the old unregister code did was to remove it from the global
callbacks array (with the careful use of mutex+SRCU to coordinate with
the task work).  Then synchronize_srcu() before returning.

> > +/*
> > + * The context cookie is a unique identifier which allows post-processing to
> > + * correlate kernel trace(s) with user unwinds.  The high 12 bits are the CPU
> > + * id; the lower 48 bits are a per-CPU entry counter.
> > + */
> > +static u64 ctx_to_cookie(u64 cpu, u64 ctx)
> > +{
> > +	BUILD_BUG_ON(NR_CPUS > 65535);
> 
> 2^12 = 4k, not 64k. Perhaps you mean to reserve 16 bits
> for cpu numbers ?

Yeah, here the code is right but the comment is wrong.  It actually does
use 16 bits.

> > +	return (ctx & ((1UL << 48) - 1)) | (cpu << 48);
> 
> Perhaps use ilog2(NR_CPUS) instead for the number of bits to use
> rather than hard code 12 ?

I'm thinking I'd rather keep it simple by hard-coding the # of bits, so
as to avoid any surprises caused by edge cases.

-- 
Josh
