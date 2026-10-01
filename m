Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1114519913;
	Thu,  1 Oct 2026 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865326; cv=none; b=XmHvL3Szv4ARxb6Z3PP7Yil1Lf8GJUiSJGytl0Ct64KcLT00fNU2JDnWKxgGWZLsJ3FetPM7MgIf5L+aDHHgaB1AEE2Jeg7foRqmPtLxLlfY6/TFBWL2y2MfxKFSlyCpEw0vMVDoYsWZqCTjQzGK0mSSiSWO/kznQ0dLlEUHsRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865326; c=relaxed/simple;
	bh=ZiWoeMKY1Jphngt/Z/y3ntnoCVq0sjhGH6ELYj3GYzU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uMPrNf9TSUtkWQAAhDw1vKvTCbl9xK0r4UNtFCzQSFk+9oN7v2Onf4q75eX3PR1mYeDLmKqbt9UbTkFIVuMV6dgTj/v7m2BPVGWZDv5wgbo0Zg/8wJc2fWYGclvlCKwqL3oHi0L+xFQc+ocWkcK/PQ8NOf/9Iau/tErgIy9ikFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EGaf6LV7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qxQIiIii; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EGaf6LV7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qxQIiIii"
Date: Thu, 1 Oct 2026 16:35:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790865318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k/IwPDM4uQwinZ6vpUMMDSfiapx1SuzFEtGXvxkRX1Q=;
	b=EGaf6LV77GVDh2qDtBS0L0ovit6VuVSVy4N/Xwz7i0Ta16G5odiDggo/sSO6mXvnmlheX+
	fdi4vJcobMcItHJvKKfvUecvUL5egi4PtQ9NzOut7kuwONuZL1H3xZCxn42ItqZwIhemAQ
	036pj9i9DY8MsJPcwVaVtF3S0cT1F+L66zUzqkS+rOWsocEQfgfO4nD7YvB3T2u5LZvuN6
	pX6kAvgGpylcZCwkFof3ht4Rz1fbtlj4+FudktvQRK2B547T0cNa7G5Fk2F9OznyXftmfe
	w4hda6syyKrnXfykILWlypx5R1ReV+QsVJZq/xGMnuPy9/fKfVMBTiWkjtDiOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790865318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k/IwPDM4uQwinZ6vpUMMDSfiapx1SuzFEtGXvxkRX1Q=;
	b=qxQIiIiiGy8O4AGTLiYYaXjCtKmrOjVtRNmEImHWYW8A4ahFZYqlL1hApBmfn0uhfLJkDd
	gnkP2aSO54TzUXBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-perf-users@vger.kernel.org,
	loongarch@lists.linux.dev
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
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
	WANG Xuerui <kernel@xen0n.name>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3] ARM, ARM64, LONGARCH, XTENSA: Delay HW BP notification to
 task_work()
Message-ID: <20261001143516.Ew8C97WS@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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

This was reported against ARM64. ARM, LongARCH and Xtensa follow the
same pattern are also converted. Xtensa is the only not supporting
PREEMPT_RT but now we have all architectures using the same pattern.

Reported-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reported-by: Waiman Long <longman@redhat.com>
Closes: https://lore.kernel.org/all/aho0eqjMESuHxECr@redhat.com/
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

v2=E2=80=A6v3: https://lore.kernel.org/all/20260814085118.OPEA_Ssn@linutron=
ix.de/
 - Add Xtensa for completion
 - sashiko complains and wants TWA_SIGNAL instead TWA_RESUME. His
   argument is that a syscall will trap via get_user() and loop forever
   instead making progress. This is wrong IMHO. ARM64 will single step
   over the watchpoint and continue execution. The only downside is that
   userland will get notified after the syscall completed. So my theory.
   Using TWA_SIGNAL is worse: Assume we have a watchpoint on UADDR and
   are in a futex() syscall. The get_user() invocation will trigger the
   exception, the debug handler will step over and queue a signal. The
   futex code will notice this and return ERESTARTNOINTR. A signal will
   be sent, the syscall restarts, traps onto UADDR again, the loop
   continues. But this should be case now, too=E2=80=A6
   Now that I look into arch_build_bp_info() and do actual testing I must
   say arm64 does not support mixed breakpoints. This means there is no
   breakpoint in kernel on a userland address. \o/

