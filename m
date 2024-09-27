Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6331C32E4;
	Fri, 27 Sep 2024 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463243; cv=none; b=IcCe2L4jWoE1gnggop9rySw7R47MUUZWD9Qeurq/yacUHvk0KEuC2XhCk1LiWLJ2CyfElFbgJdWvRzGOaA7n3wwT9n1cZnIAWEGu3yjGE8l/ggJ4ijEgPVyOg0f56W7NVKCYuUUoIYrm0WoVRAiVymq9gQjcvnwLiKmV8x2Yomw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463243; c=relaxed/simple;
	bh=ZP1MfqrrYWrJ0ctH6HxOMr4k4OgS0xIR/BE5dS8Y3CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBcX4nMITRnJXQiJhhp8dtHHqdSHE8IcnmjfGzKQzM/oGbpgxqVggGk7srBcc942pZUXE9TmKpq5Nja82XxNS7Y/R4WV6NDtvMK5oM2UOJvITa6vXFgW7fNF9QM34YfxpyifC+Epljah5f2gnrdrzo0SX1glGVg5Vc+2u40eZZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLiusPYS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLiusPYS"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-719ba0654f9so2161941b3a.3;
        Fri, 27 Sep 2024 11:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727463241; x=1728068041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34MOf3DFjEdXzBK7xHuDyap27i2H+2ZryV/BZ+beF1M=;
        b=RLiusPYS6jtATAb5L2PsGIvNzVWeq1rS4GOb6RLu0fvCvm6RfHxPC5bTIum9Hao5t8
         5aO3vNRBw0t55tbCZfDk3iKAH9zsQ2Rj578V1rPYnYvF3trw0THaOL6fGNPpeRXqZGM3
         ZOu+0eDUFZOBZF+qpkidaquYzMJFx97WTV0xOW1C+CUTBHK6BG0VXxDlzaAa13qR5Ah1
         5aCwCIzwKhqSQ4VFXItQsKOM7gxUL9Z18HtDXxx2Gv29+feaqBpwY8IF0JeJkKjagP1Z
         zOmRTgHKSILEAKZqgCY4gmkerw/3u1/mdW56ww1XMErZB4RXD1YrrSxm1z8jBN+hMwM+
         hWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727463241; x=1728068041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34MOf3DFjEdXzBK7xHuDyap27i2H+2ZryV/BZ+beF1M=;
        b=sZtXaW93o9JADkXpEvM0XxL9U09s2fe7LEWnQx/rMjF3ZgetThEzVICE5zaX0IxeSH
         z5IJj3zi9NCSxlETABVt1mp8RnctVtMKKjeZrSrCO1kP+3CEm9b7jHhLWTnkhbAm0c+b
         WorgzXGkYT0f/TvdvfCe7PKgVrzinyOgdMNiPSAj041xKNQgdWELE5xoqJrxV9yPhuPn
         H4NKvu+toLODe1gV5vSj+cPvb1gzB7jFWVijf1MHMn/ud5jSTUvFKSV466/3xDuRgkmu
         /SE8kMyRp3IQeXs6gEttAX+iDL/a3SAK0JCL/O2aTMdea1BGnIphEkYev7ZzAODrK64P
         QXhg==
X-Forwarded-Encrypted: i=1; AJvYcCUhkKW9GchqnRZItGTtRVPU4dMVgVC8Ir9VMZtvNZVxRVGkv/J26OkdqA1tUyXzmxPmaWZRcu6pqk/C6KCT5kJqjA==@vger.kernel.org, AJvYcCVuFDy53EBPo17NDw28ZM+uFAtIUU/3JIETgy+5y5YUtf5C9BBvqUIyzw800AVfHGgAulkLf88ekvsP4cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOfVIQwe3uccoxxhdlNhOCh9vyLNx+7xtab6pCg/nbdsdHoSCs
	1sezvV4xfVmNydtgKDGp7/zTXUvQG6C5w68HVRlb5KQgF9wrUx66
X-Google-Smtp-Source: AGHT+IEXJh+GR17BHiYGJ/Cav7SROPr6ZU+ZrdpowUOqEbVJL6bFk1N7eNkZzpUdQZeDKtXEGpnrXg==
X-Received: by 2002:a05:6a00:4fcb:b0:70d:2725:ebe4 with SMTP id d2e1a72fcca58-71b25f85147mr6724688b3a.13.1727463240815;
        Fri, 27 Sep 2024 11:54:00 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264c23b6sm1930244b3a.88.2024.09.27.11.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 11:54:00 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v5 4/8] perf record off-cpu: Dump direct off-cpu samples in BPF
