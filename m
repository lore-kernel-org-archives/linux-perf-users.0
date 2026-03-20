Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AAC371862
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994160; cv=none; b=oulfej40es21VnEsvnkIRC089O63ixmGiaEzxduNQhwpFFdmY7rSmyrKagSU8uuZiy8Hvws2teWNQBPnMm49HsxopwAY1R58+Vmma4bm3AXav+lO4SGs22KzfmjBUaJZDG92Nqem8KMufQb4rZOvYq+XFPOxY+px26MLyE3bybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994160; c=relaxed/simple;
	bh=kWFWhMGBuKqPkxq8wPChNpXge6j9wria8UeiTyOVIDc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KOrmLaaLb8+qxan8lA3QHHEKSrdUtc4tJA+dWcev2oomTRJQzgXTVL2YFMSzTkvfyjQX+6paO/fDTXQniiER/la54XnOqfKDWJydjUPEQQBaYJYfa1QPeCxliMO84nxfdAOYiJNeu++1elFTK7ENXo0HaRuFOvg6ScROUMS1KHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=reXG+Bx7; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="reXG+Bx7"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c1030ca85eso13988266eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 01:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773994159; x=1774598959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U85Lmoe7aYDk2IczNDDGSGGcR0kKHWibUp1+6PVf+pI=;
        b=reXG+Bx7EhvdWbMX8Qat6GnvB0dPx0hW7e5yRYOIifbOz9wKb8qp1tTG3uJIJk2Lj4
         rLUxbGmTZfapHt4IQpy9FZZYAvI2D+hwVunQ/Wq84B259Abfkqi9Lx9anBWNBXfnMlzo
         pMeRcyXnQI1MN7KHLPk+DLl3lGRW5PCABowlglhszXMuMEYMRnESmT6UJWwda9xvBbIf
         DbrhoDnskpbFnVfDY1G+PqFRrWO9P1nntoqAeqC65XTdOwhZVREQm8VXooPXtMW4EeCU
         cHPTpuAVh7zOu30+RC3sDyCUY5x+1sk28pLF60//SNPkwR8X40dyUYrUbEV8eYUS7KLU
         Ct8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773994159; x=1774598959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U85Lmoe7aYDk2IczNDDGSGGcR0kKHWibUp1+6PVf+pI=;
        b=lu5NsxACF8iJxYymOa9UrV0zXmlKgZK5YJOU/jtGSAFpMvLAUq8m2HKWD1rNTcCuoT
         5oeG0toda9/BLem/Uybdr+NG7D+K3o9JnwH24ppjm6ylQ7nigFcV7YsxhLcGtFmKEVtE
         6EkoDz/uefgHHh0Ccj6Rjn1W4nYt8S1Kg4IlzO3DFVtc4MVqqcLitP/CFGhuRDAD0YDs
         N+l5CQM0eBTgKhPpXLRL3w+yRwBcRgagL9GuDogNAt9L44ZC8fh5GsUHt5b9yiLnHU9e
         fSqAjH+gj+NNwOcRLfM7kd7uLLyG74LuMvfuYr1962nZ6+vDsRgRg5nsZys6+ZtlfEJP
         05DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN60UGb1sByuHM80+WGzyL05TV8uC5eQ7VDqt5pWRIpGrSJ6fQgqPRPx2f596MHiUS10acC2sKNXF+Nd7/gFH5@vger.kernel.org
X-Gm-Message-State: AOJu0YyD475uhiTxJzHFHyiYIToxC6viLlxpO5jTIPTNMbpxzhW36/89
	K8Cwy1UqVw8xK6ChbhMLJ2fJ3PwJZTnCy61frhpMN13I6KhWuZsEqmQTCIYvxLUdKYEjhAxEXke
	uoDdDENRP1A==
X-Received: from dybta13.prod.google.com ([2002:a05:7301:6f0d:b0:2be:b4eb:b056])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:3886:b0:2ba:a1f1:2879
 with SMTP id 5a478bee46e88-2c1095fec8fmr1181347eec.13.1773994158384; Fri, 20
 Mar 2026 01:09:18 -0700 (PDT)
