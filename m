Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F91B238C0A
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043391; cv=none; b=kXsHqf2DDBsj2hvOdJTQnaLTP22xdwi6YNFurE1RxbW/rl1xQUysGdFb5pkxOsxKSjWeHJeZNtZpz3HYB/rbC4CdEMiFlkalxf+uU81JJlCTeNNyL5NJEwgmYPrVJY7H6OQj5a+plUNWAknBPOJvqowZgmDprERXN3sIcWkhc+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043391; c=relaxed/simple;
	bh=Pp17mH3cyPs8wClDF436l++iCbJL7V577K67JvRUutU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lg+xr3gHorz8LBDbi7dyOqQGwoxaLzmlOQemKWpebPpLI73O+thAYmqsjMwe3L1W6mRefmszBkl7IgDtFIgBJmse4AHTiL5vvzq3uhSkP2O3cDOYPc8xESlly4/nPkXxJu8uedtPd4W0Daw0Az3HZGwXSgQpdAbJPlEhj5FfoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MmJTd1vs; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MmJTd1vs"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d443c3b094so8550851eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043389; x=1776648189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nq7inTgObUkJQusjbZywjT67pBRs4vv79SY6QidR5y4=;
        b=MmJTd1vstdfU7Bs7UTeffJ9e6c3H2N5vc8r4lpA23ZGXnbvM+IuKfc9jkzAGaRYed5
         rUEHl9Rl1lP1lpDFIevkZplRX8OveORPBvwLhTeuvYlOHyCtqGbK4xSQzmNkeAoOuySm
         jhYbjAuJ0xVue2oVj2tbU6RSOckpl+XI8e5sUXpq+upnyaXPE3gUjpLElxPCIiFd2RJt
         O6I7cdyQHSl1Dh2YuVzZJH+xsHapWtgaC5yu2h9zS+qCbp9rbULgxFKJiEjs9cTMbpf4
         +72kzwzc/PritZUFsxcktxKlCyXdjderI50jT2snlfa3D1XIxkSqnGOE9Oj7/TG1s4Rh
         BvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043389; x=1776648189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nq7inTgObUkJQusjbZywjT67pBRs4vv79SY6QidR5y4=;
        b=eDawVNRCR1XdcrjpvFJWsOVaFVdABtgBuybbyw0H2EqIYOZhCvToPSs/rniNtLEaZV
         bjfVXk9S9vkBJUq6sK+SNjG1t+TTZaEICFmSlQZxwYzqVzpO3lCzBc7aY5TI15rEvE4F
         bKgXeat2YY91eh2wjAop/SnGRAzGAq5YAUnjofAEylUJGlKNhbI9aJcKj/lthNdhsIkh
         4cUDduZd1eq53E7aZM4Imi4TDbFDvPmAgAKES5PSLanZ17l57Qsi9H68tE96GSi6LCCa
         XERVcoJd9vYEUQqkklYjGYIYTdCwtys2yDcFk3dXAJHvHm+bDY633xF4aetJ5CNDzame
         agbw==
X-Forwarded-Encrypted: i=1; AFNElJ++mE1GH58ssJQkQI155abvL+I21iEtVVWqM0by9WqdcKjvGtA7VB29NuR8y0cwGweHCgH7iKY+9IdnTmJQTVwR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9rQ6ZFI5AyHhexfb5iAe6por4ZiIM7sXz18fDPzXr8i25SvMq
	3CMHY7qK08NZl+WB7FubxzqIk0dCYrjCmqmTvZlICKOqKvUiZdRafo9RBflUnDdpP0LKxjcbtxt
	/+r9C1q+uAw==
X-Received: from dycnr23-n2.prod.google.com ([2002:a05:7300:e9d7:20b0:2d8:6e2f:8c6a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e82c:b0:2cb:990a:b5e
 with SMTP id 5a478bee46e88-2d5881acd8dmr5868004eec.15.1776043388353; Sun, 12
 Apr 2026 18:23:08 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:22:11 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-18-irogers@google.com>
Subject: [PATCH v11 17/33] perf timechart: Don't pass evsel with sample
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
2.53.0.1213.gd9a14994de-goog

