Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6A22749F1;
	Mon, 13 Jul 2026 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783954185; cv=none; b=qVDpdrzLdaecBfhCjIsYoMsfcLTRKlHovUjyjZbk5lxsYbyX2Lmt3DCqzSt8eZyynZOkEMRAeytJ3dU8hR1D3pC3hG5jRNkuhH1341CkQRjr5MgiR8OgBhSvZnbI2iOquwTNg3nvsgk4uj2+TW/H6LnuK2C4qAwqcXm3uKtL+QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783954185; c=relaxed/simple;
	bh=wcucBth7D3UCFJaLO/PqHyH3F/M6Tli3Uk7k3LnRg/I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AzVKPyNaFPbGWPbIxPW/75lVx+n6CdyqLuwZm3px60FmRDs/NSUlU3J5rlKRAoP6Y0LxiDTAftWrpNPUt7RC7YHgtEorbrjCiUVrB+dnuQQkGPibSyzrKx31026JENNTKWm23sDZr9elfuPSUo7Goky1SV8wk6y9qf2IdMe2VIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t1YTHtIT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rlsw8EM0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t1YTHtIT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rlsw8EM0"
Date: Mon, 13 Jul 2026 16:49:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783954181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GKlkX+jzXeOctEvEU+Hiz4rEbD81hPI0L4pAMA9OoXY=;
	b=t1YTHtITBTztRKcQz+KC2jZOo9E8T563HEN+j+y0CTKDt/Ob+Mi2kL9Fq1FAmsd19Ll6UK
	tbD4n61PqdAyT2qfVlYhCC563tJpCOU2AspmI3P4gouJLsSTiaT6wL7mVVcYYN46ZpOs+h
	rRNbkDXWqdml6yjIS/35a5amyPzurHkaofu5WHvZMYXqXVmP3bUVtN+tjKgbHkLBvMQ/Wo
	PrmU9vb2ftxgSyBbSqWXigSfBt0NoGYxH040CdMB4DjlQgCU+ov2mRHIfOD9wWy0KnncKF
	R57m0vdzHHmcT32tm6+kzTS6TvPKE+pOF4cLWmJZ5Tg+pR/r4JVzwm/8OTxOqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783954181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GKlkX+jzXeOctEvEU+Hiz4rEbD81hPI0L4pAMA9OoXY=;
	b=Rlsw8EM0jL1P6f9KvF9BOR1HUh9hmiUlwbNibTbG8xGQ1+oVXgXRyF1cqcWLEIbyHDdoGF
	7PyeX5BqpPaR0rDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Waiman Long <longman@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	WANG Xuerui <kernel@xen0n.name>, linux-perf-users@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [RFC PATCH] ARM, ARM64, LOONGARCH: Delay HW BP notification to
 task_work()
Message-ID: <20260713144939.FuCj9yvZ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Waiman, Luis, Ada reported that HW breakpoints on ARM64 trigger
"sleeping while atomic" warnings on PREEMPT_RT. The hardware event is
delivered with disabled interrupts and perf intrastrucure expects
disabled interrupts while the overflow callback is invoked.

The callback then sends a SIGTRAP signal for which it acquires
sighand_struct::siglock, a spinlock_t which becomes a sleeping lock and
must not be acquired in atomic context.

Delay the event callback until the return to userland.
Add perf_arch_hwbp_notify(), a generic perf callback which delayes the
actual callback invocation to task_work_add() callback. This callback
invokes the architecture defines callback arch_hwbp_send_sig().
This requires struct callback_head and the functions require
ARCH_NEED_PERF_HW_NOTIF to be defined.

This was reported against ARM64. ARM and LongARCH follow the same
pattern are also converted.

Reported-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reported-by: Waiman Long <longman@redhat.com>
Closes: https://lore.kernel.org/all/aho0eqjMESuHxECr@redhat.com/
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

This is approximately the fifth iteration at which point I think I can
share what I have.

