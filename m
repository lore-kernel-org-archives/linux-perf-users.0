Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8879C37F8D4
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053557; cv=none; b=ml9+YZjrYl8WBf1tEprXqr0tEo9Y2OP2oaa3LIKvwrr9zON5P6SaVpkdI58Xw+NweTNwgU+QNpxfmqhlmCLnjl+/k6RAxyYn9GdZRyRoC4DrJm4nVORHudXL4lLUB1xPKuOlYAD55I4j9otSm8RDl9xgQLCEhfcEk1TVPj0jSmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053557; c=relaxed/simple;
	bh=495v7vwy/bxdki64nsuLUq2VLnkw+FqQnijSjVyewWk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zcf70IJQNVTwIZ2IJZ1x8v2Rukg3ix4ztY57Wf3hHiG9cVFO00FFh7S7Y+5KKCQFwhiotQL2l5SUrjcfT/cujsjJUw6gEVvFfNf7l9RQ3Bmpt9foGCh4GZB2vJRp5fj7qFt9maFdu7CpqrlcgPvlPeEw7jRLJxxIaPgUdBw+kJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QxFZMLK3; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxFZMLK3"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b458add85aso8313415ad.2
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 21:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776053549; x=1776658349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TdCCiiHDf0G456jnJXOkKokcXFcoaXYbGwyy1xI9gh0=;
        b=QxFZMLK3qmpziW9EJBM67GxbyIpffuE6fPf3fEgGVecGV+YvxHga4mPPBHCaXTR02B
         gmW5xLHbiU99HMziJw4Ehr9OgmVQ6po5jzddl1H97FAKAeiVZGLwn9E0vUcn4yAIDdaW
         wo5PZ3g6KflNMBVpdONHX1E2sY+5rDi2fVaphlpuAIND1vJNT90xKXttuiSFFdWptKoq
         TfkhstLsBKcjovKX2hMbD7rmzzX1GOnbD0FqlJmXosypLqO8+8L+4RUQNRmm0R6QkHHd
         A27qIgsKgLi9Acys+mWl2j7uUJ3ilPCojdFG6oY+ATi3Mksp3d/Q5Fi83pJcsg09D3C0
         dypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053549; x=1776658349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TdCCiiHDf0G456jnJXOkKokcXFcoaXYbGwyy1xI9gh0=;
        b=tPr1VCD2JwFg/2Ls1OKNMrSM2nKeCRzbSHrWvwVJrb1E1fzPLuQbBqkIlPaPbm8+g9
         DFqd+S1tlywJ8xxv1sXSaQx33VhmHfIGOlzBlynn/cz4OiCvIynYFfm+P/QNyrWPZP4C
         2e1wk1nA8pewQhe7OgSGuA/FRQ29uQ9KDh8IbFAFj3LaaX6kUopEZbGrgCIAtmKpEc51
         K1Zn9aM+zXe36gapxCjSLmDlOWH71+LiF7x+mI9MLAdN1d4f+nBuFbh9o4811l0QW/2O
         7XjY3IrRYxVd/47lKIqacPSTtyTASpmHWyskHxduavyDp6/heb8flma+yTHWTy4632SJ
         dUOw==
X-Forwarded-Encrypted: i=1; AFNElJ81osfBGYOP6bJtd/LHIajoF0WNGTzjwyCbiLw8beAPkzz2H4H1k2L1g01kcQYaLSfTzg7LZrR2QeXRyFUDHxLs@vger.kernel.org
X-Gm-Message-State: AOJu0YzeUQcrbmACjl3dulS6DKZq753HaoUFBy8cpSvel7hAyKSs7KUx
	SJHt309Gv1hR7N/9caQgaaVHdsi8IiGDUqLT1zexNgtgAlPW3vB74Jc1ilIOC02xqIp/hOXw4gd
	p0nmHE1ZvZw==
X-Received: from plbkp8.prod.google.com ([2002:a17:903:2808:b0:2b4:6553:4533])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:6942:b0:2b0:4aeb:dedc
 with SMTP id d9443c01a7336-2b2d5a167c7mr85680495ad.26.1776053548825; Sun, 12
 Apr 2026 21:12:28 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:11:24 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413012227.1089445-1-irogers@google.com> <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413041143.1736055-15-irogers@google.com>
Subject: [PATCH v12 14/33] perf kmem: Don't pass evsel with sample
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
 tools/perf/builtin-kmem.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 2cdc56bc2616..68a39f56204d 100644
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
@@ -835,7 +834,7 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
 		return 0;
 	}
 
-	if (parse_gfp_flags(evsel, sample, gfp_flags) < 0)
+	if (parse_gfp_flags(sample, gfp_flags) < 0)
 		return -1;
 
 	callsite = find_callsite(sample);
@@ -876,8 +875,7 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
 	return 0;
 }
 
-static int evsel__process_page_free_event(struct evsel *evsel __maybe_unused,
-					  struct perf_sample *sample)
+static int evsel__process_page_free_event(struct perf_sample *sample)
 {
 	u64 page;
 	unsigned int order = perf_sample__intval(sample, "order");
@@ -954,8 +952,7 @@ static bool perf_kmem__skip_sample(struct perf_sample *sample)
 	return false;
 }
 
-typedef int (*tracepoint_handler)(struct evsel *evsel,
-				  struct perf_sample *sample);
+typedef int (*tracepoint_handler)(struct perf_sample *sample);
 
 static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 				union perf_event *event,
@@ -973,14 +970,15 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 		return -1;
 	}
 
-	if (perf_kmem__skip_sample(sample))
+	if (perf_kmem__skip_sample(sample)) {
 		return 0;
+	}
 
 	dump_printf(" ... thread: %s:%d\n", thread__comm_str(thread), thread__tid(thread));
 
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
-		err = f(evsel, sample);
+		err = f(sample);
 	}
 
 	thread__put(thread);
-- 
2.53.0.1213.gd9a14994de-goog

