Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B34F36402E;
	Thu, 13 Aug 2026 07:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786605064; cv=none; b=dJP7dXWxGqM5tC3ypyQ+9lhaT3LsipKljT06FU9NGoTJI4uO0cX1kGEJSmAWQ5aDjM0C2Jjcew7sflNKq+72MV+37Cc5WRc+6hZiWBEV8+RHurrLboPi2ivwZvd5oqtEpfXc/R9KpGl/d82byv5IEeCugEZ7eiJ046gcfHZ6nxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786605064; c=relaxed/simple;
	bh=DjpsmVN0cVoUyNLW9772/sB5yOgSKXNiZsz9RlC1Gxk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lWZofK9fN+bETnOzxWYpX1WsXqVJYABltA5wY25YwdyO3j+a/Ut6E41vgHdYrkHDmcwVCn29chFJTdIHc9WZqVuAOMUrHoXPNcjI6wca4+SbmzoV+6BGr4BsBxAKYz5IA4QrMXWR6iYCUvKEEozLKTK6oTL2yOFXO/2lGtkQsNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofVUZFF8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofVUZFF8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CBD1F000E9;
	Thu, 13 Aug 2026 07:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786605062;
	bh=V9t+Dhd3iO57HSyOv7NBURqqTY960/5SlARuSIwHs8Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ofVUZFF80ZwmHZQnzoUo7+YnHU2vV2Q8eGZkpno2SvhQRbYVL+/YDR9ewH+acUzJA
	 QsuC3muS3Urp5s/4OrxLISlBAkk814w+iLU5DnAT6mzzrO5Rl7zNhaXGKVGN1a90KE
	 UbkYhIokkrNjwxZ9qX+10ScrTGG1lyw8zDUzILlPXwZUgw+YXor2ZswTFlmosaREi1
	 4ndjSNnMWFLO9SeKTp3PI/1BDeyV0UzNQ0U8K4W1Av0BRYEEOW2viVg5ltjSzmaBm6
	 BKD67GVZVtsql30fuXGuo9zSu8zd1itCWq/zV5WpawVb6RmofW5tN3Hu83ftnwWopE
	 ld9kbfxCvV1Yg==
Content-Type: multipart/mixed; boundary="===============6934854194846056090=="
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a56bb62031244717218d4c0af380ce8598020778a0d9b3f51a7c6af405d5a437@mail.kernel.org>
In-Reply-To: <20260813060528.365959-1-kartikey406@gmail.com>
References: <20260813060528.365959-1-kartikey406@gmail.com>
Subject: Re: [PATCH v2] perf/bpf: Fix data races in BPF perf event handling
From: bot+bpf-ci@kernel.org
To: kartikey406@gmail.com,peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org,mark.rutland@arm.com,alexander.shishkin@linux.intel.com,jolsa@kernel.org,olsajiri@gmail.com,irogers@google.com,adrian.hunter@intel.com,james.clark@linaro.org,song@kernel.org,kpsingh@kernel.org,mattbobrowski@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,yonghong.song@linux.dev,emil@etsalapatis.com,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com
Cc: linux-perf-users@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kartikey406@gmail.com,syzbot+651d2774bd1d8395595f@syzkaller.appspotmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 07:11:01 +0000 (UTC)

--===============6934854194846056090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 48d851fbd8ea5..5c6dabb6dccb1 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -2136,4 +2136,6 @@ static inline void perf_lopwr_cb(bool mode)
>  }
>  #endif
>
> +extern struct mutex bpf_event_mutex;
> +
>  #endif /* _LINUX_PERF_EVENT_H */

bpf_event_mutex is defined in kernel/trace/bpf_trace.c, which is only
built when CONFIG_BPF_EVENTS=y:

  kernel/trace/Makefile: obj-$(CONFIG_BPF_EVENTS) += bpf_trace.o

CONFIG_BPF_EVENTS depends on BPF_SYSCALL and also requires either
KPROBE_EVENTS or UPROBE_EVENTS (kernel/trace/Kconfig:853-855). However,
the new reference in perf_event_alloc() is guarded by the weaker condition
'#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)'.

CONFIG_EVENT_TRACING is selected by CONFIG_TRACING and has no dependency
on KPROBE_EVENTS or UPROBE_EVENTS. This means a config with
CONFIG_PERF_EVENTS=y, CONFIG_BPF_SYSCALL=y, CONFIG_TRACING=y,
CONFIG_KPROBES=n, and CONFIG_UPROBE_EVENTS=n will have CONFIG_BPF_EVENTS=n
and produce an undefined reference to bpf_event_mutex at link time.

