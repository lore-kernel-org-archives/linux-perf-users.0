Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC933CD8A8
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935097; cv=none; b=r8mVNAglb5Beo63irsItCndYSKJZW8Xr3rB0kpk2rsDu6PICvheH4ALXe8pImmZMXeE8VypK5AGKsR0LUnuP/uSvD8AFH1Tq2wXmxK3OXEA0eMxrOlwEInfaXtVsA57ARUzc3m8R4aMVbDcV4QbahPyVZdvMUJxGrNAt4UeLEg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935097; c=relaxed/simple;
	bh=nO+ijauoqQTWW9e2E9q8sHz+WHm6zTSnd8+xq3INW9U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rg6FvdztubrTj5CCmtwL2Ij3H+LcBwbUzoR6GK5srxad2ZpeuXC2N/aPjrY+Lc4wnlpMEX3LjIoe5DTCsaN0tA4H6h2Y6tdapQdf1oJE2K2Xv5lxBXLAFGGeqL1eXmn/cNxG5+61iiaGXMlfxSQKqx3SZTjauR6hgtA/afwX/4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hz+4TTij; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hz+4TTij"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12737f276a2so14019894c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 12:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775935095; x=1776539895; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hc4PJRwo5dHcpILt7l0l61YfNSgCzUOPaqwcr0CTR3Q=;
        b=Hz+4TTij4HHstvjiOi3N0XFQkuz1fZ4SZqRvwnw6vcD9Cqs1V9kAfl5q/fHmcPjrLJ
         2eU3aYgoRig4wqrKE0tcPQmeXsrKpUoWdiiUWLAp+I/WtCq+KnK3RIh6cR9/DPiyRN+D
         yyWlakBBjGxneBrWMe8o2sGf7kM1DI3Zqnr41XlmLS5aCK0545Mzsol6pOlyMV5qoXT8
         g/uD4Tm7FyvfN4T27IkA9JlekMocEtRqGIosa2BlBtbwC+G6RcI2+xbQ6iYn9rgCeVs9
         LBdwVexJhUkvt9JjA9IVTkc/2osUWDvGyjHDfaq52jw5ZYGWOEwHDxwoaKRGwKTAHQw0
         h+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775935095; x=1776539895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hc4PJRwo5dHcpILt7l0l61YfNSgCzUOPaqwcr0CTR3Q=;
        b=b27751pz+k4Eqg1ytfTLntKGAyVz6znSnWav2j2hAsLv6X0WowtAzVU6/jUHQt3A5l
         VowRTdZ20eZTIk60KpuDtC2ZiQaXOVs2RxNFdNlOLEHzPLtXiA7ul1yqpIRDRoc8kD0a
         ocpWKEjDwttf2V11/SaQT1GacVW69inAQEvoS206Kl4MZzkjWvm4WS98uvrfHUqARa1+
         gCb+nbtHx9hTWHBoCLLc7Js3sU8wiAG2ZpJ4zVvEWO7AQVQAYurLSSeXu8Dod7XT5ina
         IR4tY2RdS21l/pYGXLNZDcTXbfMPVbi+E/21YeZmqhhBEJiXWZRH6X2hWinpCWuE/wcb
         m9kw==
X-Forwarded-Encrypted: i=1; AJvYcCX2tDB6RsofHQ/y8DKMLVQWmtfpsfDrFKVZA28UOP6Md0pNvoValVK3VnfRrbeX+fn6JJLAHE6lixluSAZXXzR/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Tq7Wun6dO+Ll3ChNCgNeIv9kEPMNdc7Lr98SYsWrC8DSdb70
	AsWbKg4gWVL2JTKbbVi1ZoAhq4FXWhjkXfQryBS/BoNadAhPP2dbaboAGw3qgocrIguJIFOL0+0
	Yd5FRylS/uA==
X-Received: from dykp42.prod.google.com ([2002:a05:7300:caa:b0:2cb:a16b:ff43])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6183:b0:11d:c22e:a131
 with SMTP id a92af1059eb24-12c34e37b04mr4420048c88.3.1775935094731; Sat, 11
 Apr 2026 12:18:14 -0700 (PDT)
Date: Sat, 11 Apr 2026 12:17:07 -0700
In-Reply-To: <20260411191710.524998-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411065718.372240-1-irogers@google.com> <20260411191710.524998-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411191710.524998-27-irogers@google.com>
Subject: [PATCH v9 26/29] perf timechart: Bounds check CPU
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
 tools/perf/builtin-timechart.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 64f69bd67c6b..64ff998c597a 100644
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
@@ -697,7 +725,7 @@ static void end_sample_processing(struct timechart *tchart)
 	u64 cpu;
 	struct power_event *pwr;
 
-	for (cpu = 0; cpu <= tchart->numcpus; cpu++) {
+	for (cpu = 0; cpu <= min_t(unsigned int, tchart->numcpus, MAX_CPUS); cpu++) {
 		/* C state */
 #if 0
 		pwr = zalloc(sizeof(*pwr));
-- 
2.53.0.1213.gd9a14994de-goog

