Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FD138A72A
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053591; cv=none; b=holqHDegQq+Tbx+zWMnDGmGlU4YQS2yrmHPu/F0KcEF5y4pxICtSNfps8+imTMAwqat7CKM0Okzsk9v06K1+tcVEU0ap/7MMMvhJ4ZI+OtzNWbPPlMn811cE8b1g1/PoNGUOKAQEy5S+jElK1Np73UdALJID7VQq8OaHyLlsBDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053591; c=relaxed/simple;
	bh=dVAsi7bYYPJqnhbBpPHXGd5q5Za/B/TINrLvFtzpiD8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QMZ/L4fWTDkR8J37qM7EV6zs+qJX9FC1sAB4pqpaX2VHfLZjoFjv3nfz3VQKWVCdgxFJW/PdRjSQ/ZRJGVu52pf4naW0GujPAodDxgjD5JQr8cKUDrQEpJDHchPmKxhgbzt+jYei+XY0/6yecAeW5javTh6qpx9EgLAAqc5WXvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zriw2GbD; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zriw2GbD"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdc1b30ac8so7180607eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 21:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776053586; x=1776658386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3gAJ13cmq58H8ae4d4LEnv5+lFu4mwDfSGGPkW/FQa0=;
        b=Zriw2GbDLVpChKItO20J7eK/216p8N7u7/5AUV1zR4yLh2up9SC5VTTWAhNbCiAcmG
         rJxJB0YsdZNXqGwPV+w24OaDCzdrKFfZnYgbuKsrai0P5azS+OqcjtuCFN7u9nwZsIO/
         WGx5WWHCj3tNgIB7JBcjXGZ5yMhbgmZMfM1KiAKOOehGa5BTCyrXDdU1bMYzMOmjVEJX
         RLnbl0FdV5k8hW0Id05QBxjQXsGM2yOnC4fiFpoFCXSuZhz6WehhMLRl3vn7DXRyy6Zl
         eMi/Yn2z4+INFZTBO/2Eq/uEYMJLDFDAQyN82uPQJKFf8oIfczKUDe+SBWBnn33/nAwL
         nsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053586; x=1776658386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gAJ13cmq58H8ae4d4LEnv5+lFu4mwDfSGGPkW/FQa0=;
        b=gVyu0wPB92x2L2Tyi3AAVOmtj5S5+U6p+Ls8Y75mpx3W6Q3jKZKpl/+faBoCGKfQtx
         5AUc4wcG4h3W1p1XPAinSLNUBFH96Z4vuOGCUTXzDDBuxVFBT9YjGzp5borJjtwef8QR
         X9FDUj7AWmPcWmUXyrTSWoOks1GSewyhWR1fQmCcXUQGbvPJQFfnu0VZSFvokYsVQaqN
         QlifbExGEqCVSu2f6gX2MpIcPlQhpSGaWdhm0KBeCa0nxTYpc2Og132vm2rYLhoSNAtG
         unb7PPnA5pr+QtaV9Lf0rvxwBWtjP66sQYZuOKR6nHP4dWD0Zl+o8SK/4MYUVBNLTSOl
         bNMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFtnz/EZmKbicaQismYSz3T30GiGCm5SDsAOGUt1NKkPvh8CWcIflKC3JSYQ7QMm0CoU7vaw3A/+Xm4hq622rh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0CK4snJJYCDDEyE+69B3ufgiclyDfN34CJB7jdAibOY4cKInU
	EvlRvC50fKuS+n3duHwEBz8ghxEgFuot0hwMY4bXfNd41nxpZ07NS0ArwMoe7NeWsLdvx8J5th4
	NKjFjlRkZ1A==
X-Received: from dlec2-n1.prod.google.com ([2002:a05:701b:4282:10b0:12c:4ced:d080])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6987:b0:12b:ee8a:19ae
 with SMTP id a92af1059eb24-12c34e3f4f4mr6223412c88.7.1776053585914; Sun, 12
 Apr 2026 21:13:05 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:11:40 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413012227.1089445-1-irogers@google.com> <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413041143.1736055-31-irogers@google.com>
Subject: [PATCH v12 30/33] perf timechart: Bounds check CPU
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
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
2.53.0.1213.gd9a14994de-goog

