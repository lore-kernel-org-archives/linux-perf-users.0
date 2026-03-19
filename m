Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE39411617
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 23:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962690; cv=none; b=m6jXiyxFlh0xkzmLEg9JXAqnbL/EfGo9P0AJ2NzIq3NNwU9yeAjLsKWWDwaMZNlrjyrYKeujOXq4vluRVVybi9TEimxq8ULtKrrgdUzhPrLzgWJk8hjmDQ/nneTJIKCv8r2o3Yu6my0u/vW4QN3vdCZGBeM2S3HymM4ryRQrFWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962690; c=relaxed/simple;
	bh=P8KDmNQFrM0XR+mgWRTGutdGK2cdbUvdj6uQlGb++3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ph/EVAdoe+MxuQ7/87d8JDDx1geaYQkU8ZEwCMetOHbXWFrfZJIpiLWetFGCW4UkSSXKq/2tcdqraGCTrCSstpFMvV2Mxs09qi48zoBZuN1tpkoc0XkHYsuxdhYFKgwLcW9IEp1j34l18I8lPF+Gz+4ZkdL3BeHRIZRQwLqt3Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qKBG0kiI; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qKBG0kiI"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-127133794b6so1319871c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 16:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773962687; x=1774567487; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqHnahhuT1GAymhjowNR84SadXg0EkK+QwbF+RTjHSA=;
        b=qKBG0kiIuGSN4DtjgSCDKF3zdqanHEpK0fm4AjhAuh4FS+V3orqf/OVQb/QRPSu3HI
         ChIcb79CtfxP4NEqo5URaky+b0RpZzGGkR1JBA9Frv8X52dc9D52EPg4jQqPIU5pfLQr
         yWseC+jOIXkP1xY3PddC8mLvHOjucocjy1NTS/I+SrRii07PNyGVtk/tndOTwEfnPV4d
         X2te7yTxezw2UOHx8lXmBbq5gQDF1F3opcNAoKpgmm1QvKt24OCLZP5jZIi/sJPjffCt
         dmsxcI8ap3jcTTmiW2a8fQlGjl0O3au79ZJfL6vNxXw22Hbvt1Zh2eq1YfKQ7yKIC1AE
         VeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962687; x=1774567487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqHnahhuT1GAymhjowNR84SadXg0EkK+QwbF+RTjHSA=;
        b=XxKqULUaeuKvvL1SKwqygkWtAbsvIf9ymmmOOWYTLJCsWCrC7x/oFc8c8dCN6qvuWR
         RTcEwtQhXGqS1kXENG+F6f9+s8zUiYaBaxudiImVf2ouoKkQJQlGYl4Xy/H5ZVVAuiV2
         45gEWmiAlYYTbRMJp5NG9RaqeJffn1+HQJGWZjtLNSDVEyUsI6MAi9MI8JJ/BA3nD3lF
         cFTPyxfzywLo3+KtNjgUK/3+SyTuM2OAFOJM5hBTD206iOXIMbp2dnWK2hrqvEx940w0
         Et/6zP5AX4xnJn4fjjDXxVAo6zXyJm7fTANN/k2rR+4jcnTH5Dz01I8x6mBUZEM6E7lV
         aHeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtDohw1FEzT/wpQtVKpnK82SQf6/fLjbb566EbHuYWLUl4IIyHWvSiXeBgMWfxL0GUoY3zIusIb4IvqPqBaIK0@vger.kernel.org
X-Gm-Message-State: AOJu0YzR2y1bopNKo/NpEbPye8hLYbfuu/qUbrXIgo5IcXeSXjBY+M8O
	JgqIBz9wGNmlI75iXX4pi3xSSnXWp6V2w/daQh8QtuKCmZYob3AiM6Qbdt56VD2swtE4aHTiJ0/
	DJ/603hTVsQ==
