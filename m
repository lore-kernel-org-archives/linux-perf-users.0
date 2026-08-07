Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E363B47E1
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 07:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087120; cv=none; b=bXww+L07x5ZjmcPSP1SIvL7VWzTKExWJbSCVUofVlD/eVUnJhDFbGr2aWMGgAnfqREZs4nCmtVc3RE7PGUw25/4Jq5F7lxSlxVZW3I3ZsuV/8m2kfoolOhKs2xgmOmtcuDXQ9bubWzO1SVEt/G9t/1lPNkSi2ok8BX57FOz7Yuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087120; c=relaxed/simple;
	bh=ZCCc99i/EoDgKN+cfkIOUGAGG11H8cIUbt47iXLmBNo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lDkicod+ogl7q4pjEFWA/BVP+uDHlwC9Lc0A2MEVdO7+wj6AUfWzbOBQGU5KuFrNl/g/KzIrKm8Uk9INWNfiCU16cbA7/rx80i+Zv+NNR28VicrSmIjHAWzpe7iUDDNE8Fps943JecrtVS7E3IRzL2/3RFTSMMwZ64lJ4qb20DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9YJld5N; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9YJld5N"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb5cc1e139bso2257513a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Aug 2026 00:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786087115; x=1786691915; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rWScONZGZwN2NQDuInfCsrpxwH4OLRaI7pljij4G41I=;
        b=I9YJld5NZszfpIVD7q5wvtfhVKg5R1PytZcXHAf2q9N2FoqHyW3TPvrMLwqRPg52nx
         viC9thw5053+f9be+d1pRIlkBm5/VeDcuKDvVODn3ovtf3OcyXqUHGFtEuybS1/ApG8C
         MZtJZmAZyhw0dIbM+dIuPn53gnITmGlTLF0ihsyzNONXluNSWcgbbJkMYIzViXoPVaON
         3m7rFDbT4p0qUCyMTmoJN/rzNfO3ktrfjVBdA98UHTtWfZ6iLMlBHE5tn+UdlwJzvGEQ
         kjg4SPuoskrXXmwPrE7uHTCHNiRNd6IDcKcJ50fgL9YUcl910NS4NZpxPdotSAhXWCml
         Htug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786087115; x=1786691915;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rWScONZGZwN2NQDuInfCsrpxwH4OLRaI7pljij4G41I=;
        b=qZvyF58y6dwmYf8YXIOtJXqrTQCGeiTGPjHX+OgwkX5NP/nKwzC6/N+Ci3xMbgkEAc
         KIzRsLsMm8auNuJ8pLpHRXyp3zf2pdah2SXL59BSObhArq6RR+KKrcysD3JIz/pkGd/g
         chwqVCsUpRwXx9WI6tyImld8mP1cFxPJm3cyBtORtDizx72QTlRTlNHMP8JpK3V9oNB0
         w0vqZTEVT5+17gzNHxLwdZxdxTIfYq64/o+phhp0YheJq0TZomF1rnYbBnIiehHHold3
         HI7NYoUG0lbWzGtLHSGzvGtXYQUYSgMprQWekPutsVBtgTIIIBBJAbqfiuTQ3fV9IVxC
         Vgng==
X-Forwarded-Encrypted: i=1; AHgh+Rr0UoRKMH5nIj03JOSgd25rQLEOEiNM7kK5g4FYClOlBUFjoPOUHQGT7AoyRj9s0jxC8qdNreicZlN1/UJViKKx@vger.kernel.org
X-Gm-Message-State: AOJu0YxJkpCC9oUxTRBHk/ETaa32xi+FpjdBnrbr7nDyIAU6ywPVh1pN
	VkLsWh/kH5DQ+Mp3ZLoA4N2pzJzCcjqruaw/UUyqDJx4KJ0fnunzBXnqRMRfTTUHVBK+PyU/6SV
	r/zNrvgVvQA==
