Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B26F201111;
	Mon, 28 Oct 2024 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152102; cv=none; b=PEx7Fr4aG0CVRARaXhA9vjzZLzaqCn+bDwCz6NaqPhJN0HnAxSq7YhPLtAaMc7vLXl07VySQvCVLR9PQ2jm1rasNJlEDwAPqaJgLwx1chwsJBlSAc5M05YglF0eqhh0RfeMgYqjFMnXWyFK862M2h4bcVp93NfSqOkonFFioZnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152102; c=relaxed/simple;
	bh=Es5oY0xOQfeuhKGtAHCUsq1KBkzukwi8QHbJItNGzbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgCZiHuNpZhCPaLR2wTFjX8G7mC8X1I0V2ucHNg7jMr6KZRbC88pth30VC0rOvdQmY11guJmNOtkvxgsLYAvfuDFOGOAz4GImQo7psNGeBtMWJX3uKksYKAMqIasqzFlweI8/Ofyk6EOMyNabwwiUQ3mKrA/eigXHEediytKbHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z20iHXcy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z20iHXcy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFD5C4CECD;
	Mon, 28 Oct 2024 21:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152101;
	bh=Es5oY0xOQfeuhKGtAHCUsq1KBkzukwi8QHbJItNGzbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z20iHXcy1Mhi6ZQ7zG8JIJqbNhpJtOrZG3zdzDD/xU9PFlVdyeSxRynyrOl0gXM6t
	 GlyrcEIZfEiHGKzs0iLLHarNgYIYOpg8Mls4ScJOCcAbLQn+tX954im9SlJHRPRwbN
	 MufPPMaSTKwGZpUxvE0yzmwxxIg6+4YtyqiLsNLHXhLmhxf68W6bDf5NAkxIO6f0QS
	 SpqrHATG+kJWpeV1YRAzb69MNTfVF0KLbajwlLGoYyI6//1pKkZtDm1Q6phx9T2buw
	 ce073EIqPYQ08MQ0K8RIwvEJAjxD6OVzOIebfBSmRgAEpy1U8L1DC4+rpkMRYoI+rw
	 B/GE9qa2w4b2Q==
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
	Sam James <sam@gentoo.org>,
	linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Namhyung Kim <Namhyung@kernel.org>
Subject: [PATCH v3 12/19] perf: Remove get_perf_callchain() 'init_nr' argument
Date: Mon, 28 Oct 2024 14:47:39 -0700
Message-ID: <886694ebe866d9e20a55516713d9856d38e4a3a4.1730150953.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730150953.git.jpoimboe@kernel.org>
References: <cover.1730150953.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'init_nr' argument has double duty: it's used to initialize both the
number of contexts and the number of stack entries.  That's confusing
and the callers always pass zero anyway.  Hard code the zero.

Acked-by: Namhyung Kim <Namhyung@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/perf_event.h |  2 +-
 kernel/bpf/stackmap.c      |  4 ++--
 kernel/events/callchain.c  | 12 ++++++------
 kernel/events/core.c       |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fb908843f209..1e956ff9acd3 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1568,7 +1568,7 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
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
index 8a47e52a454f..83834203e144 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -216,7 +216,7 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
 }
 
 struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
+get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark)
 {
 	struct perf_callchain_entry *entry;
@@ -227,11 +227,11 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
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
index df27d08a7232..1654d6e7c148 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7800,7 +7800,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	if (!kernel && !user)
 		return &__empty_callchain;
 
-	callchain = get_perf_callchain(regs, 0, kernel, user,
+	callchain = get_perf_callchain(regs, kernel, user,
 				       max_stack, crosstask, true);
 	return callchain ?: &__empty_callchain;
 }
-- 
2.47.0