Date: Fri, 27 Sep 2024 11:53:36 -0700
Message-ID: <20240927185340.658143-5-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240927185340.658143-1-howardchu95@gmail.com>
References: <20240927185340.658143-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add perf_event_array map for dumping direct off-cpu samples, but keep
the at-the-end approach.

Tons of checking before access, to pass the BPF verifier.

If off-cpu time (represented as delta) exceeds the off-cpu threshold, do
output.

Output PERF_SAMPLE_TID, PERF_SAMPLE_PERIOD, PERF_SAMPLE_CALLCHAIN, and
PERF_SAMPLE_CGROUP in bpf_perf_event_output().

Ideally, we should only output
PERF_SAMPLE_PERIOD (off-cpu time) and PERF_SAMPLE_CALLCHAIN (sched_in
process's callchain). One only needs to set PERF_SAMPLE_TID and
PERF_SAMPLE_CGROUP, and perf_event will do everything for us.

But in reality, that's not the case. Setting PERF_SAMPLE_TID will mostly
give us TID of 0. We might get the correct TID for offcpu-time event
from time to time, but it is really rare.
         swapper       0 [000] offcpu-time:  /
        :1321819 1321819 [002] offcpu-time:  /user.slice/user-1000.slice/session-2.scope
         swapper       0 [001] offcpu-time:  /
         swapper       0 [003] offcpu-time:  /

And setting PERF_SAMPLE_CGROUP doesn't work properly either.
    tmux: server    3701 [003] offcpu-time:  /
    blueman-tray    1064 [001] offcpu-time:  /
            bash 1350867 [001] offcpu-time:  /
            bash 1350844 [000] offcpu-time:  /

We need to retrieve PERF_SAMPLE_TID, PERF_SAMPLE_PERIOD,
PERF_SAMPLE_CALLCHAIN, and PERF_SAMPLE_CGROUP using BPF and output these
four fields.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 121 +++++++++++++++++++++++++
 tools/perf/util/off_cpu.h              |   8 +-
 2 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index 5ea320aa9a53..c42d0e2d91d8 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -18,6 +18,9 @@
 #define MAX_STACKS   32
 #define MAX_ENTRIES  102400
 
+#define MAX_CPUS  4096
+#define MAX_OFFCPU_LEN 128
+
 struct tstamp_data {
 	__u32 stack_id;
 	__u32 state;
@@ -32,6 +35,7 @@ struct offcpu_key {
 	__u64 cgroup_id;
 };
 
+/* for dumping at the end */
 struct {
 	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
 	__uint(key_size, sizeof(__u32));
@@ -39,6 +43,37 @@ struct {
 	__uint(max_entries, MAX_ENTRIES);
 } stacks SEC(".maps");
 
+struct offcpu_data {
+	u64 array[MAX_OFFCPU_LEN];
+};
+
+struct stack_data {
+	u64 array[MAX_STACKS];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+	__uint(max_entries, MAX_CPUS);
+} offcpu_output SEC(".maps");
+
+/* temporary offcpu sample */
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct offcpu_data));
+	__uint(max_entries, 1);
+} offcpu_payload SEC(".maps");
+
+/* cached stack per task storage */
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct stack_data);
+} stack_cache SEC(".maps");
+
 struct {
 	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
 	__uint(map_flags, BPF_F_NO_PREALLOC);
@@ -185,12 +220,75 @@ static inline int can_record(struct task_struct *t, int state)
 	return 1;
 }
 