X-Received: from dyx18.prod.google.com ([2002:a05:693c:8212:b0:30c:5c4a:b8b1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e58b:b0:3a3:a9c4:3d60
 with SMTP id adf61e73a8af0-3cb85f5c2b0mr25707036637.27.1786087114976; Fri, 07
 Aug 2026 00:18:34 -0700 (PDT)
Date: Fri,  7 Aug 2026 00:18:15 -0700
In-Reply-To: <20260807071818.718751-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807071818.718751-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807071818.718751-6-irogers@google.com>
Subject: [RFC PATCH v1 5/8] perf tools: Internal support for BUILD_ID_OFFSET
From: Ian Rogers <irogers@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Eric Biggers <ebiggers@kernel.org>, Zecheng Li <zli94@ncsu.edu>, 
	Gabriel Marin <gmx@google.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	Derek Foreman <derek.foreman@collabora.com>, Tanushree Shah <tshah@linux.ibm.com>, 
	Ankur Arora <ankur.a.arora@oracle.com>, Aaron Tomlin <atomlin@atomlin.com>, tanze <tanze@kylinos.cn>, 
	Rui Qi <qirui.001@bytedance.com>, Howard Chu <howardchu95@gmail.com>, 
	Chuck Lever <cel@kernel.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Alessio Podda <aleph.pi.gh@gmail.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Implement user-space parsing for the new sample types in evsel,
update perf_event_attr_fprintf to display the new bits
in 'perf report -D', and update synthetic event parameter names.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c               | 16 +++--
 tools/perf/util/event.c                   | 42 +++++++----
 tools/perf/util/evsel.c                   | 24 +++++++
 tools/perf/util/evsel.h                   |  3 +-
 tools/perf/util/evsel_fprintf.c           |  2 +-
 tools/perf/util/machine.c                 | 87 ++++++++++++++++-------
 tools/perf/util/maps.c                    | 29 ++++++++
 tools/perf/util/maps.h                    |  2 +
 tools/perf/util/perf_event_attr_fprintf.c |  3 +-
 tools/perf/util/sample.h                  | 13 ++++
 tools/perf/util/synthetic-events.c        | 20 ++++++
 11 files changed, 192 insertions(+), 49 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 93cffafb1af7..65229e9952a8 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -494,7 +494,8 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 		return -EINVAL;
 
 	if (PRINT_FIELD(IP)) {
-		if (evsel__check_stype(evsel, PERF_SAMPLE_IP, "IP", PERF_OUTPUT_IP))
+		if (evsel__check_stype(evsel, PERF_SAMPLE_IP | PERF_SAMPLE_BUILD_ID_OFFSET,
+			       "IP", PERF_OUTPUT_IP))
 			return -EINVAL;
 	}
 
@@ -511,7 +512,8 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 		return -EINVAL;
 
 	if (PRINT_FIELD(SYM) &&
-	    !(evsel->core.attr.sample_type & (PERF_SAMPLE_IP|PERF_SAMPLE_ADDR))) {
+	    !(evsel->core.attr.sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_ADDR |
+					      PERF_SAMPLE_BUILD_ID_OFFSET))) {
 		pr_err("Display of symbols requested but neither sample IP nor "
 			   "sample address\navailable. Hence, no addresses to convert "
 		       "to symbols.\n");
@@ -523,7 +525,8 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 		return -EINVAL;
 	}
 	if (PRINT_FIELD(DSO) &&
-	    !(evsel->core.attr.sample_type & (PERF_SAMPLE_IP|PERF_SAMPLE_ADDR))) {
+	    !(evsel->core.attr.sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_ADDR |
+					      PERF_SAMPLE_BUILD_ID_OFFSET))) {
 		pr_err("Display of DSO requested but no address to convert.\n");
 		return -EINVAL;
 	}
@@ -1702,7 +1705,7 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 		unsigned int print_opts = output[type].print_ip_opts;
 		struct callchain_cursor *cursor = NULL;
 
