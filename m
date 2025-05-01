Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3011CD0C;
	Thu,  1 May 2025 02:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746066501; cv=none; b=Yb+xlN2LOKBTWERV1ZFQBbdJauwG5bvtdZ5ky2c5+OyEQzFg2fvTDkn6oRL+JsHiWBF6HU8GjHLo/M8JH/eM+++UG8DZmgeS1W+7LmoEqVlL+h3Dbjk7Lx42d6t71UKN9eprVYf4oWCGDKdZLiW0usHRjaOpZV8BU6WGl7wwbBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746066501; c=relaxed/simple;
	bh=maCxAVlgYLrPtTMDiRXoouVhL1n+mDRVFX081dzkkkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGOeB13FDzI1iTEkeMLobXJUzpXbxo7UwqmfIo9ape1oCo933UvQU0c1qj8eBcN1rTbdWSv3T4Z9foiMQqFindzAU6M5e7ta9MkLP38ovtqz7WbPQrkuJ0DXy48WtLR/7RF7RzlyqZIy1crS4nHKJ+V5ot65O1xiAVx86NX84lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krAmhMUq; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krAmhMUq"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7370a2d1981so447755b3a.2;
        Wed, 30 Apr 2025 19:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746066499; x=1746671299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99+pPmvSZ94HNiM6U5VflkxaawFrODtXZOw1+c9x/Ww=;
        b=krAmhMUqkXJT9Gy1AXN1VVkaOfM62sDv5Efu09nwcGHURwsZBmAd+kmC2kbFNIX69L
         b5eYH0UaIth4MSKcN75uhJ+1boV5QyOxyqS2CHJSUqKTSH/kdUgDfgTrKqcYTvParfoy
         Hh950MK5opcNLxhQrMXs8daFo4E6o3dpPAK4vH2LgiNQ3NgjDykTM3secrvsNgOx0fpD
         6dqNjqSnhc0PRIyghcjn5lFd9U1xr8IMmp3U0NHbLoxbuQbOh7CcCnemvzv8n20vPYHW
         eakFobxjKYy6Q7zmbrjOdhZa/PPyR6r1NEr9r53+qsHxUejpPmWdaIgsSs/WWQ0P7HtP
         SaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746066499; x=1746671299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99+pPmvSZ94HNiM6U5VflkxaawFrODtXZOw1+c9x/Ww=;
        b=jDIZrfPssBgmTKDkmaNdXSdugml/6nRkSix3VZFtmdLseV8zxIq0wu1y/7h9pMYwPg
         ob68bAho9d+rOh/mkgrIGbxwU5UZMairNclQ81QHvp/qKgG8o6c9a4Awa7h/Nb0l0GbM
         kO9wnB0Vp3829KtWWauggQBjDbPGQuxt4ROs7GjY4aXwbBRXnEdLRz5iZi9cxOynigUQ
         kKnvucJkGPlmLb11Ub/+PTloRWKjkv839Dqnzht5OTXG3tqLwPykeWQjGIm/1UQ7nrFl
         8Hr/SRToYEkt2AIVoWP3H0vkCTTrB3jNXnRYxti38WlQyknKPrmQzWGPUzdA50CeWOBr
         0nSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxS8qL3tSLkLrrSg1jJBNSRxT2aG2zyqJ7PYIr7HavJFnRPZoHxOdfEdTHWSUCfKQeXpTekSyN53EDw/QKNeppJg==@vger.kernel.org, AJvYcCVqF70xDhy2GosdHOqg2cT1yO8tbqW2CPeiblT5XwjjziyG4JBB89UbkMxTrY9CyXG9S9CvjgqCuz9Vl6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzrrEwr79uSkgMKDmmn4kg3eDLkC1imeM+i4FAzWDAyZ1YdKly
	sSQXAUD845po6wXlphRsCjrCbtMAQe6BwnTx1ifknHbe26ehh1PI
X-Gm-Gg: ASbGncsroS8Z9oT8ChV3blBp0tCBl8H4/pam2PFNczuszVAif/vZ9aEIOeKwVfjQavU
	KAQcWA3AvQN/wBtV0YKyhfvd9GAAxVboOQjCUu2Q4Gv41M8W6YNqoqyW+TgY+is6x20HseaaNuL
	BTUHItmtzYMkAVPlvbb6PPEYGoiy8+E1urNEv3w98j1wNNKAgp8hRQkHylQ8OIrccrbUxIeofor
	J35Smvy5uvhi5t2o94b7jaxB+/YxfGC8aBpvnFOiMLELl3RkUJETeRR/6mr20+vcHMT1zNcYY3U
	tJAxFKbnmSunb3rrpSdMztntzopSBNY3I8HUSctrVO8C6FMEQ23t2bMnGyN5lklejdlEf/m1jgz
	+EU1+a1q//g==
X-Google-Smtp-Source: AGHT+IFOC1GJ6lS+g+xIUeme5KfR/5i6w/pzEEXr4APwC7p/sKfCc1ON5b3O9tGlMZoutDbvIhXSZA==
X-Received: by 2002:a05:6a00:3006:b0:740:34cd:498f with SMTP id d2e1a72fcca58-74047764a8bmr1695756b3a.5.1746066499217;
        Wed, 30 Apr 2025 19:28:19 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a8fbe7sm2459599b3a.160.2025.04.30.19.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 19:28:18 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gautam@linux.ibm.com,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v16 04/10] perf record --off-cpu: Dump off-cpu samples in BPF
Date: Wed, 30 Apr 2025 19:28:02 -0700
Message-ID: <20250501022809.449767-5-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250501022809.449767-1-howardchu95@gmail.com>
References: <20250501022809.449767-1-howardchu95@gmail.com>
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

Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
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
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 89 ++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index a5002e25b259..14cd8881f8bb 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -19,11 +19,18 @@
 #define MAX_ENTRIES  102400
 
 #define MAX_CPUS  4096
+#define MAX_OFFCPU_LEN 37
+
+// We have a 'struct stack' in vmlinux.h when building with GEN_VMLINUX_H=1
+struct __stack {
+	u64 array[MAX_STACKS];
+};
 
 struct tstamp_data {
 	__u32 stack_id;
 	__u32 state;
 	__u64 timestamp;
+	struct __stack stack;
 };
 
 struct offcpu_key {
@@ -41,6 +48,10 @@ struct {
 	__uint(max_entries, MAX_ENTRIES);
 } stacks SEC(".maps");
 
+struct offcpu_data {
+	u64 array[MAX_OFFCPU_LEN];
+};
+
 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
 	__uint(key_size, sizeof(int));
@@ -48,6 +59,13 @@ struct {
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
@@ -106,6 +124,8 @@ const volatile bool uses_cgroup_v1 = false;
 
 int perf_subsys_id = -1;
 
+__u64 offcpu_thresh_ns = 500000000ull;
+
 /*
  * Old kernel used to call it task_struct->state and now it's '__state'.
  * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
@@ -192,6 +212,47 @@ static inline int can_record(struct task_struct *t, int state)
 	return 1;
 }
 
+static inline int copy_stack(struct __stack *from, struct offcpu_data *to, int n)
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
+			struct __stack *stack, __u64 delta)
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
@@ -216,6 +277,16 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
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
 
@@ -230,11 +301,19 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
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
2.45.2

