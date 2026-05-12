Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27163B38B0
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625090; cv=none; b=DCJcuHk7WDzdAb4KjvP7ljoLu3DyoyaHpnTD0qmOKDiJZenLtosNcK52OIh5lMsjzVmtYM9zFHySIpL3SqaGSJBWeI6uKpGefZmjm8Obvm31RggD3CXqiev2HUx3FlHR8/z1/+yvgHlyBPQk8zlZY92siS6Xrs09Zc4rZBxZk54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625090; c=relaxed/simple;
	bh=rwHrgyewnn6qmp2MCiFOYU06LPjfGHf3OEw57cam3vM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DhWTL+GuJvtFy7VLWDeyusqN4AmsIOQE3kbDTY6CM45VA0TgT78xSNbCAlpEssmUnmkOry/WhHRS1Lwxg3+xFsukhhv13Q69OIpviBYXvghA5BM3C7vdOJFVwzoGztMbGQ9aVXrfwN+c878uTRL8GaEJursOnJkmxIf7aTpD2Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WvIN2ocI; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WvIN2ocI"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2f1383b7439so5132560eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 15:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625088; x=1779229888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u5eatz8V1oR6L945v4HmYI+8zqOcLRgYzYetQvCHYvg=;
        b=WvIN2ocI6zvfiuWE48+hfir7jdlcEruuuxg5DC2bah16Qh8/2z8VRZl8asiVxdSUBY
         PRKoyaWCdZtrBlCsXvc3PbaGE87C4vPdZLY2IXFNrx5lkkUTIYT6K2hyGwTYz4auA2JA
         wnFat6RMwd9jnrFP9wnhSX4g3LtDwQlZSu5CGEM9E4C0Y2BnlYfofT2skyiE2IQGFFFY
         MZD8sfuf7yzthnxjiVC59XqbY4V+ujG1FVjQPh3w9eYUiVyf7bZnwq4KAxFCkTJlDMRn
         tnqnfiaAS/LaraS+yM04iCX/KtfQmRns9nvT0YxwYo2mlqymhd9RgrgJa9GuyD+XNNoY
         X2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625088; x=1779229888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5eatz8V1oR6L945v4HmYI+8zqOcLRgYzYetQvCHYvg=;
        b=e+bEoy0/yTM/kIgItjGQaXwiwWcHfFKiKN4shu9Kpdm5Ps5WEXEcDQ5pqL6xs9qTu0
         RCjgPuXn2oCB6+/sf/unQaZwzG1pM6GTMCXgdsR1ZLAMIgL542Z+C3A4LRfLy9jPiVLs
         HXpApef0IoNu9Y9vYEqIbahP+pQ8BPQ/Owl8aibmdkk55n91ZdDJZy72TR8d31U+gUtl
         89lqsP2oVhLfSAK67kjK8Tg0cJw4BNRarplm7flVCXx/lHzwQwwQXQUHzx77aPax7lvR
         sfVi1/JLXpnRojvCbOapRqfXlGYfQ+PDgz6hOzEI622TOAw4R29gTLTLB7gPGTMUKByv
         QpRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+w9/pZtjg3r+XQehtoSL32K8+ndF6qUGzs1h+f+ZrhXELK8CLJxzkZ8ojfG1RHgvQiZ+269My8xq/r+YAZqvDI@vger.kernel.org
X-Gm-Message-State: AOJu0YzPus5nPtfqQREwu7p6nK3DKnudNhM/K+yvcjYjFDNLbD+6MmI9
	Nq0RzwRQHLx9po+uGq24fkhrb4iqOXX8Z8OH05uS+iYfQ0J3nHYDuBuxU3VUFCE61oexPB90MqP
	io0hVpSyPZQ==