-		if (symbol_conf.use_callchain && sample->callchain) {
+		if (symbol_conf.use_callchain && (sample->callchain || sample->callchain_bids)) {
 			cursor = get_tls_callchain_cursor();
 			if (thread__resolve_callchain(al->thread, cursor,
 						      sample, NULL, NULL,
@@ -2528,7 +2531,7 @@ static void process_event(struct perf_script *script,
 		if (script->stitch_lbr)
 			thread__set_lbr_stitch_enable(al->thread, true);
 
-		if (symbol_conf.use_callchain && sample->callchain) {
+		if (symbol_conf.use_callchain && (sample->callchain || sample->callchain_bids)) {
 			cursor = get_tls_callchain_cursor();
 			if (thread__resolve_callchain(al->thread, cursor,
 						      sample, NULL, NULL,
@@ -2815,7 +2818,7 @@ static int process_deferred_sample_event(const struct perf_tool *tool,
 	if (PRINT_FIELD(IP)) {
 		struct callchain_cursor *cursor = NULL;
 
-		if (symbol_conf.use_callchain && sample->callchain) {
+		if (symbol_conf.use_callchain && (sample->callchain || sample->callchain_bids)) {
 			cursor = get_tls_callchain_cursor();
 			if (thread__resolve_callchain(al.thread, cursor,
 						      sample, NULL, NULL,
@@ -2897,6 +2900,7 @@ static int process_attr(const struct perf_tool *tool, union perf_event *event,
 	/* Enable fields for callchain entries */
 	if (symbol_conf.use_callchain &&
 	    (sample_type & PERF_SAMPLE_CALLCHAIN ||
+	     sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET ||
 	     sample_type & PERF_SAMPLE_BRANCH_STACK ||
 	     (sample_type & PERF_SAMPLE_REGS_USER &&
 	      sample_type & PERF_SAMPLE_STACK_USER))) {
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 982fb9ed049f..86df3edd1bfa 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -702,12 +702,6 @@ struct map *thread__find_map(struct thread *thread, struct perf_sample *sample,
 	thread__zput(al->thread);
 	al->thread = thread__get(thread);
 
-	if (sample->ip) {
-		al->addr = sample->ip;
-	} else {
-		pr_debug("Sample missing IP data\n");
-		return NULL;
-	}
 	al->cpumode = sample->cpumode;
 	al->filtered = 0;
 
@@ -740,15 +734,33 @@ struct map *thread__find_map(struct thread *thread, struct perf_sample *sample,
 
 		return NULL;
 	}
-	al->map = maps__find(maps, al->addr);
-	if (al->map != NULL) {
-		/*
-		 * Kernel maps might be changed when loading symbols so loading
-		 * must be done prior to using kernel maps.
-		 */
-		if (load_map)
-			map__load(al->map);
-		al->addr = map__map_ip(al->map, al->addr);
+
+	if (sample->ip) {
+		al->addr = sample->ip;
+		al->map = maps__find(maps, al->addr);
+		if (al->map != NULL) {
+			/*
+			 * Kernel maps might be changed when loading symbols so loading
+			 * must be done prior to using kernel maps.
+			 */
+			if (load_map)
+				map__load(al->map);
+			al->addr = map__map_ip(al->map, al->addr);
+		}
+	} else if (sample->bid.bid && sample->bid.bid->size > 0) {
+		struct build_id bid;
+
+		build_id__init(&bid, sample->bid.bid->data, sample->bid.bid->size);
+		al->addr = sample->bid.offset;
+		al->map = maps__find_by_build_id(maps, &bid);
+		if (al->map != NULL) {
+			if (load_map)
+				map__load(al->map);
+			/* al->addr is already a file offset */
+		}
+	} else {
+		pr_debug("Sample missing IP or build id + offset data\n");
+		return NULL;
 	}
 
 	return al->map;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d4cb455f4a7d..d9a07f5825e8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3778,6 +3778,30 @@ int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array = (void *)array + sz;
 	}
 
+	if (type & PERF_SAMPLE_BUILD_ID_OFFSET) {
+		data->bid.bid = (struct perf_build_id *) array;
+		array += sizeof(struct perf_build_id) / sizeof(u64);
+		data->bid.offset = *array;
+		array++;
+	} else {
+		data->bid.bid = NULL;
+		data->bid.offset = 0;
+	}
+
+
+	if (type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) {
+		OVERFLOW_CHECK_u64(array);
+		sz = *array++;
+
+		OVERFLOW_CHECK(array, sz * (sizeof(struct perf_build_id) + sizeof(u64)), max_size);
+		data->callchain_bids = (struct perf_build_id *) array;
+		data->callchain_bids_nr = sz;
+		array += sz * (sizeof(struct perf_build_id) + sizeof(u64)) / sizeof(u64);
+	} else {
+		data->callchain_bids = NULL;
+		data->callchain_bids_nr = 0;
+	}
+
 	if (evsel__is_offcpu_event(evsel)) {
 		if (__set_offcpu_sample(data))
 			goto out_efault;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d9ecc6628217..e082e6e6af66 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -567,7 +567,8 @@ static inline bool evsel__has_callchain(const struct evsel *evsel)
 	 * For reporting purposes, an evsel sample can have a recorded callchain
 	 * or a callchain synthesized from AUX area data.
 	 */
-	return evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN ||
+	return evsel->core.attr.sample_type & (PERF_SAMPLE_CALLCHAIN |
+				       PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) ||
 	       evsel->synth_sample_type & PERF_SAMPLE_CALLCHAIN;
 }
 
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 0f7a25500a44..9f7054410a2c 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -131,7 +131,7 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 	if (cursor == NULL)
 		return fprintf(fp, "<not enough memory for the callchain cursor>%s", print_oneline ? "" : "\n");
 
-	if (sample->callchain) {
+	if (sample->callchain || sample->callchain_bids) {
 		callchain_cursor_commit(cursor);
 
 		while (1) {
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index aeace492b4e7..82de7bc7eba1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2216,7 +2216,9 @@ static int add_callchain_ip(struct thread *thread,
 			    struct branch_flags *flags,
 			    struct iterations *iter,
 			    u64 branch_from,
-			    bool symbols)
+			    bool symbols,
+			      struct perf_build_id *bid,
+			      u64 offset)
 {
 	struct map_symbol ms = {};
 	struct addr_location al;
@@ -2230,7 +2232,9 @@ static int add_callchain_ip(struct thread *thread,
 	al.srcline = NULL;
 	if (!cpumode) {
 		thread__find_cpumode_addr_location(thread,
-					   &(struct perf_sample){.ip = ip},
+					   &(struct perf_sample){.ip = ip,
+								 .bid = { .bid = bid,
+									  .offset = offset }},
 					   symbols, &al);
 	} else {
 		if (ip >= PERF_CONTEXT_MAX) {
@@ -2411,7 +2415,7 @@ static int lbr_callchain_add_kernel_ip(struct thread *thread,
 			err = add_callchain_ip(thread, cursor, parent,
 					       root_al, &cpumode, chain->ips[i],
 					       false, NULL, NULL, branch_from,
-					       symbols);
+					       symbols, /*bid=*/NULL, /*offset=*/0);
 			if (err)
 				return err;
 		}
@@ -2422,7 +2426,7 @@ static int lbr_callchain_add_kernel_ip(struct thread *thread,
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, chain->ips[i],
 				       false, NULL, NULL, branch_from,
-				       symbols);
+				       symbols, /*bid=*/NULL, /*offset=*/0);
 		if (err)
 			return err;
 	}
@@ -2505,7 +2509,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
 				       true, flags, NULL,
-				       *branch_from, symbols);
+				       *branch_from, symbols, /*bid=*/NULL, /*offset=*/0);
 		if (err)
 			return err;
 
@@ -2530,7 +2534,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 			err = add_callchain_ip(thread, cursor, parent,
 					       root_al, &cpumode, ip,
 					       true, flags, NULL,
-					       *branch_from, symbols);
+					       *branch_from, symbols, /*bid=*/NULL, /*offset=*/0);
 			if (err)
 				return err;
 			save_lbr_cursor_node(thread, cursor, i);
@@ -2545,7 +2549,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
 				       true, flags, NULL,
-				       *branch_from, symbols);
+				       *branch_from, symbols, /*bid=*/NULL, /*offset=*/0);
 		if (err)
 			return err;
 		save_lbr_cursor_node(thread, cursor, i);
@@ -2565,7 +2569,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		err = add_callchain_ip(thread, cursor, parent,
 				root_al, &cpumode, ip,
 				true, flags, NULL,
-				*branch_from, symbols);
+				*branch_from, symbols, /*bid=*/NULL, /*offset=*/0);
 		if (err)
 			return err;
 	}
@@ -2829,7 +2833,8 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
 		if (ip >= PERF_CONTEXT_MAX) {
 			err = add_callchain_ip(thread, cursor, parent,
 					       root_al, cpumode, ip,
-					       false, NULL, NULL, 0, symbols);
+					       false, NULL, NULL, 0, symbols,
+					       /*bid=*/NULL, /*offset=*/0);
 			break;
 		}
 	}
@@ -2857,6 +2862,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	struct branch_stack *branch = sample->branch_stack;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	struct ip_callchain *chain = sample->callchain;
+	struct ip_callchain *alloc_chain = NULL;
 	int chain_nr = 0;
 	u8 cpumode = PERF_RECORD_MISC_USER;
 	int i, j, err, nr_entries, usr_idx;
@@ -2864,6 +2870,16 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	int first_call = 0;
 	u64 leaf_frame_caller;
 
+	if (!chain && sample->callchain_bids_nr > 0) {
+		alloc_chain = malloc(sizeof(*chain) + sample->callchain_bids_nr * sizeof(u64));
+		if (alloc_chain) {
+			alloc_chain->nr = sample->callchain_bids_nr;
+			for (i = 0; i < (int)sample->callchain_bids_nr; i++)
+				alloc_chain->ips[i] = ((u64 *)sample->callchain_bids)[i * 4 + 3];
+			chain = alloc_chain;
+		}
+	}
+
 	if (chain)
 		chain_nr = chain->nr;
 
@@ -2874,8 +2890,10 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 						   root_al, max_stack,
 						   !env ? 0 : env->max_branches,
 						   symbols);
-		if (err)
-			return (err < 0) ? err : 0;
+		if (err) {
+			err = (err < 0) ? err : 0;
+			goto out;
+		}
 	}
 
 	/*
@@ -2938,18 +2956,20 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 					       root_al,
 					       NULL, be[i].to,
 					       true, &be[i].flags,
-					       NULL, be[i].from, symbols);
+					       NULL, be[i].from, symbols,
+					       /*bid=*/NULL, /*offset=*/0);
 
 			if (!err) {
 				err = add_callchain_ip(thread, cursor, parent, root_al,
 						       NULL, be[i].from,
 						       true, &be[i].flags,
-						       &iter[i], 0, symbols);
+						       &iter[i], 0, symbols,
+						       /*bid=*/NULL, /*offset=*/0);
 			}
 			if (err == -EINVAL)
 				break;
 			if (err)
-				return err;
+				goto out;
 		}
 
 		if (chain_nr == 0)
@@ -2962,12 +2982,16 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	if (chain && callchain_param.order != ORDER_CALLEE) {
 		err = find_prev_cpumode(chain, thread, cursor, parent, root_al,
 					&cpumode, chain->nr - first_call, symbols);
-		if (err)
-			return (err < 0) ? err : 0;
+		if (err) {
+			err = (err < 0) ? err : 0;
+			goto out;
+		}
 	}
 	for (i = first_call, nr_entries = 0;
 	     i < chain_nr && nr_entries < max_stack; i++) {
 		u64 ip;
+		struct perf_build_id *bid = NULL;
+		u64 offset = 0;
 
 		if (callchain_param.order == ORDER_CALLEE)
 			j = i;
@@ -2979,13 +3003,19 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 			continue;
 #endif
 		ip = chain->ips[j];
+		if (sample->callchain_bids) {
+			bid = (struct perf_build_id *)&((u64 *)sample->callchain_bids)[j * 4];
+			offset = ((u64 *)sample->callchain_bids)[j * 4 + 3];
+		}
 		if (ip < PERF_CONTEXT_MAX)
                        ++nr_entries;
 		else if (callchain_param.order != ORDER_CALLEE) {
 			err = find_prev_cpumode(chain, thread, cursor, parent,
 						root_al, &cpumode, j, symbols);
-			if (err)
-				return (err < 0) ? err : 0;
+			if (err) {
+				err = (err < 0) ? err : 0;
+				goto out;
+			}
 			continue;
 		}
 
@@ -3011,21 +3041,28 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 
 				err = add_callchain_ip(thread, cursor, parent,
 						root_al, &cpumode, leaf_frame_caller,
-						false, NULL, NULL, 0, symbols);
-				if (err)
-					return (err < 0) ? err : 0;
+						false, NULL, NULL, 0, symbols, bid, offset);
+				if (err) {
+					err = (err < 0) ? err : 0;
+					goto out;
+				}
 			}
 		}
 
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
-				       false, NULL, NULL, 0, symbols);
+				       false, NULL, NULL, 0, symbols, bid, offset);
 
-		if (err)
-			return (err < 0) ? err : 0;
+		if (err) {
+			err = (err < 0) ? err : 0;
+			goto out;
+		}
 	}
 
-	return 0;
+	err = 0;
+out:
+	free(alloc_chain);
+	return err;
 }
 
 static int unwind_entry(struct unwind_entry *entry, void *arg)
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index f808df2fe77b..7884720481d8 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -1251,6 +1251,35 @@ static int map__strcmp_name(const void *name, const void *b)
 	return strcmp(name, dso__short_name(dso));
 }
 
