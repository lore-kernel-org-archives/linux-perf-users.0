Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EF83D8917
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248874; cv=none; b=evP7CRrN9w7EJ1BCAjyxEdsQBjpimkt7ScjW/secR0x9508drYiSMMN7dkurMPxVDihq2egvq5dxYsXPEj98yZA5JphamB7nvu8JEL+3IeCPHq3XtO5vwFxcS7LskVUB0XF6iiSrtaByB/DYOOq559H7a6RrBqUr/PRJA8mPW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248874; c=relaxed/simple;
	bh=gaaj7mqTj9irdR4S7xoXLu9VEiPSaerqzbyXPHicpOk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k5jXNnyO/xDRkT/iksX90UP+ND1O53SIbemgeYwrL6AE7qcsnhdEeSuxz83WPxV+mEpxq6Q86552AvS1qtbuKN1+cNW9Ly41NAmQU5bJl7DW4cPMvE6JyUkRCoOxSO7LCSLu2Ggr7wn8R8YOyrZJ8VhkBZ4gJkdS/kURPD3a3ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v68Flh7n; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v68Flh7n"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so3086939eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 13:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775248872; x=1775853672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/+euWmx5IbaoRi1V0BAsO1Eoicg/byu+jgqEgqtKYw=;
        b=v68Flh7nOLvmEwoelDM13kT72npdO+eW/fhywk0OHMXMQkL4d7lt+6MeV3zglOOXLC
         DX4ScHMnltCi8fIboAvC7IcgQkMzpicovtzGhySwukDnJRVoj3zpcDkfrXroYC0djTAQ
         2dUHL7f9I4Vd0T1AwuV5ZO1IF6WCIE+4161C+P4VxKu0zZTUGsMI79PYy0fIH4E4ghz8
         XUtmA0iT3TRHvRO+11daNOGWy0FCLXpelYUTyR9ur0yPr847uG7d8AiJsXSvjrfQJ978
         sQztj8SRLRf9mKoiz2f+397RttDvrFG3+liNPUwb5dgYRBirLRAMDU8zuNXw/THkVe0T
         cL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775248872; x=1775853672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/+euWmx5IbaoRi1V0BAsO1Eoicg/byu+jgqEgqtKYw=;
        b=B/6bAZnsAyDMRPcULeW2pCZLuS5rbzVqeSDX++LsTf9aK5lMPwyj2HfjEbqq5VU7UX
         0JZ5PfrVjtnNxsFCtq0rHnsrY7QTwHIaKsi17/FEZoyLuJeasjposlNs1TrSy5R3Ij3F
         MP/qW7QAc9tUWa4LLWeHnXLWWAd/MPa/hgmAvzQiwuGZuX0hA72zTHmWyCYou4MEA4lN
         qR6SKFt0cHkTazZ+j+6Ck3K8U5vykBCkBmpQrsYAUzHOe7IlNy2pnldfLOpFpKzLxQ6F
         /pTCyXAEJALlFpxDmTE7CrIa9QfmTTHljYlEJLWaUc5e3eDVO2AWe20kYoE1Ag0fOD8S
         4tng==
X-Forwarded-Encrypted: i=1; AJvYcCVZkHykl9CiTSfqT+E/VLTfxrWvOK/SY85J/s7HZxGTV2mWlHdADZTwAqEkZx74dFIW5LjcbBgoErpPgAMWP5wD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9HwCj4sJ0oNeKaTZN0RtSHGtRtbwSDIoN+WiSxwUTc6Kj6Uuq
	HcT8oOVoSfgvKa4ChQnuZP0zDE+ykl/1TaEn2/Ctk8I1j6BczIBqckihxqEtZM4dN90mX0J19+o
	T2wXd9UcxHQ==
X-Received: from dyw23.prod.google.com ([2002:a05:7300:8817:b0:2c8:fc92:6e72])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2315:b0:2c8:1d56:340c
 with SMTP id 5a478bee46e88-2cbfba8d9femr1972599eec.23.1775248871533; Fri, 03
 Apr 2026 13:41:11 -0700 (PDT)
Date: Fri,  3 Apr 2026 13:40:12 -0700
In-Reply-To: <20260403204017.2919994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fXDd2_uqRHGOrbbjsAjbunsW67P-kONsmhm6UZWQUc-2w@mail.gmail.com>
 <20260403204017.2919994-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403204017.2919994-21-irogers@google.com>
Subject: [PATCH v5 20/25] perf timechart: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel and so it is unnecessary to pass the
evsel as well. Add missing backtrace argument to tracepoint_handler
functions and mark them unused. Fix missing free from cat_backtrace,
which requires copies of the backtrace being made in functions that
save it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-timechart.c | 81 ++++++++++++++++------------------
 1 file changed, 39 insertions(+), 42 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 782ede4258a2..0db2a9bd5b91 100644
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
@@ -544,8 +544,10 @@ static const char *cat_backtrace(union perf_event *event,
 				 * It seems the callchain is corrupted.
 				 * Discard all.
 				 */
-				zfree(&p);
-				goto exit;
+				addr_location__exit(&al);
+				fclose(f);
+				free(p);
+				return NULL;
 			}
 			continue;
 		}
@@ -567,7 +569,6 @@ static const char *cat_backtrace(union perf_event *event,
 }
 
 typedef int (*tracepoint_handler)(struct timechart *tchart,
-				  struct evsel *evsel,
 				  struct perf_sample *sample,
 				  const char *backtrace);
 
