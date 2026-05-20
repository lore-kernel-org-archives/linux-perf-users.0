Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5891F3446AB
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304005; cv=none; b=KibaoxsKaAzAtV+kWpWxqAx62os5TMyrvVntggD1YbrCr9X4fE+aIN+nEUmnG82WHDTRo0QRUBjYDIQwcWco4PUyr5bukJ2T+JB8UZadVQc7j5zyBrF8s71u/AGVedMaVSc/e6BO7EQ0Tha6yLSo4hj+bUwcWcOJxYsMBYsi+zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304005; c=relaxed/simple;
	bh=G4ZCgqQkYPCZXfmnCPqbemBVgH/8qiJZrouE6lHFM4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K19FeJ8kWEdruDQkGfKQ41Ma1dytLZQIrksvaar87NL8/8a7JW1apjH2la9/kRYyFAX1F+6qizrOp23mCjaOivEd5jat4rATS4QMNR/ZCBjjjkHVj7liKy0q53ejzkTCJkEnG5NuV2IcX3eQTNrzzc8RLTkVY4HkALod+buwq/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pyMBod6O; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pyMBod6O"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-303b38ec2f6so7339692eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779304003; x=1779908803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D7pQMmzSBP78K6l1cH4FM1ptkAldOCxyM7ssZb+L56w=;
        b=pyMBod6OYQR9g46coq+vfmMPskFSJlr7yVCouetsiUWjbpO6RxHs1Cr0eMJqhY4r86
         BsEiEk/4pxmTWYhUm6t+WgM2WUyI7BUMY1Xvy878EaYdJxEwQYswVMEHYKW5YKyqbfDE
         aNGYmiCHcZSxV8/2/ECNiTjl/j/LsRvSAAlnDOHCGRBMU2F9/jd+8ugOix52WGzjuQIq
         7x1deuyy2nB5hzaNxueSNPQoNVM+gGqKaE1xx7fc7VQrQQvmFaeqTQ0+pY+r1dzY2u2j
         LC6G6gk8OE1Ii9Zg08qNSn19ROmdoi4VoJRnB0WnnWDatcTNBMd6y5RgT6Aks78brVhg
         RhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779304003; x=1779908803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7pQMmzSBP78K6l1cH4FM1ptkAldOCxyM7ssZb+L56w=;
        b=DBkWL0ukNv1pQ4J4dLt3aUO8eylE3RBGMJxJ2jvacet9MhhqqFf5LG8JknSV6umXCx
         u3WgJVPK6GBqYEi8NepvmG3/akT3aly5zqpOKvMf7BrxNuvwGGTOacwAgj4J/ZVMZwdM
         /Py1+tW/fpsLLkZc/uqMtDdPc/3OONluQoL1+XgN8QOedX9ukyURd7kiTvH6rift/19Y
         UsUbTd+MDQDtNza925iqc/CQZ9RKvAkWO9mtX6i+41Uf4/HEUtpv6cFL3s7lhZ6U9fdf
         arm1LwquLJuw5rRU+0vkREMsuCNZdr6ssX01CSjeHXmOwNCZCe+C00d1+0SxHx+NTP+Y
         gtbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/0mUC6kk8Tfs+FuCf4D7BKMLK/CKc6SkXofmWXixKl1ayQBoHb8wtMV0M+94GKQGjKa482ase/DeLVajI9nAgb@vger.kernel.org
X-Gm-Message-State: AOJu0YwOUh2TYH7RtDUBbziurKEFmxWFPe5ADk1CSiXZm0wppnYnzIgi
	Adq5UY9Cw7S6GSUGA/ntywedsp+P+LpQS6bKtA+dMcN2A7Y7FePSJ0WSYuteksKCIU/wfrzV85z
	rX9ljj26Kkw==