Should the declaration be moved to include/linux/trace_events.h with
appropriate CONFIG_BPF_EVENTS guards, similar to how
perf_event_attach_bpf_prog() and perf_event_detach_bpf_prog() are
declared there?

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index ba5bd6a78fe7b..1416066ef460e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10652,20 +10652,19 @@ static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *r
>  #ifdef CONFIG_BPF_SYSCALL
>  static int bpf_overflow_handler(struct perf_event *event,
>  				struct perf_sample_data *data,
> -				struct pt_regs *regs)
> +				struct pt_regs *regs,
> +				struct bpf_prog *prog)
>  {
>  	struct bpf_perf_event_data_kern ctx = {
>  		.data = data,
>  		.event = event,
>  	};
> -	struct bpf_prog *prog;
>  	int ret = 0;
>
>  	ctx.regs = perf_arch_bpf_user_pt_regs(regs);
>  	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
>  		goto out;
>  	rcu_read_lock();
> -	prog = READ_ONCE(event->prog);
>  	if (prog) {
>  		perf_prepare_sample(data, event, regs);
>  		ret = bpf_prog_run(prog, &ctx);

The function signature was updated to add the fourth parameter, but the
!CONFIG_BPF_SYSCALL stub at the end of this file was not updated:

  #else
  static inline int bpf_overflow_handler(struct perf_event *event,
                                         struct perf_sample_data *data,
                                         struct pt_regs *regs)
  {
      return 1;
  }

The call site at __perf_event_overflow() passes four arguments and is not
inside any CONFIG_BPF_SYSCALL guard. Since kernel/events/core.c is built
unconditionally for CONFIG_PERF_EVENTS=y, any CONFIG_PERF_EVENTS=y,
CONFIG_BPF_SYSCALL=n build will fail with "error: too many arguments to
function bpf_overflow_handler".

Should the stub also take the fourth 'struct bpf_prog *prog' parameter?

> @@ -10708,7 +10707,7 @@ static inline int perf_event_set_bpf_handler(struct perf_event *event,
>  		return -EPROTO;
>  	}
>
> -	event->prog = prog;
> +	WRITE_ONCE(event->prog, prog);
>  	event->bpf_cookie = bpf_cookie;
>  	return 0;
>  }
> @@ -10720,7 +10719,7 @@ static inline void perf_event_free_bpf_handler(struct perf_event *event)
>  	if (!prog)
>  		return;
>
> -	event->prog = NULL;
> +	WRITE_ONCE(event->prog, NULL);
>  	bpf_prog_put(prog);
>  }
>  #else
> @@ -10753,6 +10752,7 @@ static int __perf_event_overflow(struct perf_event *event,
>  {
>  	int events = atomic_read(&event->event_limit);
>  	int ret = 0;
> +	struct bpf_prog *prog;
>
>  	/*
>  	 * Non-sampling counters might still use the PMI to fold short
> @@ -10766,8 +10766,9 @@ static int __perf_event_overflow(struct perf_event *event,
>  	if (event->attr.aux_pause)
>  		perf_event_aux_pause(event->aux_event, true);
>
> -	if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
> -	    !bpf_overflow_handler(event, data, regs))
> +	prog = READ_ONCE(event->prog);
> +	if (prog && prog->type == BPF_PROG_TYPE_PERF_EVENT &&
> +	    !bpf_overflow_handler(event, data, regs, prog))
>  		goto out;
>
>  	/*

[ ... ]

> @@ -13433,12 +13434,15 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>  		overflow_handler = parent_event->overflow_handler;
>  		context = parent_event->overflow_handler_context;
>  #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
> -		if (parent_event->prog) {
> -			struct bpf_prog *prog = parent_event->prog;
> +		struct bpf_prog *prog;
>
> +		mutex_lock(&bpf_event_mutex);
> +		prog = parent_event->prog;
> +		if (prog) {
>  			bpf_prog_inc(prog);
>  			event->prog = prog;
>  		}
> +		mutex_unlock(&bpf_event_mutex);
>  #endif
>  	}
>

bpf_event_mutex is taken to serialize against concurrent detach during
fork, but does this actually protect against all writers?

event->prog has two sets of writers:
(a) tracing events: perf_event_attach_bpf_prog() and
    perf_event_detach_bpf_prog() in kernel/trace/bpf_trace.c - these hold
    bpf_event_mutex
(b) non-tracing events (BPF_PROG_TYPE_PERF_EVENT):
    perf_event_set_bpf_handler() and perf_event_free_bpf_handler() in
    kernel/events/core.c - these do not hold bpf_event_mutex

For case (b), the concurrent path remains unprotected:

  bpf_perf_link_release()  (kernel/bpf/syscall.c, bpf_link fd close)
    -> perf_event_free_bpf_prog()
       -> perf_event_free_bpf_handler()
            struct bpf_prog *prog = event->prog;
            WRITE_ONCE(event->prog, NULL);
            bpf_prog_put(prog);

versus the fork path here:

  perf_event_init_context()  (holds parent_ctx->mutex only)
    -> inherit_task_group -> inherit_group -> inherit_event()
       -> perf_event_alloc()
            mutex_lock(&bpf_event_mutex);
            prog = parent_event->prog;
            if (prog) bpf_prog_inc(prog);

Timeline:
  CPU0: mutex_lock(&bpf_event_mutex); prog = parent_event->prog  -> P
  CPU0: preempted
  CPU1: perf_event_free_bpf_handler(): WRITE_ONCE(event->prog, NULL);
        bpf_prog_put(P); -> refcnt -> 0, free deferred by call_rcu()
  CPU0: bpf_prog_inc(P) on an object already at zero and queued for
        freeing

bpf_perf_link_release() takes neither ctx->mutex nor bpf_event_mutex, so
the NULL-deref/use-after-free window remains open for overflow-handler
progs.

Should perf_event_free_bpf_handler() also take bpf_event_mutex, or should
the inherit be serialized differently (e.g., under the event's ctx->mutex)?

Also, the read stayed a plain load rather than READ_ONCE(), so it still
data-races with the WRITE_ONCE(event->prog, NULL) added in this same
patch.

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 29260951aa871..e91676ae6cfb4 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1944,7 +1944,7 @@ const struct bpf_verifier_ops perf_event_verifier_ops = {
>  const struct bpf_prog_ops perf_event_prog_ops = {
>  };
>
> -static DEFINE_MUTEX(bpf_event_mutex);
> +DEFINE_MUTEX(bpf_event_mutex);
>
>  #define BPF_TRACE_MAX_PROGS 64

[ ... ]

> @@ -2018,7 +2018,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
>
>  put:
>  	prog = event->prog;
> -	event->prog = NULL;
> +	WRITE_ONCE(event->prog, NULL);
>
>  unlock:
>  	mutex_unlock(&bpf_event_mutex);

The commit message states "Fix by using WRITE_ONCE() in all write paths
including perf_event_detach_bpf_prog()", but the matching attach function
in the same file was left as a plain store:

  kernel/trace/bpf_trace.c perf_event_attach_bpf_prog():
      event->prog = prog;

perf_event_attach_bpf_prog() is a writer of the same field that
__perf_event_overflow() now reads with READ_ONCE(). The attach path can
be called on already-enabled tracepoint events that are concurrently
firing (via ioctl(PERF_EVENT_IOC_SET_BPF) or BPF_LINK_CREATE), so KCSAN
can still report 'data-race in __perf_event_overflow /
perf_event_attach_bpf_prog' (marked READ_ONCE vs plain write).

Similarly, several other plain reads remain:
- perf_event_free_bpf_handler(): 'struct bpf_prog *prog = event->prog;'
- perf_event_free_bpf_prog() read before dispatching
- perf_event_set_bpf_handler() checks before writing
- perf_event_detach_bpf_prog() reads before the WRITE_ONCE
- perf_event_alloc() read in the new mutex-protected section

Should the remaining plain writes be converted to WRITE_ONCE() and the
plain reads to READ_ONCE() to complete the annotation coverage?

---

The commit message describes the changes and their intent:

>     Fix multiple data races involving event->prog field:
>     1. __perf_event_overflow() reads event->prog twice without
>        synchronization creating a TOCTOU race. Fix by using READ_ONCE()
>        to capture prog into a local variable and pass it directly to
>        bpf_overflow_handler() to avoid a second read inside that function.

The fix does eliminate the double-read and the dropped-sample bug. However,
moving the READ_ONCE() out of bpf_overflow_handler() also moves it outside
the rcu_read_lock() that previously ensured the prog couldn't be freed
before bpf_prog_run().

Pre-patch: bpf_overflow_handler() did 'rcu_read_lock(); prog =
READ_ONCE(event->prog);' and then used that pointer. Since
perf_event_free_bpf_handler() stores NULL before bpf_prog_put(), and
freeing is RCU-deferred (call_rcu() in __bpf_prog_put_noref()), observing
a non-NULL prog inside the RCU section guaranteed the object couldn't be
freed before rcu_read_unlock().

Post-patch: the pointer is loaded in __perf_event_overflow() before
rcu_read_lock(), so in principle bpf_prog_run() could be handed an
already-freed prog if the grace period ends between the READ_ONCE() and
the rcu_read_lock().

Looking at the call paths, __perf_event_overflow() is reached with
preemption and IRQs disabled (perf_event_overflow() asserts
lockdep_assert_irqs_disabled()), which is an implicit RCU read-side
critical section covering the whole call, so the object is protected.

Should the commit message mention this trade-off, or should the code
document why the moved load is still safe despite being outside the
explicit rcu_read_lock()?

>     2. perf_event_set_bpf_handler() and perf_event_free_bpf_handler()
>        perform plain writes to event->prog without WRITE_ONCE(), failing
>        to pair with the READ_ONCE() in __perf_event_overflow().

Before this patch there was no READ_ONCE() in __perf_event_overflow() at
all - the only READ_ONCE(event->prog) was in bpf_overflow_handler(), and
this patch deletes it. The sentence describes the pre-existing code as
failing to pair with something the same patch introduces.

The substantive point (an unpaired marked read existed) is accurate, but
it was in bpf_overflow_handler(), not __perf_event_overflow().

Should this be clarified to say the plain writes failed to pair with the
READ_ONCE() that was in bpf_overflow_handler()?

>     3. perf_event_alloc() reads parent_event->prog locklessly during
>        fork() which can race with a concurrent detach clearing and freeing
>        the prog, potentially causing a NULL pointer dereference or
>        use-after-free in bpf_prog_inc(). Fix by holding bpf_event_mutex
>        when inheriting the BPF program.

As noted above, bpf_event_mutex is only held by the tracing event
attach/detach paths in kernel/trace/bpf_trace.c. It is not taken by
perf_event_free_bpf_handler(), which is the detach path for non-tracing
events (BPF_PROG_TYPE_PERF_EVENT).

perf_event_free_bpf_prog() dispatches based on perf_event_is_tracing()
and routes BPF_PROG_TYPE_PERF_EVENT progs to perf_event_free_bpf_handler(),
which does 'WRITE_ONCE(event->prog, NULL); bpf_prog_put(prog);' with no
lock at all.

A BPF_PROG_TYPE_PERF_EVENT prog can be attached to an inheritable sampling
event, and the inherit block in perf_event_alloc() is not restricted by
event type. For that case the NULL-deref/refcount-resurrection race
described above remains open.

Holding bpf_event_mutex does correctly close the race against
perf_event_detach_bpf_prog() (which clears event->prog under the mutex and
only calls bpf_prog_put() after unlocking).

Should the commit message clarify that the fix is partial and only covers
tracing events, or should perf_event_free_bpf_handler() also take
bpf_event_mutex?

>     Make bpf_event_mutex non-static and declare it extern in perf_event.h
>     so it is accessible from kernel/events/core.c.

The declaration is added to include/linux/perf_event.h outside any CONFIG
guard, but bpf_event_mutex is only defined when CONFIG_BPF_EVENTS=y
(kernel/trace/bpf_trace.o is only built for CONFIG_BPF_EVENTS).

The new mutex_lock/unlock reference in kernel/events/core.c is guarded by
'#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)', which
is strictly weaker than CONFIG_BPF_EVENTS (CONFIG_BPF_EVENTS additionally
requires KPROBE_EVENTS || UPROBE_EVENTS). A valid config with
CONFIG_BPF_SYSCALL=y, CONFIG_TRACING=y, CONFIG_KPROBES=n, and
CONFIG_UPROBE_EVENTS=n yields CONFIG_BPF_EVENTS=n and an undefined
reference at link time.

This creates both a build failure and a layering concern (exposing a
bpf_trace.c-internal mutex through the global perf_event.h). Other
bpf_trace.c functions (perf_event_attach_bpf_prog,
perf_event_detach_bpf_prog, perf_event_query_prog_array) are declared in
include/linux/trace_events.h under CONFIG_BPF_EVENTS with !BPF_EVENTS
stubs.

Should bpf_event_mutex follow the same pattern?

---

This commit fixes data races but lacks a Fixes: tag. The bugs were
introduced when BPF perf event support was first added. Suggested:

  Fixes: aa6a5f3cb2b2 ("perf, bpf: add perf events core support for BPF_PROG_TYPE_PERF_EVENT programs")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31673322805
--===============6934854194846056090==--