+struct map *maps__find_by_build_id(struct maps *maps, struct build_id *bid)
+{
+	struct map *result = NULL;
+	bool done = false;
+
+	/* See locking/sorting note. */
+	while (!done) {
+		down_read(maps__lock(maps));
+		if (maps__maps_by_address_sorted(maps)) {
+			struct map **maps_by_address = maps__maps_by_address(maps);
+			unsigned int nr_maps = maps__nr_maps(maps);
+
+			for (unsigned int i = 0; i < nr_maps; i++) {
+				struct map *map = maps_by_address[i];
+
+				if (dso__build_id_equal(map__dso(map), bid)) {
+					result = map__get(map);
+					break;
+				}
+			}
+			done = true;
+		}
+		up_read(maps__lock(maps));
+		if (!done)
+			maps__sort_by_address(maps);
+	}
+	return result;
+}
+
 struct map *maps__find_by_name(struct maps *maps, const char *name)
 {
 	struct map *result = NULL;
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 4ec9b7453a3b..6f1791457068 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -11,6 +11,7 @@ struct ref_reloc_sym;
 struct machine;
 struct map;
 struct maps;
+struct build_id;
 
 #define KMAP_NAME_LEN 256
 
@@ -76,6 +77,7 @@ int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams);
 int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new);
 
 struct map *maps__find_by_name(struct maps *maps, const char *name);
