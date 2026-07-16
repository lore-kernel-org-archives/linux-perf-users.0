Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB3C2E739A;
	Thu, 16 Jul 2026 02:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784169442; cv=none; b=aTWU5psAaCRb3rm4TIgl8CQm97kj4WczG48lqAMkf+DjP0S+DYfcpdKtLpdN7n7MbIPkrsRFODrFGoF34agqObHF1z9FthJqk/Y4cOa7K7L6DixDiQrnz/NCtdTlwxmCUCH/XSdWo73CV7L4sXXXwwktTeyIKqN8nHCA6RHucQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784169442; c=relaxed/simple;
	bh=qh3MXJ4zX+PzAH+IjADYpiOM1VCNO89t+VDqgXX5oQ8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GzDgPW/09PJe800bQIW0FUur3PJOhiotAF5uJF8TOauZ18RzdgzyXW/dqAJ4Y4nbRxVyxGtDKM3Hqplx2uD79n6aX3vVrWbmpjPj43bKbCeUI3/Lq2MTNBEXtnhqU3Y9tNPUEzK1WzCqtPgFV4K3su04Y7YqiF+97wecrEhp8WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bd/IIAU5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bd/IIAU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3ED1F000E9;
	Thu, 16 Jul 2026 02:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784169440;
	bh=WmoFwcuL/Sj1/kJRhDt+nVyg5ufKUIzE4A2ZN4dKudc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Bd/IIAU5oAGXnSiWQvC68ALSpH2NxX2ZbSJsLmeecD2Awu+WOvrffJCc4nwq1v9sv
	 znclPfoAkgvq9HNjZ+Lg4/Ev1u2FbFx/FG0Hrjw730YO9VF1TXVXLhyJ7znxytd/zi
	 UlwtOkdztHtR7QzBVamsAqpjx0VJj7qah1EUGfD/CSmnSt2h63kpy5C2zIX1c8GAKp
	 LkOgplTcim5e4xAZWymLNfNlmvazIWZ/s5Zy6RNfxbi2mG3vJdxfoO0eH4egsig27M
	 b0ViEHYmUu5Pdk6fKALqxxjVg9uf75SQvqIuPQG35W9SSa0C1rVfbd7jsxJybRXFBD
	 O28hzGgrg/OPQ==
Date: Thu, 16 Jul 2026 11:37:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org,
 linux-perf-users@vger.kernel.org, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v7 10/10] selftests: ftrace: Add wprobe trigger testcase
Message-Id: <20260716113716.55cfcd374d78f94620209ae5@kernel.org>
In-Reply-To: <20260716105913.e04dd8dfa271a263f959d847@kernel.org>
References: <178407983818.95826.12714571928538799781.stgit@devnote2>
	<178407995495.95826.11582585035165074036.stgit@devnote2>
	<20260715021641.B3D691F000E9@smtp.kernel.org>
	<20260716105913.e04dd8dfa271a263f959d847@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Oops, sorry for confusion, this is for [9/10].

Thanks,

