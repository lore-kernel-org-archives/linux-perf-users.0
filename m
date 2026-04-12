Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FAE31F99F
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959758; cv=none; b=p9UphIKiuR4+b/zQ2R7ht6V6eHLm+8jpUjnJw+TivwN7yj1ZDYjYKuMPMc8E1ptRfXdwqsouCIz9b32EByBQnQLVn6tSA+f86j4WbhpBbFXw7YyA8bA6fJdab/6CmXnDFXGLKx+ah8pfod6AFc6js1GG4sfAMGfiwlGgnUsB4t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959758; c=relaxed/simple;
	bh=wuj8eHDVqu0tfjx5SmZhqut/DywEnXDT6OJBHolpYag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RX0wAQP+YsmJV0l/BwCXV4I4Qob8y7K+LR2usYDu57fqMm26cTN+KLeMQi9f81RbR+jwqX62bhHcPsWSinEmxnujYK/1YGgwwqNQXcQXUD54wUToUe1O+MqztWZBelHFTeVL6ZOuotwsQYOryLkMXf8XvMi8hrrMyvCOa0sLkog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vGOE9lGG; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGOE9lGG"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12711ec96fbso9489796c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775959755; x=1776564555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I094G/M3b5jYi7fA68w+DPTi9TUF14mA4YbtJieKwSk=;
        b=vGOE9lGGbSaMDZ35tfaxre+Wqz1GKsNtH10alM2JBiyJVP/SCeFBLEMLtnUc98cHUa
         LRHW1vVQDhYIqda8t6UktFuf4Ry6QGS7njyPn8by003nlLHJPy4/hp9FiBAhQUKFimXG
         UlpTHxWfaPES+lZUQS/1qxk8RX7LEPSuonm7c3wgIhKe2VUHyeBa+buWNMIYwb/QjHZc
         /MrJb38zl1XZYMzhBaLRRXoLs+H/KMYRtR7iCcepFLjfDvVLUGVu72bLIu2hCZ4G1a9p
         Aaky+TcsboCbTT/mOf4sCce2Gz/2E/QvwlLMmKLV45Xi+0VaR+etxiyO9I9p8eeQwChE
         VXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775959755; x=1776564555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I094G/M3b5jYi7fA68w+DPTi9TUF14mA4YbtJieKwSk=;
        b=bgVYmDcKWCbkfDiQQyez0jKZBPb96L/OAT7e0xOEMNL7nRlzSALiPZr9yvev80klae
         nOeDl+cSF2XLd8BMVd7w321HRlMvxHCJaDcii1UNoQ6Nr//qlPCb6KOk448wtpMCQ2Ai
         p7qROwCtO30jcZ1n6zWZ0JTFhrEp8EQv3hH6QvcvVqy3snUfFqGGzR1vnR572mIy+cNI
         K1Bsdz9yV3DYUTnLLsuKa02bKca4ozHjAf9SnrOGBFh9WW42p4xjjYNbYjgVyXOYH+07
         1Am4PayGciaWH6xSluCbu4nkeyATWi2bLdcW7yluQ/94JMvvlGgBiqKPWRdlq9qeRnm7
         WmRA==
X-Forwarded-Encrypted: i=1; AJvYcCUpbBQTR59eA1AazDuoDTyLI/JxA9001ncgZ2IK9OaJUnrLYnYMei86k4IOggmlMjGiO7oHNH+It5ZB4H2cvzG3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw363Rf95hSh8DjrJ8h1r6/Gd8Dwu87j4BBSV+mDEJle+BiQF9M
	3ph8XbkdmPLC2fUjqfLR6Q7krtHaU9DUIcDAocT4FshXifgQVH0hZ7/mxiV1AOJaCfEYv5d/E0i
	aViqerebyzg==
X-Received: from dybtn10.prod.google.com ([2002:a05:7300:f10a:b0:2d7:f6a7:dbdb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec11:b0:12a:6902:ddc6
 with SMTP id a92af1059eb24-12c34dc294amr5156070c88.0.1775959754392; Sat, 11
 Apr 2026 19:09:14 -0700 (PDT)
Date: Sat, 11 Apr 2026 19:08:18 -0700
In-Reply-To: <20260412020833.641177-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260412020833.641177-16-irogers@google.com>
Subject: [PATCH v10 15/29] perf kmem: Don't pass evsel with sample
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

