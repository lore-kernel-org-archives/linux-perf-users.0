Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDD31F2C3B;
	Wed, 11 Dec 2024 22:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955941; cv=none; b=aC2sljc2kPZ/w/3NUsXgeEMVfC1MH8e1ZAjzjngEBKe9camois5YcQ6INC3FriXzx/vpcQ5Ew7oi3Zndo2FU+oRxuZmoS3J+eVs1v8QQ99R9+ZK34FdDk86k8XStgV0DgZQy9yqths8npoyZ+FcyRPI9yBRZuFmXCdGRbIq84bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955941; c=relaxed/simple;
	bh=FhYBFcBipaHcJVExkC+3V5vt7nolG31xdwTCXFsCPv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkdiV+x01l/FrlrqS1D9k+r4poHdza+NHQR3KW/biHiml18o1aiQruYVwIge/fYYMjQG9ipbZsVPNBMbE4sfdDztXpRJP9UMFG4wZzi12LEF+rX/dfpQPce5LLRTjHb4mKpuHfqV4kXqnYjL9aJkMz1lovCuim86MInQchfzfBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2/BgLzr; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2/BgLzr"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fd45005a09so6485a12.2;
        Wed, 11 Dec 2024 14:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733955939; x=1734560739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HM89nxEPCN1/mXqArlw/4nxHHrqhLHtRHulGS1q1v6g=;
        b=C2/BgLzrg+5M+/B64c5tuI1xEhbtYV51nZ0SNueIMdQsxKWMaQvbzu221yfNxnierr
         NwWOSjgzugalIJe4jKcoQC2fDjdxOH+OLutiJbnxQjZT3sFmf4L0d+jJDSr8jTySukCS
         wRtlhcVmmjYxG2VJjMktNETpyyWlgt3qLtBSBMbqKq+4IJcihUCCjZHw15csn4CW0a6L
         ou7r4bBnZV4GE4UHbzQ3ElaIh6/5BjMb850ktzBtldtK30Ju5xZvNvXYZL1wFRO9rHLz
         xn0GAznxz6GE8i+lUNLnkIBerBvGi9tntIFKFgaNSyh7JKSqBdhuGSmv4MSDArh+5XTv
         HS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733955939; x=1734560739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HM89nxEPCN1/mXqArlw/4nxHHrqhLHtRHulGS1q1v6g=;
        b=CmQ/AZEOeQdaf/oeI6wVgcnb+baUGd7PvAPGmvfJAjN6dq51zSUoCU5Zov08DQuiWd
         t3bAZPS9o5u0Opt/jTs3bxNUyvW0B3EfdyfLnF/dCH5E6rbaksOQWBzfT6drjDC3JBIM
         7vIA3+P4R/KwAGJpzNR0cT7D9kZG5E1BUegMUc3UpVOkpY2L5G3vpPBLu/vtPCXcWzNM
         Wv3kxg7ZntG2oEg5/nsejsUzwWR4ht+7FnHWlyYADp/3flUYPDfeNY2e1EWsLqD8e2rw
         NaDVVe5oPtcMlXR0+a26VfI93ojpGSSskXAC4ZAiXG3w/opLzzwN3kF52V+rXTjgyMCS
         +cnA==
X-Forwarded-Encrypted: i=1; AJvYcCUHNKL5Iu0DxfuNZd3OU7CdKl0Glbl7CD10dmArgZokURlXwGxxUJYeVtYw8aYHzBlX+BClqZEW5FDd7PG7wl9r1Q==@vger.kernel.org, AJvYcCVYw51ZBATkGTRAU1G3nzKGHzRmU/4dzH//z6a3vd8fzJGOyCrpX0j88CIF89umyLPpeulanow5QK7Kl8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfl9ZSpDedbph7kOZLYU/dqdzRAlKuy98h1iNysn46aJADXsB2
	PGkRrA0VFp6m+NKMTzQNStcgVBixpC0UEIAiCpZYeiGlpS08HeBe
X-Gm-Gg: ASbGnctYWI8XGh6C/533TKRGEj3eToN/rwqsCTselgsrEWF+AZFT4vOEmhykdUB1YpL
	+R9yGChUsN4Z/xDF5B6QO1aWQW6squou40QhYLmNLRGonajR94cf4RHLaEaGbgyPawXwdCn3pvj
	KC1yQps3VokkCzTACCRIEyUgRxV5HEs3V8HmW6i0W1y9YFodq/Q+MnTDTtegExdyUbMBdiJfMWc
	UCvY+kexyajAZRdBuJociUgSQZye4RJL8Msx2Vo1rdxFG3NF8+iEnn2xv8ycdWapmz2seJJI2wd
	swViKUz6eQ==
X-Google-Smtp-Source: AGHT+IGZh43wS6jR3abaQ4VciC4pcBqtRGirScKa5ez5wP+GsDjXEIBmtTZ/oGWJrUhY+mHuFmJMRQ==
X-Received: by 2002:a17:90b:548b:b0:2ea:59e3:2d2e with SMTP id 98e67ed59e1d1-2f139293a0fmr2536753a91.10.1733955939076;
        Wed, 11 Dec 2024 14:25:39 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef6d1fd68asm11241561a91.36.2024.12.11.14.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:25:38 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v11 04/10] perf record --off-cpu: Dump off-cpu samples in BPF
