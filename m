Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66E427FD74;
	Mon, 12 Oct 2026 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795876; cv=none; b=UAYld+NGnry5rlBvG9jwyGKrNBmKNFWRtjNu4+xt4ETLRUEUP+GUrQM6cuY8FU44VO4sVitGQL6fgZvQZxDn6/NMOjrPqeZkl6iabqnzATMfsuJuarUn0vNjuPdkgZxjgcAsisWoO273BucGe94CtCTtfwd+LAmDg3FS4inXafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795876; c=relaxed/simple;
	bh=mMbCMq4mT15KjIxu5uzbDeQ+T3dgyQaQaYXJ1lPa/Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iMcUoOLGfShrJaxrYpZkffpm2ILgKN+QzaAh3ypxFj519PVFei2OpkKLSTUBdzU+qoMAYxmODdh5XVzsVpqrY+2T4hVxvQVTV8Dsw0Zt6VfgCvQ62f4Y6XoWKQEquFid+VOPFNxZ8qsa0yOr4+SJ+jfLgWfMm3lv65i2ku97tqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oI2cKCuf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mHtL3Njz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oI2cKCuf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mHtL3Njz"
Date: Mon, 12 Oct 2026 11:04:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791795872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CA9Z+1y8hG4Kx0oUTNF/FgJsgbGVmHVoJqpnzAlnWfU=;
	b=oI2cKCufUmNPL+SQ6sOASjCI4vjMTslu5GSL7xkh4tK8n3fpmJSYVP2cr8FoB3qe71BfBj
	32W8stigCND7fIY6crWUI0GqAL+aNNGJ/qoYvaJmm6DUsrBjM5/5D61mViDKCKc75OSpU2
	S53i6ebyrPqVFIO8KOGj8bCFx+wvVCd++UyTHEv4pQzafXFyEFZT+cM4YQULpEDIgjXS03
	JJcT3p/y5AgoYoLAcR5EpDH2Sv3SJMrajaJvTTdKQrGDB7X2nQy4TNJ+8rxwq3JB/xyp0o
	g6byzoG66OUVHYF+3ZFSqjb3b+maD1iQL9eXn3C5+tjMt5RCYbMtn/keRNDeZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791795872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CA9Z+1y8hG4Kx0oUTNF/FgJsgbGVmHVoJqpnzAlnWfU=;
	b=mHtL3NjznWkotqpnOCifRGghUDf3z2h62DG4oIzbWGy/jVCytremJRON/FXlQ0yV3YDhCW
	JuaI3FBfBS1cFDDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-perf-users@vger.kernel.org,
	loongarch@lists.linux.dev
Cc: Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v4] ARM, ARM64, LONGARCH, XTENSA: Delay HW BP notification to
 task_work()
Message-ID: <20261012090431.TF3iVDsk@linutronix.de>
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
Add perf_hwbp_notify(), a generic perf callback which delayes the
actual callback invocation to task_work_add() callback. This callback
invokes the architecture defined callback perf_arch_hwbp_send_sig().
This requires struct callback_head and the functions require
ARCH_NEED_PERF_HW_NOTIFY to be defined.

This was reported against ARM64. ARM, LongARCH and Xtensa follow the
same pattern are also converted. Xtensa is the only not supporting
PREEMPT_RT but now we have all architectures using the same pattern.

Fixes: d8fccd9ca5f90 ("arm64: Allow to enable PREEMPT_RT.")
Reported-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reported-by: Waiman Long <longman@redhat.com>
Closes: https://lore.kernel.org/all/aho0eqjMESuHxECr@redhat.com/
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Tested-by: Ada Couprie Diaz <ada.coupriediaz@arm.com> (arm64)
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v3=E2=80=A6v4: https://lore.kernel.org/all/20261001143516.Ew8C97WS@linutron=
ix.de/
 - Add fixes tag
 - Rename the functions as suggested by Ada to use the pattern that perf
   uses in other places:
   - perf_arch_hwbp_notify() -> perf_hwbp_notify() (generic)
   - arch_hwbp_send_sig() -> perf_arch_hwbp_send_sig() (arch specific)
   - perf_arch_hwbp_send_sig() -> perf_hwbp_send_sig() (generic)
 - Rename ARCH_NEED_PERF_HW_NOTIF -> ARCH_NEED_PERF_HW_NOTIFY

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
 arch/arm/kernel/ptrace.c                   |  7 ++----
 arch/arm64/include/asm/hw_breakpoint.h     |  1 +
 arch/arm64/kernel/ptrace.c                 |  6 ++---
 arch/loongarch/include/asm/hw_breakpoint.h |  1 +
 arch/loongarch/kernel/ptrace.c             |  6 ++---
 arch/xtensa/include/asm/hw_breakpoint.h    |  1 +
 arch/xtensa/kernel/ptrace.c                |  7 ++----
 include/linux/hw_breakpoint.h              |  3 +++
 include/linux/perf_event.h                 |  4 ++++
 kernel/events/core.c                       | 26 ++++++++++++++++++++++
 11 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw=
