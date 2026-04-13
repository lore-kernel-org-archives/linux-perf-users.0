Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C6522423A
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043384; cv=none; b=Ib9pUpbIOkQbWp9bMDSk8UtNsoRiZH7yN0i131MrzvzCbQM1h7DmJztcwgP+TUb+NDUDX0jkcfvcRofmLYzrTuDKJQGoc9ZVqzZ56v+fJa8M+h74+tEsSHaINNDZmg36OVNAubmC152TErVU9BXAKdTur9jhjGYgzIR9RyftwU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043384; c=relaxed/simple;
	bh=495v7vwy/bxdki64nsuLUq2VLnkw+FqQnijSjVyewWk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kLCEFThR1rYh5AbAV+DbAZUSVR3oshKtFsmETaqziUG+ovZkzOx53XurXBcPmzCjvx59AL59S2GiNzmZoD9lypnqdmNhLPfx5spbQOoQUnqzXVoyylX2wakvVy55+iH1xmsw+KCz/jilkywkG+V0yow6kv206AizcAm0OSqVgzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dmSxGNxa; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dmSxGNxa"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d5de9deba9so4439847eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043382; x=1776648182; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TdCCiiHDf0G456jnJXOkKokcXFcoaXYbGwyy1xI9gh0=;
        b=dmSxGNxatmZRLgH0q9DZ48sPuK/xs8QwHCNm3OUh5LTIbfXc/3XkXWkgTURF0b4jAQ
         lhdZmFCEhoCGTQD3JDarSh0YBIxKf3MCAqlE4DMSKJr7n+oPvr0hYUT5+3lw4EtEsQBP
         UEPZe/srXUY4BGlJc97DA972gfC7p0xjO8CMmtbAcjl7ahXxRV80lRroT9bfsP++dyZZ
         jyFlCAY49iVIG/xoyEFd6RhtNoFO0iKmxELjmgvyPb1iFHJ845zjKVYpm1HoyyF1W6PB
         eVa9sEynH618bUjo4Mj7j0xmcoQoNP/5HmIz04EUpmmaOx2BCuQIy+/83SvSbDURGmVG
         bJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043382; x=1776648182;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TdCCiiHDf0G456jnJXOkKokcXFcoaXYbGwyy1xI9gh0=;
        b=G+YYX8GYIlxjs+HT8ybEJSzGRMj1DNRzQA6hVXj9+M//esi37zLRX08zvhBAW3vuWa
         m/va7yLIv2hbp0QTMJDnBV5u2RK6Et3iLYg8iqTq5sWl+mZWNzldj7GqgYbpkkuehSG1
         LS1lvWMp5BQj5Iq8G3jpViBtp9twFl8Oul/4I7w3/KnZccpcDEqvTIdVAd5EInLM/FoK
         EV/McSECS4qH1aFRJKAXsE+BgSyPNR0h1hYSDY3F8IkI29IbBpqsopI5gefGcEabVRTL
         Si6HRTn/1kpwiIr1prPkOTrTglQKBtD+063DBrbBvbskNQ9hEk4ClFpPcE8lbZhp63SQ
         39hg==
X-Forwarded-Encrypted: i=1; AFNElJ8uDsNDnZFgXkLM3YpxYsGXOfn7jR3Oj4/6YzLl4fhL/P3bsMorbFGWPv+eE8zEE5Ss16fLs7EtbiIMOz7mNYA3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Gxb9pb2wi5Bmw6B2rcvp+t9OgEfIsp6KgQ8fKBDtG3+ndcNR
	9A+3lykorQz/FTrQV1tIOLNeDBDYUiCXhBA+oo9dzmn705wJyi46bllbWkaY3ZX5moiAuz91xom
	rg7nEAcia5A==
X-Received: from dycnr23-n2.prod.google.com ([2002:a05:7300:e9d7:20b0:2d8:6e2f:8c6a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8184:b0:2d9:d062:4cb3
 with SMTP id 5a478bee46e88-2d9d0624f07mr299361eec.26.1776043381790; Sun, 12
 Apr 2026 18:23:01 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:22:08 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-15-irogers@google.com>
Subject: [PATCH v11 14/33] perf kmem: Don't pass evsel with sample
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

