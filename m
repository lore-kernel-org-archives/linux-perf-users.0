Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A1E26B74A
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 05:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765948393; cv=none; b=Cdeajrz1mkU/8i+dNUxYXZ8QxQhjR68AIUq2zuGL3iHuFXKjXKUwgI1dtVRVYwtVq3aEYDzD3FGdR/Lj9EajZzQkl2sddTbU2sMczgTo/PTOTpeTa2sqx1ZI04ud0WQUibuArk6CnlBnUvHP0C8QprGPuB4s0w72VQ5/dPKMV68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765948393; c=relaxed/simple;
	bh=eGCCxOqbBm6Jly0TcaepFPdDTUT8uH/jBlS6bx+ZGOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEzIuVnnqZ4tWeC28WvCQ64TWkCWFuw4FsW1xVGasIJYkwrf4T8ZoSlO4XUJbrT0/pzMh9x6mXGgvDh0K8yYrSNOBnNxongnCF5c/7I203G89RJaSgcsxqzzxd61RTdj877fDrT+bwiYAmOb1zIJnhifsxw+RRT9MqDTKJ73IJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZLJXPTVU; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZLJXPTVU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765948383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RHDwCxqBHRsF8+YQINTwrK2Wm0+gA9njAFM2wxpLMvg=;
	b=ZLJXPTVUaEOzX4dRAIDKUZGBtmzWZJREBSbmpWyirIjc+ZU/CNVzCNbsy+I+ovnZ54UAHY
	Eq9bO0JNKNnkNuKlzOlY1BGFOzXzcerEI47AZl/fnimNkKlcm2UtJOevN3KQDEjhuubxps
	kdkRwSTEsS79JEOBp6CDXgwgz+FActQ=
From: Tao Chen <chen.dylane@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	song@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v7 1/2] perf: Refactor get_perf_callchain
Date: Wed, 17 Dec 2025 13:12:01 +0800
Message-ID: <20251217051203.1738517-2-chen.dylane@linux.dev>
In-Reply-To: <20251217051203.1738517-1-chen.dylane@linux.dev>
References: <20251217051203.1738517-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From BPF stack map, we want to ensure that the callchain buffer
will not be overwritten by other preemptive tasks. Peter
suggested provide more flexible stack-sampling APIs, which
can be used in BPF, and we can still use the perf callchain
entry with the help of these APIs. The next patch will modify
the BPF part.

In the future, these APIs will also make it convenient for us to
add stack-sampling kfuncs in the eBPF subsystem, just as Andrii and
Alexei discussed earlier.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/linux/perf_event.h |  9 +++++
 kernel/events/callchain.c  | 73 ++++++++++++++++++++++++--------------
 2 files changed, 56 insertions(+), 26 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fd1d91017b9..edd3058e4d8 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -67,6 +67,7 @@ struct perf_callchain_entry_ctx {
 	u32				nr;
 	short				contexts;
 	bool				contexts_maxed;
+	bool				add_mark;
 };
 
 typedef unsigned long (*perf_copy_f)(void *dst, const void *src,
@@ -1718,6 +1719,14 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
 
 extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
+
+extern void __init_perf_callchain_ctx(struct perf_callchain_entry_ctx *ctx,
+				      struct perf_callchain_entry *entry,
+				      u32 max_stack, bool add_mark);
+
+extern void __get_perf_callchain_kernel(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs);
+extern void __get_perf_callchain_user(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs);
+
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark);
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 808c0d7a31f..dfb7cdbd470 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -216,13 +216,54 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
 #endif
 }
 
+void __init_perf_callchain_ctx(struct perf_callchain_entry_ctx *ctx,
+			       struct perf_callchain_entry *entry,
+			       u32 max_stack, bool add_mark)
+
+{
+	ctx->entry		= entry;
+	ctx->max_stack		= max_stack;
+	ctx->nr			= entry->nr = 0;
+	ctx->contexts		= 0;
+	ctx->contexts_maxed	= false;
+	ctx->add_mark		= add_mark;
+}
+
+void __get_perf_callchain_kernel(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		return;
+
+	if (ctx->add_mark)
+		perf_callchain_store_context(ctx, PERF_CONTEXT_KERNEL);
+	perf_callchain_kernel(ctx, regs);
+}
+
+void __get_perf_callchain_user(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs)
+{
+	int start_entry_idx;
+
+	if (!user_mode(regs)) {
+		if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
+			return;
+		regs = task_pt_regs(current);
+	}
+
+	if (ctx->add_mark)
+		perf_callchain_store_context(ctx, PERF_CONTEXT_USER);
+
+	start_entry_idx = ctx->entry->nr;
+	perf_callchain_user(ctx, regs);
+	fixup_uretprobe_trampoline_entries(ctx->entry, start_entry_idx);
+}
+
 struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark)
 {
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
-	int rctx, start_entry_idx;
+	int rctx;
 
 	/* crosstask is not supported for user stacks */
 	if (crosstask && user && !kernel)
@@ -232,34 +273,14 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 	if (!entry)
 		return NULL;
 
-	ctx.entry		= entry;
-	ctx.max_stack		= max_stack;
-	ctx.nr			= entry->nr = 0;
-	ctx.contexts		= 0;
-	ctx.contexts_maxed	= false;
+	__init_perf_callchain_ctx(&ctx, entry, max_stack, add_mark);
 
-	if (kernel && !user_mode(regs)) {
-		if (add_mark)
-			perf_callchain_store_context(&ctx, PERF_CONTEXT_KERNEL);
-		perf_callchain_kernel(&ctx, regs);
-	}
-
-	if (user && !crosstask) {
-		if (!user_mode(regs)) {
-			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
-				goto exit_put;
-			regs = task_pt_regs(current);
-		}
+	if (kernel)
+		__get_perf_callchain_kernel(&ctx, regs);
 
-		if (add_mark)
-			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
-
-		start_entry_idx = entry->nr;
-		perf_callchain_user(&ctx, regs);
-		fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
-	}
+	if (user && !crosstask)
+		__get_perf_callchain_user(&ctx, regs);
 
-exit_put:
 	put_callchain_entry(rctx);
 
 	return entry;
-- 
2.48.1

