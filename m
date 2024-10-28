Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75AE205AC5;
	Mon, 28 Oct 2024 21:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152122; cv=none; b=dbMDNu4FXPD4010WSNou8YjaE+2lB2Q1OgU2YwhUsBrhD2Ov5cgAnRwgrOjEs8Cx8MjE36zP380Bwe6XkmD6q0KpdIEirKCph/U0nEbHN6dkHHywzCuGEUCTY+0Y/Sh5rSdCS8oFaNIqGpP2HsEDFa7Ssnzv61w3iZHMQmuFWCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152122; c=relaxed/simple;
	bh=Es5oY0xOQfeuhKGtAHCUsq1KBkzukwi8QHbJItNGzbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iR/vjE+qyQOOHo1k1VpYmONDkJl9/j/YMGc1Aa1j9out06E3cx5e72uJZytaU7yAIV+Wt00/TjSstt3eACMGm9N/o4439Z5nuPw0Sy7i3uws7C6KONnFoYjCe3jgjkBGExt9MtkiBKh5Pam/fSJuiW9V5oqDmfL85FMTRsdU0IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8ZD9tkj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8ZD9tkj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA40C4CEC3;
	Mon, 28 Oct 2024 21:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152122;
	bh=Es5oY0xOQfeuhKGtAHCUsq1KBkzukwi8QHbJItNGzbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z8ZD9tkjMM49ryioIhqVy6/GwaL44CuSCBPUxidEMmu/otFU19n8GfpRXjgNWQruF
	 2wPR+aOxBvX3cKHAb4GyAJmSFIMR0siTZ5a3s5FtmtAt1ioSzfvTD9nRjblbCMAAPH
	 J0+ZOpBJ3wF6edWIl0SWNvvpt/O+6OotwwtHzE1EQRGFrK6uYpI8CP3+dqw7YnFl9o
	 IkQnRdzYV58XfvExyCp/V8cygBqnsYPs4/EKT0K2xzbQgKSjFpYCX/FEw8wnTuUf7F
	 K9npH3NA2UY9ImJT3fzPxhf0n805ODQGicLeos5GgKDzbrH3G2my0N3f8tAtOhyird
	 3X7ZUYv14RJZw==
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
Date: Mon, 28 Oct 2024 14:47:59 -0700
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
Message-ID: <20241028214759.y5MvqBsyEhNklypHyvRCGMYJ_rebxtxoe6MOPu2JGH4@z>

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

