Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800A115AAC1;
	Thu, 12 Dec 2024 02:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970297; cv=none; b=BYePfIJDzwHYOACCzYO8k1cznBa7dlCE4rngZgQ8GeCEcH58326UMaSStmIzwShV1+NWFyXlG8Bf3zvAvpRn3c7SmuSeCHDFdPUXYKb3QBSEns5MuurbgIT/OZ9Ji7hSzmV2FlZ5Jm0urssPKIuigVjClzybUKkKvAT0VzKlsN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970297; c=relaxed/simple;
	bh=FhYBFcBipaHcJVExkC+3V5vt7nolG31xdwTCXFsCPv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLETQJs7eUrehXDv4FlAHuv1r0LXyy6FqAWqu1AORuPUoT8CGS1U9XK/YRF1BBzmsLYwQIDeBYq2zgPlgi33acCVpCqU9KghsYDv9H/mfHRSEQIaolcIn2V33fy6if48eGhCqPr2pAu4iIsHeNiRSaiR1/pZq5eKYybgC0haqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwL9X6j/; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwL9X6j/"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ef760a1001so75520a91.0;
        Wed, 11 Dec 2024 18:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733970295; x=1734575095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HM89nxEPCN1/mXqArlw/4nxHHrqhLHtRHulGS1q1v6g=;
        b=ZwL9X6j/JKQEX9HD4179QuRa69TxZajX3AqIOvU1XJJEaTos0mr0Ujm9VuyPDr82W3
         o6o41qrU59z/ktzxCf79HID1FY3V9/V4RcCvojPIyfAzhpgkrB8lABxOUcFKStWZUgFF
         o2keMFLxXMagzuycUJPiRoTZ2nndUXt571EHwnLqk9fj8EbZimj2PV7m0vUt2UNCLo5t
         z0aRDSGuIPpcKB7fzMzMw5iyvLNSpv9LlJ30Zw8VIJZy1hPsvZ9Y42dVDEaVYdBszpLf
         20/1S5FlCjQys0q8TRyiVgtIPq4Bnin2cNfhNLeAJofAVQHi9yfm5tHIG+lvlYLNp4NH
         MDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733970295; x=1734575095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HM89nxEPCN1/mXqArlw/4nxHHrqhLHtRHulGS1q1v6g=;
        b=FFpyeUnIRvijp9MYUdtt9yrrI3ZDRzUAbOYoR/3RYKforL0N5pXo3KA1MGpd8U/Wyu
         jZ3MQ3Xk596PzKesOA/84b0UQvUsDrxvyA/VkAdmzzMRg/HJ2RhdxZPlgFwJpkg11ydg
         tySZ6Eswp39Ab3GbX/bA1TtYHCE+Qi2BZqQm5XIz0MMXarLk6ebZS5MYp2F/jPkbdk76
         oAa9p8ETPtx7Ei/Os32PiFdbYkfNGL9Qq2S+nmxdhlbousof/6yr9HG1H9qGdq+CylOs
         9II3jlJc0CZWg3wa1N/DpznkdGIS9VQQTncDKr1JqVHatBYtZB/tfia+NRURThyQPFXP
         8ROg==
X-Forwarded-Encrypted: i=1; AJvYcCVMa3CHkmkDSHfBXl5o4z9ceWJ5bw/O//mDLHqO093APkbe/V+mOoDt9R9Jvy+CJmqNDbdxCwCT6TeysY7kzB859A==@vger.kernel.org, AJvYcCXg/zE17Hoh8HRn6TptxSOR/BKQt8L5reMFBMvwjCEnosVFREE/2Gn5zy0SygwO/FdXXzC5MDO+k23yUFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNeNFLAn2F2+B4c510IHDAO3fv26WvpmKHkj9YWS9l17mrSpVh
	WX9ViGnAI9B+Fv9y6C/O8zIC7VdKrOIr0w+WTtzQeOUygXoGHSqz
X-Gm-Gg: ASbGnctlPW7JY8uQ1G9fMgT8YnCfV+c13k4oqSmxM1a5wslfaYQB4ciycTmXZFE6z+x
	kM/W2FaqO7l7DqYbbfpzljVQOTvlfKKL0J28OGUUuqBzTgxGpTtNiWg3Z66wEPDegHuJwX6PVak
	JGijqa2P2rbebOdSBAQeiSnSPRJdZQkFBHLcOKM9AIzR3+lV6ApDzj6VVi7A1OcevHh46ics2Wr
	vP4WzeOE4rXu7ilsjrGs7Kb3xnGP5Ct7q47qKdF3dvjqZ3SCYYQrpGuvItruJUOd+L+dqDD0AJh
	aeC6F2n0CCgu
X-Google-Smtp-Source: AGHT+IEGvTTnx0S4DjO8wD+wECnZ6dMM1Vujj4+bhatBYMiMAJInJfZWijGvVA1WFYk6LKmTJccQMg==
X-Received: by 2002:a17:90b:510d:b0:2ee:7862:1b10 with SMTP id 98e67ed59e1d1-2f127fa547amr7989950a91.11.1733970294812;
        Wed, 11 Dec 2024 18:24:54 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142daeb5asm112583a91.12.2024.12.11.18.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 18:24:54 -0800 (PST)
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
Subject: [PATCH v12 04/10] perf record --off-cpu: Dump off-cpu samples in BPF
Date: Wed, 11 Dec 2024 18:24:14 -0800
Message-ID: <20241212022420.1035999-5-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212022420.1035999-1-howardchu95@gmail.com>
References: <20241212022420.1035999-1-howardchu95@gmail.com>
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

