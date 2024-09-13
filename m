Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602181865F3;
	Fri, 13 Sep 2024 23:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726268600; cv=none; b=Bj1VZuIU6NLxZJWvqr9zRZ/q/gd2+933QpkYot/imcJUScBs3cj+BURyIidATElua0i4mPS9yiM1Xs4av72UwFtHMLWEOUofr1f8A0v7ApyyfLvRaRChsDNe5oa8bKrCQHK0xBkDTAyoYYaKr+MdLzIRiBbxt0W0jaep62K3bg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726268600; c=relaxed/simple;
	bh=1BrnE9jNsOh9s3h17ejYdYppCxUeupDFyNyWCmzffhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFPpb7YHU62PtqPrnfQXmoScsX4Ee0KwVb00OZp5xnq9wv0l3Ls7MdBSyNzHtbDnnFUrxg5NYhtSuA63wNgB7noyoo0jqGDnATlguiGNnTCfJX+rq5B8w1NIxYnOa1DWcdWF+Q2EWM2IJbjmPAsBwAPFCJD0aV7oV159mP3tiVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4LYYoVw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4LYYoVw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF27C4CED0;
	Fri, 13 Sep 2024 23:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726268600;
	bh=1BrnE9jNsOh9s3h17ejYdYppCxUeupDFyNyWCmzffhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C4LYYoVw2wmkdE2zixrEdLNkowutqxSSRFV9ecM2k4ipvIVMXZcyK5XL67AxMUS66
	 yuNXxyTwtmMHE26Pl40T945kKQurkPF5nRVCVgVI6Bcf0s1EA9TEsvVxsTo8W71PGg
	 l1JPoxXuDZiP+LAblzyLybrUvLcfUTzA6PizMM6NRzeV0MOpbpHTTuoYoNVaxyyi8O
	 ZoeJHOHbhwLDB1yUEmeMJS+n6MGrLhM4v0V3GFGDGl34tbLrr4Vx8Wp0W58OpgHO21
	 xPaZdLekXvtVMFd//EM0nbL3G6xkuxsd5yRJHOxIOOehMMeQBepe62qHDmEX7So64P
	 oqbsUw3tAhFHw==
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
	Namhyung Kim <Namhyung@kernel.org>
Subject: [PATCH v2 06/11] perf: Remove get_perf_callchain() 'init_nr' argument
Date: Sat, 14 Sep 2024 01:02:08 +0200
Message-ID: <eb14dc404a0c2c04b39f077358ff393856e7ea2b.1726268190.git.jpoimboe@kernel.org>
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
index 1a8942277dda..4365bb0684a5 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1540,7 +1540,7 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
 extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
+get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index c99f8e5234ac..0f922e43b524 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -297,7 +297,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	if (max_depth > sysctl_perf_event_max_stack)
 		max_depth = sysctl_perf_event_max_stack;
 
-	trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
+	trace = get_perf_callchain(regs, kernel, user, max_depth,
 				   false, false);
 
 	if (unlikely(!trace))
@@ -432,7 +432,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	else if (kernel && task)
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
-		trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
+		trace = get_perf_callchain(regs, kernel, user, max_depth,
 					   crosstask, false);
 	if (unlikely(!trace))
 		goto err_fault;
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
index 8a6c6bbcd658..8038cd4d981b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7694,7 +7694,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	if (!kernel && !user)
 		return &__empty_callchain;
 
-	callchain = get_perf_callchain(regs, 0, kernel, user,
+	callchain = get_perf_callchain(regs, kernel, user,
 				       max_stack, crosstask, true);
 	return callchain ?: &__empty_callchain;
 }
-- 
2.46.0

