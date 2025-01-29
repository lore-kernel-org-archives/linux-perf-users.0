Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B51578F58
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2025 00:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738110317; cv=none; b=ckIiFJ7QWwskjjViC1cvsPmddPLyIgA2jn8Zf/IHHSOnPgidegomVpiCFBd6OuSFv8ORu73cjjskJonFy00WMUOb/xERXILq8IaAUMMCyd6NPf8g1Txm7pzTHFUVdycWCbbNt5NBGjkT3gtvylVcGKhkyEnfQnB2CvcQa4LHpfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738110317; c=relaxed/simple;
	bh=27Hu/QjNl2hArTosMTM15Ibs0q2pm4UaVBt0g8CsV+E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cFQgjUqH/92L8ugRgee4GdpcVbCZ15DY4MRYO3rkYy7YBLBzGJTkYCZWbx2HcBEaEKQZbMNnZUz4BHrC5vHqXiuJ+RELNDHZF4Xv3YBM40duY9nAqocIrIlmUq6WOdvR4ZOwXsTJoIlIAqPjJXGxuVJGQowCr8I+ZI5WV14JhLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EQI24tFL; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EQI24tFL"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee9f66cb12so12774145a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 16:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738110314; x=1738715114; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PXeAr/W67pFJL0V452kTAWbs3WuQao1XWrD/nQMSmJk=;
        b=EQI24tFLn10xGvZ4HLHJC5iFHY4lTTa/aJSq3iHFTsK6Y2Va3jKT8g6l0uUyCWrzPE
         Vb22ShpdvAKlMH6Scf0uHctRtFx5y9nXM5MWY32JzrTTCFyDpPnqJQgdcXN8NYhemXlQ
         n4x0WCnkvp6xzOGAcIkmMtcahmBTr1H8TP4cPTmVBBK7XnblmrDklRVjv3MjoQ78emFA
         k56UYx+dpBt+DmBc5nZp4ysPhQ+E+Rt0jO39nRrXMxUdit/gQPYPB3k0sRwUfQXsOpJj
         UTSKrRCt1jaC5ld3XH3qMutgXP6lZimCaHKAxo3r7vpPzVD3Q88XB8kGsk5zG1e2OjQL
         1sBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738110314; x=1738715114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXeAr/W67pFJL0V452kTAWbs3WuQao1XWrD/nQMSmJk=;
        b=uHbvukRaIefpXMLDQMu3l3BMFVb0G05QFrnzYYAP83Gt41G7g2Z7j+brXxW1Xu/rkx
         PtFXjsAwd0OvqptnZxBTrH27/vTD3iAww/iCeAODzC9nYxNK84TbayiczasH8jIdhSKQ
         snmaZZZf2H9jaCDj5bga5Z8Agv/M5vUF4cI2XwWtUX8S2i3ZUw01rWMu1tWfuq2N6Qq+
         eQNtgn9rNRmkzwCR4L7aXPCwxlxwS4TDYzygE4o2R1Gpe/1fT0h8ZPlWkS8NJHAmNl1M
         ISVzC/qEZbXL3OBIM/rI4ZOT49O7eLA7bYhxGeWGyQtJzi8mFwxUXdx3K76+cwlqTlzz
         EfyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDdpEfuTOydQx8bWb32RoOKiJ1ReaoYlLc3pOkZ3FfwYgYso15Q40xRqRYXO1/SzSshBbsLTIuhg+4bde4SqzM@vger.kernel.org
X-Gm-Message-State: AOJu0YzWuhnLhN0FkeMnNU7jCwymud2GwG1cAqYk0brCyIP8CVNpOXrg
	NpnqNDmCUjwz24XTyYjCo7sptFW6WAmgPFKFgBAYp3nA8c38rP/COyRsS3QBQzH+Uf4hQ7u7lH0
	b0Q==
X-Google-Smtp-Source: AGHT+IEXM93qHwaO7edPXGrECqoSkr/Auhvr+ArqW++XActsaTaaIYnOSH8wKgfjnEoeuuF4WQsk+oHQunQ=
X-Received: from pfbbu11.prod.google.com ([2002:a05:6a00:410b:b0:725:3321:1f0c])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:148c:b0:71e:21:d2d8
 with SMTP id d2e1a72fcca58-72fd0bf3be7mr1616751b3a.7.1738110313779; Tue, 28
 Jan 2025 16:25:13 -0800 (PST)
Date: Tue, 28 Jan 2025 16:14:57 -0800
In-Reply-To: <20250129001905.619859-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250129001905.619859-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250129001905.619859-2-ctshao@google.com>
Subject: [PATCH v3 1/5] perf lock: Add bpf maps for owner stack tracing
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nathan@kernel.org, 
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Add a struct and few bpf maps in order to tracing owner stack.
`struct owner_tracing_data`: Contains owner's pid, stack id, timestamp for
  when the owner acquires lock, and the count of lock waiters.