_breakpoint.h
index e7f9961c53b2d..fa7fb2b2a392a 100644
--- a/arch/arm/include/asm/hw_breakpoint.h
+++ b/arch/arm/include/asm/hw_breakpoint.h
@@ -7,6 +7,7 @@
 struct task_struct;
=20
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
+#define ARCH_NEED_PERF_HW_NOTIFY
=20
 struct arch_hw_breakpoint_ctrl {
 		u32 __reserved	: 9,
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index ed7a2a87a6707..db4b28c6e15a4 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -347,9 +347,7 @@ static long ptrace_hbp_idx_to_num(int idx)
 /*
  * Handle hitting a HW-breakpoint.
  */
-static void ptrace_hbptriggered(struct perf_event *bp,
-				     struct perf_sample_data *data,
-				     struct pt_regs *regs)
+void perf_arch_hwbp_send_sig(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *bkpt =3D counter_arch_bp(bp);
 	long num;
@@ -424,8 +422,7 @@ static struct perf_event *ptrace_hbp_create(struct task=
_struct *tsk, int type)
 	attr.bp_type	=3D type;
 	attr.disabled	=3D 1;
=20
-	return register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL,
-					   tsk);
+	return register_user_hw_breakpoint(&attr, perf_hwbp_notify, NULL, tsk);
 }
