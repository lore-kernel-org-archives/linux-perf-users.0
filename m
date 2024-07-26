Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685E2179675;
	Fri, 26 Jul 2024 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989721; cv=none; b=XDfdGIzMRvwBDFOc86MGunkLdz5kEHa8AUQdK71jYAENHIhEUWu1+X+O00z8UgsDnXsEvtPFb+qr+WQwtukAGnggf/TWRmMnfBpoM0RSXCMtSRXgAFvp/n233OvymKRivVz8OyfU1FLn0ZX1cwB6wMoD81pnV9WtH02fkoph+EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989721; c=relaxed/simple;
	bh=fS9SBM64AG0d14gzlJcmtqgK3QA3471WA3nuuLSXvNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ds20IO7aCKDvhwncoQSrCiEnZIIq6Zi+j0lQPuYcdK91wFw22HyoHejloFubqT0KjMq7c1ngOYJBHe8OdmzGn24ZweXO0+yruAGeXmROn+prT+Hal+fm/OAGJKxfP2DxuQDs83vI3MhO7CZcThlv5t6YEDTZ4w6p7XjGE9U8CxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/w+pX9+; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/w+pX9+"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7a1215dd114so608426a12.1;
        Fri, 26 Jul 2024 03:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721989720; x=1722594520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQXEEa7o2N3nGNIfvLfIK7YtcqSm6PiBdbgGbpQNEDY=;
        b=Z/w+pX9+5EzAr6BQL2vyKjmi/ZfV9ndclCjp9LQOkPJIfc7r0RBPnKquOr0TU/YLbh
         N+peYIHyMmh1vJrLrk44skgs6gWHbuyXehtwSL6QouGQpaJjiIi5p/Yk8TjvekLH+6AG
         s9rH0QxF3Y1aS64+1Dzlo6su12Zfj9BtOzQlQV8jr8Q1i2jqje873dCMUpwLeOLi2jeb
         d4BMm2m5jQnjq0uuY4SNNYw68cmKvPKx8yIQeDSINqM44rdrcNnPdqBKW2xgQfJOqMpT
         OTbmTgyDjKibh96Ns6oAgXwaPzWZEJ0Ho7GqacK5ET9sD2e+VVgPem2tdsMliG/lqyrG
         wl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721989720; x=1722594520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQXEEa7o2N3nGNIfvLfIK7YtcqSm6PiBdbgGbpQNEDY=;
        b=tqV51U7AURTuvA7HZoj1FD/cKub8eS+kuhoMpwHVriUZrh0A7EF8qCBcCKE7o8ESJl
         58FK2emV3VzhliTjAK/Eb1wDC12jTAs7deM/I/FtVLmx0mviYS3u08QrPBHSn++8LR3G
         S5WWLF5cXyxQbf6FCZ2IzTtiUu5YyOTYt1SnxvXHKQQYNwqY4s72wuzyWar6e05xOMeu
         i7gQWdQ4bVm1c9v3E+E5ZWD1xj8QUjJnwhHDP/NEiMKVR0fdmKoudX/V6emrLHPod7ip
         R6hGrESm3FAvXnynwCIiVbOIXWjJsYOboyE1XeVaXnSKuyf+9n8x5jPJ6R3S4TXlkH9E
         mk8A==
X-Forwarded-Encrypted: i=1; AJvYcCWyBxI9LGZWx7bY7ZrUIVHEPzVZXMKH3l4wxnBfa7kLGEXQLfz6uuFh0XR4x1qmfuh+EjWdXIYj+PYLJ6DcjtxWimqptb5vfE6JaXqStpA+DuF/JIr/499ijkpEmw4kfJb4OotEC4GTsXhgtWnh0g==
X-Gm-Message-State: AOJu0YzAsoSrmCkY4zNV4wb4314l2q8he2U4WSFDoJq8+6vHt5e5wcpc
	duGBbtCQdt0hsSvGyS7KmMrPeQudIhxtLnN7QomVlrkMZLSLa7U7un2AmuBY
X-Google-Smtp-Source: AGHT+IEFT1Upw9lF+F6Y8N7JGoI8iFl0O76iBsZ9yIIeSrBfVIJwpwinTXHDG72oqRSMQN0r80S6kA==
X-Received: by 2002:a05:6a20:7fa4:b0:1c4:8da5:581b with SMTP id adf61e73a8af0-1c48da55a81mr2341258637.39.1721989719678;
        Fri, 26 Jul 2024 03:28:39 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f816da89sm2179964a12.20.2024.07.26.03.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 03:28:39 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: namhyung@kernel.org