`stack_buf`: Percpu buffer for retrieving owner stacktrace.
`owner_stacks`: For tracing owner stacktrace to customized owner stack id.
`owner_data`: For tracing lock_address to `struct owner_tracing_data` in
  bpf program.
`owner_stat`: For reporting owner stacktrace in usermode.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/util/bpf_lock_contention.c         | 16 +++++--
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 42 ++++++++++++++++---
 tools/perf/util/bpf_skel/lock_data.h          |  7 ++++
 3 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index fc8666222399..795e2374facc 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -131,9 +131,19 @@ int lock_contention_prepare(struct lock_contention *con)
 	else
 		bpf_map__set_max_entries(skel->maps.task_data, 1);
 
-	if (con->save_callstack)
-		bpf_map__set_max_entries(skel->maps.stacks, con->map_nr_entries);
-	else
+	if (con->save_callstack) {
+		bpf_map__set_max_entries(skel->maps.stacks,
+					 con->map_nr_entries);
+		if (con->owner) {
+			bpf_map__set_value_size(skel->maps.stack_buf, con->max_stack * sizeof(u64));
+			bpf_map__set_key_size(skel->maps.owner_stacks,
+						con->max_stack * sizeof(u64));
+			bpf_map__set_max_entries(skel->maps.owner_stacks, con->map_nr_entries);
+			bpf_map__set_max_entries(skel->maps.owner_data, con->map_nr_entries);
+			bpf_map__set_max_entries(skel->maps.owner_stat, con->map_nr_entries);
+			skel->rodata->max_stack = con->max_stack;
+		}
+	} else
 		bpf_map__set_max_entries(skel->maps.stacks, 1);
 
 	if (target__has_cpu(target)) {
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 6533ea9b044c..b4961dd86222 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -19,13 +19,37 @@
 #define LCB_F_PERCPU	(1U << 4)
 #define LCB_F_MUTEX	(1U << 5)
 
-/* callstack storage  */
+ /* buffer for owner stacktrace */
 struct {
-	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
 	__uint(key_size, sizeof(__u32));
 	__uint(value_size, sizeof(__u64));
-	__uint(max_entries, MAX_ENTRIES);
-} stacks SEC(".maps");
+	__uint(max_entries, 1);
+} stack_buf SEC(".maps");
+
+/* a map for tracing owner stacktrace to owner stack id */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64)); // owner stacktrace
+	__uint(value_size, sizeof(__u64)); // owner stack id
+	__uint(max_entries, 1);
+} owner_stacks SEC(".maps");
+
+/* a map for tracing lock address to owner data */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64)); // lock address
+	__uint(value_size, sizeof(struct owner_tracing_data));
+	__uint(max_entries, 1);
+} owner_data SEC(".maps");
+
+/* a map for contention_key (stores owner stack id) to contention data */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(struct contention_key));
+	__uint(value_size, sizeof(struct contention_data));
+	__uint(max_entries, 1);
+} owner_stat SEC(".maps");
 
 /* maintain timestamp at the beginning of contention */
 struct {
@@ -43,6 +67,14 @@ struct {
 	__uint(max_entries, 1);
 } tstamp_cpu SEC(".maps");
 
+/* callstack storage  */
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u64));
+	__uint(max_entries, MAX_ENTRIES);
+} stacks SEC(".maps");
+
 /* actual lock contention statistics */
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
@@ -143,6 +175,7 @@ const volatile int needs_callstack;
 const volatile int stack_skip;
 const volatile int lock_owner;
 const volatile int use_cgroup_v2;
+const volatile int max_stack;
 
 /* determine the key of lock stat */
 const volatile int aggr_mode;
@@ -466,7 +499,6 @@ int contention_end(u64 *ctx)
 			return 0;
 		need_delete = true;
 	}
-
 	duration = bpf_ktime_get_ns() - pelem->timestamp;
 	if ((__s64)duration < 0) {
 		__sync_fetch_and_add(&time_fail, 1);
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index c15f734d7fc4..15f5743bd409 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -3,6 +3,13 @@
 #ifndef UTIL_BPF_SKEL_LOCK_DATA_H
 #define UTIL_BPF_SKEL_LOCK_DATA_H
 
+struct owner_tracing_data {
+	u32 pid; // Who has the lock.
+	u32 count; // How many waiters for this lock.
+	u64 timestamp; // The time while the owner acquires lock and contention is going on.
+	s32 stack_id; // Identifier for `owner_stat`, which stores as value in `owner_stacks`
+};
+
 struct tstamp_data {
 	u64 timestamp;
 	u64 lock;
-- 
2.48.1.262.g85cc9f2d1e-goog

