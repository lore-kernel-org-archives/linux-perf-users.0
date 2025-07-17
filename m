Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D820A1F95C;
	Thu, 17 Jul 2025 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773592; cv=none; b=ouX5sLMgnIH8Znse9l1lgB3lASgpGACcexNVA/uiSbeeQ4vdU5SX/Pm56gKqXPkwzG/OWiBWiBhwkA3iN+vFyPnfsP2H+BlVDhASorqebafrTBRxOJSWwc6saElubiGXhMCRVRxmXlomSnQsoK/QKxLYWfOB4Z60bBIDU251Gtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773592; c=relaxed/simple;
	bh=PlMed3FiOV4T6l6o16L8MmIemjqgKth6Lso3Lz/CSCM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rambXSDm8sZk73hc5pY+9Kfelk0NSFmkRbmGa4moGrMz+uukSq3Zv0Ns2MlW7b5GQxhaUngiloiXdYzOLzznGNa5WL8USW1XaYZQTkZLy+8v3RlEvR7XpD3jDQ/Jh0Rivjvq5VvwUvAhZSA7QZhaJn6L8AKseUvYTm26NCGUVLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHdS9iBd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHdS9iBd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83511C4CEED;
	Thu, 17 Jul 2025 17:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752773591;
	bh=PlMed3FiOV4T6l6o16L8MmIemjqgKth6Lso3Lz/CSCM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=fHdS9iBd1CaH3EGr2zl1Q0VGhIEXTFpsm1YZio1TTgQR/ehZPmA7kEXcKhXlMx/fg
	 5gjDrQm8OiovNmwBE/EuQ4coURkSc/HiI3d4X2xjc4NfLOcfWjdTqb9ToqZ48h9NGC
	 Zt7oFhumhuEaXzqQR/WZ/1degS5qp2xKUu6LkbKBj09ZA7AhRy34cnxDRFkWiki3sG
	 VVF7bEakM28X64+Ue+l1JBsWrqfRa68vdutXCvlc9jQ+WUpCTFOjrhD0wRJ9dGDBFn
	 DfptXNdafvksOXaXP5u1w2p4G8DWlEtVMOKDfEFFRLlSUoMBNqUmYxh3SruoYUD1TL
	 6Tu2b8R0XS4zg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucSU9-00000006byk-1BQn;
	Thu, 17 Jul 2025 13:33:33 -0400
Message-ID: <20250717173333.141133447@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 17 Jul 2025 13:31:26 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jens Axboe <axboe@kernel.dk>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Namhyung Kim <Namhyung@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 1/5] perf: Remove get_perf_callchain() init_nr argument
References: <20250717173125.434618999@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

The 'init_nr' argument has double duty: it's used to initialize both the
number of contexts and the number of stack entries.  That's confusing
and the callers always pass zero anyway.  Hard code the zero.

Acked-by: Namhyung Kim <Namhyung@kernel.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/perf_event.h |  2 +-
 kernel/bpf/stackmap.c      |  4 ++--
 kernel/events/callchain.c  | 12 ++++++------
 kernel/events/core.c       |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ec9d96025683..54e0d31afcad 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1719,7 +1719,7 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
 extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
+get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 3615c06b7dfa..ec3a57a5fba1 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -314,7 +314,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	if (max_depth > sysctl_perf_event_max_stack)
 		max_depth = sysctl_perf_event_max_stack;
 
-	trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
+	trace = get_perf_callchain(regs, kernel, user, max_depth,
 				   false, false);
 
 	if (unlikely(!trace))
@@ -451,7 +451,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	else if (kernel && task)
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
-		trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
+		trace = get_perf_callchain(regs, kernel, user, max_depth,
 					   crosstask, false);
 
 	if (unlikely(!trace) || trace->nr < skip) {
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 6c83ad674d01..b0f5bd228cd8 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -217,7 +217,7 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
 }
 
 struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
+get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark)
 {
 	struct perf_callchain_entry *entry;
@@ -228,11 +228,11 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 	if (!entry)
 		return NULL;
 
-	ctx.entry     = entry;
-	ctx.max_stack = max_stack;
-	ctx.nr	      = entry->nr = init_nr;
-	ctx.contexts       = 0;
-	ctx.contexts_maxed = false;
+	ctx.entry		= entry;
+	ctx.max_stack		= max_stack;
+	ctx.nr			= entry->nr = 0;
+	ctx.contexts		= 0;
+	ctx.contexts_maxed	= false;
 
 	if (kernel && !user_mode(regs)) {
 		if (add_mark)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0db36b2b2448..b2a53cabcb17 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8178,7 +8178,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	if (!kernel && !user)
 		return &__empty_callchain;
 
-	callchain = get_perf_callchain(regs, 0, kernel, user,
+	callchain = get_perf_callchain(regs, kernel, user,
 				       max_stack, crosstask, true);
 	return callchain ?: &__empty_callchain;
 }
-- 
2.47.2


