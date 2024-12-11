Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8D11F2394;
	Wed, 11 Dec 2024 22:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954433; cv=none; b=euwT5oXmv+A/wG/u/UWtDn5b9ppsOBlLDbr3+pAA6nFVm20ofOXPQEWoE3qjlZlCWbn47erw66J0xDFy9mzVP2LQUx9nihhb6n/0Rza5TXnZJ6kH9cxh05Y9hdI9KoRrEVnuo4a5I+vq007Xa+KkFIo4Nfby2LAZJRACXIvaC1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954433; c=relaxed/simple;
	bh=FhYBFcBipaHcJVExkC+3V5vt7nolG31xdwTCXFsCPv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1Sgzn2Td4W0YSgyE1O3RCTeIFv4woFK6cuC+MyG+NP0cgOqNpmd0Q9NagetPYb9joBmN8T0PRSXftAZkaUFllx9J25CAz2OOkRtNOnNDU/BMWj4Z7QvUYoj3WD3PSXj6B3q29t/AAWQPt4WKLPDe+j4Q8u0+YY/SK13gI6Erf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TohcHrKA; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TohcHrKA"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso5236289a91.1;
        Wed, 11 Dec 2024 14:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733954430; x=1734559230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HM89nxEPCN1/mXqArlw/4nxHHrqhLHtRHulGS1q1v6g=;
        b=TohcHrKAM5ZWpJ3WdrMMZo0pLd8dw3nnv+bPkblqxqxmrQRgH+noNkJUsWJqyq1LAG
         7uitpU5ZRCo9POQ3+hdb/1jddy6ox0HbAuLaS07Cd8DS3L6FtB7qaQZfmfqo28sqHYUI
         WnmlfEyQSVNoy3KSeexrjdm53zbt029CMZJSvl3TU+eYjyRl7xCuGF/r7HBCiO6ijIYf
         S6j70mGJ1nW8T37VH32gCH+DRDl0vmQhc60+v/fI+OZIUuE+Ll8jhLn9VbI4UqfjQy+s
         QAEoU4kM3xx0RGCfqBOwzVa2v2p3nAFHBm1DaVE1uW2tI/De71wh6K8nPRIXoqE9NS/Y
         SvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733954430; x=1734559230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HM89nxEPCN1/mXqArlw/4nxHHrqhLHtRHulGS1q1v6g=;
        b=O3Me+Em9dWmwjJUjxjkE84m2TLWINU3SMHy5hfz/Qzfs9zYPo3qQEKPJIoLhFm0FON
         K0eIeA+JEZNTiKalDpUdd+4z85yVY6FiUlvBYjcc++VynyFkNbakXm6TC9QGOYrRjoG7
         Hl4c0hRSnskk8KKDGA+lYZrHxGwzCSOw70ojjk8Bww6+rB9jCaaGlFdMOSPd5bTUP6Fv
         hQ+uqT+YLvcNcYZRmDN/T2YiUaqUVWPAyOGtomvmwr2u9zCXFtWVoMFQdAm7lvszRRZD
         vqFOuhVC8ll1INFau20uWCO7GoWbnOW006olfGPWFDYm1d+jv+i7IM96v7HrDdfNI++A
         m1qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPRcIbbueKfwC2WusJW6Bye23lLUen3OvTbctD8GxZdkP/JLtKQ2YOzRVFPHhMCKO+B4la3TD5dpsnBUA=@vger.kernel.org, AJvYcCXhyEjqkxnwTNh6oq7471KNsJLcKHW2JNS2r6WS5GBKWG3xsvSJjH14FsJ3ZgARZbsv+VVoqxLxpdi+CLMZfgb2hw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqa95EAgNGe4fBlT7thaa27Rf+XLMil7vhQtMN3NWYar6unnwE
	hjqV7/xEWeZjywZSG10dZjhwKO6XM/iJbLB+fqqQqXqwWO4J3NyT
X-Gm-Gg: ASbGncua2P5x6nRs+4qMWhoPsL6HCwOzW3+IWmCI4O1mgC9RBSOvDhxglC3LL1XYDne
	IPsjL9K86heE05NHOGKQGlsW6dYDIwuv3Mjy3B5nAnqVbFdVoBCr4Nbp6OrftpPg/J2GogDHROr
	EWLPH98V3C0x4i3HVDC46dbxh/GW7e0zDzHV70hWyHxPuAvW/MR33WUSFntidVTJ7SrKNnepB0q
	4tfZfkjOn3td8esx47QH+O2LXelG8atmOW0ktqk0Pk4+CCXehy7ORRvkEWSRtLE1dRaf/PzbXlM
	qFLzAWo5WDhv
X-Google-Smtp-Source: AGHT+IFdL6uyvHO9Jvm4Aof7MSYriKqxrG1J0os80HsE1QNsKh8D4B2zDKgEnEIRb9CiiAr7Pz7ofA==
X-Received: by 2002:a17:90b:3502:b0:2ee:3cc1:793b with SMTP id 98e67ed59e1d1-2f12803555fmr6170771a91.26.1733954429915;
        Wed, 11 Dec 2024 14:00:29 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2700cccasm13912665a91.22.2024.12.11.14.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:00:29 -0800 (PST)
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
Subject: [PATCH v10 04/10] perf record --off-cpu: Dump off-cpu samples in BPF
Date: Wed, 11 Dec 2024 14:00:08 -0800
Message-ID: <20241211220014.931479-5-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211220014.931479-1-howardchu95@gmail.com>
References: <20241211220014.931479-1-howardchu95@gmail.com>
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