+static inline bool check_bounds(int index)
+{
+	if (index < 0 || index >= MAX_OFFCPU_LEN)
+		return false;
+
+	return true;
+}
+
+static inline int copy_stack(struct stack_data *from,
+			     struct offcpu_data *to, int n)
+{
+	int max_stacks = MAX_STACKS, len = 0;
+
+	if (!from)
+		return len;
+
+	for (int i = 0; i < max_stacks && from->array[i]; ++i) {
+		if (check_bounds(n + 2 + i)) {
+			to->array[n + 2 + i] = from->array[i];
+			++len;
+		}
+	}
+	return len;
+}
+
+static int off_cpu_dump(void *ctx, struct offcpu_data *data, struct offcpu_key *key,
+			struct stack_data *stack_p, __u64 delta, __u64 timestamp)
+{
+	int size, n = 0, ip_pos = -1, len = 0;
+
+	if (sample_type & PERF_SAMPLE_TID && check_bounds(n))
+		data->array[n++] = (u64)key->tgid << 32 | key->pid;
+	if (sample_type & PERF_SAMPLE_PERIOD && check_bounds(n))
+		data->array[n++] = delta;
+	if (sample_type & PERF_SAMPLE_CALLCHAIN && check_bounds(n + 2)) {
+		/* data->array[n] is callchain->nr (updated later) */
+		data->array[n + 1] = PERF_CONTEXT_USER;
+		data->array[n + 2] = 0;
+
+		len = copy_stack(stack_p, data, n);
+
+		/* update length of callchain */
+		data->array[n] = len + 1;
+
+		/* update sample ip with the first callchain entry */
+		if (ip_pos >= 0)
+			data->array[ip_pos] = data->array[n + 2];
+
+		/* calculate sample callchain data->array length */
+		n += len + 2;
+	}
+	if (sample_type & PERF_SAMPLE_CGROUP && check_bounds(n))
+		data->array[n++] = key->cgroup_id;
+
+	size = n * sizeof(u64);
+	if (size >= 0 && size <= MAX_OFFCPU_LEN * sizeof(u64))
+		bpf_perf_event_output(ctx, &offcpu_output, BPF_F_CURRENT_CPU, data, size);
+
+	return 0;
+}
+
 static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
 			struct task_struct *next, int state)
 {
 	__u64 ts;
 	__u32 stack_id;
 	struct tstamp_data *pelem;
+	struct stack_data *stack_p;
+	int zero = 0;
 
 	ts = bpf_ktime_get_ns();
 
@@ -200,6 +298,21 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
 	stack_id = bpf_get_stackid(ctx, &stacks,
 				   BPF_F_FAST_STACK_CMP | BPF_F_USER_STACK);
 
+	/*
+	 * if stacks are successfully collected, cache them to task_storage, they are then
+	 * dumped if the off-cpu time hits the threshold.
+	 */
+	if (stack_id > 0) {
+		stack_p = bpf_task_storage_get(&stack_cache, prev, NULL,
+					       BPF_LOCAL_STORAGE_GET_F_CREATE);
+		if (stack_p) {
+			/* to pass the clang result unused warning */
+			int __attribute__((unused)) len;
+			len = bpf_get_stack(ctx, stack_p->array, MAX_STACKS * sizeof(u64),
+					    BPF_F_USER_STACK) / sizeof(u64);
+		}
+	}
+
 	pelem = bpf_task_storage_get(&tstamp, prev, NULL,
 				     BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!pelem)
@@ -229,6 +342,14 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
 		else
 			bpf_map_update_elem(&off_cpu, &key, &delta, BPF_ANY);
 
+		if (delta >= offcpu_thresh) {
+			struct offcpu_data *data = bpf_map_lookup_elem(&offcpu_payload, &zero);
+
+			stack_p = bpf_task_storage_get(&stack_cache, next, NULL, 0);
+			if (data && stack_p)
+				off_cpu_dump(ctx, data, &key, stack_p, delta, pelem->timestamp);
+		}
+
 		/* prevent to reuse the timestamp later */
 		pelem->timestamp = 0;
 	}
diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
index 357231cb1c38..eaf7be92472d 100644
--- a/tools/perf/util/off_cpu.h
+++ b/tools/perf/util/off_cpu.h
@@ -15,9 +15,15 @@ struct record_opts;
 #define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP | \
 			      PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
 			      PERF_SAMPLE_ID | PERF_SAMPLE_CPU | \
-			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN | \
+			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_RAW | \
 			      PERF_SAMPLE_CGROUP)
 
+/*
+ * for embedded data to overwrite the original sample, duplicated sample types
+ * must be set in the original OFFCPU_SAMPLE_TYPES, except for callchain.
+ */
+#define OFFCPU_EMBEDDED_SAMPLE_TYPES  (PERF_SAMPLE_TID | PERF_SAMPLE_PERIOD | \
+				       PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_CGROUP)
 
 #ifdef HAVE_BPF_SKEL
 int off_cpu_prepare(struct evlist *evlist, struct target *target,
-- 
2.43.0

