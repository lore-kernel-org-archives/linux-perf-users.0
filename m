Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B11170854;
	Fri, 22 Nov 2024 04:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732250334; cv=none; b=JmQYa7cDbOpt7y7H45VwH6tYzPX2QBVO/uD6iCGaP4G64VS3Kz6bn5Ym5eneDUSVl0KbjOmDXZyCCE/jahPazjObgOP6TIsgussP1hNfk5bK6tkldbaC9bMLRsHWbR4m61jGQP5LMdskxiwa/nGlZvzZmjRDzUbNQY0bxGuRea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732250334; c=relaxed/simple;
	bh=FhYBFcBipaHcJVExkC+3V5vt7nolG31xdwTCXFsCPv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2CiMsMO/5toNIVwI2q2f9hLrv69sz0BUw+Aonh8Y4MtIOQdO48xUfxWZjgTcqhSXgVy34jJweh3QX9RcXgS072CbytbCS2KMvBBH1fskH8L8VGYvdCRhGBbW84gvFDKyEnL1AkZeHIS3vE3tF0L2dwkgrpa2Jdyp6KSjzWtZ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+kdRIrh; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+kdRIrh"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7eb0bc007edso1178550a12.3;
        Thu, 21 Nov 2024 20:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732250332; x=1732855132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HM89nxEPCN1/mXqArlw/4nxHHrqhLHtRHulGS1q1v6g=;
        b=S+kdRIrh9r8bWowy/IBMrou8RWPP5lldKs04HdkNGqaAKCkoDwEvWpLB6sgp5YWE0Q
         nt0pcPy5TWpayCNtIqGQGW6gEZkXPsAOcc51XL1kqysghI06lH+/TQqvAJVkKb2pjya1
         wDReUohQDQvyV/R2VTrv4EiZU2yvvp7kdytEw+jUhYFiAdPU4DsZ19tfneyfv+hCoSx5
         ch3dCllYzVHLW1TiC0THr6qYweQneCGUFuHHkAgZESbfQndLIyIxBaxxfR5KR84AZwoO
         AJAOX00d2BOnkiXVsbRJsFhsDK8DRp59ddmDYLWAxxt1NVQFYDa3xM206bGcHyRomjF0
         g2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732250332; x=1732855132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HM89nxEPCN1/mXqArlw/4nxHHrqhLHtRHulGS1q1v6g=;
        b=tycwyAa6YMsRGV6HNTs5Mc1UZ37c8Zbilt/7A2NftpRO3ESrh/wrA+eX2y04RNJI2t
         kqEZ2dK1xkHPymDs81w+HxflL1Zh1xkivCU9uSj5QQ/GsBw7gERVp4d4JRK7hu4cZ/P0
         N+22j5rcLnUqzmch4vJZl0jClY+ljrKVoZYA2P7f3EecwURCn/4EUR5vLMctfC5ib94e
         1DIUWw1BrNCy2EwHATjjLKUheeRbIczMtO4BlksXif4/g9oWWktTg0Sa8b4DOwNcCQG9
         ol7w2N9Jo9HJU7m58P8fTXLRfTc/vqZlMrL9c4V6TDTNaf02nD9fJimmbd9oaeqTrRaP
         kXcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEJcQ3U3gasGUzkIdNc6faDo03VSk6S5mRC7DkdD++qDmGz3/HuyFN/CkKDMIYBpI4Bdkyh6+lFFqz1i4=@vger.kernel.org, AJvYcCVBBef0r26xsGaPOHYW1THQO59Tszx96E0Azo96Z0Ry9NW7RdS5o3CYRyksBfeKyxuyGi2Y6YHPw2AeneM+1JPGXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzf7+d512OllZrEYmThiEPdkU+c5gnI5l2WB6NiwUmNkeE4ioc
	5OLLYYiaJ+ej2XSMesXuABbbwOYoTQxThN6Nk3K/NTWuViB6Zj8s
X-Gm-Gg: ASbGnctxavris/uUqqm0ER6PaxrTCymjpSGXfJRGR5tkQXjsuk7XRudq+/5FZR5UiNU
	hZErKK1EiwkUpfPGTlH+phEuiudUv6kzU2UjyLD+fLlAxFTj3d+vi5S5SeTbaWnEUAuPxm5bj6C
	mqTV6nwK1b3iViReOr+DbK0ks1tg5GsvJhx6PH0up9loz1Le/KiA0SG82eU7wa1PV1KGNbcBaDq
	+YCR8HEsOahI9mKvKTX6lNitxVn4Iw6Z1t/nbeFYAB0glJHSl3t+bBLJY6edExKuDqsFUc2q63v
	5zbYS2mnHKM=
X-Google-Smtp-Source: AGHT+IEFWw3TaTwAKGV1sSZ/OGFz7T8nnDb8tmmjryeRN9fGo9PilPEl//PZqMc7KD5AhGljbHhC1Q==
X-Received: by 2002:a05:6a20:72ab:b0:1d9:2705:699e with SMTP id adf61e73a8af0-1e09e3a33c8mr1754210637.7.1732250332479;
        Thu, 21 Nov 2024 20:38:52 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc1544bsm6638135ad.193.2024.11.21.20.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 20:38:52 -0800 (PST)
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
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v9 05/10] perf record --off-cpu: Dump off-cpu samples in BPF
Date: Thu, 21 Nov 2024 20:38:35 -0800
Message-ID: <20241122043840.217453-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122043840.217453-1-howardchu95@gmail.com>
References: <20241122043840.217453-1-howardchu95@gmail.com>
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