Cc: irogers@google.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] perf record off-cpu: Dumping samples in BPF
Date: Fri, 26 Jul 2024 18:28:23 +0800
Message-ID: <20240726102826.787004-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726102826.787004-1-howardchu95@gmail.com>
References: <20240726102826.787004-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add perf_event_array map for dumping direct off-cpu samples, but keep
the in-the-end approach.

Tons of checking before access to pass the BPF verifier.

If off-cpu time (represented as delta) is greater than the output
threshold, do the output.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Suggested-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 143 +++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index d877a0a9731f..4b0412a7aa5c 100644
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
@@ -39,6 +43,45 @@ struct {
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
+/* temporary stack data */
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct stack_data));
+	__uint(max_entries, 1);
+} stack_tmp SEC(".maps");
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
@@ -96,6 +139,8 @@ const volatile bool uses_cgroup_v1 = false;
 
 int perf_subsys_id = -1;
 
+__u64 sample_id, sample_type, offcpu_thresh;
+
 /*
  * Old kernel used to call it task_struct->state and now it's '__state'.
  * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
@@ -182,12 +227,87 @@ static inline int can_record(struct task_struct *t, int state)
 	return 1;
 }
 
+static inline bool check_bounds(int index)
+{
+	if (index >= 0 && index < MAX_OFFCPU_LEN)
+		return true;
+
+	return false;
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
+	if (sample_type & PERF_SAMPLE_IDENTIFIER && check_bounds(n))
+		data->array[n++] = sample_id;
+	if (sample_type & PERF_SAMPLE_IP && check_bounds(n)) {
+		ip_pos = n;
+		data->array[n++] = 0;  /* will be updated */
+	}
+	if (sample_type & PERF_SAMPLE_TID && check_bounds(n))
+		data->array[n++] = (u64)key->pid << 32 | key->tgid;
+	if (sample_type & PERF_SAMPLE_TIME && check_bounds(n))
+		data->array[n++] = timestamp;
+	if (sample_type & PERF_SAMPLE_ID && check_bounds(n))
+		data->array[n++] = sample_id;
+	if (sample_type & PERF_SAMPLE_CPU && check_bounds(n))
+		data->array[n++] = 0;
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
+	struct stack_data *stack_tmp_p, *stack_p;
+	int zero = 0, len = 0;
 
 	ts = bpf_ktime_get_ns();
 
@@ -197,6 +317,22 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
 	stack_id = bpf_get_stackid(ctx, &stacks,
 				   BPF_F_FAST_STACK_CMP | BPF_F_USER_STACK);
 
+	/* temporary stack data */
+	stack_tmp_p = bpf_map_lookup_elem(&stack_tmp, &zero);
+	if (stack_tmp_p)
+		len = bpf_get_stack(ctx, stack_tmp_p->array, MAX_STACKS * sizeof(u64),
+				    BPF_F_USER_STACK) / sizeof(u64);
+
+	/* save stacks if collectable */
+	if (len > 0) {
+		stack_p = bpf_task_storage_get(&stack_cache, prev, NULL,
+					       BPF_LOCAL_STORAGE_GET_F_CREATE);
+		if (stack_p) {
+			for (int i = 0; i < len && i < MAX_STACKS; ++i)
+				stack_p->array[i] = stack_tmp_p->array[i];
+		}
+	}
+
 	pelem = bpf_task_storage_get(&tstamp, prev, NULL,
 				     BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!pelem)
@@ -226,6 +362,13 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
 		else
 			bpf_map_update_elem(&off_cpu, &key, &delta, BPF_ANY);
 
+		if (delta >= offcpu_thresh) {
+			struct offcpu_data *data = bpf_map_lookup_elem(&offcpu_payload, &zero);
+			stack_p = bpf_task_storage_get(&stack_cache, next, NULL, 0);
+			if (data && stack_p)
+				off_cpu_dump(ctx, data, &key, stack_p, delta, pelem->timestamp);
+		}
+
 		/* prevent to reuse the timestamp later */
 		pelem->timestamp = 0;
 	}
-- 
2.45.2