Could this be tested, please? I tested it on arm64 for arm64 based on
Luis' test. ARM compiles my HW lacks support for this I think (gdb
aborts early). I hope the best for LoongARCH.

Are the perf bits okay or is it too gross?

 arch/arm/include/asm/hw_breakpoint.h       |  1 +
 arch/arm/kernel/ptrace.c                   |  6 ++----
 arch/arm64/include/asm/hw_breakpoint.h     |  1 +
 arch/arm64/kernel/ptrace.c                 |  6 ++----
 arch/loongarch/include/asm/hw_breakpoint.h |  1 +
 arch/loongarch/kernel/ptrace.c             |  6 ++----
 include/linux/hw_breakpoint.h              |  3 +++
 include/linux/perf_event.h                 |  3 +++
 kernel/events/core.c                       | 24 ++++++++++++++++++++++
 9 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw_breakpoint.h
index e7f9961c53b2d..5b3a373348ff5 100644
--- a/arch/arm/include/asm/hw_breakpoint.h
+++ b/arch/arm/include/asm/hw_breakpoint.h
@@ -7,6 +7,7 @@
 struct task_struct;
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
+#define ARCH_NEED_PERF_HW_NOTIF
 
 struct arch_hw_breakpoint_ctrl {
 		u32 __reserved	: 9,
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 7951b2c06fec6..1650f12a04702 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -347,9 +347,7 @@ static long ptrace_hbp_idx_to_num(int idx)
 /*
  * Handle hitting a HW-breakpoint.
  */
-static void ptrace_hbptriggered(struct perf_event *bp,
-				     struct perf_sample_data *data,
-				     struct pt_regs *regs)
+void arch_hwbp_send_sig(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
 	long num;
@@ -424,7 +422,7 @@ static struct perf_event *ptrace_hbp_create(struct task_struct *tsk, int type)
 	attr.bp_type	= type;
 	attr.disabled	= 1;
 
-	return register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL,
+	return register_user_hw_breakpoint(&attr, perf_arch_hwbp_notify, NULL,
 					   tsk);
 }
 
diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index bd81cf17744af..58befb79c885c 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -124,6 +124,7 @@ extern void hw_breakpoint_pmu_read(struct perf_event *bp);
 extern int hw_breakpoint_slots(int type);
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
+#define ARCH_NEED_PERF_HW_NOTIF
 extern void hw_breakpoint_thread_switch(struct task_struct *next);
 extern void ptrace_hw_copy_thread(struct task_struct *task);
 #else
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 4d08598e2891d..df6122779ada6 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -168,9 +168,7 @@ void ptrace_disable(struct task_struct *child)
 /*
  * Handle hitting a HW-breakpoint.
  */
-static void ptrace_hbptriggered(struct perf_event *bp,
-				struct perf_sample_data *data,
-				struct pt_regs *regs)
+void arch_hwbp_send_sig(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
 	const char *desc = "Hardware breakpoint trap (ptrace)";
@@ -312,7 +310,7 @@ static struct perf_event *ptrace_hbp_create(unsigned int note_type,
 	attr.bp_type	= type;
 	attr.disabled	= 1;
 
-	bp = register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL, tsk);
+	bp = register_user_hw_breakpoint(&attr, perf_arch_hwbp_notify, NULL, tsk);
 	if (IS_ERR(bp))
 		return bp;
 
diff --git a/arch/loongarch/include/asm/hw_breakpoint.h b/arch/loongarch/include/asm/hw_breakpoint.h
index 5faa97a87a9e2..2b51922eb5492 100644
--- a/arch/loongarch/include/asm/hw_breakpoint.h
+++ b/arch/loongarch/include/asm/hw_breakpoint.h
@@ -120,6 +120,7 @@ void breakpoint_handler(struct pt_regs *regs);
 void watchpoint_handler(struct pt_regs *regs);
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
+#define ARCH_NEED_PERF_HW_NOTIF
 extern void ptrace_hw_copy_thread(struct task_struct *task);
 extern void hw_breakpoint_thread_switch(struct task_struct *next);
 #else
diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrace.c
index be38430f7e280..1d5e05a70b8d3 100644
--- a/arch/loongarch/kernel/ptrace.c
+++ b/arch/loongarch/kernel/ptrace.c
@@ -384,9 +384,7 @@ static int lbt_set(struct task_struct *target,
 /*
  * Handle hitting a HW-breakpoint.
  */
-static void ptrace_hbptriggered(struct perf_event *bp,
-				struct perf_sample_data *data,
-				struct pt_regs *regs)
+void arch_hwbp_send_sig(struct perf_event *bp)
 {
 	int i;
 	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
@@ -479,7 +477,7 @@ static struct perf_event *ptrace_hbp_create(unsigned int note_type,
 	attr.bp_type	= type;
 	attr.disabled	= 1;
 
-	bp = register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL, tsk);
+	bp = register_user_hw_breakpoint(&attr, perf_arch_hwbp_notify, NULL, tsk);
 	if (IS_ERR(bp))
 		return bp;
 
diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index db199d653dd1a..bb4c1064a103d 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -85,6 +85,9 @@ extern int register_perf_hw_breakpoint(struct perf_event *bp);
 extern void unregister_hw_breakpoint(struct perf_event *bp);
 extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events);
 extern bool hw_breakpoint_is_used(void);
+extern void arch_hwbp_send_sig(struct perf_event *bp);
+extern void perf_arch_hwbp_notify(struct perf_event *bp, struct perf_sample_data *data,
+				  struct pt_regs *regs);
 
 extern int dbg_reserve_bp_slot(struct perf_event *bp);
 extern int dbg_release_bp_slot(struct perf_event *bp);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 48d851fbd8ea5..bc7fae88a2742 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -215,6 +215,9 @@ struct hw_perf_event {
 
 	/* Last sync'ed generation of filters */
 	unsigned long			addr_filters_gen;
+#ifdef ARCH_NEED_PERF_HW_NOTIF
+	struct callback_head		arch_hw_notif;
+#endif
 
 /*
  * hw_perf_event::state flags; used to track the PERF_EF_* state.
diff --git a/kernel/events/core.c b/kernel/events/core.c
index d7f3e2c2ecb1e..1f70cdb52f068 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13336,6 +13336,26 @@ static void account_event(struct perf_event *event)
 	account_pmu_sb_event(event);
 }
 
+#ifdef ARCH_NEED_PERF_HW_NOTIF
+static void perf_arch_hwbp_send_sig(struct callback_head *head)
+{
+	struct perf_event *bp;
+
+	bp = container_of(head, struct perf_event, hw.arch_hw_notif);
+	arch_hwbp_send_sig(bp);
+	put_event(bp);
+}
+
+void perf_arch_hwbp_notify(struct perf_event *bp, struct perf_sample_data *data,
+			   struct pt_regs *regs)
+{
+	if (WARN_ON_ONCE(!atomic_long_inc_not_zero(&bp->refcount)))
+		return;
+	if (WARN_ON_ONCE(task_work_add(current, &bp->hw.arch_hw_notif, TWA_RESUME)))
+		put_event(bp);
+}
+#endif
+
 /*
  * Allocate and initialize an event structure
  */
@@ -13441,6 +13461,10 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	}
 
 	if (overflow_handler) {
+#ifdef ARCH_NEED_PERF_HW_NOTIF
+		if (overflow_handler == perf_arch_hwbp_notify)
+			init_task_work(&event->hw.arch_hw_notif, perf_arch_hwbp_send_sig);
+#endif
 		event->overflow_handler	= overflow_handler;
 		event->overflow_handler_context = context;
 	} else if (is_write_backward(event)){
-- 
2.53.0

