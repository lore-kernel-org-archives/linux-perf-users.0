Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8096188581;
	Fri, 13 Sep 2024 23:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726268612; cv=none; b=lNB2iSRkJ3mFTRb0JKKsz2HhqWgSxUSRiZmqzRdrFG31bNZKtCZopbTWfzPB6Cqw5j89sfhj0Ld2u6yMzzK1WDX6COOPuoqKczYeAwgBaW4p8raQLPOv3qYqdKbk2o/uBBjR4jwqBb2Uku6+s48BCVa6D1iKyQQ/2lNI9ZyfAxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726268612; c=relaxed/simple;
	bh=I10Ag4ofNMWbBk+oEbGUJAFz+TaMxmRZTVkWU5+eNcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jw3ZrrWymyBkukSKiI9yaPG+bZLtZPv2NVa+oRntbWnAdKSxtS+DkIQMaBq2vB8K0WDDKzZ5Pi2OAFfthDXVGB2PZ/At90+ndINEu52APz1ZbpAL9V1Bo5IAu5zp2L7cPc0A1lEmu4pSn1vrvxliz7sIfnkj96RxVdOhwiTNMk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVo2b6hZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVo2b6hZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95F0C4CED2;
	Fri, 13 Sep 2024 23:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726268612;
	bh=I10Ag4ofNMWbBk+oEbGUJAFz+TaMxmRZTVkWU5+eNcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GVo2b6hZuEnVwdRpnql4jQWs9gpgSH+tr65TtMT2ycYG+EJJstSUJGfhwLL+z4+QR
	 sga4n9v4wLzyP0zR67wWTMXlSS0dDRvwi6cd7RE4CE8nZ7r6vBhFH0JHxp1c1DCcwt
	 XaKcmtIgJp727S7+kKc5W7fw2ODRdKIxHfV/MTKQIZky10zUmCw+gBTmT1IKHdIb9w
	 rvSbDwiVkAHp12Lq7ddB0WukUOTCjAIRIhjeZuYGpjgB09ZQiCj+uweVgvFkMBZIre
	 UkoeUmNKLSPhwsaF5EKKhF/lcpWPxo0FdX2w416ujYfLHoWDPgzVIMYk0e00cP8vtV
	 9EDnzyhLXYjWA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org,
	Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>
Subject: [PATCH v2 09/11] perf: Introduce deferred user callchains
Date: Sat, 14 Sep 2024 01:02:11 +0200
Message-ID: <5bc834b68fe14daaa1782b925ab54fc414245334.1726268190.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726268190.git.jpoimboe@kernel.org>
References: <cover.1726268190.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of attempting to unwind user space from the NMI handler, defer
it to run in task context by sending a self-IPI and then scheduling the
unwind to run in the IRQ's exit task work before returning to user space.

This allows the user stack page to be paged in if needed, avoids
duplicate unwinds for kernel-bound workloads, and prepares for SFrame
unwinding (so .sframe sections can be paged in on demand).

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/Kconfig                    |  3 ++
 include/linux/perf_event.h      |  9 +++-
 include/uapi/linux/perf_event.h | 21 ++++++++-
 kernel/bpf/stackmap.c           |  5 +--
 kernel/events/callchain.c       | 12 +++++-
 kernel/events/core.c            | 76 ++++++++++++++++++++++++++++++++-
 6 files changed, 119 insertions(+), 7 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index ff5d5bc5f947..0629c1aa2a5c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -431,6 +431,9 @@ config HAVE_USER_UNWIND
 config HAVE_USER_UNWIND_SFRAME
 	bool
 
+config HAVE_PERF_CALLCHAIN_DEFERRED
+	bool
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 64f9efe19553..a617aad2851c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -787,6 +787,7 @@ struct perf_event {
 	struct callback_head		pending_task;
 	unsigned int			pending_work;
 	struct rcuwait			pending_work_wait;
+	unsigned int			pending_callchain;
 
 	atomic_t			event_limit;
 
@@ -1541,12 +1542,18 @@ extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct p
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool add_mark);
+		   u32 max_stack, bool add_mark, bool defer_user);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
 extern void put_callchain_entry(int rctx);
 
+#ifdef CONFIG_HAVE_PERF_CALLCHAIN_DEFERRED
+extern void perf_callchain_user_deferred(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
+#else
+static inline void perf_callchain_user_deferred(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs) {}
+#endif
+
 extern int sysctl_perf_event_max_stack;
 extern int sysctl_perf_event_max_contexts_per_stack;
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 4842c36fdf80..a7f875eb29dd 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -460,7 +460,8 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				defer_callchain:  1, /* generate PERF_RECORD_CALLCHAIN_DEFERRED records */
+				__reserved_1   : 25;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1217,6 +1218,23 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_AUX_OUTPUT_HW_ID		= 21,
 
+	/*
+	 * This user callchain capture was deferred until shortly before
+	 * returning to user space.  Previous samples would have kernel
+	 * callchains only and they need to be stitched with this to make full
+	 * callchains.
+	 *
+	 * TODO: do PERF_SAMPLE_{REGS,STACK}_USER also need deferral?
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				nr;
+	 *	u64				ips[nr];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CALLCHAIN_DEFERRED		= 22,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
@@ -1247,6 +1265,7 @@ enum perf_callchain_context {
 	PERF_CONTEXT_HV			= (__u64)-32,
 	PERF_CONTEXT_KERNEL		= (__u64)-128,
 	PERF_CONTEXT_USER		= (__u64)-512,
+	PERF_CONTEXT_USER_DEFERRED	= (__u64)-640,
 
 	PERF_CONTEXT_GUEST		= (__u64)-2048,
 	PERF_CONTEXT_GUEST_KERNEL	= (__u64)-2176,
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index ff6f0ef7ba5d..9d58a84e553a 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -297,8 +297,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	if (max_depth > sysctl_perf_event_max_stack)
 		max_depth = sysctl_perf_event_max_stack;
 
-	trace = get_perf_callchain(regs, kernel, user, max_depth, false);
-
+	trace = get_perf_callchain(regs, kernel, user, max_depth, false, false);
 	if (unlikely(!trace))
 		/* couldn't fetch the stack trace */
 		return -EFAULT;
@@ -432,7 +431,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
 		trace = get_perf_callchain(regs, kernel, user, max_depth,
-					   false);
+					   false, false);
 	if (unlikely(!trace))
 		goto err_fault;
 
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 2278402b7ac9..883f0ac9ef3a 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -217,7 +217,7 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
 
 struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool add_mark)
