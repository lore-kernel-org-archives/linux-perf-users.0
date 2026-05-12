Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7003A3E6F
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625060; cv=none; b=HYJf4KRT4ZjCmcGnpeVwK0UAttclLV2MsooWskbLz0u7yPNA5QJtsVwhLj2zk/V3+snz13QoUJLD7wg7StJc1AJYZpLAKoPne8ynK1cdNWr764YHlz1iLsX4wGrawaMpn7PlnKRI7I2lnILWQHnbp7oDLNn4dvgsWuMnQOhMPnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625060; c=relaxed/simple;
	bh=0Io+d4edOBR2L6gM1qkOSK5AGrjarBaQFizDyhymSYw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tU8YBpOPE7i4xm0F04yWAPCG0BBvyWQiV3ahDExHr4158zWABsS+4jwvSKLQfV80m1D+U01CgJNv4nbqGUsqAY0DP/oxT5C0x1aL/MA8XgsW+r5FUbSXfUQT/pbu7lxoOmuZfnC0+mZSp+fHmvFfDaXOaVx++8prqtFttOwe+QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DIFbsS71; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DIFbsS71"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2fded513994so9013947eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 15:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625057; x=1779229857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E0qdBSpICKgzweWaq/2kP0gfgIsKnGY4cYtTacm1HwA=;
        b=DIFbsS71vqoR/7y9QPDyMvsnL8RrMRoXPdwoYwXbXWcGXJx7LZ/uYpfblTylpsLgAb
         lF/lH0qrE9FzLFFGMFCgiA6i0LUgjPi9GEoi/3yDz83/RuVnXrUjrm5FL3Jc+0qaaOYn
         STzid1Cm1p8nqIHc/NR8QJMD2Dd5zueq152pzefbJzJHILckstGIODCqxFQoyW0BRr/S
         CrQeR7Vq/jBgneBcMLno1lkT33COwkM7eDTiBfy5YlgUr/WNDSolOb/5J1Euua+ZW5Cu
         z0D58UXsWQMbUYEAx7D5coseIlXpWj4+Bod2pnY2FE59yeQMAC3CXEEiSE1ITpA1w5IY
         Mu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625057; x=1779229857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0qdBSpICKgzweWaq/2kP0gfgIsKnGY4cYtTacm1HwA=;
        b=Qs96iUgX9uRFqvVr5AzQgADkYQ+y0NjH48fgFcvP8U7rsMePDRa494AVCnYl7GqQ7d
         G8MAdRBCADWM9s76XsSE11NKJzWpBloQPcL9bzUkNq3R7Oj/O4LY0z0ikKSnSarJ21Xv
         LPLxUAK4gI5Rn1gmDeriw103g5TbdBHIVi+iKKgQJtxl5yKuQGctvawFB8D9R62kh+rA
         Ja69+G3s42mgvTUXdnZJdGyBNAWtx0rfqkux8L7ydYYFvj+ZCW7d2dQSPD3qjf4fCUFl
         jSgt+eBluGQOstYf/fuQ5MTWFE7obbHURoyMMml/SVq1rkLXgbRN5jl+fCfrjdDFlArx
         mCQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+XPqDNGEexoG8/Vq/g5qyVTHf1K3KjIjRG+f2kwWx9255OXYvgxp54FSt9iGPc9barRSUZYFJhky149EHxQaUF@vger.kernel.org
X-Gm-Message-State: AOJu0YzzM+kyA+O09vMSi7imHXWy+ZprgyW7zk4JI9DR6Ix6latagDgQ
	XJUcIwb9wxoQW/QTKxnVDzstu4NW/jzoCCGJf5mlf/xUxJIm9R9Lb3O86O51FAq2djKO29qrnqU
	O/qzRgyhYfQ==
