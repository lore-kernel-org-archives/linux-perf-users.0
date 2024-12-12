Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683681DF277;
	Thu, 12 Dec 2024 23:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046050; cv=none; b=JtxURKqpuf4msPABRD4OVgHNCLBOP0XeqQYxe001/GHAkPfKsEVzjmNLUvtrWTgGz/YOgdf4d+jIMMa/b9MUBLTcGI5HCnkytbi1kUYTmeXVZ8itK1A8szDy3mJSmH7drbNZlu+0KHoKo8BQPx7xftSubGqi2QPym4rc1DrxE/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046050; c=relaxed/simple;
	bh=mUcS+ASYoZR9ZJIlcEk8OGmgnQDvwgRTk6WQBu8286g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qr+DXer5bFEHKhYFJ9FFCBfhbl69v8yN3qZmtovvN4GtbRleO7yKn/vOGj221N061LWQluVYyK33PMLNGJada33U9fRNj/oLxH8uqw5DbjArVIS8ChqhjhHblFgFSsrlC/7WDzqaDgHF5AZJ+chKn6kwPY3c3P1m14qjBsB/Juo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efK8vamJ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efK8vamJ"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-728eedfca37so1235586b3a.2;
        Thu, 12 Dec 2024 15:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734046048; x=1734650848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNFLCf1qgtNxbc2CCINQbIdRIjwFbT1I23jfba115fw=;
        b=efK8vamJiONwvIrvbGQc5dij6+9SFvNLK8iENdv4XD3Mk6BdKiXPSbFyJHvj+DkRVu
         x9/VS+Cx+SljVgmbZxZCjYXC6hTGlhFSb+3MM3jdnquDXWFQlsPsyqrERARiSdhj3kBO
         QkBNa16WKmDoL/73huzFntgK76SiT3hlDmoe7wJ3RYmtRAEGZvbhpfLkj/tzmVpaS1W7
         PxjF6FqncvfVI5P/TtEjy6yIO1KoycgzJLH2f9Io7sFf+dcu3+dRITStWmmSjhD0fAvA
         DbG8ibFOZgedlwrB3RXIRR9PYdLGCtRxpTMthiJgiPUwWDc80VMNV7Nugty9TsqVQslX
         LLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046048; x=1734650848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNFLCf1qgtNxbc2CCINQbIdRIjwFbT1I23jfba115fw=;
        b=GObwi2WH2bn1Z2CvIFb/FXNkooSzWC6uNNdAkqJLauypMWq+v0dg+AdWpMZwEEBAjl
         0zz2dXUIjC+9FIUKPILo6MszVG972khNQhbA0c/ipnJEB4mInydPgEv2jKexnnb4nZGt
         +MMdL/bjdgCpeIKAyWNRLkYjd+rEr0rwR5qBgNAnSDSYZEbsZ2F+uQhA5IvMUpfymRvb
         cjVuvLTYG3fwn2Ge5XcfQh1bCe8luXfzb753vEf+47l6AzWVeDJbW34y4uJK3inWZmkI
         j/0SmsEKrJU70aN/Gykew3IDmDMYhpEGsSGvyv0z/DvWVLDhwMPzqgx4SPUYQ56Vqp+s
         f50Q==
X-Forwarded-Encrypted: i=1; AJvYcCVohLP6lfjv3I7J5igpDFRzlaxXmrvis3FPAaMNaKuOeZzvcaz//jOtHPPofC0K2b/7wyFIRb+NP4M6FjKchBjVOQ==@vger.kernel.org, AJvYcCXEPPZ6DnbToqxCNskEU1p0aGs8uUwWc6RiUQAqJjl8IdDo89an3F1sferqM+NN3rgvcij7WnTq6nV6lCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwddxHI/s8J0y5QxpyRN3QRoFai6omjLZLMkJB5WytUqoU7VGea
	1wVPja8cBX8qWf0CIcjNwEPVQo4NNnPWfMVQXLSYdgJjfXtLlc1m
X-Gm-Gg: ASbGncuhkxgO9m9vNzpFkJn7j6CsDZp/9mXNEnBhV/4o4EZWNno6NQj6vrbiugzw5Wv
	rjM8nKMPjddWRRHos8Gt5wmHahzbUqgxMFFTbq3k8/M2s7RISBgggFTWZ2TI8uYQHWzwxPDhi4/
	XKv8zKpO8UTKsLzV8MiqZu5qJ3p+lMBwOEjOChbVwoBSbySLzJzaoHIiv/jWQeJFQOxhHv5nyOp
	LhAlmyQKGxTOfBqEdJXDgAEL2tCoy7hTDKci6pBiXqbFKOJMZoLlX2Asttt7obSNAHzt27POAcO
	OaqtmSBojJX2
X-Google-Smtp-Source: AGHT+IG1ZJMPrKSDMv45FoBGhnsXUR2C+l0tshftfzn0OBSgzgHHqrNr7PJ8rWFbXGGaqihYb+gkdA==
X-Received: by 2002:a05:6a21:66c7:b0:1e1:bee3:50ea with SMTP id adf61e73a8af0-1e1dfd3dab2mr584296637.11.1734046047729;
        Thu, 12 Dec 2024 15:27:27 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4e202e9asm7324674a12.72.2024.12.12.15.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 15:27:27 -0800 (PST)
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
Subject: [PATCH v13 04/10] perf record --off-cpu: Dump off-cpu samples in BPF
Date: Thu, 12 Dec 2024 15:27:11 -0800
Message-ID: <20241212232717.232507-5-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212232717.232507-1-howardchu95@gmail.com>
References: <20241212232717.232507-1-howardchu95@gmail.com>
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
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 88 ++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index 1cdd4d63ea92..77fdc9e81db3 100644
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
@@ -106,6 +123,8 @@ const volatile bool uses_cgroup_v1 = false;
 
 int perf_subsys_id = -1;
 
+__u64 offcpu_thresh_ns = 500000000ull;
+
 /*
  * Old kernel used to call it task_struct->state and now it's '__state'.
  * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
@@ -192,6 +211,47 @@ static inline int can_record(struct task_struct *t, int state)
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
@@ -216,6 +276,16 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
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
 
@@ -230,11 +300,19 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
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