v1=E2=80=A6v2: https://lore.kernel.org/all/20260713144939.FuCj9yvZ@linutron=
ix.de/
 - sashiko complained that a memory breakpoint might trigger several
   times before a signal is sent if the syscall touches the memory (via
   get_user()) more than once before returning back. This would lead to
   list corruption in task_work_add(). To handle this, there is now a
   variable which is set via xchg before task_work_add() and cleared
   after the signal has been sent.

 arch/arm/include/asm/hw_breakpoint.h       |  1 +
 arch/arm/kernel/ptrace.c                   |  6 ++---
 arch/arm64/include/asm/hw_breakpoint.h     |  1 +
 arch/arm64/kernel/ptrace.c                 |  6 ++---
 arch/loongarch/include/asm/hw_breakpoint.h |  1 +
 arch/loongarch/kernel/ptrace.c             |  6 ++---
 arch/xtensa/include/asm/hw_breakpoint.h    |  1 +
 arch/xtensa/kernel/ptrace.c                |  6 ++---
 include/linux/hw_breakpoint.h              |  3 +++
 include/linux/perf_event.h                 |  4 ++++
 kernel/events/core.c                       | 26 ++++++++++++++++++++++
 11 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw=
_breakpoint.h
index e7f9961c53b2d..5b3a373348ff5 100644
--- a/arch/arm/include/asm/hw_breakpoint.h
+++ b/arch/arm/include/asm/hw_breakpoint.h
@@ -7,6 +7,7 @@
 struct task_struct;
=20
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
+#define ARCH_NEED_PERF_HW_NOTIF
=20
 struct arch_hw_breakpoint_ctrl {
 		u32 __reserved	: 9,
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index ed7a2a87a6707..ab6ac7b88bd4e 100644
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
 	struct arch_hw_breakpoint *bkpt =3D counter_arch_bp(bp);
 	long num;
@@ -424,7 +422,7 @@ static struct perf_event *ptrace_hbp_create(struct task=
_struct *tsk, int type)
 	attr.bp_type	=3D type;
 	attr.disabled	=3D 1;
=20
-	return register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL,
+	return register_user_hw_breakpoint(&attr, perf_arch_hwbp_notify, NULL,
 					   tsk);
 }
=20
diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/as=
m/hw_breakpoint.h
index bd81cf17744af..58befb79c885c 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -124,6 +124,7 @@ extern void hw_breakpoint_pmu_read(struct perf_event *b=
p);
 extern int hw_breakpoint_slots(int type);
=20
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
+#define ARCH_NEED_PERF_HW_NOTIF
 extern void hw_breakpoint_thread_switch(struct task_struct *next);
 extern void ptrace_hw_copy_thread(struct task_struct *task);
 #else
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index f743cbec1c3ad..2a9d8bad98090 100644
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
 	struct arch_hw_breakpoint *bkpt =3D counter_arch_bp(bp);
 	const char *desc =3D "Hardware breakpoint trap (ptrace)";
@@ -312,7 +310,7 @@ static struct perf_event *ptrace_hbp_create(unsigned in=
t note_type,
 	attr.bp_type	=3D type;
 	attr.disabled	=3D 1;
=20
-	bp =3D register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL, tsk);
+	bp =3D register_user_hw_breakpoint(&attr, perf_arch_hwbp_notify, NULL, ts=
k);
 	if (IS_ERR(bp))
 		return bp;
=20
diff --git a/arch/loongarch/include/asm/hw_breakpoint.h b/arch/loongarch/in=
clude/asm/hw_breakpoint.h
index 5faa97a87a9e2..2b51922eb5492 100644
--- a/arch/loongarch/include/asm/hw_breakpoint.h
+++ b/arch/loongarch/include/asm/hw_breakpoint.h
@@ -120,6 +120,7 @@ void breakpoint_handler(struct pt_regs *regs);
 void watchpoint_handler(struct pt_regs *regs);
=20
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
 	struct arch_hw_breakpoint *bkpt =3D counter_arch_bp(bp);
@@ -479,7 +477,7 @@ static struct perf_event *ptrace_hbp_create(unsigned in=
t note_type,
 	attr.bp_type	=3D type;
 	attr.disabled	=3D 1;
=20
-	bp =3D register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL, tsk);
+	bp =3D register_user_hw_breakpoint(&attr, perf_arch_hwbp_notify, NULL, ts=
k);
 	if (IS_ERR(bp))
 		return bp;
