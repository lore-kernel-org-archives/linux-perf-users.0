Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FF8310651
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413565; cv=none; b=jkWaDKeLHE3iNdV24Qp4jBNrX28XMdfMuZAoIIIn3eecaQn/2LhC/pfUOgvbSG9Cykf6AydOLxS4U9L6g4gP8g2zFmH7rq2c5nOTWxFXhK2b2UZF1vMHxx3S1JwlO17EVu+UhuUWJ+axQjWBI8jPL8HwRpLkj6BXi3BxYjInNs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413565; c=relaxed/simple;
	bh=NktD6tjtBJc8ZlKtG4yjDn3iJhKXY/1JyGPuSKcMr7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDKyk6fag2OSXmadZ2KPqll47Evgru2Psd7MGnw/snfKWSCb4TTzegILAkF8gSR7YFmgtX5mUSOOD+aJDNPNsAb5bXb0GQR5Tsj0OjFs/SRaZaTZRLX2YOxmUlFCyGgvhIN8quDq/QkLnsqLfTy8qUAGwwGdibJnudDPfxXeL58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eVdtXpxD; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eVdtXpxD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769413561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eGKZCIMuPLTUUetmg43YQkbWKXVbZVR0jeFtXTaplZM=;
	b=eVdtXpxDRjCOghcT7+o4hJKuG0Izhm5Xvkov/Nwg4mUMD13QaveVWXlIneAcsCK/PFfWbq
	o7i6wqRDXhInQRFS1sqUyi7Jo1oVY29uXft7ruaO3avYLhuYDhTV/SyLmte+EPRaIsRe5D
	yFaotQVUJwwJ6/qz+RF45M2J/t/L4z0=
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
Subject: [PATCH bpf-next v8 3/3] bpf: Hold ther perf callchain entry until used completely
Date: Mon, 26 Jan 2026 15:43:31 +0800
Message-ID: <20260126074331.815684-4-chen.dylane@linux.dev>
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

As Alexei noted, get_perf_callchain() return values may be reused
if a task is preempted after the BPF program enters migrate disable
mode. The perf_callchain_entres has a small stack of entries, and
we can reuse it as follows:

1. get the perf callchain entry
2. BPF use...
3. put the perf callchain entry

And Peter suggested that get_recursion_context used with preemption
disabled, so we should disable preemption at BPF side.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/stackmap.c | 55 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index e77dcdc2164..6bdee6cc05f 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -215,7 +215,9 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
 #ifdef CONFIG_STACKTRACE
 	struct perf_callchain_entry *entry;
 
+	preempt_disable();
 	entry = get_callchain_entry();
+	preempt_enable();
 
 	if (!entry)
 		return NULL;
@@ -237,14 +239,40 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
 			to[i] = (u64)(from[i]);
 	}
 
-	put_callchain_entry(entry);
-
 	return entry;
 #else /* CONFIG_STACKTRACE */
 	return NULL;
 #endif
 }
 
+static struct perf_callchain_entry *
+bpf_get_perf_callchain(struct pt_regs *regs, bool kernel, bool user, int max_stack,
+		       bool crosstask)
+{
+	struct perf_callchain_entry *entry;
+	int ret;
+
+	preempt_disable();
+	entry = get_callchain_entry();
+	preempt_enable();
+
+	if (unlikely(!entry))
+		return NULL;
+
+	ret = __get_perf_callchain(entry, regs, kernel, user, max_stack, crosstask, false, 0);
+	if (ret) {
+		put_callchain_entry(entry);
+		return NULL;
+	}
+
+	return entry;
+}
+
+static void bpf_put_perf_callchain(struct perf_callchain_entry *entry)
+{
+	put_callchain_entry(entry);
+}
+
 static long __bpf_get_stackid(struct bpf_map *map,
 			      struct perf_callchain_entry *trace, u64 flags)
 {
@@ -327,20 +355,23 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	struct perf_callchain_entry *trace;
 	bool kernel = !user;
 	u32 max_depth;
+	int ret;
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
 		return -EINVAL;
 
 	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
-	trace = get_perf_callchain(regs, kernel, user, max_depth,
-				   false, false, 0);
+	trace = bpf_get_perf_callchain(regs, kernel, user, max_depth, false);
 
 	if (unlikely(!trace))
 		/* couldn't fetch the stack trace */
 		return -EFAULT;
 
-	return __bpf_get_stackid(map, trace, flags);
+	ret = __bpf_get_stackid(map, trace, flags);
+	bpf_put_perf_callchain(trace);
+
+	return ret;
 }
 
 const struct bpf_func_proto bpf_get_stackid_proto = {
@@ -468,13 +499,19 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	} else if (kernel && task) {
 		trace = get_callchain_entry_for_task(task, max_depth);
 	} else {
-		trace = get_perf_callchain(regs, kernel, user, max_depth,
-					   crosstask, false, 0);
+		trace = bpf_get_perf_callchain(regs, kernel, user, max_depth, crosstask);
 	}
 
-	if (unlikely(!trace) || trace->nr < skip) {
+	if (unlikely(!trace)) {
+		if (may_fault)
+			rcu_read_unlock();
+		goto err_fault;
+	}
+	if (trace->nr < skip) {
 		if (may_fault)
 			rcu_read_unlock();
+		if (!trace_in)
+			bpf_put_perf_callchain(trace);
 		goto err_fault;
 	}
 
@@ -495,6 +532,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	/* trace/ips should not be dereferenced after this point */
 	if (may_fault)
 		rcu_read_unlock();
+	if (!trace_in)
+		bpf_put_perf_callchain(trace);
 
 	if (user_build_id)
 		stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
-- 
2.48.1