+		   u32 max_stack, bool add_mark, bool defer_user)
 {
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
@@ -246,6 +246,16 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 			regs = task_pt_regs(current);
 		}
 
+		if (defer_user) {
+			/*
+			 * Foretell the coming of a
+			 * PERF_RECORD_CALLCHAIN_DEFERRED sample which can be
+			 * stitched to this one.
+			 */
+			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER_DEFERRED);
+			goto exit_put;
+		}
+
 		if (add_mark)
 			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 19fd7bd38ecf..5fc7c5156287 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6835,6 +6835,12 @@ static void perf_pending_irq(struct irq_work *entry)
 	struct perf_event *event = container_of(entry, struct perf_event, pending_irq);
 	int rctx;
 
+	if (!is_software_event(event)) {
+		if (event->pending_callchain)
+			task_work_add(current, &event->pending_task, TWA_RESUME);
+		return;
+	}
+
 	/*
 	 * If we 'fail' here, that's OK, it means recursion is already disabled
 	 * and we won't recurse 'further'.
@@ -6854,11 +6860,70 @@ static void perf_pending_irq(struct irq_work *entry)
 		perf_swevent_put_recursion_context(rctx);
 }
 
+struct perf_callchain_deferred_event {
+	struct perf_event_header	header;
+	struct perf_callchain_entry	callchain;
+};
+
+#define PERF_CALLCHAIN_DEFERRED_EVENT_SIZE				\
+	sizeof(struct perf_callchain_deferred_event) +			\
+	(sizeof(__u64) * 1) + /* PERF_CONTEXT_USER */			\
+	(sizeof(__u64) * PERF_MAX_STACK_DEPTH)
+
+static void perf_event_callchain_deferred(struct perf_event *event)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+	struct perf_callchain_entry *callchain;
+	struct perf_output_handle handle;
+	struct perf_sample_data data;
+	unsigned char buf[PERF_CALLCHAIN_DEFERRED_EVENT_SIZE];
+	struct perf_callchain_entry_ctx ctx;
+	struct perf_callchain_deferred_event *deferred_event;
+
+	deferred_event = (void *)&buf;
+
+	callchain = &deferred_event->callchain;
+	callchain->nr = 0;
+
+	ctx.entry		= callchain;
+	ctx.max_stack		= MIN(event->attr.sample_max_stack,
+				      PERF_MAX_STACK_DEPTH);
+	ctx.nr			= 0;
+	ctx.contexts		= 0;
+	ctx.contexts_maxed	= false;
+
+	perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
+	perf_callchain_user_deferred(&ctx, regs);
+
+	deferred_event->header.type = PERF_RECORD_CALLCHAIN_DEFERRED;
+	deferred_event->header.misc = 0;
+	deferred_event->header.size = sizeof(*deferred_event) +
+				      (callchain->nr * sizeof(u64));
+
+	perf_event_header__init_id(&deferred_event->header, &data, event);
+
+	if (perf_output_begin(&handle, &data, event,
+			      deferred_event->header.size))
+		return;
+
+	perf_output_copy(&handle, deferred_event, deferred_event->header.size);
+	perf_event__output_id_sample(event, &handle, &data);
+	perf_output_end(&handle);
+}
+
 static void perf_pending_task(struct callback_head *head)
 {
 	struct perf_event *event = container_of(head, struct perf_event, pending_task);
 	int rctx;
 
+	if (!is_software_event(event)) {
+		if (event->pending_callchain) {
+			perf_event_callchain_deferred(event);
+			event->pending_callchain = 0;
+		}
+		return;
+	}
+
 	/*
 	 * All accesses to the event must belong to the same implicit RCU read-side
 	 * critical section as the ->pending_work reset. See comment in
@@ -7688,6 +7753,8 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	bool user   = !event->attr.exclude_callchain_user;
 	const u32 max_stack = event->attr.sample_max_stack;
 	struct perf_callchain_entry *callchain;
+	bool defer_user = IS_ENABLED(CONFIG_HAVE_PERF_CALLCHAIN_DEFERRED) &&
+			  event->attr.defer_callchain;
 
 	/* Disallow cross-task user callchains. */
 	user &= !event->ctx->task || event->ctx->task == current;
@@ -7695,7 +7762,14 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	if (!kernel && !user)
 		return &__empty_callchain;
 
-	callchain = get_perf_callchain(regs, kernel, user, max_stack, true);
+	callchain = get_perf_callchain(regs, kernel, user, max_stack, true,
+				       defer_user);
+
+	if (user && defer_user && !event->pending_callchain) {
+		event->pending_callchain = 1;
+		irq_work_queue(&event->pending_irq);
+	}
+
 	return callchain ?: &__empty_callchain;
 }
 
-- 
2.46.0