@@ -578,6 +579,7 @@ static int process_sample_event(const struct perf_tool *tool,
 {
 	struct timechart *tchart = container_of(tool, struct timechart, tool);
 	struct evsel *evsel = sample->evsel;
+	int ret = 0;
 
 	if (evsel->core.attr.sample_type & PERF_SAMPLE_TIME) {
 		if (!tchart->first_time || tchart->first_time > sample->time)
@@ -588,16 +590,17 @@ static int process_sample_event(const struct perf_tool *tool,
 
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
@@ -617,7 +620,6 @@ process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
 
 static int
 process_sample_cpu_frequency(struct timechart *tchart,
-			     struct evsel *evsel __maybe_unused,
 			     struct perf_sample *sample,
 			     const char *backtrace __maybe_unused)
 {
@@ -634,7 +636,6 @@ process_sample_cpu_frequency(struct timechart *tchart,
 
 static int
 process_sample_sched_wakeup(struct timechart *tchart,
-			    struct evsel *evsel __maybe_unused,
 			    struct perf_sample *sample,
 			    const char *backtrace)
 {
@@ -648,7 +649,6 @@ process_sample_sched_wakeup(struct timechart *tchart,
 
 static int
 process_sample_sched_switch(struct timechart *tchart,
-			    struct evsel *evsel __maybe_unused,
 			    struct perf_sample *sample,
 			    const char *backtrace)
 {
@@ -664,7 +664,6 @@ process_sample_sched_switch(struct timechart *tchart,
 #ifdef SUPPORT_OLD_POWER_EVENTS
 static int
 process_sample_power_start(struct timechart *tchart __maybe_unused,
-			   struct evsel *evsel __maybe_unused,
 			   struct perf_sample *sample,
 			   const char *backtrace __maybe_unused)
 {
@@ -681,7 +680,6 @@ process_sample_power_start(struct timechart *tchart __maybe_unused,
 
 static int
 process_sample_power_end(struct timechart *tchart,
-			 struct evsel *evsel __maybe_unused,
 			 struct perf_sample *sample,
 			 const char *backtrace __maybe_unused)
 {
@@ -691,7 +689,6 @@ process_sample_power_end(struct timechart *tchart,
 
 static int
 process_sample_power_frequency(struct timechart *tchart,
-			       struct evsel *evsel __maybe_unused,
 			       struct perf_sample *sample,
 			       const char *backtrace __maybe_unused)
 {
@@ -865,8 +862,8 @@ static int pid_end_io_sample(struct timechart *tchart, int pid, int type,
 
 static int
 process_enter_read(struct timechart *tchart,
-		   struct evsel *evsel __maybe_unused,
-		   struct perf_sample *sample)
+		   struct perf_sample *sample,
+		   const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_READ,
@@ -875,8 +872,8 @@ process_enter_read(struct timechart *tchart,
 
 static int
 process_exit_read(struct timechart *tchart,
-		  struct evsel *evsel __maybe_unused,
-		  struct perf_sample *sample)
+		  struct perf_sample *sample,
+		  const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_READ,
@@ -885,8 +882,8 @@ process_exit_read(struct timechart *tchart,
 
 static int
 process_enter_write(struct timechart *tchart,
-		    struct evsel *evsel __maybe_unused,
-		    struct perf_sample *sample)
+		    struct perf_sample *sample,
+		    const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_WRITE,
@@ -895,8 +892,8 @@ process_enter_write(struct timechart *tchart,
 
 static int
 process_exit_write(struct timechart *tchart,
-		   struct evsel *evsel __maybe_unused,
-		   struct perf_sample *sample)
+		   struct perf_sample *sample,
+		   const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_WRITE,
@@ -905,8 +902,8 @@ process_exit_write(struct timechart *tchart,
 
 static int
 process_enter_sync(struct timechart *tchart,
-		   struct evsel *evsel __maybe_unused,
-		   struct perf_sample *sample)
+		   struct perf_sample *sample,
+		   const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_SYNC,
@@ -915,8 +912,8 @@ process_enter_sync(struct timechart *tchart,
 
 static int
 process_exit_sync(struct timechart *tchart,
-		  struct evsel *evsel __maybe_unused,
-		  struct perf_sample *sample)
+		  struct perf_sample *sample,
+		  const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_SYNC,
@@ -925,8 +922,8 @@ process_exit_sync(struct timechart *tchart,
 
 static int
 process_enter_tx(struct timechart *tchart,
-		 struct evsel *evsel __maybe_unused,
-		 struct perf_sample *sample)
+		 struct perf_sample *sample,
+		 const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_TX,
@@ -935,8 +932,8 @@ process_enter_tx(struct timechart *tchart,
 
 static int
 process_exit_tx(struct timechart *tchart,
-		struct evsel *evsel __maybe_unused,
-		struct perf_sample *sample)
+		struct perf_sample *sample,
+		const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_TX,
@@ -945,8 +942,8 @@ process_exit_tx(struct timechart *tchart,
 
 static int
 process_enter_rx(struct timechart *tchart,
-		 struct evsel *evsel __maybe_unused,
-		 struct perf_sample *sample)
+		 struct perf_sample *sample,
+		 const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_RX,
@@ -955,8 +952,8 @@ process_enter_rx(struct timechart *tchart,
 
 static int
 process_exit_rx(struct timechart *tchart,
-		struct evsel *evsel __maybe_unused,
-		struct perf_sample *sample)
+		struct perf_sample *sample,
+		const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_RX,
@@ -965,8 +962,8 @@ process_exit_rx(struct timechart *tchart,
 
 static int
 process_enter_poll(struct timechart *tchart,
-		   struct evsel *evsel __maybe_unused,
-		   struct perf_sample *sample)
+		   struct perf_sample *sample,
+		   const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_POLL,
@@ -975,8 +972,8 @@ process_enter_poll(struct timechart *tchart,
 
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
2.53.0.1213.gd9a14994de-goog