X-Received: from dlj2.prod.google.com ([2002:a05:7022:502:b0:12e:97be:ed8a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:401:b0:128:d5bd:3557
 with SMTP id a92af1059eb24-1341e7be174mr559602c88.4.1778625087399; Tue, 12
 May 2026 15:31:27 -0700 (PDT)
Date: Tue, 12 May 2026 15:29:58 -0700
In-Reply-To: <20260512223001.2952848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413041143.1736055-1-irogers@google.com> <20260512223001.2952848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512223001.2952848-30-irogers@google.com>
Subject: [PATCH v13 29/32] perf timechart: Bounds check CPU
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Ensure the CPU is within expected bounds to avoid out of bound memory
accesses in arrays tracking CPU state.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-timechart.c | 35 +++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 64f69bd67c6b..64903b54e8a7 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -607,6 +607,10 @@ process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
 	u32 state  = perf_sample__intval(sample, "state");
 	u32 cpu_id = perf_sample__intval(sample, "cpu_id");
 
+	if (cpu_id >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu_id %u\n", cpu_id);
+		return -1;
+	}
 	if (state == (u32)PWR_EVENT_EXIT)
 		c_state_end(tchart, cpu_id, sample->time);
 	else
@@ -622,6 +626,10 @@ process_sample_cpu_frequency(struct timechart *tchart,
 	u32 state  = perf_sample__intval(sample, "state");
 	u32 cpu_id = perf_sample__intval(sample, "cpu_id");
 
+	if (cpu_id >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu_id %u\n", cpu_id);
+		return -1;
+	}
 	p_state_change(tchart, cpu_id, sample->time, state);
 	return 0;
 }
@@ -635,6 +643,10 @@ process_sample_sched_wakeup(struct timechart *tchart,
 	int waker = perf_sample__intval(sample, "common_pid");
 	int wakee = perf_sample__intval(sample, "pid");
 
+	if (sample->cpu >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu %u\n", sample->cpu);
+		return -1;
+	}
 	sched_wakeup(tchart, sample->cpu, sample->time, waker, wakee, flags, backtrace);
 	return 0;
 }
@@ -648,6 +660,10 @@ process_sample_sched_switch(struct timechart *tchart,
 	int next_pid   = perf_sample__intval(sample, "next_pid");
 	u64 prev_state = perf_sample__intval(sample, "prev_state");
 
+	if (sample->cpu >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu %u\n", sample->cpu);
+		return -1;
+	}
 	sched_switch(tchart, sample->cpu, sample->time, prev_pid, next_pid,
 		     prev_state, backtrace);
 	return 0;
@@ -662,6 +678,10 @@ process_sample_power_start(struct timechart *tchart __maybe_unused,
 	u64 cpu_id = perf_sample__intval(sample, "cpu_id");
 	u64 value  = perf_sample__intval(sample, "value");
 
+	if (cpu_id >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu_id %llu\n", (unsigned long long)cpu_id);
+		return -1;
+	}
 	c_state_start(cpu_id, sample->time, value);
 	return 0;
 }
@@ -671,6 +691,10 @@ process_sample_power_end(struct timechart *tchart,
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
@@ -683,6 +707,10 @@ process_sample_power_frequency(struct timechart *tchart,
 	u64 cpu_id = perf_sample__intval(sample, "cpu_id");
 	u64 value  = perf_sample__intval(sample, "value");
 
+	if (cpu_id >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu_id %llu\n", (unsigned long long)cpu_id);
+		return -1;
+	}
 	p_state_change(tchart, cpu_id, sample->time, value);
 	return 0;
 }
@@ -694,10 +722,9 @@ process_sample_power_frequency(struct timechart *tchart,
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
@@ -1517,6 +1544,8 @@ static int process_header(struct perf_file_section *section __maybe_unused,
 	switch (feat) {
 	case HEADER_NRCPUS:
 		tchart->numcpus = ph->env.nr_cpus_avail;
+		if (tchart->numcpus > MAX_CPUS)
+			tchart->numcpus = MAX_CPUS;
 		break;
 
 	case HEADER_CPU_TOPOLOGY:
-- 
2.54.0.563.g4f69b47b94-goog