Date: Wed, 11 Dec 2024 14:25:22 -0800
Message-ID: <20241211222528.945590-5-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211222528.945590-1-howardchu95@gmail.com>
References: <20241211222528.945590-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Collect tid, period, callchain, and cgroup id and dump them when off-cpu
time threshold is reached.

We don't collect the off-cpu time twice (the delta), it's either in
direct samples, or accumulated samples that are dumped at the end of
perf.data.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-6-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 86 ++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index c87132e01eb3..aae63d999abb 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -19,11 +19,17 @@
 #define MAX_ENTRIES  102400
 
 #define MAX_CPUS  4096
+#define MAX_OFFCPU_LEN 37
+
+struct stack {
+	u64 array[MAX_STACKS];
+};
 
 struct tstamp_data {
 	__u32 stack_id;
 	__u32 state;
 	__u64 timestamp;
+	struct stack stack;
 };
 
 struct offcpu_key {
@@ -41,6 +47,10 @@ struct {
 	__uint(max_entries, MAX_ENTRIES);
 } stacks SEC(".maps");
 
+struct offcpu_data {
+	u64 array[MAX_OFFCPU_LEN];
+};
+
 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
 	__uint(key_size, sizeof(__u32));
@@ -48,6 +58,13 @@ struct {
 	__uint(max_entries, MAX_CPUS);
 } offcpu_output SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct offcpu_data));
+	__uint(max_entries, 1);
+} offcpu_payload SEC(".maps");
+
 struct {
 	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
 	__uint(map_flags, BPF_F_NO_PREALLOC);
@@ -194,6 +211,47 @@ static inline int can_record(struct task_struct *t, int state)
 	return 1;
 }
 
+static inline int copy_stack(struct stack *from, struct offcpu_data *to, int n)
+{
+	int len = 0;
+
+	for (int i = 0; i < MAX_STACKS && from->array[i]; ++i, ++len)
+		to->array[n + 2 + i] = from->array[i];
+
+	return len;
+}
+
+/**
+ * off_cpu_dump - dump off-cpu samples to ring buffer
+ * @data: payload for dumping off-cpu samples
+ * @key: off-cpu data
+ * @stack: stack trace of the task before being scheduled out
+ *
+ * If the threshold of off-cpu time is reached, acquire tid, period, callchain, and cgroup id
+ * information of the task, and dump it as a raw sample to perf ring buffer
+ */
+static int off_cpu_dump(void *ctx, struct offcpu_data *data, struct offcpu_key *key,
+			struct stack *stack, __u64 delta)
+{
+	int n = 0, len = 0;
+
+	data->array[n++] = (u64)key->tgid << 32 | key->pid;
+	data->array[n++] = delta;
+
+	/* data->array[n] is callchain->nr (updated later) */
+	data->array[n + 1] = PERF_CONTEXT_USER;
+	data->array[n + 2] = 0;
+	len = copy_stack(stack, data, n);
+
+	/* update length of callchain */
+	data->array[n] = len + 1;
+	n += len + 2;
+
+	data->array[n++] = key->cgroup_id;
+
+	return bpf_perf_event_output(ctx, &offcpu_output, BPF_F_CURRENT_CPU, data, n * sizeof(u64));
+}
+
 static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
 			struct task_struct *next, int state)
 {
@@ -218,6 +276,16 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
 	pelem->state = state;
 	pelem->stack_id = stack_id;
 
+	/*
+	 * If stacks are successfully collected by bpf_get_stackid(), collect them once more
+	 * in task_storage for direct off-cpu sample dumping
+	 */
+	if (stack_id > 0 && bpf_get_stack(ctx, &pelem->stack, MAX_STACKS * sizeof(u64), BPF_F_USER_STACK)) {
+		/*
+		 * This empty if block is used to avoid 'result unused warning' from bpf_get_stack().
+		 * If the collection fails, continue with the logic for the next task.
+		 */
+	}
 next:
 	pelem = bpf_task_storage_get(&tstamp, next, NULL, 0);
 
@@ -232,11 +300,19 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
 		__u64 delta = ts - pelem->timestamp;
 		__u64 *total;
 
-		total = bpf_map_lookup_elem(&off_cpu, &key);
-		if (total)
-			*total += delta;
-		else
-			bpf_map_update_elem(&off_cpu, &key, &delta, BPF_ANY);
+		if (delta >= offcpu_thresh_ns) {
+			int zero = 0;
+			struct offcpu_data *data = bpf_map_lookup_elem(&offcpu_payload, &zero);
+
+			if (data)
+				off_cpu_dump(ctx, data, &key, &pelem->stack, delta);
+		} else {
+			total = bpf_map_lookup_elem(&off_cpu, &key);
+			if (total)
+				*total += delta;
+			else
+				bpf_map_update_elem(&off_cpu, &key, &delta, BPF_ANY);
+		}
 
 		/* prevent to reuse the timestamp later */
 		pelem->timestamp = 0;
-- 
2.43.0

