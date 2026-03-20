Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2F03FE660
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034946; cv=none; b=ckiRwMvZ2owKDHSWxyYLlYf5sXQ2c3zDp4/K1ivFK86yxA2cgaxfcAUFsqsuLMMEYy8SfYcORi09mN6ZCCXl2zje8WgfNlViIR/xIygF/ORy7Hkh9/YGFo11Xiw4JYBue3I+961PhqHDzH+7XvdB98isvqZzqhOqJG/wuVRBFNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034946; c=relaxed/simple;
	bh=pXK7y7ZuOVRML1aOeG+R07tIO0+gbHDOA/JGYMY35PE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LKP99lmPAJSM5HDnQxr4jE8HQ7gRBEakimt8tSqYAqhWX+cRvVMz564f42YRRPtSyc7af8BqZXaC9UuBp0Qc08PIaFcDN0FQV6u/So5h2sY2TLaE9FeDK+HcbIlV4KhUQhJRduhm96D+u1Lsof5ZG51dFCyirnGCqfbt194buGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OoxnFE2+; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OoxnFE2+"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12a77b008deso8692677c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774034941; x=1774639741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=91h6BWsxtGziSV6ylkwBKTTT39CDjMj0ZvKle7CWKFI=;
        b=OoxnFE2+zXyDqIbX0aX/PRoDxcV1cSAJMVbwcSfWyoqc+d+U7tJiCtJI7o34r6guIy
         /Hk1S6k/CTBPdsybc97ayPLHboYchBlSG0S+eBydMCmY8UyNIXxW39idi4QOKlp+3qp9
         LnI3gc94A48QQ6ERKkQ0vVzX3IfIE6If+N6w+qzSHTzKAd6VOF7j0THV9yD/NIdFk6Ta
         f70z8ITvxGzCXFfgLCmK01/H4Sbys1a3U+OI2RNiLtIRjLt0X60s7wjc0gF91rPHOaop
         j6z1y2EEbckKZptExrba6IQ+kkwJvgy+yHmnU0oWVjuWHYGwRsrL0ycg4CH8lxtSB1/1
         LseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034941; x=1774639741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91h6BWsxtGziSV6ylkwBKTTT39CDjMj0ZvKle7CWKFI=;
        b=WJK7Gg/BN8lWR6VAQLCG96mrddiXDfjjyz2vxTvTkzdr9KziMSjYk9g+tIUQT32uGd
         4dWq0Tyh9zg8fM3oLGOzUHmkq+I5vKI5Wz5F6YdnEMwwLr1vWOYajeRSctcTiwyekWCk
         rGWfz2YjComiNQA7bXAcIDPpNlN2RoXcaU1mkTNxSzQshJp3MZ6xF13NML/1DtR07RmA
         KcsQGmjrmv6Rgqo26draP9tAohECSmI9Bcn18kau9BS9CaEJtTEJbaRcwt7fgxqbv68W
         UDMYdny0D0BTBywSIKPr3gLX524Vr3UJl0IYNpA3SviGE1tFvHq2wBWyv4P+zDj/hVUc
         6qeg==
X-Forwarded-Encrypted: i=1; AJvYcCV/2s7+6E3SQjEVKnsuSyYToFYyG8n5oD37uUFnQTOOY54QH42N4I9nJ+WSAVbyzJj58S5+dX0OppPw67+NnXEd@vger.kernel.org
X-Gm-Message-State: AOJu0YwpLcrtT5IgNdJsSUwtiYhDnBYM3vJzfaGV5+fy2o337s9jWR+S
	bBo6htCvIEq+NQksHDh/A+enGHSrE7hcvOwW4dHO6NyoG8raCQqQMjxFIs14beT7e0Z12emOMih
	LHU45GpfB8A==
X-Received: from dlbto10.prod.google.com ([2002:a05:7022:3b0a:b0:12a:6ccc:6d06])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:226:b0:11b:b179:6e17
 with SMTP id a92af1059eb24-12a726d0480mr2091074c88.34.1774034940456; Fri, 20
 Mar 2026 12:29:00 -0700 (PDT)
Date: Fri, 20 Mar 2026 12:26:22 -0700
In-Reply-To: <20260320192627.368357-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320080835.724836-1-irogers@google.com> <20260320192627.368357-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320192627.368357-21-irogers@google.com>
Subject: [PATCH v4 20/25] perf timechart: Don't pass evsel with sample
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