X-Received: from dybgi3.prod.google.com ([2002:a05:7301:83:b0:2c0:fbcb:769c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e2cb:b0:2c0:dd99:f11
 with SMTP id 5a478bee46e88-2c1097589e5mr602979eec.22.1773962686434; Thu, 19
 Mar 2026 16:24:46 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:23:29 -0700
In-Reply-To: <20260319232334.287517-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com> <20260319232334.287517-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319232334.287517-21-irogers@google.com>
Subject: [PATCH v2 20/25] perf timechart: Don't pass evsel with sample
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
evsel as well.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-timechart.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 034e0ba3f9cb..de551c9d3053 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -567,7 +567,6 @@ static const char *cat_backtrace(union perf_event *event,
 }
 
 typedef int (*tracepoint_handler)(struct timechart *tchart,
-				  struct evsel *evsel,
 				  struct perf_sample *sample,
 				  const char *backtrace);
 
@@ -588,7 +587,7 @@ static int process_sample_event(const struct perf_tool *tool,
 
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
-		return f(tchart, evsel, sample,
+		return f(tchart, sample,
 			 cat_backtrace(event, sample, machine));
 	}
 
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
@@ -849,7 +841,6 @@ static int pid_end_io_sample(struct timechart *tchart, int pid, int type,
 
 static int
 process_enter_read(struct timechart *tchart,
-		   struct evsel *evsel __maybe_unused,
 		   struct perf_sample *sample)
 {
 	long fd = perf_sample__intval(sample, "fd");
@@ -859,7 +850,6 @@ process_enter_read(struct timechart *tchart,
 
 static int
 process_exit_read(struct timechart *tchart,
-		  struct evsel *evsel __maybe_unused,
 		  struct perf_sample *sample)
 {
 	long ret = perf_sample__intval(sample, "ret");
@@ -869,7 +859,6 @@ process_exit_read(struct timechart *tchart,
 
 static int
 process_enter_write(struct timechart *tchart,
-		    struct evsel *evsel __maybe_unused,
 		    struct perf_sample *sample)
 {
 	long fd = perf_sample__intval(sample, "fd");
@@ -879,7 +868,6 @@ process_enter_write(struct timechart *tchart,
 
 static int
 process_exit_write(struct timechart *tchart,
-		   struct evsel *evsel __maybe_unused,
 		   struct perf_sample *sample)
 {
 	long ret = perf_sample__intval(sample, "ret");
@@ -889,7 +877,6 @@ process_exit_write(struct timechart *tchart,
 
 static int
 process_enter_sync(struct timechart *tchart,
-		   struct evsel *evsel __maybe_unused,
 		   struct perf_sample *sample)
 {
 	long fd = perf_sample__intval(sample, "fd");
@@ -899,7 +886,6 @@ process_enter_sync(struct timechart *tchart,
 
 static int
 process_exit_sync(struct timechart *tchart,
-		  struct evsel *evsel __maybe_unused,
 		  struct perf_sample *sample)
 {
 	long ret = perf_sample__intval(sample, "ret");
@@ -909,7 +895,6 @@ process_exit_sync(struct timechart *tchart,
 
 static int
 process_enter_tx(struct timechart *tchart,
-		 struct evsel *evsel __maybe_unused,
 		 struct perf_sample *sample)
 {
 	long fd = perf_sample__intval(sample, "fd");
@@ -919,7 +904,6 @@ process_enter_tx(struct timechart *tchart,
 
 static int
 process_exit_tx(struct timechart *tchart,
-		struct evsel *evsel __maybe_unused,
 		struct perf_sample *sample)
 {
 	long ret = perf_sample__intval(sample, "ret");
@@ -929,7 +913,6 @@ process_exit_tx(struct timechart *tchart,
 
 static int
 process_enter_rx(struct timechart *tchart,
-		 struct evsel *evsel __maybe_unused,
 		 struct perf_sample *sample)
 {
 	long fd = perf_sample__intval(sample, "fd");
@@ -939,7 +922,6 @@ process_enter_rx(struct timechart *tchart,
 
 static int
 process_exit_rx(struct timechart *tchart,
-		struct evsel *evsel __maybe_unused,
 		struct perf_sample *sample)
 {
 	long ret = perf_sample__intval(sample, "ret");
@@ -949,7 +931,6 @@ process_exit_rx(struct timechart *tchart,
 
 static int
 process_enter_poll(struct timechart *tchart,
-		   struct evsel *evsel __maybe_unused,
 		   struct perf_sample *sample)
 {
 	long fd = perf_sample__intval(sample, "fd");
@@ -959,7 +940,6 @@ process_enter_poll(struct timechart *tchart,
 
 static int
 process_exit_poll(struct timechart *tchart,
-		  struct evsel *evsel __maybe_unused,
 		  struct perf_sample *sample)
 {
 	long ret = perf_sample__intval(sample, "ret");
-- 
2.53.0.959.g497ff81fa9-goog

