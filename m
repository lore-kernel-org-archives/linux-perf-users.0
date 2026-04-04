Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4681033438F
	for <linux-perf-users@vger.kernel.org>; Sat,  4 Apr 2026 03:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775274259; cv=none; b=byFOAPsGULMZVESSJy3XdN+iUVJjR+mdEuL/sJMk81J07YuLwYfAKA6SPrQ553fwoInMWdwplwdEdpavxpJ7bLGkC2N3E+Yc0QA/nrqWuSo+DVwOHCCnXI9C2BDfwsfwF5nyBTPuWAaTf8/bQI0j7Vz1h4VIYKGVrVlZZ8k8pPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775274259; c=relaxed/simple;
	bh=lta2fI5qXdYPdhIfm8zOThe6wXUgcAlnODSeXuma/Io=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bgk9+pN3LfxpnXnh7r7zJL3TYXlAXwIBE2vr4GO/XqOi013ImHbGMHDSDPuW9XJp0pDAGLHw1gtw1+MfY81DAbjwqE89MCyqc7mlvFvTvIE7cY4woZGgwFVirTc9nKUI75HgTqlpC5E1XYpkNST4vDykw9arryGllVvGyuUFDw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K1WlAbkD; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K1WlAbkD"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-127337c8e52so8649253c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 20:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775274257; x=1775879057; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KaYE6VTNH1rn50K/H2pN6vOvFrscNqJ0UK5rxmsiNw8=;
        b=K1WlAbkDko0AElH+mECAW1aZ1b8V/hAehrTlN8X9GtHZABswY3gQf8xjh4lBYuXieC
         YD4w3G+591vQz5HkD95j9w6QiYFjXomz694eioXORMhI/ecg9GxvbzPSTfNRMUMswDH3
         c4zCBtmjFxqSEDR+xMvux6AFKYYxNMwunsOYB6+mhGDJ5VsVzRDWl5k6TQVOuF9WcfY9
         8PUzZ9tKtlEdXs7Nx+FxqPWUN4o6ajPqSuZw8f40nMQ9Z+J/g5/YViiI7eZyNl9bcvvh
         +oe+MH5inKQHBOJsahKjBaJ6K15WbFJ3COu/5bhaNFEPDvvg+qfIWfR4lU3fsy+JcVz6
         ZQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775274257; x=1775879057;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KaYE6VTNH1rn50K/H2pN6vOvFrscNqJ0UK5rxmsiNw8=;
        b=d8UHydq+iNjpMHQwYOBgBdoWotkyEI3kUdE6d7Jcb+uYt4u/UY6n62bVM0uGEvs10Z
         fAH3R7L9bX9mWUzLQ5XF9J/NQjegUhB1xCI/htK914gyxtvr2Cj6bQozOSPZQKHt79L9
         yUdGoranfHtO58LY4G3nDkU9myIXustjOXu/Kr7iuitDDwRl6idG47vYenkWgp3sjiN5
         94Buc0vyaEInpJ4VVLCUJ6MRQkEwKYALSizRNrt5tnmou1NkeuZXbgZ3Q6EKOA4B8VZw
         DmAMoy0NBX0iHDJROUkc3GPK3B9cmytWh7RQQklh/ylf5F4CL5P7KeovCb4ytQlUXT69
         B01Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKZZCc7z2nkuXps0ImFpiCzqYiXDdsc33ElXwIcWZf7bYytoYV6efp3cQbu0NJ9vC8iQZdYN1uEJg6AGPDLqKe@vger.kernel.org
X-Gm-Message-State: AOJu0YzrcpulcJE5QgDM5mHUd1gnBIR0kJm/6+mhIEeLv26y+loo7J2N
	dAQMVznvLHxNW2hEtpg0DC/dgs2LvTJQRHpEREqvvYBkeuhsZ7VKV5YAXSMTPI6qg0nKIeccAlC
	zkDdvob/dUQ==
X-Received: from dlbvs3.prod.google.com ([2002:a05:7022:3f03:b0:12a:7a40:ea24])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:61f:b0:12b:ec67:3523
 with SMTP id a92af1059eb24-12bfb6fa2f7mr2715555c88.9.1775274257068; Fri, 03
 Apr 2026 20:44:17 -0700 (PDT)
Date: Fri,  3 Apr 2026 20:43:17 -0700
In-Reply-To: <20260404034325.3172592-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403204017.2919994-1-irogers@google.com> <20260404034325.3172592-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260404034325.3172592-18-irogers@google.com>
Subject: [PATCH v6 17/25] perf kmem: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
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