X-Received: from dycnr6-n1.prod.google.com ([2002:a05:7300:e9c6:10b0:2da:2af9:bfe2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e28b:b0:2c4:dd55:ffc1
 with SMTP id 5a478bee46e88-3039816dcfcmr11801389eec.2.1779304003233; Wed, 20
 May 2026 12:06:43 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:35 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-30-irogers@google.com>
Subject: [PATCH v14 29/32] perf timechart: Bounds check CPU
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Prevent out-of-bounds writes/reads in CPU state tracking arrays by enforcing
strict MAX_CPUS bounds checks in timechart's tracepoint handlers.

Ensure that cpu_id retrieved from idle/frequency and sched tracepoints is less
than MAX_CPUS before indexing into cpus_cstate_state, cpus_cstate_start_times,
and similar tracking arrays. Also, fix an off-by-one error in the CPU iteration
loop inside end_sample_processing() by changing the loop condition from
'cpu <= tchart->numcpus' to 'cpu < tchart->numcpus'.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-timechart.c | 35 +++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index d2e15d02304e..630756bebe32 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -605,6 +605,10 @@ process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
 	u32 state  = perf_sample__intval(sample, "state");
 	u32 cpu_id = perf_sample__intval(sample, "cpu_id");
 
+	if (cpu_id >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu_id %u\n", cpu_id);
+		return -1;
+	}
 	if (state == (u32)PWR_EVENT_EXIT)
 		c_state_end(tchart, cpu_id, sample->time);
 	else
@@ -620,6 +624,10 @@ process_sample_cpu_frequency(struct timechart *tchart,
 	u32 state  = perf_sample__intval(sample, "state");
 	u32 cpu_id = perf_sample__intval(sample, "cpu_id");
 
+	if (cpu_id >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu_id %u\n", cpu_id);
+		return -1;
+	}
 	p_state_change(tchart, cpu_id, sample->time, state);
 	return 0;
 }
@@ -633,6 +641,10 @@ process_sample_sched_wakeup(struct timechart *tchart,
 	int waker = perf_sample__intval(sample, "common_pid");
 	int wakee = perf_sample__intval(sample, "pid");
 
+	if (sample->cpu >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu %u\n", sample->cpu);
+		return -1;
+	}
 	sched_wakeup(tchart, sample->cpu, sample->time, waker, wakee, flags, backtrace);
 	return 0;
 }
@@ -646,6 +658,10 @@ process_sample_sched_switch(struct timechart *tchart,
 	int next_pid   = perf_sample__intval(sample, "next_pid");
 	u64 prev_state = perf_sample__intval(sample, "prev_state");
 
+	if (sample->cpu >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu %u\n", sample->cpu);
+		return -1;
+	}
 	sched_switch(tchart, sample->cpu, sample->time, prev_pid, next_pid,
 		     prev_state, backtrace);
 	return 0;
@@ -660,6 +676,10 @@ process_sample_power_start(struct timechart *tchart __maybe_unused,
 	u64 cpu_id = perf_sample__intval(sample, "cpu_id");
 	u64 value  = perf_sample__intval(sample, "value");
 
+	if (cpu_id >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu_id %llu\n", (unsigned long long)cpu_id);
+		return -1;
+	}
 	c_state_start(cpu_id, sample->time, value);
 	return 0;
 }
@@ -669,6 +689,10 @@ process_sample_power_end(struct timechart *tchart,
 			 struct perf_sample *sample,
 			 const char *backtrace __maybe_unused)
 {
+	if (sample->cpu >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu %u\n", sample->cpu);
+		return -1;
+	}
 	c_state_end(tchart, sample->cpu, sample->time);
 	return 0;
 }
@@ -681,6 +705,10 @@ process_sample_power_frequency(struct timechart *tchart,
 	u64 cpu_id = perf_sample__intval(sample, "cpu_id");
 	u64 value  = perf_sample__intval(sample, "value");
 
+	if (cpu_id >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu_id %llu\n", (unsigned long long)cpu_id);
+		return -1;
+	}
 	p_state_change(tchart, cpu_id, sample->time, value);
 	return 0;
 }
@@ -692,10 +720,9 @@ process_sample_power_frequency(struct timechart *tchart,
  */
 static void end_sample_processing(struct timechart *tchart)
 {
-	u64 cpu;
-	struct power_event *pwr;
+	for (u64 cpu = 0; cpu < tchart->numcpus; cpu++) {
+		struct power_event *pwr;
 
-	for (cpu = 0; cpu <= tchart->numcpus; cpu++) {
 		/* C state */
 #if 0
 		pwr = zalloc(sizeof(*pwr));
@@ -1515,6 +1542,8 @@ static int process_header(struct perf_file_section *section __maybe_unused,
 	switch (feat) {
 	case HEADER_NRCPUS:
 		tchart->numcpus = ph->env.nr_cpus_avail;
+		if (tchart->numcpus > MAX_CPUS)
+			tchart->numcpus = MAX_CPUS;
 		break;
 
 	case HEADER_CPU_TOPOLOGY:
-- 
2.54.0.746.g67dd491aae-goog