On Thu, 16 Jul 2026 10:59:13 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Wed, 15 Jul 2026 02:05:55 +0000
> sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 8 potential issue(s) to consider:
> > - [Critical] Deadlocks due to NMI-unsafe operations (schedule_work and raw_spin_lock_irqsave) in tracepoint context.
> > - [High] Missing cancel_work_sync() causes a Use-After-Free of wprobe_trigger_data via the workqueue.
> > - [High] Synchronous free of wprobe_data violates RCU removal ordering, risking concurrent use-after-free.
> > - [High] Missing trace_event_try_get_ref() and imbalanced trace_event_put_ref() cause module refcount underflow.
> > - [High] on_each_cpu is called with wait=false for an IPI that references wprobe_data.
> > - [High] Immediate kfree() of RCU-protected trigger_data and wprobe_data on the error path.
> > - [Medium] Permanent memory leak of wprobe trigger objects on successful registration.
> > - [Medium] tw->addr is read and written concurrently by different triggers without a shared lock.
> > --
> > 
> 
> Thanks for the review comments.
> BTW, why this only to linux-perf-users? (Maybe I need to modify Sashiko setting)
> 
> > --- Patch [9]: [PATCH v7 09/10] tracing: wprobe: Add wprobe event trigger ---
> > The format of this report is altered due to recitation restrictions.
> > I am providing a free-form summary of the findings rather than inline
> > quoting the patch.
> > 
> > Commit: 4087513c82b11b98d27cfc4452df9a1a8e41ddd5
> > Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Subject: tracing: wprobe: Add wprobe event trigger
> > 
> > This patch adds a wprobe event trigger to set and clear watch events
> > dynamically, allowing watchpoints on local variables and slab objects.
> > 
> > [Severity: Critical]
> > Is it safe to call raw_spin_lock_irqsave() and schedule_work() directly
> > from wprobe_trigger()? Tracepoints can execute in arbitrary contexts,
> > including NMI or with scheduler locks held. Calling schedule_work() is
> > unsafe in these contexts. Additionally, acquiring wprobe_data->lock here
> > can cause a hard deadlock if the tracepoint interrupts wprobe_smp_update_func()
> > while it is holding the exact same lock in IPI context.
> 
> Hmm, good catch!
> OK, use a pair of irq_work and work to call on_each_cpu() for some
> interrupt context.
> For NMI context, I think wprobe_trigger should check the original state
> is in_nmi(). This can work for normal trace events or fprobe, but not
> for kprobes, because kprobe handler itself is working inside NMI context.
> Hmm, let me check how can I fix this. Until solving this problem, this
> wprobe trigger may not work with kprobes.
> Also, I found the lock should protect the wprobe itself, not data.
> Let me move the irq_work and lock to trace_wprobe.
> 
> Hmm, we may need to pass to original context (calculated by preempt_count)
> to trigger event so that it can evaluate the original context.
> (BTW, )
> 
> > [Severity: High]
> > Does free_wprobe_trigger_data() safely handle the embedded work struct?
> > When a trigger is unregistered, this function frees wprobe_data via kfree().
> > If wprobe_trigger() recently scheduled wprobe_data->work, the workqueue
> > could execute wprobe_work_func() on the freed memory since there is no
> > cancel_work_sync() before freeing.
> 
> OK, so move the worker to wprobe because anyway the worker will update
> the wprobe itself.
> 
> > 
> > [Severity: High]
> > Is an RCU grace period needed in wprobe_trigger_free()?
> > wprobe_unregister_trigger() unlinks the trigger and calls
> > wprobe_trigger_free(), which synchronously frees wprobe_data. Since
> > tracepoints execute under RCU, could a concurrent tracepoint execution
> > still be accessing wprobe_data when it gets freed?
> 
> Indeed, let's use call_rcu().
> 
> > 
> > [Severity: High]
> > Can the error path in wprobe_trigger_cmd_parse() cause a use-after-free?
> > If event_trigger_register() successfully exposes the trigger to RCU
> > readers but a subsequent step fails, returning an error causes the
> > __free(kfree) cleanup to immediately free trigger_data and wprobe_data.
> > This bypasses any RCU grace period for objects that were just briefly
> > exposed to concurrent tracepoint readers.
> 
> Ah, good catch. OK, let me call synchronize_rcu() before returning.
> 
> > 
> > [Severity: High]
> > Is it intentional that on_each_cpu() is called with wait=false in
> > wprobe_work_func()? Because it doesn't wait, the work function completes
> > immediately while IPIs are still pending on other CPUs. If the trigger
> > is unregistered and freed right after, wprobe_smp_update_func() will
> > access freed wprobe_data.
> 
> Ah, indeed. I will use a combination of irq_worker and worker and use
> on_each_cpu() with wait=true for safety.
> 
> > 
> > [Severity: High]
> > Does wprobe_trigger_cmd_parse() acquire the target event's module
> > reference? The code calls trace_event_enable_disable() directly without
> > first calling trace_event_try_get_ref(). However, wprobe_trigger_free()
> > unconditionally calls trace_event_put_ref(), which could lead to a module
> > refcount underflow.
> 
> OK, let me fix it.
> 
> > 
> > [Severity: Medium]
> > Is there a memory leak on the success path of wprobe_trigger_cmd_parse()?
> > The function increments the refcount via event_trigger_init(), and then
> > event_trigger_register() increments it again. On success, trigger_data
> > is set to NULL to bypass the cleanup macro, but the initial refcount is
> > never dropped. When the trigger is later unregistered, the refcount only
> > drops to 1, permanently leaking the objects.
> 
> OK, call trace_event_put_ref directly in wprobe_trigger_cmd_parse().
> 
> 
> > 
> > [Severity: Medium]
> > How is concurrent access to tw->addr synchronized between different
> > triggers? If a user attaches multiple triggers (e.g., set_wprobe and
> > clear_wprobe) targeting the same wprobe event, they allocate separate
> > wprobe_data instances with independent locks. When wprobe_trigger()
> > executes, they will read and write the shared tw->addr simultaneously
> > without a common lock, potentially corrupting the hardware breakpoint state.
> 
> I decided to use a lock in trace_wprobe side and use READ_ONCE/WRITE_ONCE()
> which may be enough.
> 
> Thank you,
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