The sample contains the evsel and so it is unnecessary to pass the
evsel as well. Add missing backtrace argument to tracepoint_handler
functions and mark them unused. Fix missing free from cat_backtrace,
which requires copies of the backtrace being made in functions that
save it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-timechart.c | 75 ++++++++++++++++------------------
 1 file changed, 35 insertions(+), 40 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 782ede4258a2..69ee08a8295f 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -299,7 +299,7 @@ static void pid_put_sample(struct timechart *tchart, int pid, int type,
 	sample->type = type;
 	sample->next = c->samples;
 	sample->cpu = cpu;
-	sample->backtrace = backtrace;
+	sample->backtrace = backtrace ? strdup(backtrace) : NULL;
 	c->samples = sample;
 
 	if (sample->type == TYPE_RUNNING && end > start && start > 0) {
@@ -433,7 +433,7 @@ static void sched_wakeup(struct timechart *tchart, int cpu, u64 timestamp,
 
 	we->time = timestamp;
 	we->waker = waker;
-	we->backtrace = backtrace;
+	we->backtrace = backtrace ? strdup(backtrace) : NULL;
 
 	if ((flags & TRACE_FLAG_HARDIRQ) || (flags & TRACE_FLAG_SOFTIRQ))
 		we->waker = -1;
@@ -489,9 +489,9 @@ static void sched_switch(struct timechart *tchart, int cpu, u64 timestamp,
 	}
 }
 
-static const char *cat_backtrace(union perf_event *event,
-				 struct perf_sample *sample,
-				 struct machine *machine)
+static char *cat_backtrace(union perf_event *event,
+			   struct perf_sample *sample,
+			   struct machine *machine)
 {
 	struct addr_location al;
 	unsigned int i;
@@ -567,7 +567,6 @@ static const char *cat_backtrace(union perf_event *event,
 }
 
 typedef int (*tracepoint_handler)(struct timechart *tchart,
-				  struct evsel *evsel,
 				  struct perf_sample *sample,
 				  const char *backtrace);
 
@@ -578,6 +577,7 @@ static int process_sample_event(const struct perf_tool *tool,
 {
 	struct timechart *tchart = container_of(tool, struct timechart, tool);
 	struct evsel *evsel = sample->evsel;
+	int ret = 0;
 
 	if (evsel->core.attr.sample_type & PERF_SAMPLE_TIME) {
 		if (!tchart->first_time || tchart->first_time > sample->time)
@@ -588,16 +588,17 @@ static int process_sample_event(const struct perf_tool *tool,
 
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
-		return f(tchart, evsel, sample,
-			 cat_backtrace(event, sample, machine));
+		char *backtrace = cat_backtrace(event, sample, machine);
+
+		ret = f(tchart, sample, backtrace);
+		free(backtrace);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int
 process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
-			struct evsel *evsel __maybe_unused,
 			struct perf_sample *sample,
 			const char *backtrace __maybe_unused)
 {
@@ -617,7 +618,6 @@ process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
 
 static int
 process_sample_cpu_frequency(struct timechart *tchart,
-			     struct evsel *evsel __maybe_unused,
 			     struct perf_sample *sample,
 			     const char *backtrace __maybe_unused)
 {
@@ -634,7 +634,6 @@ process_sample_cpu_frequency(struct timechart *tchart,
 
 static int
 process_sample_sched_wakeup(struct timechart *tchart,
-			    struct evsel *evsel __maybe_unused,
 			    struct perf_sample *sample,
 			    const char *backtrace)
 {
@@ -648,7 +647,6 @@ process_sample_sched_wakeup(struct timechart *tchart,
 
 static int
 process_sample_sched_switch(struct timechart *tchart,
-			    struct evsel *evsel __maybe_unused,
 			    struct perf_sample *sample,
 			    const char *backtrace)
 {
@@ -664,7 +662,6 @@ process_sample_sched_switch(struct timechart *tchart,
 #ifdef SUPPORT_OLD_POWER_EVENTS
 static int
 process_sample_power_start(struct timechart *tchart __maybe_unused,
-			   struct evsel *evsel __maybe_unused,
 			   struct perf_sample *sample,
 			   const char *backtrace __maybe_unused)
 {
@@ -681,7 +678,6 @@ process_sample_power_start(struct timechart *tchart __maybe_unused,
 
 static int
 process_sample_power_end(struct timechart *tchart,
-			 struct evsel *evsel __maybe_unused,
 			 struct perf_sample *sample,
 			 const char *backtrace __maybe_unused)
 {
@@ -691,7 +687,6 @@ process_sample_power_end(struct timechart *tchart,
 
 static int
 process_sample_power_frequency(struct timechart *tchart,
-			       struct evsel *evsel __maybe_unused,
 			       struct perf_sample *sample,
 			       const char *backtrace __maybe_unused)
 {
@@ -865,8 +860,8 @@ static int pid_end_io_sample(struct timechart *tchart, int pid, int type,
 
 static int
 process_enter_read(struct timechart *tchart,
-		   struct evsel *evsel __maybe_unused,
-		   struct perf_sample *sample)
+		   struct perf_sample *sample,
+		   const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_READ,
@@ -875,8 +870,8 @@ process_enter_read(struct timechart *tchart,
 
 static int
 process_exit_read(struct timechart *tchart,
-		  struct evsel *evsel __maybe_unused,
-		  struct perf_sample *sample)
+		  struct perf_sample *sample,
+		  const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_READ,
@@ -885,8 +880,8 @@ process_exit_read(struct timechart *tchart,
 
 static int
 process_enter_write(struct timechart *tchart,
-		    struct evsel *evsel __maybe_unused,
-		    struct perf_sample *sample)
+		    struct perf_sample *sample,
+		    const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_WRITE,
@@ -895,8 +890,8 @@ process_enter_write(struct timechart *tchart,
 
 static int
 process_exit_write(struct timechart *tchart,
-		   struct evsel *evsel __maybe_unused,
-		   struct perf_sample *sample)
+		   struct perf_sample *sample,
+		   const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_WRITE,
@@ -905,8 +900,8 @@ process_exit_write(struct timechart *tchart,
 
 static int
 process_enter_sync(struct timechart *tchart,
-		   struct evsel *evsel __maybe_unused,
-		   struct perf_sample *sample)
+		   struct perf_sample *sample,
+		   const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_SYNC,
@@ -915,8 +910,8 @@ process_enter_sync(struct timechart *tchart,
 
 static int
 process_exit_sync(struct timechart *tchart,
-		  struct evsel *evsel __maybe_unused,
-		  struct perf_sample *sample)
+		  struct perf_sample *sample,
+		  const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_SYNC,
@@ -925,8 +920,8 @@ process_exit_sync(struct timechart *tchart,
 
 static int
 process_enter_tx(struct timechart *tchart,
-		 struct evsel *evsel __maybe_unused,
-		 struct perf_sample *sample)
+		 struct perf_sample *sample,
+		 const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_TX,
@@ -935,8 +930,8 @@ process_enter_tx(struct timechart *tchart,
 
 static int
 process_exit_tx(struct timechart *tchart,
-		struct evsel *evsel __maybe_unused,
-		struct perf_sample *sample)
+		struct perf_sample *sample,
+		const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_TX,
@@ -945,8 +940,8 @@ process_exit_tx(struct timechart *tchart,
 
 static int
 process_enter_rx(struct timechart *tchart,
-		 struct evsel *evsel __maybe_unused,
-		 struct perf_sample *sample)
+		 struct perf_sample *sample,
+		 const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_RX,
@@ -955,8 +950,8 @@ process_enter_rx(struct timechart *tchart,
 
 static int
 process_exit_rx(struct timechart *tchart,
-		struct evsel *evsel __maybe_unused,
-		struct perf_sample *sample)
+		struct perf_sample *sample,
+		const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_RX,
@@ -965,8 +960,8 @@ process_exit_rx(struct timechart *tchart,
 
 static int
 process_enter_poll(struct timechart *tchart,
-		   struct evsel *evsel __maybe_unused,
-		   struct perf_sample *sample)
+		   struct perf_sample *sample,
+		   const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_POLL,
@@ -975,8 +970,8 @@ process_enter_poll(struct timechart *tchart,
 
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
2.53.0.959.g497ff81fa9-goog