Date: Fri, 20 Mar 2026 01:08:26 -0700
In-Reply-To: <20260320080835.724836-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319232334.287517-1-irogers@google.com> <20260320080835.724836-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320080835.724836-18-irogers@google.com>
Subject: [PATCH v3 17/25] perf kmem: Don't pass evsel with sample
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
evsel as well.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index df3bfb8fd9c0..6dbb2b2f1f59 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -171,7 +171,7 @@ static int insert_caller_stat(unsigned long call_site,
 	return 0;
 }
 
-static int evsel__process_alloc_event(struct evsel *evsel, struct perf_sample *sample)
+static int evsel__process_alloc_event(struct perf_sample *sample)
 {
 	unsigned long ptr = perf_sample__intval(sample, "ptr"),
 		      call_site = perf_sample__intval(sample, "call_site");
@@ -198,7 +198,7 @@ static int evsel__process_alloc_event(struct evsel *evsel, struct perf_sample *s
 	 * If the tracepoint contains the field "node" the tool stats the
 	 * cross allocation.
 	 */
-	if (evsel__field(evsel, "node")) {
+	if (evsel__field(sample->evsel, "node")) {
 		int node1, node2;
 
 		node1 = cpu__get_node((struct perf_cpu){.cpu = sample->cpu});
@@ -243,7 +243,7 @@ static struct alloc_stat *search_alloc_stat(unsigned long ptr,
 	return NULL;
 }
 
-static int evsel__process_free_event(struct evsel *evsel __maybe_unused, struct perf_sample *sample)
+static int evsel__process_free_event(struct perf_sample *sample)
 {
 	unsigned long ptr = perf_sample__intval(sample, "ptr");
 	struct alloc_stat *s_alloc, *s_caller;
@@ -751,8 +751,7 @@ static char *compact_gfp_string(unsigned long gfp_flags)
 	return NULL;
 }
 
-static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
-			   unsigned int gfp_flags)
+static int parse_gfp_flags(struct perf_sample *sample, unsigned int gfp_flags)
 {
 	struct tep_record record = {
 		.cpu = sample->cpu,
@@ -773,7 +772,7 @@ static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
 	}
 
 	trace_seq_init(&seq);
-	tp_format = evsel__tp_format(evsel);
+	tp_format = evsel__tp_format(sample->evsel);
 	if (tp_format)
 		tep_print_event(tp_format->tep, &seq, &record, "%s", TEP_PRINT_INFO);
 
@@ -805,7 +804,7 @@ static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
 	return 0;
 }
 
-static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_sample *sample)
+static int evsel__process_page_alloc_event(struct perf_sample *sample)
 {
 	u64 page;
 	unsigned int order = perf_sample__intval(sample, "order");
@@ -845,7 +844,7 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
 		return 0;
 	}
 
-	if (parse_gfp_flags(evsel, sample, gfp_flags) < 0)
+	if (parse_gfp_flags(sample, gfp_flags) < 0)
 		return -1;
 
 	callsite = find_callsite(sample);
@@ -886,8 +885,7 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
 	return 0;
 }
 
-static int evsel__process_page_free_event(struct evsel *evsel __maybe_unused,
-					  struct perf_sample *sample)
+static int evsel__process_page_free_event(struct perf_sample *sample)
 {
 	u64 page;
 	unsigned int order = perf_sample__intval(sample, "order");
@@ -964,8 +962,7 @@ static bool perf_kmem__skip_sample(struct perf_sample *sample)
 	return false;
 }
 
-typedef int (*tracepoint_handler)(struct evsel *evsel,
-				  struct perf_sample *sample);
+typedef int (*tracepoint_handler)(struct perf_sample *sample);
 
 static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 				union perf_event *event,
@@ -990,7 +987,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
-		err = f(evsel, sample);
+		err = f(sample);
 	}
 
 	thread__put(thread);
-- 
2.53.0.959.g497ff81fa9-goog

