Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73B82B9BC;
	Wed, 13 Nov 2024 00:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457711; cv=none; b=ig3CA8CBFNAZ/GrZpt6yZU5//OWIw/mP2pXiEpI7upx4HDBw15KjXNtX9LwyEJDcO1sqYAxixGQgNppnMhC9zxROBrfBNJZVCgI/CIRkl6X/zWJANikcYJOq33O48PSsTJxRrzfGBxWH83ZsyXleR4dsfzwJiDsN9UPgY94Htak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457711; c=relaxed/simple;
	bh=FhYBFcBipaHcJVExkC+3V5vt7nolG31xdwTCXFsCPv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpXJuaryyDhELyckCkGSWuLWkFb+IJUZiQIctRm0gqaAW9z7w1nHcXzSUBZIxE+2cFAiECbwi7xZnZE8XyADsJ7zmVGspltV3BkQVciwv0Oi8LwJwpPdQXoSF8Xciq1SpyqWYbCBFYTRmutfP5T2ByGUY5QBTi/jWLGtW+a/s2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuI6N243; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuI6N243"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c803787abso1708815ad.0;
        Tue, 12 Nov 2024 16:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731457709; x=1732062509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HM89nxEPCN1/mXqArlw/4nxHHrqhLHtRHulGS1q1v6g=;
        b=WuI6N2435/69kIR6J7rIdeOga1jvQOevLCE4na9Gq5OmBUzLppiKed+Dbzym2rhKnG
         MKHfUDDvvK/OAxyMTGCLD7lBANsOdGhVtvgOvq+MRh3e14oZTKGl1IahWDxrpcpHZPey
         Vu7kY73hsApzEBycUXKuQiFHxdLh0mzLQFmToEXNm/n97QqedSJ9B5Gmteep1PPiwXK1
         eJkZHRTdjHIlkXLfoMVQYFhyK91Y4AkSbKR6vmI3mwJWEibSu6y/rmLpwytZLhM0iGCF
         biW7GW2i4z8Ba1XIElE82Sv96LOP1W95voXyEdrR7ViD6GR1PWs/xGx6DUu/Q2d9/xhD
         KW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731457709; x=1732062509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HM89nxEPCN1/mXqArlw/4nxHHrqhLHtRHulGS1q1v6g=;
        b=Oj1el4HbmQpmkgYVVO+zp/56VmHJj2dr+NL+lMIFdr6szvGE0UcJwpGO2vhF1NJNvJ
         kn1vUJFE6J1PMSmboTkQhMwRZQPJ1kqbckVHk7zJ6vOv7SFeC80fXRqwqAFh6aTkJk/C
         EnypHPLFrfajE3eScAsArKdqT5XwH20ejtD3+kf/xsqS63SkG0jJK12JVGJzuZAEqRMP
         lOSO/R5fEMTOYKq7Agq3YoaLCby/m+bjycjjHSFSrPNiH2V2TwUszeUc2mvAXlwAgWRg
         9MhIV4s7uE30Ovew8zHsyHSn81Tws0nwhLp/fBrzl1Ncv/fbIP8ZC7xgJUuKj4CGyFQ7
         oOPA==
X-Forwarded-Encrypted: i=1; AJvYcCUr+r3sJC+kf/HyjD2jbeP34pa1Ze6lUam/cIl7n7xiiS5E3WefWVPUZXfLWuCXp8vcXIkfp3JvcNnTP9aiNHgBqA==@vger.kernel.org, AJvYcCVmolAdfucU0Hh1hYvrNu6zLOHSUDWzLbQDWy64Yy3ZnyE1J8D9zIJ9ZuuNdT7/2PSOTd/k3ZSfSFSFxWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJZH2opZuZuSjC7utR0QbWS21ZX3CC1uJ7PgpDM/Ro9fZ2Ldhi
	/eCNXPOW7dou+z/C2ZBYOxfbqUp8F0eJ5GwCjQbJOYQy2kfqqKpE
X-Google-Smtp-Source: AGHT+IHrQ5cn+T07aVsaHLPMLxQxSg2+xjL27GuTAYLQtp8AH1pRu3KFuF1Ma8D8cAC4R6z4z5e+qg==
X-Received: by 2002:a17:902:c412:b0:20c:da7c:6e8c with SMTP id d9443c01a7336-2118215cc97mr223373435ad.3.1731457709183;
        Tue, 12 Nov 2024 16:28:29 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e458bdsm100158425ad.133.2024.11.12.16.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 16:28:28 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org,
	peterz@infradead.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mingo@redhat.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v8 05/10] perf record --off-cpu: Dump off-cpu samples in BPF
Date: Tue, 12 Nov 2024 16:28:13 -0800
Message-ID: <20241113002818.3578645-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241113002818.3578645-1-howardchu95@gmail.com>
References: <20241113002818.3578645-1-howardchu95@gmail.com>
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

