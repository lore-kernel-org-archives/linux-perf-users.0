Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F62A3D8135
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 20:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248865; cv=none; b=DEQNs1dBouxPiZVAHWYTEDfh0rtNNrwb7hoSnZ7daswTTD2tov0OHBXV5DHvY0o+0WQrBLJY84b4s33Iu4NGNVbtYJ6S5oLvd7YTM6b/96cLNr8tvEDTukMFH8uTjBZXKnqoeCEXc2mbKnGXiW4ieiR7I6hZ7edoBnorm01QTsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248865; c=relaxed/simple;
	bh=lta2fI5qXdYPdhIfm8zOThe6wXUgcAlnODSeXuma/Io=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GPYZ6bFeKbd+W3rmTuM83JCiavaI/HFkQBePUOTv5sLEI8aUQfTxVEmFJAFzJLzWLhsFBrQy/YEnGMQMHBFs9MMbzrliBAIyOE2JPnF0U7SMsWwBMPvRuOkik826Llrp0AZX3x89F+uB2VSQETgPsMsBCLuT9VsVF1AxOjDyrug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ulDUbRVy; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ulDUbRVy"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1276e71652fso4453139c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 13:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775248864; x=1775853664; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KaYE6VTNH1rn50K/H2pN6vOvFrscNqJ0UK5rxmsiNw8=;
        b=ulDUbRVyRxSf4ys6gxo7zqsTsM6HwYLURVTEqwFIi5AmYpOmaJd6/0YrlSTt1DT52O
         414eWe1npzyj7PYTXVyTnwbQQJyqSkY4xvOqYl6hJ6YwmB2jG3BUEKL1Sw/9TygeZVpy
         //ZEQMHXEHg1Hau+ogPJevOVSjkYlWrgozfSmOdBa3jSv8yE+sek3qEnDx0XhFX/R7Qn
         mBWEaOksjJlvHv1zMcZOqJ0fxuOpt6Tm02RtXS2udSWZj/+cEyTkMBMSv0awqf0A7NaO
         26ga4BPi/Z1lCNe2P1vI4+KD0HE4gopvr+nq4+ZHpiXcBuHhTgp26W6ZbbfIM1mps2pY
         X9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775248864; x=1775853664;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KaYE6VTNH1rn50K/H2pN6vOvFrscNqJ0UK5rxmsiNw8=;
        b=AtqldBI5ZS4HOjgjE6/NQt6XHY29ieTmtal+hem1N5MCAAOePJwYRmOg0YnglUDraq
         blRWgHi4p4VG/OQ1mRfvcZJ9ygSaMypRqCirWTLGsWsQmC/ZOFglOv4F0D5CNtbHcL4F
         5tUXviyaBOHnhybyGX1urMoU7Fiy1a38x+N3xMeO70SnrTSv91dsSDDYVDRiUAGM27+R
         l1nOBDB+r0gUIuBaVvSEG3r1CNVKcVTM0OPTNreGlgwIF3CNwtAyfU20OmLRdM7Nw3J4
         g006lRgOHr08NoFNGDfgTg4sCHIOO4i23Ic+x5Fh+dvglRk4avujXKmv7NYPaPXlnDuY
         146Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQP/5HItWwEKMOC4EwvnHYz+oDqg84jcIFt0aIKFeel9xjQc1b7ThHifUZnhpqO+r5JQLxWZ73aFRtk3xNyLRt@vger.kernel.org
X-Gm-Message-State: AOJu0YxLfhzsPMz5mYAn8Gs5hDLAFI1TMoG1/yeZmEmKG2a2Yo09oQBI
	h0WgM1whNw7dBzMTwL3PpZDKmuDxokhxHVctMd9Y9nCkB9l9o7JptGhmCMqZLqG/CShkdvVsQaZ
	ANhFJMFD29A==
X-Received: from dlae5.prod.google.com ([2002:a05:701b:2305:b0:12b:fdc5:ed69])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:b0c:b0:12a:713b:8953
 with SMTP id a92af1059eb24-12bfb6fbf94mr1891515c88.12.1775248863422; Fri, 03
 Apr 2026 13:41:03 -0700 (PDT)
Date: Fri,  3 Apr 2026 13:40:09 -0700
In-Reply-To: <20260403204017.2919994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fXDd2_uqRHGOrbbjsAjbunsW67P-kONsmhm6UZWQUc-2w@mail.gmail.com>
 <20260403204017.2919994-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403204017.2919994-18-irogers@google.com>
Subject: [PATCH v5 17/25] perf kmem: Don't pass evsel with sample
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