=20
 static int ptrace_gethbpregs(struct task_struct *tsk, long num,
diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/as=
m/hw_breakpoint.h
index bd81cf17744af..0bc75f42b0da6 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -124,6 +124,7 @@ extern void hw_breakpoint_pmu_read(struct perf_event *b=
p);
 extern int hw_breakpoint_slots(int type);
=20
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
+#define ARCH_NEED_PERF_HW_NOTIFY
 extern void hw_breakpoint_thread_switch(struct task_struct *next);
 extern void ptrace_hw_copy_thread(struct task_struct *task);
 #else
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index f743cbec1c3ad..dc3793c2a7c3c 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -168,9 +168,7 @@ void ptrace_disable(struct task_struct *child)
 /*
  * Handle hitting a HW-breakpoint.
  */
-static void ptrace_hbptriggered(struct perf_event *bp,
-				struct perf_sample_data *data,
-				struct pt_regs *regs)
+void perf_arch_hwbp_send_sig(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *bkpt =3D counter_arch_bp(bp);
 	const char *desc =3D "Hardware breakpoint trap (ptrace)";
@@ -312,7 +310,7 @@ static struct perf_event *ptrace_hbp_create(unsigned in=
t note_type,
 	attr.bp_type	=3D type;
 	attr.disabled	=3D 1;
=20
-	bp =3D register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL, tsk);
+	bp =3D register_user_hw_breakpoint(&attr, perf_hwbp_notify, NULL, tsk);
 	if (IS_ERR(bp))
 		return bp;
=20
diff --git a/arch/loongarch/include/asm/hw_breakpoint.h b/arch/loongarch/in=
clude/asm/hw_breakpoint.h
index 5faa97a87a9e2..c2d061ff3763a 100644
--- a/arch/loongarch/include/asm/hw_breakpoint.h
+++ b/arch/loongarch/include/asm/hw_breakpoint.h
@@ -120,6 +120,7 @@ void breakpoint_handler(struct pt_regs *regs);
 void watchpoint_handler(struct pt_regs *regs);
=20
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
+#define ARCH_NEED_PERF_HW_NOTIFY
 extern void ptrace_hw_copy_thread(struct task_struct *task);
 extern void hw_breakpoint_thread_switch(struct task_struct *next);
 #else
diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrace.c
index be38430f7e280..27e7e64591592 100644
--- a/arch/loongarch/kernel/ptrace.c
+++ b/arch/loongarch/kernel/ptrace.c
@@ -384,9 +384,7 @@ static int lbt_set(struct task_struct *target,
 /*
  * Handle hitting a HW-breakpoint.
  */
-static void ptrace_hbptriggered(struct perf_event *bp,
-				struct perf_sample_data *data,
-				struct pt_regs *regs)
+void perf_arch_hwbp_send_sig(struct perf_event *bp)
 {
 	int i;
 	struct arch_hw_breakpoint *bkpt =3D counter_arch_bp(bp);
@@ -479,7 +477,7 @@ static struct perf_event *ptrace_hbp_create(unsigned in=
t note_type,
 	attr.bp_type	=3D type;
 	attr.disabled	=3D 1;
=20
-	bp =3D register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL, tsk);
+	bp =3D register_user_hw_breakpoint(&attr, perf_hwbp_notify, NULL, tsk);
 	if (IS_ERR(bp))
 		return bp;
=20
diff --git a/arch/xtensa/include/asm/hw_breakpoint.h b/arch/xtensa/include/=
asm/hw_breakpoint.h
index 9ec86f440a48e..44ea340c88742 100644
--- a/arch/xtensa/include/asm/hw_breakpoint.h
+++ b/arch/xtensa/include/asm/hw_breakpoint.h
@@ -12,6 +12,7 @@
 #define __ASM_XTENSA_HW_BREAKPOINT_H
=20
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
+#define ARCH_NEED_PERF_HW_NOTIFY
=20
 #include <linux/kdebug.h>
 #include <linux/types.h>
diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
index 364e4fdabb00d..c9f583d650de2 100644
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
+void perf_arch_hwbp_send_sig(struct perf_event *bp)
 {
 	int i;
 	struct arch_hw_breakpoint *bkpt =3D counter_arch_bp(bp);
@@ -395,8 +393,7 @@ static struct perf_event *ptrace_hbp_create(struct task=
_struct *tsk, int type)
 	attr.bp_type	=3D type;
 	attr.disabled	=3D 1;
=20
-	return register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL,
-					   tsk);
+	return register_user_hw_breakpoint(&attr, perf_hwbp_notify, NULL, tsk);
 }
=20
 /*
diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index db199d653dd1a..91e8d80220c54 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -85,6 +85,9 @@ extern int register_perf_hw_breakpoint(struct perf_event =
*bp);
 extern void unregister_hw_breakpoint(struct perf_event *bp);
 extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cp=
u_events);
 extern bool hw_breakpoint_is_used(void);
+extern void perf_arch_hwbp_send_sig(struct perf_event *bp);
+extern void perf_hwbp_notify(struct perf_event *bp, struct perf_sample_dat=
a *data,
+			     struct pt_regs *regs);
=20
 extern int dbg_reserve_bp_slot(struct perf_event *bp);
 extern int dbg_release_bp_slot(struct perf_event *bp);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2d5e7687875b0..07f2c858d50d1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -215,6 +215,10 @@ struct hw_perf_event {
=20
 	/* Last sync'ed generation of filters */
 	unsigned long			addr_filters_gen;
+#ifdef ARCH_NEED_PERF_HW_NOTIFY
+	struct callback_head		arch_hw_notif;
+	int				arch_hw_notif_busy;
+#endif
=20
 /*
  * hw_perf_event::state flags; used to track the PERF_EF_* state.
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7846d70be57f6..619eab68d1dfd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13334,6 +13334,28 @@ static void account_event(struct perf_event *event)
 	account_pmu_sb_event(event);
 }
=20
+#ifdef ARCH_NEED_PERF_HW_NOTIFY
+static void perf_hwbp_send_sig(struct callback_head *head)
+{
+	struct perf_event *bp;
+
+	bp =3D container_of(head, struct perf_event, hw.arch_hw_notif);
+	perf_arch_hwbp_send_sig(bp);
+	xchg_relaxed(&bp->hw.arch_hw_notif_busy, 0);
+	put_event(bp);
+}
+
+void perf_hwbp_notify(struct perf_event *bp, struct perf_sample_data *data,
+		      struct pt_regs *regs)
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
@@ -13439,6 +13461,10 @@ perf_event_alloc(struct perf_event_attr *attr, int=
 cpu,
 	}
=20
 	if (overflow_handler) {
+#ifdef ARCH_NEED_PERF_HW_NOTIFY
+		if (overflow_handler =3D=3D perf_hwbp_notify)
+			init_task_work(&event->hw.arch_hw_notif, perf_hwbp_send_sig);
+#endif
 		event->overflow_handler	=3D overflow_handler;
 		event->overflow_handler_context =3D context;
 	} else if (is_write_backward(event)){
--=20
2.55.0

