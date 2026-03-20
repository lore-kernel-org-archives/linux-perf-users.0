Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E383FAE0B
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034934; cv=none; b=MQ+2vhayQHmjgmNhg/XebRzN8yeMwiBikzgb1SdrwpNMUq0/BXXcvKWSE1H7jTF1Cf4m+DulhVOQef8HGd95pcXbSODK+JRpETXwKnSYurg4ZVul71aO0P02qPg7VA28t1FhVS47m/ORXErv5EkYq7gk2vtwSeqO8jpuwJPznJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034934; c=relaxed/simple;
	bh=CEzrpzKB5IgM/hwuaLjglqhHBaNyniUjqkDKSMp0k6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YGv5OBabsqby4amBpNz+0itPk3FuAERh0Z0/LEGHEHsf7TZ9TUehy0MYMlV+eftDeGp/FSfMxgCvrX171PaglbStgPR8iF+nwkYmNn0qzNsMasezStN12MBxeIFiP2Ue2blE4LAEB2a+60jvzn5tQOYlDd+QI6uAdz8vtN9Ubsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JXY37XV2; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXY37XV2"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35b901d542bso15119842a91.3
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 12:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774034929; x=1774639729; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yZrluTFZUT4tONIgqjkyumkc9DPApsGSP8KPJ2mvbkc=;
        b=JXY37XV2kVL+ZaA//EtFvFgZ7XAoaVRK5o4F8o6KFQz49J9zpS63FUh0rSGL7CMUBG
         sOfQkerbaz65gE64+7ds0JqyGRAJOlxENeb/rueadQAAgsR3NUV1a0g2nM4zr24NWZG6
         ho0IwVVlkWtDzu5Hzn9xi1eEhVKX4C/yeVTYTRogHekTkRm5BRvX0VdCzb/tJDEek3P7
         1glUO+icdoxsGu/dpcEfQ1JAko6jXnRGNsWDZ1eJCHdrLugBK1VqhgPnDHJTvWjgGtXA
         idvbCwecZKZQLEwvqniUILvk+inWSoGX1s+FFJayMQJzJueY4M8UUFXHf0vJ6nFFbXr/
         afuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034929; x=1774639729;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZrluTFZUT4tONIgqjkyumkc9DPApsGSP8KPJ2mvbkc=;
        b=n3VdV/Cdu2WkPMXLAYorYPHpm56AU/RGHOW3THbaasxWaKr2djMpeUQw/ERQXYzIlP
         yvuDcyYhfQrnPcseqrDRWlQCynGfYKVkC8GSmphLM2BXTvTXeh95qbscAx+xG7oWBZGK
         IOzXtxvzsrSJuGxahhPLzu54wCCwr/1ycyM0byquQ16H6K9Yfw08hwpsLdpmagx36TFI
         pgT7ih2IBDZOzJHELrea9NOQfGNpoho9SJ8rnEIj4al1BqEYrnMgOrw1VF0pZWfkWJf6
         ZxUD2Am0LUtempzICOA7IZulDQVSpV9of/qbfKel2oXQz1i2DmSqJSmTDWySNykvmKPr
         hGow==
X-Forwarded-Encrypted: i=1; AJvYcCWxubXs/5rUY7poEkWM6hZUuSjDEfAHvY9tdYb/19jg6M21xz6Jrqq7e8tjZjkNESF857OZ/syzLXyNZF/EKQJT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2gs4MBEwUuKw02Lv4oia8RbZ1rsKeFjfDTWotaQhuAO0X45Iv
	J3rsm6ck1JBepCmbITYBzCVCyDr4wCdtn1DPp1Mo2sC20dGQaXgRFkTiDWQjNSg+yTO36tM3yFY
	oin6MRsfT4g==
X-Received: from pjvg12.prod.google.com ([2002:a17:90a:db0c:b0:35b:963b:d15c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:510a:b0:359:3426:c60a
 with SMTP id 98e67ed59e1d1-35bd2bd6af9mr3625369a91.4.1774034929280; Fri, 20
 Mar 2026 12:28:49 -0700 (PDT)
Date: Fri, 20 Mar 2026 12:26:19 -0700
In-Reply-To: <20260320192627.368357-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320080835.724836-1-irogers@google.com> <20260320192627.368357-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320192627.368357-18-irogers@google.com>
Subject: [PATCH v4 17/25] perf kmem: Don't pass evsel with sample
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
 tools/perf/builtin-kmem.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index b04f5d578e7a..8eb4eff4e469 100644
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
 
@@ -784,7 +783,7 @@ static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
 
 			new = realloc(gfps, (nr_gfps + 1) * sizeof(*gfps));
 			if (new == NULL)
-				return -ENOMEM;
+				goto err_out;
 
 			gfps = new;
 			new += nr_gfps++;
@@ -793,7 +792,7 @@ static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
 			new->human_readable = strdup(str + 10);
 			new->compact_str = compact_gfp_flags(str + 10);
 			if (!new->human_readable || !new->compact_str)
-				return -ENOMEM;
+				goto err_out;
 
 			qsort(gfps, nr_gfps, sizeof(*gfps), gfpcmp);
 		}
@@ -803,9 +802,12 @@ static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
 
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
@@ -845,7 +847,7 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
 		return 0;
 	}
 
-	if (parse_gfp_flags(evsel, sample, gfp_flags) < 0)
+	if (parse_gfp_flags(sample, gfp_flags) < 0)
 		return -1;
 
 	callsite = find_callsite(sample);
@@ -886,8 +888,7 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
 	return 0;
 }
 
-static int evsel__process_page_free_event(struct evsel *evsel __maybe_unused,
-					  struct perf_sample *sample)
+static int evsel__process_page_free_event(struct perf_sample *sample)
 {
 	u64 page;
 	unsigned int order = perf_sample__intval(sample, "order");
@@ -969,8 +970,7 @@ static bool perf_kmem__skip_sample(struct perf_sample *sample)
 	return false;
 }
 
-typedef int (*tracepoint_handler)(struct evsel *evsel,
-				  struct perf_sample *sample);
+typedef int (*tracepoint_handler)(struct perf_sample *sample);
 
 static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 				union perf_event *event,
@@ -988,14 +988,16 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
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
2.53.0.959.g497ff81fa9-goog

