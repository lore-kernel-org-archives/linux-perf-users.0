Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3D5395D80
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658887; cv=none; b=Kx9qzAUIjPc47yp3DwrRo47I4DQJ0NdqQJFckiIEaHYxhp1v6EUgxXCY7jZJzMmRT6idSqa28uHQEsaw67bsD7bzf/XopxneWq5vZ2bQWG6rhI86PPrZb/mBxWxq/9V0wECEN/gV30Vtl6bkYDViStTMZ3f1HdywQty7bcadKuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658887; c=relaxed/simple;
	bh=iKfucuoq4fC7+9dAli6wr6MGhdZwXtov5hIDvfKVRkQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ISTa7m4iuQ/ZLEytqOv6qcJ/NMUwesP+UfmERAqqSVsO5Cim+3C+69IVISnLU+ytcZ4juZhdwrw/mq0XpbQl1sK/f8GmMjIp0kn3+VfY/RCwLRXHdpdyvljYp6oJFgosJjGk2OW2ecuC2eyi14i6JW8FlEVhqekBXYfe+Hqx79c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZMEVfUdU; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZMEVfUdU"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1270e3704d6so16723683c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 09:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658886; x=1771263686; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EKkXHh8kQIQTC6XgAP/I2lhtEuG40HP3Ck2zRwIvF4c=;
        b=ZMEVfUdU0yVni4qqxc5rbfAYmFcBQPMPnQ4nqAVY0CBhlJuuwjjk7J3GMbWEk6l5or
         l0Vq52nTVxiwdKFS6Q5u1TtwGwYTdCjR+NXGx2ac2XQPMK4PzUqhVBsHyUMwPCflLl+M
         2x4ZPGwkAzNl2CeiXbp0xqq8np39yPkt2d/6kf7EsXDFi4j9cla0dACr0hxn35rVkrBz
         taYaPIvfrPHXJmikw27olNX7iAAaQbEap9mNSND+QYngirnDEf3BztbFzJ7VaPOC7LGZ
         ENpxqGsvSA5tFqtgmJHEfNi/oNWCIfjGu0skNJ1lltFk1TXA0qS2+jlJuAqjJsUWbfsk
         XCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658886; x=1771263686;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EKkXHh8kQIQTC6XgAP/I2lhtEuG40HP3Ck2zRwIvF4c=;
        b=hxjVuv4d6HaNY9F5jP1WkPmEYMXl+ccakWJfZYDCnXFQtWGzns0hH8ZDEhmJyNRQNe
         d7O4XFj4HvXi8UQQOnDwqb8kDFKV+VIlk04Q8Fy29LCbyJZfuadNQdl5yC3hvLILk4RG
         +YHOBLilvyIBFFE+xuBNlvMRtz5NuDxN5lJwM23kgIbP+uzktTNO3PPm15bPdDyz9wEy
         O76Fi4dOfMInVyGfV8+ymaMRmtXtJ83icNiBTHETy9kiiR7qhMhTivvuypY+XCAnXduZ
         sKrZnuy3kOdQbTdE+ZgLpfyUatMhePjzgJe06KhfZWR9tWwx8CkJGCdF58oNEARmH/+s
         Iluw==
X-Forwarded-Encrypted: i=1; AJvYcCWzrZagiOI4Ns3MX8NegTuoSghx4hviLTBn0xBfCgTTJjTjNhYjyPy4zBSa+9LQZndhlAiuLD4EXtFQ1wrYIPn+@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ+2vg7xTxVqwiZVzKmNWlxqgSeBYvhnfWnr4ECfy4+QWS92rG
	u9vPcr5mML/xCiVDyrlOQVoPD4inGS+hnDBBcpMlUXMQH/lAtNhnjFLqtL3nT6IiaUXIwwHGifa
	5B8fg2sGb1w==
X-Received: from dlj11.prod.google.com ([2002:a05:7022:50b:b0:11b:d4a7:e833])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6ba9:b0:11b:c4ee:66b
 with SMTP id a92af1059eb24-12704178963mr6220044c88.37.1770658886062; Mon, 09
 Feb 2026 09:41:26 -0800 (PST)
Date: Mon,  9 Feb 2026 09:40:27 -0800
In-Reply-To: <20260209174032.4142096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209174032.4142096-21-irogers@google.com>
Subject: [PATCH v1 20/25] perf timechart: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Leo Yan <leo.yan@arm.com>, Tianyou Li <tianyou.li@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, tanze <tanze@kylinos.cn>, 
	Hrishikesh Suresh <hrishikesh123s@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Chen Ni <nichen@iscas.ac.cn>, Blake Jones <blakejones@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel and so it is unnecessary to pass the
evsel as well.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-timechart.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index b3f2ce52938d..d98c0b50e93f 100644
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
2.53.0.239.g8d8fc8a987-goog

