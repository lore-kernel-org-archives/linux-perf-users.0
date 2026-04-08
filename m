Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA567390C95
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633203; cv=none; b=RWpnZsqUejmPyALp2hiNFuoTgxXH9CmTaCOyArIsAMpShA5piA3fPPs+bHFsUrvbt8TSBrbXIiojTepMQyGthsCzqmWYpNz52WT/ICqmhAGyevyPyP3TUDl7iGhown5inQq49wsA2lVe8JfkbBsP/JV3XSOORr+WGVP6+tGZPP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633203; c=relaxed/simple;
	bh=lta2fI5qXdYPdhIfm8zOThe6wXUgcAlnODSeXuma/Io=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AOzKRS0CFA+VigwVlMAhMs5kuiTU0ogDOjiq5H9NhFCNXqL85pGkzIYikbFh2RAjBODOIFpdolrXDHpFphwBSuIEnY+UYkUcEJKHHvIPXpCTGduZYoOcoOe83cnwdvQCfe5J1WNltQN98pp7Ov0xS0UVAPOuoSLtRLdOI0hJPHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qRk9WIJM; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qRk9WIJM"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-127133794b6so9651574c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Apr 2026 00:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775633201; x=1776238001; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KaYE6VTNH1rn50K/H2pN6vOvFrscNqJ0UK5rxmsiNw8=;
        b=qRk9WIJMXxvFuQUJY020bJuQ7pLllQi8ma1VsLk083jrZ7yu3pdh3w9uZxFs+10B/k
         7ElRAOLEOLnE8RdXI0BkgsrHR2tYsF/Ti3T4se7ugEu/9WIK23inM5rnEiR7Y3fg7b+s
         rIEp+pkjm0KrqW1QTidks1vJbyQIWp1/YL5QydYG9qH+dK98g/SXWrYJEOGf8y7lIu/B
         QWqiF1lnrFA6+00xotv5r1tmxIUDfN2mgpNnV9o6qz/ZI5u9+oFVwSVYzRbJXs6R457/
         OXC/Lz6MHyhf6kUj4lqI0PFqImxMFhvz3CAbV0RdvTGzAJ5PmMTbO/VrjMoDjtH62o1n
         vLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775633201; x=1776238001;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KaYE6VTNH1rn50K/H2pN6vOvFrscNqJ0UK5rxmsiNw8=;
        b=ZQYqipIyvFanSaVgw+qMzq1WMMnamNX8pTkmdUoFBq41kg5Db49zkOzZtau5k3Wuph
         MVEB2jvZz/cYAnkS1ql0eFGn1vKanFUj651umkKpI1/FI04FEUWM2Y3BNA5+0dPJaij8
         rl7rbOK8w1yOBgEs1LMct+3m8SOfG/ZkSjAjxwR1CIfwwGyPPOwAWiowNLvQ6WG8858/
         70WmqPUoOEaayGmDdtWNIEooCESHb+Bu2xLlHGcBRfUKg47VTvw7wtY7VSbGzTWCAgVu
         mTD6QeItJaR3LF3uIx9LN/v/KBkmee42LeYc7QyGS2OZARo4WJilbuKxDx45/IG9wspK
         lgpw==
X-Forwarded-Encrypted: i=1; AJvYcCUtBVbDrKsYrsgVJM/5dIapPiwcgiNFgCHw8UF5mLaEz1NlSuzD6lLg7Wcofm2GikqBI9LUUB8M5xzNq4lBnXtE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp0xOkWztxP8+pEf3MkoUJGqLXf6LJCbR2u6RKuvBspG9bgNyP
	IIs8HfHKThGg8UG+Of8M1qoGTt4JhW4yUN/Q/hR2eM2VL7RKsXHHjYJ7Rx90xXUesb4tobk1b+O
	i3sJkc5ee0g==
X-Received: from dlag15.prod.google.com ([2002:a05:701b:250f:b0:12a:c3c1:4ace])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e14:b0:128:ea68:27f1
 with SMTP id a92af1059eb24-12bfb760b99mr9338591c88.23.1775633200703; Wed, 08
 Apr 2026 00:26:40 -0700 (PDT)
Date: Wed,  8 Apr 2026 00:25:53 -0700
In-Reply-To: <20260408072601.210837-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <adPyeCq3rQrTurju@google.com> <20260408072601.210837-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408072601.210837-16-irogers@google.com>
Subject: [PATCH v7 15/23] perf kmem: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel and so it is unnecessary to pass the
evsel as well. Fix memory leaks on error paths spotted during code
review.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 44 ++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index b04f5d578e7a..cafa0eabfbc5 100644
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
+			if(!new->human_readable)
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
@@ -845,7 +851,7 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
 		return 0;
 	}
 
-	if (parse_gfp_flags(evsel, sample, gfp_flags) < 0)
+	if (parse_gfp_flags(sample, gfp_flags) < 0)
 		return -1;
 
 	callsite = find_callsite(sample);
@@ -886,8 +892,7 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
 	return 0;
 }
 
-static int evsel__process_page_free_event(struct evsel *evsel __maybe_unused,
-					  struct perf_sample *sample)
+static int evsel__process_page_free_event(struct perf_sample *sample)
 {
 	u64 page;
 	unsigned int order = perf_sample__intval(sample, "order");
@@ -969,8 +974,7 @@ static bool perf_kmem__skip_sample(struct perf_sample *sample)
 	return false;
 }
 
-typedef int (*tracepoint_handler)(struct evsel *evsel,
-				  struct perf_sample *sample);
+typedef int (*tracepoint_handler)(struct perf_sample *sample);
 
 static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 				union perf_event *event,
@@ -988,14 +992,16 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
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

