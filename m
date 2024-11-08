Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A0D20B80C;
	Fri,  8 Nov 2024 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098513; cv=none; b=IfYaDOS8gCgdzKwyRyT95LhXANPHB2OYD2KJHdjn00qZSPZlphbTrC1oXifHWM6GKSd4ERSXoR52ZJu58kvwb+0eaMGAltfy0bEmU6kfa5uVE3dqHHBlDGLJc9r/caL6MXdJZFSSsIHi0F1S0I8ktCbdybxtCH2HXrpkQ8wdps8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098513; c=relaxed/simple;
	bh=Tl9AyEv3smIY7p3T198j57FdTS4TZIpXoQZrVbxqybY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXWb+7uOqycemoe93xttcYg0n7mJ44tmaw7J7JUs3uPwWMzL19Sxtd/ERT+cQsNG+XuLjRsIjgDgG403rXEPh88Pn+NTSPeiwVd2WhXQY1PTpIzf8XQJhURD9djasP7N6N0DxCIIngW2/1zzVIFuXR0YrNQQm1mcQDri+gLNFZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIlBZMqp; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIlBZMqp"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7eab7622b61so1871743a12.1;
        Fri, 08 Nov 2024 12:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731098512; x=1731703312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+BAbUCg60j3RuDc5ntxQHSalyoQVHFsNzlA4CMtOQA=;
        b=VIlBZMqpnf5YsSZCu1LbWGOFZKr3WXb4lSY841+svwG8BXlSxDpnClltQsBZw8NYwx
         RyuVQzhqDR6C21jpbtKcPAzMRRJlwHO6eVmSH22ntCQa2Co4M9dfH3q0TigeVqkCRJTv
         VL3d02DiqU2TSSieUHdQhUon4bW2FloP1rgkiIeT02KHzRJ3EWRgJoZk7CiJMkyZ8rzZ
         apxGJlnq+0pKrKFyWmJJ4163Uynk6U3UBNG7axQKAgPppCzm2gbtlHbA0IRierqa1WY9
         rAGdmKzQJ3NOlHc0h1RJTxdRUY9UHXbEjDBGDm3tenXkNHEoNBOrFPAUqPjf+p3L4QkN
         d1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731098512; x=1731703312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+BAbUCg60j3RuDc5ntxQHSalyoQVHFsNzlA4CMtOQA=;
        b=MbJ6zxRaFKQXfjAqxpe9aq8HEggFvKqG04rTT4XzVTG4uDnzyGExAYtf/pon4vKbX1
         7tqgqsejAu9V0XMDJ5/eiGV0vkQVmFTWj2kDpb3V+tpyXronigJiXEC/azET7Ed+CzQ1
         g/77dkg3M9u7+nu3tz5CWO5sZGrbL9YIOSQOa8QUn62pIwI8TP9LQSgWxs89rDQOq1Ev
         7gKihZYTYrbSErRaAn6JzgTVokq6Sl+jaMubluoEoGfD6xszzWyTrS0KMLcfEQibmRZe
         WfJDuyvmvnFsY+PUV9r0r98p5rM8Mq7RRsiaFJHN3EyeM+hrsjj1Mgk798D0syp3JHkP
         T1tA==
X-Forwarded-Encrypted: i=1; AJvYcCV1yLILn72vt/3WNJPNGZTb9tLvCXFhUKeev+EIqUTV32WM5cha2wfDqtM8lhm5N7Dwbb738cGBXjF2AGw=@vger.kernel.org, AJvYcCWIkshbP72mfyfpp5ziOQPMxJMI/9uBGwqk6DdczBAR6s5URd0O7NokyjT7WEOt3aJTqOlhCmGw4+M4fxBbdExnfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmZZngodl1xVrr87pitvNTffZhggbjGFNNmQg48s5oKpGNEIhl
	QtsvjF93YYb+fAcbLu0qhlsAqSgaV4hzBz9dwkmrgan9WKa3GgCG
X-Google-Smtp-Source: AGHT+IGqmQ4wNgdsf9GSvRWHeQMzuTah+ugDU5ZOuZgYAOIV8zPHcwI5VfsOOSwuOH0m/DDqauyfxA==
X-Received: by 2002:a05:6a20:8421:b0:1d9:c6e8:60fc with SMTP id adf61e73a8af0-1dc228931b2mr6256266637.6.1731098511794;
        Fri, 08 Nov 2024 12:41:51 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffe3sm4221945b3a.2.2024.11.08.12.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:41:51 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org,
	peterz@infradead.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mingo@redhat.com,
	mark.rutland@arm.com,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v7 05/10] perf record --off-cpu: Dump off-cpu samples in BPF
Date: Fri,  8 Nov 2024 12:41:32 -0800
Message-ID: <20241108204137.2444151-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108204137.2444151-1-howardchu95@gmail.com>
References: <20241108204137.2444151-1-howardchu95@gmail.com>
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
---
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 83 ++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index dc6acafb9353..bf652c30b1c9 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -18,10 +18,18 @@
 #define MAX_STACKS   32
 #define MAX_ENTRIES  102400
 
+#define MAX_CPUS  4096
+#define MAX_OFFCPU_LEN 37
+
+struct stack {
+	u64 array[MAX_STACKS];
+};
+
 struct tstamp_data {
 	__u32 stack_id;
 	__u32 state;
 	__u64 timestamp;
+	struct stack stack;
 };
 
 struct offcpu_key {
@@ -39,6 +47,24 @@ struct {
 	__uint(max_entries, MAX_ENTRIES);
 } stacks SEC(".maps");
 
+struct offcpu_data {
+	u64 array[MAX_OFFCPU_LEN];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+	__uint(max_entries, MAX_CPUS);
+} offcpu_output SEC(".maps");
+
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
@@ -185,6 +211,39 @@ static inline int can_record(struct task_struct *t, int state)
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
+static int off_cpu_dump(void *ctx, struct offcpu_data *data, struct offcpu_key *key,
+			struct stack *stack, __u64 delta, __u64 timestamp)
+{
+	/* dump tid, period, callchain, and cgroup id */
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
@@ -209,6 +268,12 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
 	pelem->state = state;
 	pelem->stack_id = stack_id;
 
+	/*
+	 * If stacks are successfully collected by bpf_get_stackid(), collect them once more
+	 * in task_storage for direct off-cpu sample dumping
+	 */
+	if (stack_id > 0 && bpf_get_stack(ctx, &pelem->stack, MAX_STACKS * sizeof(u64), BPF_F_USER_STACK)) {
+	}
+
 next:
 	pelem = bpf_task_storage_get(&tstamp, next, NULL, 0);
 
@@ -223,11 +288,19 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
 		__u64 delta = ts - pelem->timestamp;
 		__u64 *total;
 
-		total = bpf_map_lookup_elem(&off_cpu, &key);
-		if (total)
-			*total += delta;
-		else
-			bpf_map_update_elem(&off_cpu, &key, &delta, BPF_ANY);
+		if (delta >= offcpu_thresh) {
+			int zero = 0;
+			struct offcpu_data *data = bpf_map_lookup_elem(&offcpu_payload, &zero);
+
+			if (data)
+				off_cpu_dump(ctx, data, &key, &pelem->stack, delta, pelem->timestamp);
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

