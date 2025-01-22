Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20771F8F0C;
	Wed, 22 Jan 2025 02:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513145; cv=none; b=EGJ2nUX3yGKtXwr7hRoQiHBFYo5yG7TstT+vOL5v2vcra2YlibFoOdo+Acs58esIC8Yvztk6oKMIB5Vu9qcx9P4elqSgXR9Z8jgp7CewpvPzpF3knfiVSHYwTM5GRqNxz/iZ5MThVwtnL9sKcODwGPDT5YiqiAStOcowwivid8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513145; c=relaxed/simple;
	bh=yg549yt5k36N+w4cLjQJtSf1SxCGDHbIvRGsG4AqAok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eisuy0MhRsQvUu6Qdxf9lzJkz6LEa/a6tYq/Qvvy2Ckxjz4ymfF0AEj+HEkl5yf9KObD4ASpz78inioCoi5F4WPx1dKs6UC/mUOASq7mQoKCJlG2w4cjzozgAOyeMN7lZFxUIJpP+y+gaYzbYc3MSIf+lvRTaPbp6tBLcYIqI/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrDnuMIp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrDnuMIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A31C4CEE0;
	Wed, 22 Jan 2025 02:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513145;
	bh=yg549yt5k36N+w4cLjQJtSf1SxCGDHbIvRGsG4AqAok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QrDnuMIpnHWBgHkJax/ZjLEvkV0m4TP05glKUz2wP+MU1BewEH8+EgtBSZWWPurM3
	 OKCQahkExfR+CRZNtQPaGfrYk0yTlX1wKsYQOyiHzjDEMt+XRBquBrfCwhDbdtfEGJ
	 o/6VnS0w4UKPw3m5I0YaaK3dViEAT5V0Hp4lNO+ElJVGxxlSCaqldxwBuACou42CQo
	 fI3yAnOVsPHhvmK9yUkE5oIlr+91fmhizUM5GkNPUzqGbBOIcim1HgNpadiggRchxH
	 vJyFjEFGcdduFfOXKjbPPucjbVzHV/5ZRJF3OH53Wph7BWwgjp5w8CtbqvAZeJMR4+
	 +0yAiehp/KwrQ==
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
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: [PATCH v4 32/39] perf: Remove get_perf_callchain() 'crosstask' argument
Date: Tue, 21 Jan 2025 18:31:24 -0800
Message-ID: <73229250c0279667f617c3d6da121c6621164e4d.1737511963.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1737511963.git.jpoimboe@kernel.org>
References: <cover.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_perf_callchain() doesn't support cross-task unwinding, so it doesn't
make much sense to have 'crosstask' as an argument.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/perf_event.h |  2 +-
 kernel/bpf/stackmap.c      | 12 ++++--------
 kernel/events/callchain.c  |  6 +-----
 kernel/events/core.c       |  9 +++++----
 4 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 4c8ff7258c6a..1563dc2cd979 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1590,7 +1590,7 @@ extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct p
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark);
+		   u32 max_stack, bool add_mark);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index ec3a57a5fba1..ee9701337912 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -314,8 +314,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	if (max_depth > sysctl_perf_event_max_stack)
 		max_depth = sysctl_perf_event_max_stack;
 
-	trace = get_perf_callchain(regs, kernel, user, max_depth,
-				   false, false);
+	trace = get_perf_callchain(regs, kernel, user, max_depth, false);
 
 	if (unlikely(!trace))
 		/* couldn't fetch the stack trace */
@@ -430,10 +429,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	if (task && user && !user_mode(regs))
 		goto err_fault;
 
-	/* get_perf_callchain does not support crosstask user stack walking
-	 * but returns an empty stack instead of NULL.
-	 */
-	if (crosstask && user) {
+	/* get_perf_callchain() does not support crosstask stack walking */
+	if (crosstask) {
 		err = -EOPNOTSUPP;
 		goto clear;
 	}
@@ -451,8 +448,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	else if (kernel && task)
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
-		trace = get_perf_callchain(regs, kernel, user, max_depth,
-					   crosstask, false);
+		trace = get_perf_callchain(regs, kernel, user, max_depth,false);
 
 	if (unlikely(!trace) || trace->nr < skip) {
 		if (may_fault)
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 83834203e144..655fb25a725b 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -217,7 +217,7 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
 
 struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark)
+		   u32 max_stack, bool add_mark)
 {
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
@@ -248,9 +248,6 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		}
 
 		if (regs) {
-			if (crosstask)
-				goto exit_put;
-
 			if (add_mark)
 				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
@@ -260,7 +257,6 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		}
 	}
 
-exit_put:
 	put_callchain_entry(rctx);
 
 	return entry;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index ebe457bacf96..99f0f28feeb5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7793,16 +7793,17 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
 	bool kernel = !event->attr.exclude_callchain_kernel;
 	bool user   = !event->attr.exclude_callchain_user;
-	/* Disallow cross-task user callchains. */
-	bool crosstask = event->ctx->task && event->ctx->task != current;
 	const u32 max_stack = event->attr.sample_max_stack;
 	struct perf_callchain_entry *callchain;
 
 	if (!kernel && !user)
 		return &__empty_callchain;
 
-	callchain = get_perf_callchain(regs, kernel, user,
-				       max_stack, crosstask, true);
+	/* Disallow cross-task callchains. */
+	if (event->ctx->task && event->ctx->task != current)
+		return &__empty_callchain;
+
+	callchain = get_perf_callchain(regs, kernel, user, max_stack, true);
 	return callchain ?: &__empty_callchain;
 }
 
-- 
2.48.1