+struct map *maps__find_by_build_id(struct maps *maps, struct build_id *bid);
 
 struct map *maps__find_next_entry(struct maps *maps, struct map *map);
 
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 3933639d76c5..41ccb45eca86 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -40,7 +40,8 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
 		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
 		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(AUX),
 		bit_name(CGROUP), bit_name(DATA_PAGE_SIZE), bit_name(CODE_PAGE_SIZE),
-		bit_name(WEIGHT_STRUCT),
+		bit_name(WEIGHT_STRUCT), bit_name(BUILD_ID_OFFSET),
+		bit_name(CALLCHAIN_BUILD_ID_OFFSET),
 		{ .name = NULL, }
 	};
 #undef bit_name
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index c4eae8b2fd06..5041c193a953 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -8,6 +8,7 @@
 struct evsel;
 struct machine;
 struct thread;
+struct perf_build_id;
 
 /* number of register is bound by the number of bits in regs_dump::mask (64) */
 #define PERF_SAMPLE_REGS_CACHE_SIZE (8 * sizeof(u64))
@@ -158,6 +159,18 @@ struct perf_sample {
 	u64 code_page_size;
 	/** @cgroup: The sample event PERF_SAMPLE_CGROUP value. */
 	u64 cgroup;
+	/** @bid: The sample event PERF_SAMPLE_BUILD_ID_OFFSET value. */
+	struct {
+		struct perf_build_id *bid;
+		u64 offset;
+	} bid;
+	/**
+	 * @callchain_bids: Build IDs for the callchain when
+	 * PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET is set.
+	 */
+	struct perf_build_id *callchain_bids;
+	/** @callchain_bids_nr: Number of entries in callchain_bids. */
+	u32 callchain_bids_nr;
 	/** @file_offset: Byte offset of this event in the perf.data file. */
 	u64 file_offset;
 	/** @flags: Extra flag data from auxiliary events like intel-pt. */
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index f7dedfb6bab8..a7b2b2a5f6bd 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1701,6 +1701,13 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 		result += sample->aux_sample.size;
 	}
 
+	if (type & PERF_SAMPLE_BUILD_ID_OFFSET)
+		result += sizeof(struct perf_build_id) + sizeof(u64);
+
+	if (type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)
+		result += sizeof(u64) + sample->callchain->nr *
+			  (sizeof(struct perf_build_id) + sizeof(u64));
+
 	return result;
 }
 
@@ -1933,6 +1940,19 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 		array = (void *)array + sz;
 	}
 
+	if (type & PERF_SAMPLE_BUILD_ID_OFFSET) {
+		memcpy(array, sample->bid.bid, sizeof(struct perf_build_id));
+		array += sizeof(struct perf_build_id) / sizeof(u64);
+		*array++ = sample->bid.offset;
+	}
+
+	if (type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) {
+		*array++ = sample->callchain->nr;
+		sz = sample->callchain->nr * (sizeof(struct perf_build_id) + sizeof(u64));
+		memcpy(array, sample->callchain_bids, sz);
+		array += sz / sizeof(u64);
+	}
+
 	return 0;
 }
 
-- 
2.55.0.679.g6767b8d81c-goog

