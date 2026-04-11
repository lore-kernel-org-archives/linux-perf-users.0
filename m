Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E049132D0EE
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775890681; cv=none; b=Kq3ST79Y0eoF9QtVS+21uvFIB9mABaTlFPCtCio29KV045aLkyKHfyDlVssxTke0A5Xw0rrXvx8ZkbpFlDKR6/93Zkn27JxOekGJcXCOizJq5PTjQst79r2gmBtJCVuaW78+TFrDbm4kmg4nKsKxXzfhmWg5JszuvYSbtXrnjEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775890681; c=relaxed/simple;
	bh=wuj8eHDVqu0tfjx5SmZhqut/DywEnXDT6OJBHolpYag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C0NGF7nm4H2kpeE4Ox5kdpvHWjCHLDBmvNwK5zg7nrYjF36ABOtN8HSf2DBZ7jqJ+OB1MXwpSGqqGcwlw+qYIMZ+QKT9ni08QL7yctWqqu+qqiuMPTbkGpr/AWN8YG68bayq+x0yKGuKegVMh0IwkozhLCwHVqgjvuUYxN7LTzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cfg0Z8rk; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cfg0Z8rk"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d3a617ad90so8393571eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 23:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775890678; x=1776495478; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I094G/M3b5jYi7fA68w+DPTi9TUF14mA4YbtJieKwSk=;
        b=Cfg0Z8rkROewW/I4IXhenAkm8ZOqladTS0AsqUjU+u/QRtI3YJr1y9WmOuzz/2Unk4
         ScFz/Ani/B5FsAyjDUlUmd3lUr3ojg6rDLSBaxoS+rtV/e5iwsQENs+vJSCF5VD0tkqd
         FS+FbYc1zA9J1Wc6FtsM4ruYBgcg+tNfmgYph4VexR31l8n/C5yuvkeFrzRoQ6poouOo
         dv4uNKz3FMTSvLPqNaU0cG5t65es5pDhbKhaQoYxdHdgGdz0RdAk5x2gu4/+iTVXNYve
         5VB5wF1xj0qiXuEETRwuqk+Jdej2NwJhbuOGzfdj2S++nP7csJfTGzJHyual9Yh+zZMy
         X5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775890678; x=1776495478;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I094G/M3b5jYi7fA68w+DPTi9TUF14mA4YbtJieKwSk=;
        b=D3/+p0H0588TaFQ2rMJnuQMXAN6uOh4MBnNPFtpX2xaW/GEL8SiZ72xY9jC98MLfyV
         dXlSGcDs3Vq1/aF6rCAooLQjIrgVf2N5jbgw1YRU+AdAfATrxGsPkg1FbtrCnYrKOBwl
         s0FN2r+m//O/v3lFYjkgJoDVPAt7P31Lu3c0kNNJUkjTjfosdhY7tLzZbSeLW7PQ/MBE
         RxCdiLfXUGS+D4i+125ZShcn+38ryhorObyX46/TubYLUB+tp8pYRfkZERmLUjqukUeC
         AFaLEw1wdEbkpO6N+hopDIQ/SYIwdaw2hBAC1LsGyy22wAI7oOZPAQONZN0FEIIzUI7S
         QTEw==
X-Forwarded-Encrypted: i=1; AJvYcCXewskLtlo0kw4m3hVlQ08+miOmHv798b27r97Z2e6H2xjv4MaovT8KyEVAvoHm+dS+vP6WHyxAFhVBNf4/GwIx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3JbOxDdTygCxfuniuwoyXyxt8hZS4UFnRjnTUvP9oTPQ907RD
	XQzrfRxieEARvqtd5mInb83/jaqgqwKPYte8Cjp8Y3ghgEkQA1x97ZxOhFLT3fr6WcFlj6XUxUE
	JqYNHYOheSw==
X-Received: from dycaa26.prod.google.com ([2002:a05:7301:541a:b0:2d5:6cd6:c849])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a59a:b0:2cc:600d:2ffa
 with SMTP id 5a478bee46e88-2d589660db5mr3570377eec.16.1775890677762; Fri, 10
 Apr 2026 23:57:57 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:57:04 -0700
In-Reply-To: <20260411065718.372240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408072601.210837-1-irogers@google.com> <20260411065718.372240-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411065718.372240-16-irogers@google.com>
Subject: [PATCH v8 15/29] perf kmem: Don't pass evsel with sample
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
evsel as well. Fix memory leaks on error paths spotted during code
review.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 44 ++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 2cdc56bc2616..daf2272c7337 100644
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
 
@@ -784,17 +783,21 @@ static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
 
 			new = realloc(gfps, (nr_gfps + 1) * sizeof(*gfps));
 			if (new == NULL)
-				return -ENOMEM;
+				goto err_out;
 
 			gfps = new;
-			new += nr_gfps++;
+			new += nr_gfps;
 
 			new->flags = gfp_flags;
 			new->human_readable = strdup(str + 10);
+			if (!new->human_readable)
+				goto err_out;
 			new->compact_str = compact_gfp_flags(str + 10);
-			if (!new->human_readable || !new->compact_str)
-				return -ENOMEM;
-
+			if (!new->compact_str) {
+				free(new->human_readable);
+				goto err_out;
+			}
+			nr_gfps++;
 			qsort(gfps, nr_gfps, sizeof(*gfps), gfpcmp);
 		}
 
@@ -803,9 +806,12 @@ static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
 
 	trace_seq_destroy(&seq);
 	return 0;
+err_out:
+	trace_seq_destroy(&seq);
+	return -ENOMEM;
 }
 
-static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_sample *sample)
+static int evsel__process_page_alloc_event(struct perf_sample *sample)
 {
 	u64 page;
 	unsigned int order = perf_sample__intval(sample, "order");
@@ -835,7 +841,7 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
 		return 0;
 	}
 
-	if (parse_gfp_flags(evsel, sample, gfp_flags) < 0)
+	if (parse_gfp_flags(sample, gfp_flags) < 0)
 		return -1;
 
 	callsite = find_callsite(sample);
@@ -876,8 +882,7 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
 	return 0;
 }
 
-static int evsel__process_page_free_event(struct evsel *evsel __maybe_unused,
-					  struct perf_sample *sample)
+static int evsel__process_page_free_event(struct perf_sample *sample)
 {
 	u64 page;
 	unsigned int order = perf_sample__intval(sample, "order");
@@ -954,8 +959,7 @@ static bool perf_kmem__skip_sample(struct perf_sample *sample)
 	return false;
 }
 
-typedef int (*tracepoint_handler)(struct evsel *evsel,
-				  struct perf_sample *sample);
+typedef int (*tracepoint_handler)(struct perf_sample *sample);
 
 static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 				union perf_event *event,
@@ -973,14 +977,16 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 		return -1;
 	}
 
-	if (perf_kmem__skip_sample(sample))
+	if (perf_kmem__skip_sample(sample)) {
+		thread__put(thread);
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

