Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290FB407578
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 23:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962682; cv=none; b=BMH+LXHWCeJ7GNEoQ7baqlmUUL3oN8+oImlBiWdOJxZfJ12xtYjrRLQtW9MJztN1GMHgE9XcAbY+GhJLYIJWBZPSxREjZPAvZy77rMpnFWz9NWrMMeVEQIGqE0AiD5jBxKP0dNUaCtZVZhc9MEoJJa/yGfOuSNYHbxRSz9BG9a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962682; c=relaxed/simple;
	bh=3xHkozfOBQ5O/0UIsbkAMpaM2l17KKcrX8h7fai6Z3Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l7GVYRCT9mucas0FUmyAVqEnGbdJOEbQfoiwBVxE95tcGBQyIrKUkQzk4DJ/VKpl7ycow+9FJdj9xAQ6ayRUtois8Kd1FWYN4fn2QUoO5ov0l1sZbl4Fua0LD9HvkhNdvq9UFcPoh0DAKnz4XfYHTrfaG5VMiN2YJH3EpThmVDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZSUd9PRe; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZSUd9PRe"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c105e5ac70so140488eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 16:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773962679; x=1774567479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j3NPJHDhmF9h/ESu+OU97vNzfzIxPr2OOmbu63IbKTw=;
        b=ZSUd9PReeo5S5vZ4jaL1l4GXzOoCoiFxPMRA4Ez32G0B/kd+8S7EjNQVuqokOao7YB
         x/v+3OtsKkyk1LT+29KMQ8USPRf2nRtcPGY33bMv+tnrpockvEgzm12awDEPRU4IZBdM
         0ucUNBoxiCjDZmMC0zxfG0PPx/141KRx/Sw3njBeOq+xvsnv6hbq4nAWBYWpkyxer9yN
         rrxP6V3KRTG/alc1ZOuVGLKXWV1X9JwTGaTfCI9YqEyP4v3UvsCNdX7gMAmKQmxZJ9Rc
         yN1z1yp/EWYMc8+7FBDM76QpRJk3dRJBkn28gsuOUaNfpNTaeBIgjliEbBQKXYMFCdC7
         L5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962679; x=1774567479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3NPJHDhmF9h/ESu+OU97vNzfzIxPr2OOmbu63IbKTw=;
        b=QGOFxTPrJ8TO6/TGWTexxTydFKAg9OcBmuZ8ToS1Z6MIFv5X+eERqyg7NiEnUtnD0y
         X9Dw845cizB/DCSi+XVtoozaukZIFUXevGCHlGs9FmJ6+6y7hbK5D9Vl4UwZELUrp604
         dxUHsQCSozMjFpL7LyAbdg5BSYYQqKgJ0vnShqsTqcVeqRq0I2P/hMl0xxeP0fCgj30s
         ll0ReZa4BrFGRrBaionxO5rILnz9QrdozKYtbUIRBau8a24r9dahCapiwsTNyfF83pKo
         WFCkp14qNMFwvmx75FzoRrPkVobT3pkLx3heqkEkDZk5VASVzUMLyn4fS28LvRATi3xk
         q+1g==
X-Forwarded-Encrypted: i=1; AJvYcCVWHPLY/sAUt4WqGHjChI8U8DC1FFPB2wRHnCmLyY5k2QqIenrsfUPQ26Io7Z8fCr2M4y1tl/aenUUkeTeVvtu9@vger.kernel.org
X-Gm-Message-State: AOJu0YxuLWiI1CW93iO0WrpFkBVlR9yzvI5yxp82LWZS/fxHZ/0EaJVn
	NUWbAW8E6JNQcP8pVMu1f8sqt8J+WJyX2ity2GTaKlRVlSHqQmiBr/GFlhEQXEmOYAVA+UFomNW
	KmxKs6cRgJw==
X-Received: from dlbsw9.prod.google.com ([2002:a05:7022:3a89:b0:128:f497:319c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:31f:b0:127:5cfe:1ee0
 with SMTP id a92af1059eb24-12a726b2844mr437271c88.21.1773962678957; Thu, 19
 Mar 2026 16:24:38 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:23:26 -0700
In-Reply-To: <20260319232334.287517-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com> <20260319232334.287517-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319232334.287517-18-irogers@google.com>
Subject: [PATCH v2 17/25] perf kmem: Don't pass evsel with sample
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
evsel as well.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 19b12209fc08..ea2437971e8b 100644
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
@@ -836,7 +835,7 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
 		return 0;
 	}
 
-	if (parse_gfp_flags(evsel, sample, gfp_flags) < 0)
+	if (parse_gfp_flags(sample, gfp_flags) < 0)
 		return -1;
 
 	callsite = find_callsite(sample);
@@ -877,8 +876,7 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
 	return 0;
 }
 
-static int evsel__process_page_free_event(struct evsel *evsel __maybe_unused,
-					  struct perf_sample *sample)
+static int evsel__process_page_free_event(struct perf_sample *sample)
 {
 	u64 page;
 	unsigned int order = perf_sample__intval(sample, "order");
@@ -955,8 +953,7 @@ static bool perf_kmem__skip_sample(struct perf_sample *sample)
 	return false;
 }
 
-typedef int (*tracepoint_handler)(struct evsel *evsel,
-				  struct perf_sample *sample);
+typedef int (*tracepoint_handler)(struct perf_sample *sample);
 
 static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 				union perf_event *event,
@@ -981,7 +978,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
-		err = f(evsel, sample);
+		err = f(sample);
 	}
 
 	thread__put(thread);
-- 
2.53.0.959.g497ff81fa9-goog

