Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06B72E6CCE
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413516; cv=none; b=Zx91ekUpex8FHxRPD5dlUtVp6Q1dn/brw1B84WgU6TdAzqd0PbM3CYeAiRz32oikCO2V5/xOUzX/2MXY2AjAef6/DVq1fvhCzSfT0C7k237rDqBFPFU3gBwKR0odo/lXdSZq0hncLf2edVOTmZJkGQcAVAZraDK4nj31T2hdYmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413516; c=relaxed/simple;
	bh=2OU+QeH0wHZFhok3gxIeOcNWQdtwUfU5x9jijEipvmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGkXw0itmnIyZYUYsamH+fYcdbdLbO8JhIE6ymGVeQCLOc8jRrRS4LtO9w2UUYnBPN3vQZzkQnP5mHd0CEyDagA9dHifLxpyp521gMnKXfZxUGPQpYJu/c24ueZ5kLI6phDxDJtTNy/9XY8iUhSlJU3NFCRB65pZAXEU5ZGklTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BUlSSZnw; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BUlSSZnw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769413513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EzuoEG3Lq0uyN71/5JLffXaHG9gMZoBp7DXFfx+Dmdw=;
	b=BUlSSZnwl61hfr1AgSUt6Qn8SkEs5JjwFF35/+SzZyaYUdI5UzxQOz0l+RM90TxM21ZtCW
	dFx2RV/gYWQVsfrEzGBTjxu+zIKfVjKSYTSwcSvZvPM//dcJYQnO5svuKVdU0X65Du7EHg
	YWv7bY3+lTsZpp+EyIQoL+/WOu1EG8g=
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
Subject: [PATCH bpf-next v8 1/3] perf: Add rctx in perf_callchain_entry
Date: Mon, 26 Jan 2026 15:43:29 +0800
Message-ID: <20260126074331.815684-2-chen.dylane@linux.dev>
In-Reply-To: <20260126074331.815684-1-chen.dylane@linux.dev>
References: <20260126074331.815684-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Record rctx inside the perf_callchain_entry itself, when callers of
get_callchain_entry no longer care about the assignment of rctx, and
will be used in the next patch.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/linux/perf_event.h |  5 +++--
 kernel/bpf/stackmap.c      |  5 ++---
 kernel/events/callchain.c  | 27 ++++++++++++++++-----------
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 9870d768db4..f0489843ebc 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -57,6 +57,7 @@
 #include <asm/local.h>
 
 struct perf_callchain_entry {
+	int				rctx;
 	u64				nr;
 	u64				ip[]; /* /proc/sys/kernel/perf_event_max_stack */
 };
@@ -1723,8 +1724,8 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark, u64 defer_cookie);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
-extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
-extern void put_callchain_entry(int rctx);
+extern struct perf_callchain_entry *get_callchain_entry(void);
+extern void put_callchain_entry(struct perf_callchain_entry *entry);
 
 extern int sysctl_perf_event_max_stack;
 extern int sysctl_perf_event_max_contexts_per_stack;
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index da3d328f5c1..e77dcdc2164 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -214,9 +214,8 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
 {
 #ifdef CONFIG_STACKTRACE
 	struct perf_callchain_entry *entry;
-	int rctx;
 
-	entry = get_callchain_entry(&rctx);
+	entry = get_callchain_entry();
 
 	if (!entry)
 		return NULL;
@@ -238,7 +237,7 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
 			to[i] = (u64)(from[i]);
 	}
 
-	put_callchain_entry(rctx);
+	put_callchain_entry(entry);
 
 	return entry;
 #else /* CONFIG_STACKTRACE */
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index b9c7e00725d..6cdbc5937b1 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -151,31 +151,36 @@ void put_callchain_buffers(void)
 	}
 }
 
-struct perf_callchain_entry *get_callchain_entry(int *rctx)
+struct perf_callchain_entry *get_callchain_entry(void)
 {
 	int cpu;
+	int rctx;
 	struct callchain_cpus_entries *entries;
+	struct perf_callchain_entry *entry;
 
-	*rctx = get_recursion_context(this_cpu_ptr(callchain_recursion));
-	if (*rctx == -1)
+	rctx = get_recursion_context(this_cpu_ptr(callchain_recursion));
+	if (rctx == -1)
 		return NULL;
 
 	entries = rcu_dereference(callchain_cpus_entries);
 	if (!entries) {
-		put_recursion_context(this_cpu_ptr(callchain_recursion), *rctx);
+		put_recursion_context(this_cpu_ptr(callchain_recursion), rctx);
 		return NULL;
 	}
 
 	cpu = smp_processor_id();
 
-	return (((void *)entries->cpu_entries[cpu]) +
-		(*rctx * perf_callchain_entry__sizeof()));
+	entry = ((void *)entries->cpu_entries[cpu]) +
+		(rctx * perf_callchain_entry__sizeof());
+	entry->rctx = rctx;
+
+	return entry;
 }
 
 void
-put_callchain_entry(int rctx)
+put_callchain_entry(struct perf_callchain_entry *entry)
 {
-	put_recursion_context(this_cpu_ptr(callchain_recursion), rctx);
+	put_recursion_context(this_cpu_ptr(callchain_recursion), entry->rctx);
 }
 
 static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entry,
@@ -222,13 +227,13 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 {
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
-	int rctx, start_entry_idx;
+	int start_entry_idx;
 
 	/* crosstask is not supported for user stacks */
 	if (crosstask && user && !kernel)
 		return NULL;
 
-	entry = get_callchain_entry(&rctx);
+	entry = get_callchain_entry();
 	if (!entry)
 		return NULL;
 
@@ -272,7 +277,7 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 	}
 
 exit_put:
-	put_callchain_entry(rctx);
+	put_callchain_entry(entry);
 
 	return entry;
 }
-- 
2.48.1