=20
diff --git a/arch/xtensa/include/asm/hw_breakpoint.h b/arch/xtensa/include/=
asm/hw_breakpoint.h
index 9ec86f440a48e..4a627a5ed9893 100644
--- a/arch/xtensa/include/asm/hw_breakpoint.h
+++ b/arch/xtensa/include/asm/hw_breakpoint.h
@@ -12,6 +12,7 @@
 #define __ASM_XTENSA_HW_BREAKPOINT_H
=20
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
+#define ARCH_NEED_PERF_HW_NOTIF
=20
 #include <linux/kdebug.h>
 #include <linux/types.h>
diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
index 364e4fdabb00d..9e3b5aff1b8f8 100644
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -361,9 +361,7 @@ static int ptrace_pokeusr(struct task_struct *child, lo=
ng regno, long val)
 }
=20
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
-static void ptrace_hbptriggered(struct perf_event *bp,
-				struct perf_sample_data *data,
-				struct pt_regs *regs)
+void arch_hwbp_send_sig(struct perf_event *bp)
 {
 	int i;
 	struct arch_hw_breakpoint *bkpt =3D counter_arch_bp(bp);
@@ -395,7 +393,7 @@ static struct perf_event *ptrace_hbp_create(struct task=
_struct *tsk, int type)
 	attr.bp_type	=3D type;
 	attr.disabled	=3D 1;
=20
-	return register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL,
+	return register_user_hw_breakpoint(&attr, perf_arch_hwbp_notify, NULL,
 					   tsk);
 }
=20
diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index db199d653dd1a..bb4c1064a103d 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -85,6 +85,9 @@ extern int register_perf_hw_breakpoint(struct perf_event =
*bp);
 extern void unregister_hw_breakpoint(struct perf_event *bp);
 extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cp=
u_events);
 extern bool hw_breakpoint_is_used(void);
+extern void arch_hwbp_send_sig(struct perf_event *bp);
+extern void perf_arch_hwbp_notify(struct perf_event *bp, struct perf_sampl=
e_data *data,
+				  struct pt_regs *regs);
=20
 extern int dbg_reserve_bp_slot(struct perf_event *bp);
 extern int dbg_release_bp_slot(struct perf_event *bp);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 915c6fd3f0845..4e0cea7f59e4c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -215,6 +215,10 @@ struct hw_perf_event {
=20
 	/* Last sync'ed generation of filters */
 	unsigned long			addr_filters_gen;
+#ifdef ARCH_NEED_PERF_HW_NOTIF
+	struct callback_head		arch_hw_notif;
+	int				arch_hw_notif_busy;
+#endif
=20
 /*
  * hw_perf_event::state flags; used to track the PERF_EF_* state.
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 634d2ccbab82d..9b38a14880361 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13381,6 +13381,28 @@ static void account_event(struct perf_event *event)
 	account_pmu_sb_event(event);
 }
=20
+#ifdef ARCH_NEED_PERF_HW_NOTIF
+static void perf_arch_hwbp_send_sig(struct callback_head *head)
+{
+	struct perf_event *bp;
+
+	bp =3D container_of(head, struct perf_event, hw.arch_hw_notif);
+	arch_hwbp_send_sig(bp);
+	xchg_relaxed(&bp->hw.arch_hw_notif_busy, 0);
+	put_event(bp);
+}
+
+void perf_arch_hwbp_notify(struct perf_event *bp, struct perf_sample_data =
*data,
+			   struct pt_regs *regs)
+{
+	if (WARN_ON_ONCE(!atomic_long_inc_not_zero(&bp->refcount)))
+		return;
+	if (xchg_relaxed(&bp->hw.arch_hw_notif_busy, 1) ||
+	    WARN_ON_ONCE(task_work_add(current, &bp->hw.arch_hw_notif, TWA_RESUME=
)))
+		put_event(bp);
+}
+#endif
+
 /*
  * Allocate and initialize an event structure
  */
@@ -13486,6 +13508,10 @@ perf_event_alloc(struct perf_event_attr *attr, int=
 cpu,
 	}
=20
 	if (overflow_handler) {
+#ifdef ARCH_NEED_PERF_HW_NOTIF
+		if (overflow_handler =3D=3D perf_arch_hwbp_notify)
+			init_task_work(&event->hw.arch_hw_notif, perf_arch_hwbp_send_sig);
+#endif
 		event->overflow_handler	=3D overflow_handler;
 		event->overflow_handler_context =3D context;
 	} else if (is_write_backward(event)){
--=20
2.55.0

