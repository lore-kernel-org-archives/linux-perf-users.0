Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D262BEC34
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043420; cv=none; b=Dt/aXaxgQlVvZ69yH1/CL0CWjv0amGAHMprQYCUdcVhZeCkFIEf2UBkQAlSdJ+PswcIt+eqCaJx0eCS+qxhYNT7n+HQo+3QYP2+orkb/UceQH1B+Q2DKYybbnhCzkh4Q3DeH6ClvU00ythIQx1F+QoSoxvGq9C6fB21et1Xl5y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043420; c=relaxed/simple;
	bh=dVAsi7bYYPJqnhbBpPHXGd5q5Za/B/TINrLvFtzpiD8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WFuJOFbo5mCGp1g8ItauZeMIo6lbrRqaP0YVBCUQVi+2tTMaZevBUMQBDinkCCMhVrXofGXQsz4R4BBU/9LSTvkb32VDbayXT5q2qQ1gLTKO/JQ5oBFUlEx7EDhhOkPShm73DKBGgH76rRts6DdJp/m+b8slCj5twWVYjwxe47o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L31H7SOC; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L31H7SOC"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c20a91932so7453522c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043418; x=1776648218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3gAJ13cmq58H8ae4d4LEnv5+lFu4mwDfSGGPkW/FQa0=;
        b=L31H7SOChWwDyjEg+UbCEohLLemGQnX6x+3Ry40En7fRbWt9hrOCSYu3Bb9Mhk2Viw
         s5bANx4AkcIm3iifbnlx6GCb/rdgRUquZri39yd3M1gEQQcu+Ixx2/Km/YoZS0NG+ykC
         68mO8OVruRtfFx9SjIXTZvChglx3iMncLJ1XHPP/NBWyy9TEb/cKnq6iGz361UQLyhz5
         fEUYEo2EWPfEzwDAfKrvU0Lf6LVdYcloE+NlnZgBM5CeGDoE0U+kSCTFSrXHQnj9EUTF
         toV9i0bzhkIMzwrSN0u6bh3Frfve4H2zySZa+//3z7ylkYTxRmdicNcyY1DiJz6BHC1N
         Ry8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043418; x=1776648218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gAJ13cmq58H8ae4d4LEnv5+lFu4mwDfSGGPkW/FQa0=;
        b=R12VpwSsmtMuLZJ6/j9mt8iFrPXSG9xr9tnmD0iG+MSAT7ZbCTt8x4liBjgi8bSofa
         a6kM2q06OpSI0IkH1FMITHsRqhsChUi47RdW/2BJVac86F99OSMxo96QQsBxG3be0Vi8
         UUBhCRLxKPsBc2D9Z8h6Twx4OGsK417kSDl37fpII+kluThgrlHkPnFKw2zE1SgACBH7
         +kfsjAqvUybXXpPms0XMPXf12sEi3G+MDu0Z+OpEDFeCQrqMuk1BWVYiWCJXGeDMyz99
         3BhzyJbjTcWcF3OuKuMhYG0JY/jnpo8QtYcC8F10UGqHkZTahQLHI+JpoEjqxdAiaykX
         H5YA==
X-Forwarded-Encrypted: i=1; AJvYcCV84m8KrGB+OET1icuniQ/OYbPIdwd3/yFU59NXh3x68HZUsbsIQO9dRcz+NMKiWQa7Wac7/xai2GEvGLEfDjOr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy49jN7Kcc0Jfe9OJVOK78KG5A4oZ60KEkKwSqptQHlBv1CsN/P
	Mkg4gbr7K7EalriAilDFCJJanRqV8Zc6CC+k/as2r+FPPU0UMubC6s6LtELlKPoGtMAOuQJrWMi
	2OWqiR3pE2g==
X-Received: from dlcip13.prod.google.com ([2002:a05:7023:c08d:b0:12c:3dd4:fcf5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b97:b0:121:dea2:d54d
 with SMTP id a92af1059eb24-12c34ececbfmr7698351c88.20.1776043418300; Sun, 12
 Apr 2026 18:23:38 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:22:24 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-31-irogers@google.com>
Subject: [PATCH v11 30/33] perf timechart: Bounds check CPU
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

