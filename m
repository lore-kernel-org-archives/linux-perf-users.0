Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2937613AD1D;
	Wed,  7 Aug 2024 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045156; cv=none; b=ItLjYBLj38s26RfmU8bo42w/AonqOkTX7PTvwPKQ+fAcAWIgDFrRwBJE2HJa8HtJPHgrARsqWUirLLLUK9zc+oKa4o6sdUjPXbSurQEh/1TNLQiApT+rg4QtKwO1BtbqWWNkXgoX66Aa6GKyfe7g9q9UeuxeOpPslBkzq/9RnZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045156; c=relaxed/simple;
	bh=blq8IKKWWvrPrqVs1Yb9VttWa84QButnzElZfOfk1Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6vSU/Qy3fs85R3vSy6MF327lbQr+iKZd0T498UJ+SUU2nwOxi4psz4LV17C0TyJmOfdxHkwU+FBXXIttYyV38/i9Fi7Q8N+D+ax+O/t1M/5RsS+4CWLFJ4WFasSXcKKk1wtGHsl8xy5d/9tZCj6jKFpHlad40ne5bwXMVa9cbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqUeTtEy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqUeTtEy"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc49c0aaffso360555ad.3;
        Wed, 07 Aug 2024 08:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723045154; x=1723649954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PXh5CjG8YZ+eBmVxe++koknN2SUxUpkitH4m2ykKfM=;
        b=EqUeTtEyOt8vFr9a3EflfxuYYN2TITF6Rznqn2xfEzKT6BTv8vjfIVjJlZzADF95mF
         SsuIjZA3UQIU0weT7x6/oy5JV6nO9TanCBnOZHqq734aCPoxMGtBzCUKF5wxwiOqwu/f
         iltE63xmbtGiB+r0tdBI6YWrQULq9Wxyl/wUEMjuUA+vsbGTexrDWzr1GCWGezZDeDVm
         wJ0YTIyQGrfH6UEV0ynkKYikubMr6X9py+LmodDGx5l3Nc7eedEvywlZ/A7zUyTcvUUI
         n9L3NdqlW4ngnRjVYaJvk2egKtTFFOz5qqSPHz5GVSHXtyB8asBDKHEo2twcbvFeE6KB
         0/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723045154; x=1723649954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PXh5CjG8YZ+eBmVxe++koknN2SUxUpkitH4m2ykKfM=;
        b=Wl9WfpBvcJDU/RGFCEUfGItfHqGYfPH9yr8VtfX/N0GRY9icNTSEO6xW7CX7iFPpEH
         6jFXw9nZERKNtTYuLZwmtM9rCdhA5gNQbH7BTbwam1iCTfALAHH3Sr91YV5EqlQzwgpV
         p3Rd07eIwo4F1/JPw9DS4HlmlyFUM81W9w8LSVIMJSqS7/nQNbPKNWLc1aS39dB7t2z9
         FyAqeOgIMpP09I4tshQ2izNfHA7gQmqfsiErBWGa7dZfAfXxKyYYBzUtNhLY+i/m/fqJ
         ZSewcVIR5r5jvISah2pj96PrT49yKRo+ggdonWch8mCH8qgQ2LhmCtp/ohJW162JyayQ
         r66w==
X-Forwarded-Encrypted: i=1; AJvYcCW4++PZScw5FbKIXiKXUtrSBxNYJAJCmrVhSs9FFP0KalMfXpO/+x4iS8i21I7JpQ498l2bGGW5YwVYTZh5Ha7guiAnw0rGzGIUEoosIFLLdu0fLob2XwWgs8BKHf2Uc7M+2583IvoCgTC4Ii+yng==
X-Gm-Message-State: AOJu0YyXXYPLJ85N8VSpldV2Eod4cxgq/8gk3LnWnaW0dGfYyzmkhH6l
	L49wAAgmAVMOrCjsg4V6DUsJjOUXJZ4TJdoMe0KQf9yLfEdha/83vEEw/aoN
X-Google-Smtp-Source: AGHT+IE9swvFXbSaxaUilQQA21OlEPiC6Dsq6ZL2DUUHOK8zERyAaHtp3l30pgnfZj3CSPSpqMXtWQ==
X-Received: by 2002:a17:902:d501:b0:1fd:9105:7dd3 with SMTP id d9443c01a7336-1ff5750acd3mr208258825ad.64.1723045154374;
        Wed, 07 Aug 2024 08:39:14 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59297329sm108097375ad.247.2024.08.07.08.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:39:14 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: namhyung@kernel.org
Cc: irogers@google.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/9] perf record off-cpu: Dump direct off-cpu samples in BPF
Date: Wed,  7 Aug 2024 23:38:38 +0800
Message-ID: <20240807153843.3231451-5-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807153843.3231451-1-howardchu95@gmail.com>
References: <20240807153843.3231451-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Output PERF_SAMPLE_TID, PERF_SAMPLE_PERIOD, PERF_SAMPLE_CALLCHAIN, and
PERF_SAMPLE_CGROUP in BPF. Ideally, we should only output
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

Add perf_event_array map for dumping direct off-cpu samples, but keep
the at-the-end approach.

Tons of checking before access, to pass the BPF verifier.

If off-cpu time (represented as delta) exceeds the off-cpu threshold, do
output.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 133 +++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index cca1b6990a57..95cc130bb67e 100644
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
@@ -184,12 +227,75 @@ static inline int can_record(struct task_struct *t, int state)
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
+	struct stack_data *stack_tmp_p, *stack_p;
+	int zero = 0, len = 0;
 
 	ts = bpf_ktime_get_ns();
 
@@ -199,6 +305,25 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
 	stack_id = bpf_get_stackid(ctx, &stacks,
 				   BPF_F_FAST_STACK_CMP | BPF_F_USER_STACK);
 
+	/* cache stacks */
+	stack_tmp_p = bpf_map_lookup_elem(&stack_tmp, &zero);
+	if (stack_tmp_p)
+		len = bpf_get_stack(ctx, stack_tmp_p->array, MAX_STACKS * sizeof(u64),
+				    BPF_F_USER_STACK) / sizeof(u64);
+
+	/*
+	 * if stacks are successfully collected, cache them to task_storage, they are then
+	 * dumped if the off-cpu time hits the threshold.
+	 */
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
@@ -228,6 +353,14 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
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
-- 
2.45.2

