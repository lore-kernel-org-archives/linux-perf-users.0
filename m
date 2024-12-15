Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3FD1BBBD7;
	Sun, 15 Dec 2024 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734286365; cv=none; b=IZQmPs13Rb/B6GoVVByDFYGwo77tYi955GgL6RKEUA7IJk34pHivsJaJp1gGhh5or+9gCQUFpZ3ZquVGDtIwHXG7+2vGqMlNqROZmfiwp46tulli2aumD2CwtXEUmFMGrqBAWzW1ZwVz6jbTHtI/T2U0bJ7zfKbpvThZ7ZP+/2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734286365; c=relaxed/simple;
	bh=mUcS+ASYoZR9ZJIlcEk8OGmgnQDvwgRTk6WQBu8286g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aimrcen8BYil2EAGqv+JVwKbTWtgeKexvCqYuTMU+ahol+41TaT4i1AHw+thkxqmgskqEOR/E9FyJPDV+dIifpww2mXmH8L5E2iG6RVKNcweqC44EjgEqBea1IqA6O74z2dGzDnqSFpmgvCiTQSAG7C064SEHtNJX3tuLAZLnKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXZIqpoU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXZIqpoU"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7265c18d79bso3630204b3a.3;
        Sun, 15 Dec 2024 10:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734286363; x=1734891163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNFLCf1qgtNxbc2CCINQbIdRIjwFbT1I23jfba115fw=;
        b=RXZIqpoUamLl1G20uteh13OLB0/vd3oR84OQs2gAZCb2pkhKpdCqSqKCCsUsxSKZTI
         FYq42szhMM2d8cla6R20rqL29tCFlaLqZVt/2mmfG3xY/7SzaKL/+xl0QIzVXX+Ctb44
         GCqunmtVKEQp4XnNyZbGXQ0mk5vl5c+wnQsKy2phclPdD/z6GN1NNu9ZAE75oKEL0hFN
         E+I6gsv1ferMmRnpCLRyqKQO/jHRiRIaA8KZbFumqSHvXdcfjVaXDvaV5MqQ7z/QK9wG
         QBkZVUgXLtj+1lJ3H0BRLtSyOfHJm83n3Rb/Ot0Bgo2ZWqunamnv8MuJfG93SQNIHpSX
         XQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734286363; x=1734891163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNFLCf1qgtNxbc2CCINQbIdRIjwFbT1I23jfba115fw=;
        b=wGFYjD2OVe7+fdoaIBdxWqlbbCfCn49xHp3Ie8iPlM+SLWhF1Hu8I5M5Yd62j0o6Kd
         Rrt3m9a1ofKWgxHOEel6F4xtsCRm51jR0iACmtwlyaq8kq8L+kGHzKj52nL1jxAaIysO
         ea3IGJ2D6g/dzl4TsNMOpf7PETdQzagtzmLSyMmkR8e8nDtdn8qfL0hl+UeHs+pPbk/w
         OBZhZZ766oN48XuLIjlIcrvzYIIsgJuMma2r8ix/ZIlWBWEqrCoZo/92pSClOdTB0/uu
         DtOIilS+rT4YxmXo6tkUwCJDsaeX2/KZBQOGu7fhKmcu3X6zeMj14hcJ10HLzQ7JmkCF
         iXdg==
X-Forwarded-Encrypted: i=1; AJvYcCVn+qPOFeJmkzGZ5byO7et/40kKhwKkxuQ56r/n1PoCVBaCAWfWx0vyGsYmbbgYpn3uyOwu3a3DwJKsxuE=@vger.kernel.org, AJvYcCVxYG/GOcEIQysKDq+SBsaY2JhDgJK+dY+ddLY2urBGmQIkwRU2KeIn/VyQzqw8zgE+D/ErMB1NCUBAVjgWPH9OdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFmsCSfq8ie5EU3wDJxDu/1SlZDxvci/o7IstK6McHB2+BOiyI
	Lu1dQQUgbSL5FI6ILnCn8dNfleW4tVRwHC/1TcqOaTEQYUTbNT0Q
X-Gm-Gg: ASbGncum/pNmJJf3M4Bq9Te9BVI5gk1s7BxG68y2dcF8hO852mgK7jg2PHDmDxInm9y
	4FxpbVFri4M/meIppAo58QS5lJEJFXH/TMQTBASS/ZNxCqtPHYwU0elELrHm7L/G5XP/88taKDS
	okDqtu37xSzyJFZZ1cw8d2j/SjOdVoDj6eWxoMgxYzKeGCugMwnCHmbpICizHvfimtwoCbNDH65
	EcBAdbLbj0122KPEE+2JVPymG5HRYLlOEasY//hmSP6+0ba6vbU/extYg8WDzNfUliKHBRUIEGl
	CnHNjZFdFH6S
X-Google-Smtp-Source: AGHT+IGI/yW3PNjS37CDQODaShZ/w+FlthTqMFK80FGqTOLG5N8HGbYrRskb6pzM9LFXRLZ/UYB/3g==
X-Received: by 2002:a05:6a20:db0a:b0:1e1:a885:3e21 with SMTP id adf61e73a8af0-1e1dfc18486mr14701626637.7.1734286363285;
        Sun, 15 Dec 2024 10:12:43 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm2808120a12.16.2024.12.15.10.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 10:12:42 -0800 (PST)
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
Subject: [PATCH v14 04/10] perf record --off-cpu: Dump off-cpu samples in BPF
Date: Sun, 15 Dec 2024 10:12:14 -0800
Message-ID: <20241215181220.754822-5-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215181220.754822-1-howardchu95@gmail.com>
References: <20241215181220.754822-1-howardchu95@gmail.com>
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

