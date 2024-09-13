Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0DA194ACA;
	Fri, 13 Sep 2024 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726268604; cv=none; b=M9I1GRj1quiQ4Va0IQQt/h+p7a4SisYNlI53Vo7xIdLUiu8iTub8XHhhIB71rEbB92ZYfQHSHEzLm70Ek7OB89aMiWu0DQjz5FXJNj67x0B6v81N1/7n/yysA2LSC0dtA+9wovf3VcvMMj3ledAmKuBnVLW10itAgZd8x4ebAhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726268604; c=relaxed/simple;
	bh=RpKqx3PGHDLN3yrCzPGsyZkgA6P2RW9jxlJQvW5Vw8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWjPjSTfISYEXlPhX4piT514JmvMuXhyk9uY24tQInfjgvtdDf2NqZ9Xlri+4qdBIj4is6XUsyxIoOuQ/5AlwxSHIEtt/YaDET9WlkcSWXo4ZUm2VKxDqcdi9xjRQYQbFAPVUR+6jYaAZW3SHdk3bas+jqnLwH4aWFrnrDXGOd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCD4JK3i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCD4JK3i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6513BC4CEC0;
	Fri, 13 Sep 2024 23:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726268604;
	bh=RpKqx3PGHDLN3yrCzPGsyZkgA6P2RW9jxlJQvW5Vw8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rCD4JK3i/XQj16l/BTCJAWiIOhqkWxOmsEkRlyH8vEaoPgn6pdzlUqHkz1DpK3ld0
	 G2e9+9ucDxCeemU+Nrcl/phzhGjYbZIPb9eNiYA5UpXtc83vWgPmP5lDzIpi6gsN72
	 EWJjYwvw4vqxG6waStNdXLRq0z9fSDuRlXwtCoD3oZpFme6BwaqfBcejImrF5gM4wq
	 FD8dyCWW1tUmPMHFw0mpBOnc0dhl7CFXc81N3UUPivEm+g3tpj1PGKhSSn7X8HFBX7
	 oGswThlwg1fFSetqALKNjilN7QPhe8GmiHXb//VSWX9mS5g0wMeXbteF5q+7Yi5/Tb
	 cITetUYIzA5ww==
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
Subject: [PATCH v2 07/11] perf: Remove get_perf_callchain() 'crosstask' argument
Date: Sat, 14 Sep 2024 01:02:09 +0200
Message-ID: <b1ea5eccd861857ee21c8994bed96aa33248d217.1726268190.git.jpoimboe@kernel.org>
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

get_perf_callchain() doesn't support cross-task unwinding, so it doesn't
make much sense to have 'crosstask' as an argument.  Instead, have
perf_callchain() adjust 'user' accordingly.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/perf_event.h | 2 +-
 kernel/bpf/stackmap.c      | 5 ++---
 kernel/events/callchain.c  | 6 +-----
 kernel/events/core.c       | 8 ++++----
 4 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 4365bb0684a5..64f9efe19553 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1541,7 +1541,7 @@ extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct p
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark);
+		   u32 max_stack, bool add_mark);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 0f922e43b524..ff6f0ef7ba5d 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -297,8 +297,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	if (max_depth > sysctl_perf_event_max_stack)
 		max_depth = sysctl_perf_event_max_stack;
 
-	trace = get_perf_callchain(regs, kernel, user, max_depth,
-				   false, false);
+	trace = get_perf_callchain(regs, kernel, user, max_depth, false);
 
 	if (unlikely(!trace))
 		/* couldn't fetch the stack trace */
@@ -433,7 +432,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
 		trace = get_perf_callchain(regs, kernel, user, max_depth,
-					   crosstask, false);
+					   false);
 	if (unlikely(!trace))
 		goto err_fault;
 
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
index 8038cd4d981b..19fd7bd38ecf 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7686,16 +7686,16 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
 	bool kernel = !event->attr.exclude_callchain_kernel;
 	bool user   = !event->attr.exclude_callchain_user;
-	/* Disallow cross-task user callchains. */
-	bool crosstask = event->ctx->task && event->ctx->task != current;
 	const u32 max_stack = event->attr.sample_max_stack;
 	struct perf_callchain_entry *callchain;
 
+	/* Disallow cross-task user callchains. */
+	user &= !event->ctx->task || event->ctx->task == current;
+
 	if (!kernel && !user)
 		return &__empty_callchain;
 
-	callchain = get_perf_callchain(regs, kernel, user,
-				       max_stack, crosstask, true);
+	callchain = get_perf_callchain(regs, kernel, user, max_stack, true);
 	return callchain ?: &__empty_callchain;
 }
 
-- 
2.46.0

