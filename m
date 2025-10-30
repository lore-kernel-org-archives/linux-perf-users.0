Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCBE41C69;
	Thu, 30 Oct 2025 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783000; cv=none; b=ug7ScxxvJ0BiUDg6JQG2KyoSE8OTP6TIMCVnarrcx4ZdZJAaxbWvFZqRDO0PwMhehjsL2WZsfFcoetSVo4l8uFYE5TBr+FgljZTHDJLx0I0xlQO4kzLv+iNjbAqAbvLyfWNKfGGPETABYRvNm2eiN8ZkI0Pc1Y2/Ceq5l3V4264=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783000; c=relaxed/simple;
	bh=AceE3gCsdl1DA5X4XGmZcEf7H6HBtxryjxL7lc5Pcck=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uH/kt+cay4bb2Wi6oTBdiSgVR5Bhn4lFObbyVJao1IazgvJhIJBAgIPz02gzC4mxLOejmtzozyl2RAM++nH+Nb9aygldLTlKoH8yp+0Z8LCP7wAZrwa5udfYWXQHpTQhpBbNVRmUE/i+cpefJSRhGpPHsTuccsU2RZeUbxhoqOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbRGlLY+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbRGlLY+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF33C4CEFD;
	Thu, 30 Oct 2025 00:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761782999;
	bh=AceE3gCsdl1DA5X4XGmZcEf7H6HBtxryjxL7lc5Pcck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SbRGlLY+9om9klZoA9dwo0WYQHobN4e/PU1/Y8xveEi/7ZI2WDhT5chQdEcNm1QSX
	 U8hGhrLPNXFnMwwB3ACZxo2YQNKuLaIiHTcQhYxHMqxt4JoujiphZ5LBZBBhelmbUd
	 G7An3QlOisuhVQ1yrhtLK35Yq0yrOIahqOORflXgp+X4SR+NKCLqkK3hWBQanEbb2c
	 X+wCNdVumjh3z/wYYIwZCKTGlnosCMgUaPWVk/qfexbcUkj4JSOE1F2zDqdo/adp1H
	 GFrCHO9OVd0GlFFJnZxrokMcF8fueJmg23t7c2ZO327wRVhEZFzq6Ts8DIb1GBMyn6
	 r18V3ftUKJGjQ==
Date: Thu, 30 Oct 2025 09:09:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mark Brown <broonie@kernel.org>, Masami Hiramatsu
 (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
 Jinchao Wang <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v5 6/8] selftests: tracing: Add a basic testcase for
 wprobe
Message-Id: <20251030090952.befea7f0cecd5518c7fda02c@kernel.org>
In-Reply-To: <20251029172004.a0aca144735f20a6a59d2aa6@kernel.org>
References: <175859019940.374439.7398451124225791618.stgit@devnote2>
	<175859026716.374439.14852239332989324292.stgit@devnote2>
	<aPvwGhMBJqMKcC9D@finisterre.sirena.org.uk>
	<20251027224347.4c887cc956df63602f377550@kernel.org>
	<20251028084222.a3c1ae97d125d9bd88fc565b@kernel.org>
	<20251028105549.ae94e8eeb42f4efc183d2807@kernel.org>
	<20251029004219.dc9cda0eb56ae46c55855844@kernel.org>
	<20251029114317.167b7d908533385c1c9e6782@kernel.org>
	<20251029172004.a0aca144735f20a6a59d2aa6@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 17:20:04 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Wed, 29 Oct 2025 11:43:17 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > Hmm, it seems that jiffies related things are updated frequently
> > > and it may cause interrupt storm or infinit recursive call.
> > 
> > I added another trace_printk() in el1_watchpt(). It seems el1_watchpt()
> > takes too long and there is no time to do any other things.
> > (Note the interval shown below is only within the el1_watchpt function,
> >  and in reality various processes (save/restore registers etc) for
> >  exception handling will be inserted before and after.)
> 
> Forget about this. I found the root cause. The x86 watchpoint exception
> happens after the instruction is executed, the arm64 happens before.
> 
> Thus what we need is to emulate or do single step the hooked instruction
> and restart from the next instruction from the watchpoint exception on
> arm64. I thought hw_breakpoint does that, but doesn't. Should we do this
> in do_watchpoint() or in user_handler?

There is a single step execution code but only for default overflow_handlers.
This is a bit strange becuase other users can not set it up outside of
the arch dependent code. Even if it can, it is simply redundant.

So I made changes below which allow users to set its own custom handler is
compatible with perf default overflow handlers.
I confirmed this works on both arm and arm64.

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index ab76b36dce82..e12ec95b471e 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -632,6 +632,7 @@ void do_breakpoint(unsigned long esr, struct pt_regs *regs)
 	addr = instruction_pointer(regs);
 	debug_info = &current->thread.debug;
 
+	trace_printk("breakpoint exception at address: 0x%lx\n", addr);
 	for (i = 0; i < core_num_brps; ++i) {
 		rcu_read_lock();
 
@@ -661,6 +662,7 @@ void do_breakpoint(unsigned long esr, struct pt_regs *regs)
 		rcu_read_unlock();
 	}
 
+	trace_printk("breakpoint handling complete, step=%d\n", step);
 	if (!step)
 		return;
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fd1d91017b99..40dd897e26b0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -902,6 +902,7 @@ struct perf_event {
 	u64				(*clock)(void);
 	perf_overflow_handler_t		overflow_handler;
 	void				*overflow_handler_context;
+	bool				default_overflow_compatible;
 	struct bpf_prog			*prog;
 	u64				bpf_cookie;
 
@@ -1505,13 +1506,7 @@ extern int perf_event_output(struct perf_event *event,
 static inline bool
 is_default_overflow_handler(struct perf_event *event)
 {
-	perf_overflow_handler_t overflow_handler = event->overflow_handler;
-
-	if (likely(overflow_handler == perf_event_output_forward))
-		return true;
-	if (unlikely(overflow_handler == perf_event_output_backward))
-		return true;
-	return false;
+	return event->default_overflow_compatible;
 }
 
 extern void
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 177e57c1a362..6bbbde82cb21 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12946,9 +12946,11 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	} else if (is_write_backward(event)){
 		event->overflow_handler = perf_event_output_backward;
 		event->overflow_handler_context = NULL;
+		event->default_overflow_compatible = true;
 	} else {
 		event->overflow_handler = perf_event_output_forward;
 		event->overflow_handler_context = NULL;
+		event->default_overflow_compatible = true;
 	}
 
 	perf_event__state_init(event);
diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
index 98605b207f43..f2c2f26fd668 100644
--- a/kernel/trace/trace_wprobe.c
+++ b/kernel/trace/trace_wprobe.c
@@ -163,6 +163,8 @@ static void wprobe_perf_handler(struct perf_event *bp,
 static int __register_trace_wprobe(struct trace_wprobe *tw)
 {
 	struct perf_event_attr attr;
+	struct perf_event *bp;
+	int cpu;
 
 	if (tw->bp_event)
 		return -EINVAL;
@@ -179,6 +181,11 @@ static int __register_trace_wprobe(struct trace_wprobe *tw)
 		tw->bp_event = NULL;
 		return ret;
 	}
+	/* Mark wprobe_perf_handler is compatible with default one. */
+	for_each_online_cpu(cpu) {
+		bp = per_cpu(*tw->bp_event, cpu);
+		bp->default_overflow_compatible = true;
+	}
 
 	return 0;
 }

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
