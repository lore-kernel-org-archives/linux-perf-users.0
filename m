Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E9A35F8C9
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303971; cv=none; b=Wsdi72pTI7gGVJepVs0tRBo/f5CGsdVoIqSEp7Kl1yArtf9OAAqbK8dMMyD9pk07Lx4oRXEBveRuwKV/83sXQQM3XkkOsmRixo7533rqhbPgfOiiqKZp9b3WVYkaHgWE9nkgeg03uOW501eujfR1p0d0Jidcnu7ZJpzejQ2X1P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303971; c=relaxed/simple;
	bh=QCbP11BRtz449k5vcx+qgxGM53Ixx+/4qdq02lm7AKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MB0yuPWLKd2JPdT9l5p3TOJaQh6LnRoDpkzqT48FHrP+/mvjUMcU9WUwAU5cUXIhVb5e2oBlX+cIiFa7NbOmaThH6VNPTR4KSWRtVB/XVwTNfq9Bp+GlXmF5sSB9NPutnvlpaGZZBjP/E5jUZ0rxxh55SElE/wKM8uaUBf332MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mmOblyf1; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mmOblyf1"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f5943ca81aso20761907eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303969; x=1779908769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m5nXfutZj/qW9E3+337QisgIE4OAw5zZJzgJS+twK68=;
        b=mmOblyf1sUy0cgNJ1n4FPzatIC8Gpwu/YF1iF8U4wBuGoWBZ+31BG+mac/TfeYN+8Q
         cJqLZ+jMwkmFsbdyf8DMYyIw33WBdGmmvjzS7/CnUQ1reEvv+0T4bw+/CioX1WADQAwJ
         mgqEtXtTgUc+ZKUWrPokoWEqbWAUUELB17uKzDfeYIbWjY1RJAtoaVRXpISVhChpTAUl
         D5iMMrfpQTQboQEGnApoDjjyzkRqgBjAxxviNogaiCcnuJye4bgdeFSu+72019bWMNEe
         oI+z55fhgo0UW/NP+aH1EY2Ll2cCrw6H/FGVMZli9GswD8bs6XkJaZNSujX+V4v6mSGJ
         VSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303969; x=1779908769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5nXfutZj/qW9E3+337QisgIE4OAw5zZJzgJS+twK68=;
        b=FA5lmRn0vA/fqiHlqrhrKxhoSXkEq9YS9QkF1aEd4nBV3FjTR7Ornm9j/OyMEiOCKM
         lHmCld35583VCxCGoiCo052BKxU8RIUNR5eEM0L35ElCeUQ3PbRmTF5JndUnyDbafIDH
         OS8WqLMFOF0dAtbzd92w4uClieoiZBpnkJ6YrXAndfpvl8JkZ80Kj7n/sfy0Zq/pJckU
         QP9t9xUIQ1Q77C+0rQUY2L7k/NzWLmT7vRHj02RZz3oO4qOAuesDCzc6GXcZ2MhtsLi/
         foDByOzM7edQ5B2QhbO08OoM4o9BJxBuQHgqDfC0E91JBvzMcKKTuLjPlrg+dbJI3wht
         wbIg==
X-Forwarded-Encrypted: i=1; AFNElJ+Txmlztz5IT8ljWjQn9tlqDN/nWepehilEXdqVcuk4ZmHUvuB6boMwvjDFtk/Z9vpmJWhLKz/jQRxoX04oj3VP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6y5ox1v12185+k9ytOp+45AcqGmctvKXvsHRGm9UXVtbjmiRD
	9TOHhq2y+m+3fiIjEgsU+HpkdCsE85mWXKtL957zBhJLr8w2rVLTZ9VG13J0+fIPi/mU+xqhTUs
	3m91y8R5KRw==
X-Received: from dybqf6.prod.google.com ([2002:a05:7301:6486:b0:2f2:3f95:c586])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:dc11:b0:2f5:2556:5acd
 with SMTP id 5a478bee46e88-3039815f0b3mr11820657eec.13.1779303969112; Wed, 20
 May 2026 12:06:09 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:19 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-14-irogers@google.com>
Subject: [PATCH v14 13/32] perf kmem: Don't pass evsel with sample
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

Remove the redundant evsel parameter from kmem-specific handlers and
structures, ensuring the tool always directly accesses the evsel bound to the
sample. This simplifies the API signatures and eliminates the risk of passing
an inconsistent evsel.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
2.54.0.746.g67dd491aae-goog