X-Received: from dyz23.prod.google.com ([2002:a05:693c:4097:b0:2da:2525:9f3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:628d:b0:130:aa42:167b
 with SMTP id a92af1059eb24-1349ac7d301mr179761c88.36.1778625057104; Tue, 12
 May 2026 15:30:57 -0700 (PDT)
Date: Tue, 12 May 2026 15:29:45 -0700
In-Reply-To: <20260512223001.2952848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413041143.1736055-1-irogers@google.com> <20260512223001.2952848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512223001.2952848-17-irogers@google.com>
Subject: [PATCH v13 16/32] perf timechart: Don't pass evsel with sample
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

The sample contains the evsel and so it is unnecessary to pass the
evsel as well. Add missing backtrace argument to tracepoint_handler
functions and mark them unused.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-timechart.c | 60 +++++++++++++++-------------------
 1 file changed, 26 insertions(+), 34 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 034e0ba3f9cb..1d24d8738519 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -567,7 +567,6 @@ static const char *cat_backtrace(union perf_event *event,
 }
 
 typedef int (*tracepoint_handler)(struct timechart *tchart,
-				  struct evsel *evsel,
 				  struct perf_sample *sample,
 				  const char *backtrace);
 
@@ -588,8 +587,8 @@ static int process_sample_event(const struct perf_tool *tool,
 
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
-		return f(tchart, evsel, sample,
-			 cat_backtrace(event, sample, machine));
+
+		return f(tchart, sample, cat_backtrace(event, sample, machine));
 	}
 
 	return 0;
@@ -597,7 +596,6 @@ static int process_sample_event(const struct perf_tool *tool,
 
 static int
 process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
-			struct evsel *evsel __maybe_unused,
 			struct perf_sample *sample,
 			const char *backtrace __maybe_unused)
 {
@@ -613,7 +611,6 @@ process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
 
 static int
 process_sample_cpu_frequency(struct timechart *tchart,
-			     struct evsel *evsel __maybe_unused,
 			     struct perf_sample *sample,
 			     const char *backtrace __maybe_unused)
 {
@@ -626,7 +623,6 @@ process_sample_cpu_frequency(struct timechart *tchart,
 
 static int
 process_sample_sched_wakeup(struct timechart *tchart,
-			    struct evsel *evsel __maybe_unused,
 			    struct perf_sample *sample,
 			    const char *backtrace)
 {
@@ -640,7 +636,6 @@ process_sample_sched_wakeup(struct timechart *tchart,
 
 static int
 process_sample_sched_switch(struct timechart *tchart,
-			    struct evsel *evsel __maybe_unused,
 			    struct perf_sample *sample,
 			    const char *backtrace)
 {
@@ -656,7 +651,6 @@ process_sample_sched_switch(struct timechart *tchart,
 #ifdef SUPPORT_OLD_POWER_EVENTS
 static int
 process_sample_power_start(struct timechart *tchart __maybe_unused,
-			   struct evsel *evsel __maybe_unused,
 			   struct perf_sample *sample,
 			   const char *backtrace __maybe_unused)
 {
@@ -669,7 +663,6 @@ process_sample_power_start(struct timechart *tchart __maybe_unused,
 
 static int
 process_sample_power_end(struct timechart *tchart,
-			 struct evsel *evsel __maybe_unused,
 			 struct perf_sample *sample,
 			 const char *backtrace __maybe_unused)
 {
@@ -679,7 +672,6 @@ process_sample_power_end(struct timechart *tchart,
 
 static int
 process_sample_power_frequency(struct timechart *tchart,
-			       struct evsel *evsel __maybe_unused,
 			       struct perf_sample *sample,
 			       const char *backtrace __maybe_unused)
 {
@@ -849,8 +841,8 @@ static int pid_end_io_sample(struct timechart *tchart, int pid, int type,
 
 static int
 process_enter_read(struct timechart *tchart,
-		   struct evsel *evsel __maybe_unused,
-		   struct perf_sample *sample)
+		   struct perf_sample *sample,
+		   const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_READ,
@@ -859,8 +851,8 @@ process_enter_read(struct timechart *tchart,
 
 static int
 process_exit_read(struct timechart *tchart,
-		  struct evsel *evsel __maybe_unused,
-		  struct perf_sample *sample)
+		  struct perf_sample *sample,
+		  const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_READ,
@@ -869,8 +861,8 @@ process_exit_read(struct timechart *tchart,
 
 static int
 process_enter_write(struct timechart *tchart,
-		    struct evsel *evsel __maybe_unused,
-		    struct perf_sample *sample)
+		    struct perf_sample *sample,
+		    const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_WRITE,
@@ -879,8 +871,8 @@ process_enter_write(struct timechart *tchart,
 
 static int
 process_exit_write(struct timechart *tchart,
-		   struct evsel *evsel __maybe_unused,
-		   struct perf_sample *sample)
+		   struct perf_sample *sample,
+		   const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_WRITE,
@@ -889,8 +881,8 @@ process_exit_write(struct timechart *tchart,
 
 static int
 process_enter_sync(struct timechart *tchart,
-		   struct evsel *evsel __maybe_unused,
-		   struct perf_sample *sample)
+		   struct perf_sample *sample,
+		   const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_SYNC,
@@ -899,8 +891,8 @@ process_enter_sync(struct timechart *tchart,
 
 static int
 process_exit_sync(struct timechart *tchart,
-		  struct evsel *evsel __maybe_unused,
-		  struct perf_sample *sample)
+		  struct perf_sample *sample,
+		  const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_SYNC,
@@ -909,8 +901,8 @@ process_exit_sync(struct timechart *tchart,
 
 static int
 process_enter_tx(struct timechart *tchart,
-		 struct evsel *evsel __maybe_unused,
-		 struct perf_sample *sample)
+		 struct perf_sample *sample,
+		 const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_TX,
@@ -919,8 +911,8 @@ process_enter_tx(struct timechart *tchart,
 
 static int
 process_exit_tx(struct timechart *tchart,
-		struct evsel *evsel __maybe_unused,
-		struct perf_sample *sample)
+		struct perf_sample *sample,
+		const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_TX,
@@ -929,8 +921,8 @@ process_exit_tx(struct timechart *tchart,
 
 static int
 process_enter_rx(struct timechart *tchart,
-		 struct evsel *evsel __maybe_unused,
-		 struct perf_sample *sample)
+		 struct perf_sample *sample,
+		 const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_RX,
@@ -939,8 +931,8 @@ process_enter_rx(struct timechart *tchart,
 
 static int
 process_exit_rx(struct timechart *tchart,
-		struct evsel *evsel __maybe_unused,
-		struct perf_sample *sample)
+		struct perf_sample *sample,
+		const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_RX,
@@ -949,8 +941,8 @@ process_exit_rx(struct timechart *tchart,
 
 static int
 process_enter_poll(struct timechart *tchart,
-		   struct evsel *evsel __maybe_unused,
-		   struct perf_sample *sample)
+		   struct perf_sample *sample,
+		   const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_POLL,
@@ -959,8 +951,8 @@ process_enter_poll(struct timechart *tchart,
 
 static int
 process_exit_poll(struct timechart *tchart,
-		  struct evsel *evsel __maybe_unused,
-		  struct perf_sample *sample)
+		  struct perf_sample *sample,
+		  const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_POLL,
-- 
2.54.0.563.g4f69b47b94-goog

