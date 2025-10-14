Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6DA2F5A2D
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436155; cv=none; b=ZHtqZBdxs3w2NDPIEB/X5PKCx4jfh0sanTAXtw5zLhsVaS7I+kvYyLC9U4Gw2K6R450aWVtOBD3IK1c9hjPLJOnIsWVOa2uYPW+eXaK2hvuyuplXx93VCT29CNQl25xMixNNB15x+0nO11PGFvkqzoBVOapCwvZBO+cPpwiGw/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436155; c=relaxed/simple;
	bh=0wWR0ARb4iaG639FGoaQ+ToOnHpIAuK/jCQvqFiWndc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPItZ0rw92y6pc+jsvJXD4YqfDwcW+ovg3DbF/c4SBzeO/h1l0Nf5ltKGDSrCGu6Jl132/m2o7VbhaA2ceTKkDd0JZ1LaNhtc5Y26P+nkQeZFF3N/TN25DpGg45+u2WNIOwvWruPaPpzc+QhY9djFHW25p28VXq/rbI9XMrYxIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BgDme0t1; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BgDme0t1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760436148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c5ndA3xQnObfPBbFY+gazZ3jKhUuFbAJBqRdxeUz2SY=;
	b=BgDme0t1X3IIwCSP/mSRpoFXkV/aNxj4PIHchclA87Cr0qWau48TNBkqN2fo9y4wj9yt5n
	qsPsoLuBt1QhnaWEAmXA4t6XBkkZ71ojvCUomi+TRKCT/57kCVNOrjENgd/bNgKXH4WDRI
	YotbnjI3tznYWPVWg8irAioX8w+1+YI=
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
Subject: [RFC PATCH bpf-next v2 2/2] bpf: Pass external callchain entry to get_perf_callchain
Date: Tue, 14 Oct 2025 18:01:28 +0800
Message-ID: <20251014100128.2721104-3-chen.dylane@linux.dev>
In-Reply-To: <20251014100128.2721104-1-chen.dylane@linux.dev>
References: <20251014100128.2721104-1-chen.dylane@linux.dev>
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
mode. Drawing on the per-cpu design of bpf_perf_callchain_entries,
stack-allocated memory of bpf_perf_callchain_entry is used here.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/stackmap.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 94e46b7f340..acd72c021c0 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -31,6 +31,11 @@ struct bpf_stack_map {
 	struct stack_map_bucket *buckets[] __counted_by(n_buckets);
 };
 
+struct bpf_perf_callchain_entry {
+	u64 nr;
+	u64 ip[PERF_MAX_STACK_DEPTH];
+};
+
 static inline bool stack_map_use_build_id(struct bpf_map *map)
 {
 	return (map->map_flags & BPF_F_STACK_BUILD_ID);
@@ -305,6 +310,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	bool user = flags & BPF_F_USER_STACK;
 	struct perf_callchain_entry *trace;
 	bool kernel = !user;
+	struct bpf_perf_callchain_entry entry = { 0 };
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
@@ -314,12 +320,8 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	if (max_depth > sysctl_perf_event_max_stack)
 		max_depth = sysctl_perf_event_max_stack;
 
-	trace = get_perf_callchain(regs, NULL, kernel, user, max_depth,
-				   false, false);
-
-	if (unlikely(!trace))
-		/* couldn't fetch the stack trace */
-		return -EFAULT;
+	trace = get_perf_callchain(regs, (struct perf_callchain_entry *)&entry,
+				   kernel, user, max_depth, false, false);
 
 	return __bpf_get_stackid(map, trace, flags);
 }
@@ -412,6 +414,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
 	bool user = flags & BPF_F_USER_STACK;
 	struct perf_callchain_entry *trace;
+	struct bpf_perf_callchain_entry entry = { 0 };
 	bool kernel = !user;
 	int err = -EINVAL;
 	u64 *ips;
@@ -451,8 +454,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	else if (kernel && task)
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
-		trace = get_perf_callchain(regs, NULL, kernel, user, max_depth,
-					   crosstask, false);
+		trace = get_perf_callchain(regs, (struct perf_callchain_entry *)&entry,
+					   kernel, user, max_depth, crosstask, false);
 
 	if (unlikely(!trace) || trace->nr < skip) {
 		if (may_fault)
-- 
2.48.1

