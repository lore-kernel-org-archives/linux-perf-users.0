Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1D633A029
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303979; cv=none; b=ji0CR4MLfUu3ucirPrrJ5OKxE4qiuo+QuGq3QDiSgLa3PPTQdfFLR5126tHoAeV33KSiaYfosHTrRBZltl6tZ2M12TNezILJulP/1tpHcLuwsD2wwmdxt17hkfxbc30bPCF1m+XD9SB4eDEqlV1y8UPw5EWmo65Rsrwmx4sTShc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303979; c=relaxed/simple;
	bh=msjTJonVSsmxJ2FlfT5g6R7MyTJyTXNXkO8ABgtmVNA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=omt7xlLiJ5m953KyJt4SjKKQNWD1S/kYDYV9GVI/BfoS7uHLC8aqIHr41rTwSblhj4F2yHyGOgDCAsLAdCvtt5Ko7DNsW69uySuGOQ5ZDCvBY7F08HTdEzekVZWRGgU237TVrm9+VghirgsIr3p5y/aLeB50EsRCyBg455pdmko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ryfenANx; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ryfenANx"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdd327d970so2688717eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303977; x=1779908777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AaDG6CGddNhroF5AenYoE35W55I+agW9Ro3uGoIUh/Q=;
        b=ryfenANxjGLWgPRKNuxGoRmK76bWkVu/LKGEvZKNbDirsDqCGN3Ykt6Q/LnOyleR8f
         LIsBkF2O5y6gLFrYLYOeqlRtOQ9H2L6oX/seLqcVpRED5L7E2um6R3NyBlGh0hG6dIFX
         yNHJsWtjfy1Fhee9rHJ+8/tjFT5iVCLOmpcfqF/hwHDY+mUE+EKDdXpL8yu+ukTaOmzC
         39WtolbXf8FpSnIZoapvds9qQpuqGrsfqlVi8J9hK9PCNGn0rSj/yMH20UqCWvs1lnI1
         a+qCyqu8Sr4Pwfw63bSy7Og1K0Wl2Ph1HGbj12uz0H2j9RMil1EpYbIgBURO1OUW/+f8
         fwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303977; x=1779908777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaDG6CGddNhroF5AenYoE35W55I+agW9Ro3uGoIUh/Q=;
        b=S0b8XH479ZWah9K498sUftcfctL5e+Mnt7D4LobLJKiCk7+fAjgVqW6vLm5VvR/GTv
         GiBCldfW3/Uriln0ux5kYiKzi5mF2C4dpkBLadn5xrSlwjjOjhmz6ytiLDFGVBsoIs7w
         XaMMhWn0xo6h4Y9WLBlNiS1mp9Yc+SQ9zKgbVGqnzcMjuiZuWCHmaBZ3q2/0q36QE1UF
         nRQkrjNuaF6lpgp9g3ICN9hL+R6KsaJl+2eJyLyFJYXlzz/qnLQKtLu9TQJboNmViQoF
         l0SYoxiciOp5aTQpwDj14YUkpbvjyMd7Ex9zTgZd/Kd1U1g2MAUG8tFNDXXA8vJZtzz9
         J7yQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Iwpy2tWwXJTjfFukQT20RUf4Pq9+eSy8oft/s6r/lms8mKw/5JSoyHrCadgRYPTmJaPToK20G8QZ1bEz+QQ2f@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqe6IyhTLmwmCj/SNmyjLMx6KeadTW74R8XTi8UvnPy5X2j2RH
	dtMRRwZiffYUaK4oUwkuZMSJyIRFOMn/OxcJVD00LscHuXVwbiCRGv35pkT/Nnvw8nzkwSRMTnj
	dvYMLa9/1mA==
X-Received: from dybmt5.prod.google.com ([2002:a05:7300:d585:b0:304:4d0:2f4d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1923:b0:2c1:67e1:61a9
 with SMTP id 5a478bee46e88-3042b3e2951mr349111eec.13.1779303976297; Wed, 20
 May 2026 12:06:16 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:22 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-17-irogers@google.com>
Subject: [PATCH v14 16/32] perf timechart: Don't pass evsel with sample
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

As struct perf_sample now directly contains its own resolved evsel pointer,
passing the evsel separately is redundant and clutters the interface.

Remove the redundant evsel parameter from timechart-specific handlers and
structures, ensuring the tool always directly accesses the evsel bound to the
sample. This simplifies the API signatures and eliminates the risk of passing
an inconsistent evsel.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
2.54.0.746.g67dd491aae-goog

