Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96152147C9B
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 19:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543919; cv=none; b=Wlm8foekJ8AyRvyU44meUqVnLk8rqUPJGEn3MXTEOIhV3We5qNlNENQ3nftIQjynlrCT9gH6amoFM1c3nYnKbhcM+C3DoBjUMlA+TqQ87ZRMNROEfJmYlJDin8jGhKTPvmBlevJ14jk32ym1ouUwxmNjHRcIhj55C/ddhSFlMA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543919; c=relaxed/simple;
	bh=qa4R15qOtzR/BH3eD0r26mPAJuG5D1h7By2gS57JXe4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=emCv2Maz5gVzN7Z+Dd53Yd6ej5eNEeeoULGLdUOPf+0bNR3uqPJybXM1zKNZkWdLeG9Yu2Tc3qZ2s3iUvUqsWQldTWGlAC2d+wwgkT3yqjnwu5kfVKT7Ut/iHKH2paxHa9z1a8caMFrSnu90wnpHaUc63dv6gjtJcGfEfuLPEA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fBkhZOTm; arc=none smtp.client-ip=209.85.222.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBkhZOTm"
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-89019048929so8819522241.2
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 12:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755543916; x=1756148716; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AeQy6U6Mcs+KaMWERQdrKYPgECEKs1fDnJTxQRr5IIg=;
        b=fBkhZOTmDW1Qq9cScgjCtBJKDryRuCkpfYdmwjXk1uR6i0tI8ica+GK+WKnGJZvA9O
         DNfnNBWvcJOEyJT+M2PG2PJE+7wHPr2/H/tbyMv/bon36exYVuel8Mw41jPYlRl2jBts
         IFLFIzsWWfcUiWcvRA5yIYZVqbt/aKJNEnJ/KtotS79GjNXBO6EyM2H09yf91QgerZaJ
         x87YYf7ZkZlLwmnE4lfsvbTMR9s47BsjNHxPGobcd1RO2AGrDshiKVw9UrZrxDH6z2WA
         IMenRNMf7JvQbTKgAjf3rQntuDK4Q6EF6+93QbBhcsN/UM87J933lnoeDfWLDecDHEua
         GuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755543916; x=1756148716;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AeQy6U6Mcs+KaMWERQdrKYPgECEKs1fDnJTxQRr5IIg=;
        b=ZTj7MDn8kZJ4R03IpwhBkeV/YQYdlIgq7N/UiqSyco64bWCtoUGIJNWWvkvaANWaIT
         TzRHrhDttLuIE/+JHJ4d8xyEu7j2KKEtxr88bdJ5zd1+Rx4seqGQltD6xJuu0bPXJ326
         pZGVOq7I3pdBFcoWLBEPGtD+Ft0lV6yO2wi0E+mXkHrZa0TCjk7+Q5V+/WvfyL+w7zDc
         q4UTOtcy/AHyUw8eFtvADjBzH4YZX4Uv5xUOuNPbY9nR0O00wuLuzSi/o9ZqeHlRd4Hk
         us49jmiuSSuTTOEIh0lr6DWxfr74b9T/vMmhZKXWFjwFDACQ3JM8PZ8tspc/HHxdWXyi
         lAFA==
X-Forwarded-Encrypted: i=1; AJvYcCWeL7CrLowzbAB6v6GfM43BPrI2A7fkJWRH8GRsz4D/qC6h/q3bL/RuVAGeB6cJNvtiPKaMntqTSvZZsIPdjHs6@vger.kernel.org
X-Gm-Message-State: AOJu0YxVLFuIRWvM85EjxgsF3mOmzfVDpED3bnaFvSTvCa3wfpxcOPaD
	gtmMokl9bIWzN78LFvkJlS3EVPfOuKb3Smng+NndxVD3KFTf7QB2GNfVdc+E5RvS8MZHs0o6yw4
	c+eyIQV/N8Q==
X-Google-Smtp-Source: AGHT+IEfHh5zGZXDJ9T3IT6pTGa5q70K/Gu2z6P2zjPHw2vIVBLhzL3OtHQqqFDhXcyKpJAh+Pcx/6lmk97i
X-Received: from qkntz8.prod.google.com ([2002:a05:620a:6908:b0:7e2:e9ed:1448])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6102:dcb:b0:4fa:d2c:4ff
 with SMTP id ada2fe7eead31-514cb1a5babmr4171144137.27.1755543916305; Mon, 18
 Aug 2025 12:05:16 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:03:57 -0700
In-Reply-To: <20250818190416.145274-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818190416.145274-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250818190416.145274-2-irogers@google.com>
Subject: [PATCH v2 01/20] perf parse-events: Handle fake PMUs in CPU terms
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

The "Parsing of PMU event table metrics with fake PMUs" will test
metrics on machines/models that may be missing a PMU, in such a case
the fake_pmu should be used to avoid errors. Metrics that get the
cpumask from a different PMU, such as "tsc/cpu=cpu_atom/", also need
to be resilient in this test. The parse_events_state fake_pmu is set
when missing PMUs should be ignored. So that it can be queried, pass
it to the config term functions, as well as to get_config_cpu, then
ignore failures when fake_pmu is set.

Some minor code refactoring to cut down on the indent and remove some
redundant checks.

Fixes: bd741d80dc65 ("perf parse-events: Allow the cpu term to be a PMU or CPU range")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 116 +++++++++++++++++----------------
 1 file changed, 60 insertions(+), 56 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 8282ddf68b98..0026cff4d69e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -126,7 +126,8 @@ static char *get_config_name(const struct parse_events_terms *head_terms)
 	return get_config_str(head_terms, PARSE_EVENTS__TERM_TYPE_NAME);
 }
 
-static struct perf_cpu_map *get_config_cpu(const struct parse_events_terms *head_terms)
+static struct perf_cpu_map *get_config_cpu(const struct parse_events_terms *head_terms,
+					   bool fake_pmu)
 {
 	struct parse_events_term *term;
 	struct perf_cpu_map *cpus = NULL;
@@ -135,24 +136,33 @@ static struct perf_cpu_map *get_config_cpu(const struct parse_events_terms *head
 		return NULL;
 
 	list_for_each_entry(term, &head_terms->terms, list) {
-		if (term->type_term == PARSE_EVENTS__TERM_TYPE_CPU) {
-			struct perf_cpu_map *term_cpus;
+		struct perf_cpu_map *term_cpus;
 
-			if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM) {
-				term_cpus = perf_cpu_map__new_int(term->val.num);
+		if (term->type_term != PARSE_EVENTS__TERM_TYPE_CPU)
+			continue;
+
+		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM) {
+			term_cpus = perf_cpu_map__new_int(term->val.num);
+		} else {
+			struct perf_pmu *pmu = perf_pmus__find(term->val.str);
+
+			if (pmu) {
+				term_cpus = pmu->is_core && perf_cpu_map__is_empty(pmu->cpus)
+					    ? cpu_map__online()
+					    : perf_cpu_map__get(pmu->cpus);
 			} else {
-				struct perf_pmu *pmu = perf_pmus__find(term->val.str);
-
-				if (pmu && perf_cpu_map__is_empty(pmu->cpus))
-					term_cpus = pmu->is_core ? cpu_map__online() : NULL;
-				else if (pmu)
-					term_cpus = perf_cpu_map__get(pmu->cpus);
-				else
-					term_cpus = perf_cpu_map__new(term->val.str);
+				term_cpus = perf_cpu_map__new(term->val.str);
+				if (!term_cpus && fake_pmu) {
+					/*
+					 * Assume the PMU string makes sense on a different
+					 * machine and fake a value with all online CPUs.
+					 */
+					term_cpus = cpu_map__online();
+				}
 			}
-			perf_cpu_map__merge(&cpus, term_cpus);
-			perf_cpu_map__put(term_cpus);
 		}
+		perf_cpu_map__merge(&cpus, term_cpus);
+		perf_cpu_map__put(term_cpus);
 	}
 
 	return cpus;
@@ -369,13 +379,13 @@ static int parse_aliases(const char *str, const char *const names[][EVSEL__MAX_A
 
 typedef int config_term_func_t(struct perf_event_attr *attr,
 			       struct parse_events_term *term,
-			       struct parse_events_error *err);
+			       struct parse_events_state *parse_state);
 static int config_term_common(struct perf_event_attr *attr,
 			      struct parse_events_term *term,
-			      struct parse_events_error *err);
+			      struct parse_events_state *parse_state);
 static int config_attr(struct perf_event_attr *attr,
 		       const struct parse_events_terms *head,
-		       struct parse_events_error *err,
+		       struct parse_events_state *parse_state,
 		       config_term_func_t config_term);
 
 /**
@@ -471,7 +481,7 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 	bool found_supported = false;
 	const char *config_name = get_config_name(parsed_terms);
 	const char *metric_id = get_config_metric_id(parsed_terms);
-	struct perf_cpu_map *cpus = get_config_cpu(parsed_terms);
+	struct perf_cpu_map *cpus = get_config_cpu(parsed_terms, parse_state->fake_pmu);
 	int ret = 0;
 	struct evsel *first_wildcard_match = NULL;
 
@@ -514,8 +524,7 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 		found_supported = true;
 
 		if (parsed_terms) {
-			if (config_attr(&attr, parsed_terms, parse_state->error,
-					config_term_common)) {
+			if (config_attr(&attr, parsed_terms, parse_state, config_term_common)) {
 				ret = -EINVAL;
 				goto out_err;
 			}
@@ -767,8 +776,7 @@ int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 	attr.sample_period = 1;
 
 	if (head_config) {
-		if (config_attr(&attr, head_config, parse_state->error,
-				config_term_common))
+		if (config_attr(&attr, head_config, parse_state, config_term_common))
 			return -EINVAL;
 
 		if (get_config_terms(head_config, &config_terms))
@@ -903,12 +911,12 @@ void parse_events__shrink_config_terms(void)
 
 static int config_term_common(struct perf_event_attr *attr,
 			      struct parse_events_term *term,
-			      struct parse_events_error *err)
+			      struct parse_events_state *parse_state)
 {
-#define CHECK_TYPE_VAL(type)						   \
-do {									   \
-	if (check_type_val(term, err, PARSE_EVENTS__TERM_TYPE_ ## type)) \
-		return -EINVAL;						   \
+#define CHECK_TYPE_VAL(type)								\
+do {											\
+	if (check_type_val(term, parse_state->error, PARSE_EVENTS__TERM_TYPE_ ## type))	\
+		return -EINVAL;								\
 } while (0)
 
 	switch (term->type_term) {
@@ -939,7 +947,7 @@ do {									   \
 		if (strcmp(term->val.str, "no") &&
 		    parse_branch_str(term->val.str,
 				    &attr->branch_sample_type)) {
-			parse_events_error__handle(err, term->err_val,
+			parse_events_error__handle(parse_state->error, term->err_val,
 					strdup("invalid branch sample type"),
 					NULL);
 			return -EINVAL;
@@ -948,7 +956,7 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_TIME:
 		CHECK_TYPE_VAL(NUM);
 		if (term->val.num > 1) {
-			parse_events_error__handle(err, term->err_val,
+			parse_events_error__handle(parse_state->error, term->err_val,
 						strdup("expected 0 or 1"),
 						NULL);
 			return -EINVAL;
@@ -990,7 +998,7 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_PERCORE:
 		CHECK_TYPE_VAL(NUM);
 		if ((unsigned int)term->val.num > 1) {
-			parse_events_error__handle(err, term->err_val,
+			parse_events_error__handle(parse_state->error, term->err_val,
 						strdup("expected 0 or 1"),
 						NULL);
 			return -EINVAL;
@@ -1005,7 +1013,7 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 		CHECK_TYPE_VAL(NUM);
 		if (term->val.num > UINT_MAX) {
-			parse_events_error__handle(err, term->err_val,
+			parse_events_error__handle(parse_state->error, term->err_val,
 						strdup("too big"),
 						NULL);
 			return -EINVAL;
@@ -1016,7 +1024,7 @@ do {									   \
 
 		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM) {
 			if (term->val.num >= (u64)cpu__max_present_cpu().cpu) {
-				parse_events_error__handle(err, term->err_val,
+				parse_events_error__handle(parse_state->error, term->err_val,
 							strdup("too big"),
 							/*help=*/NULL);
 				return -EINVAL;
@@ -1028,8 +1036,8 @@ do {									   \
 			break;
 
 		map = perf_cpu_map__new(term->val.str);
-		if (!map) {
-			parse_events_error__handle(err, term->err_val,
+		if (!map && !parse_state->fake_pmu) {
+			parse_events_error__handle(parse_state->error, term->err_val,
 						   strdup("not a valid PMU or CPU number"),
 						   /*help=*/NULL);
 			return -EINVAL;
@@ -1042,7 +1050,7 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 	default:
-		parse_events_error__handle(err, term->err_term,
+		parse_events_error__handle(parse_state->error, term->err_term,
 					strdup(parse_events__term_type_str(term->type_term)),
 					parse_events_formats_error_string(NULL));
 		return -EINVAL;
@@ -1057,7 +1065,7 @@ do {									   \
 	 * if an invalid config term is provided for legacy events
 	 * (for example, instructions/badterm/...), which is confusing.
 	 */
-	if (!config_term_avail(term->type_term, err))
+	if (!config_term_avail(term->type_term, parse_state->error))
 		return -EINVAL;
 	return 0;
 #undef CHECK_TYPE_VAL
@@ -1065,7 +1073,7 @@ do {									   \
 
 static int config_term_pmu(struct perf_event_attr *attr,
 			   struct parse_events_term *term,
-			   struct parse_events_error *err)
+			   struct parse_events_state *parse_state)
 {
 	if (term->type_term == PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE) {
 		struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
@@ -1074,7 +1082,7 @@ static int config_term_pmu(struct perf_event_attr *attr,
 			char *err_str;
 
 			if (asprintf(&err_str, "Failed to find PMU for type %d", attr->type) >= 0)
-				parse_events_error__handle(err, term->err_term,
+				parse_events_error__handle(parse_state->error, term->err_term,
 							   err_str, /*help=*/NULL);
 			return -EINVAL;
 		}
@@ -1100,7 +1108,7 @@ static int config_term_pmu(struct perf_event_attr *attr,
 			char *err_str;
 
 			if (asprintf(&err_str, "Failed to find PMU for type %d", attr->type) >= 0)
-				parse_events_error__handle(err, term->err_term,
+				parse_events_error__handle(parse_state->error, term->err_term,
 							   err_str, /*help=*/NULL);
 			return -EINVAL;
 		}
@@ -1128,12 +1136,12 @@ static int config_term_pmu(struct perf_event_attr *attr,
 		 */
 		return 0;
 	}
-	return config_term_common(attr, term, err);
+	return config_term_common(attr, term, parse_state);
 }
 
 static int config_term_tracepoint(struct perf_event_attr *attr,
 				  struct parse_events_term *term,
-				  struct parse_events_error *err)
+				  struct parse_events_state *parse_state)
 {
 	switch (term->type_term) {
 	case PARSE_EVENTS__TERM_TYPE_CALLGRAPH:
@@ -1147,7 +1155,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
 	case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
 	case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
-		return config_term_common(attr, term, err);
+		return config_term_common(attr, term, parse_state);
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_CONFIG:
 	case PARSE_EVENTS__TERM_TYPE_CONFIG1:
@@ -1166,12 +1174,10 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 	case PARSE_EVENTS__TERM_TYPE_CPU:
 	default:
-		if (err) {
-			parse_events_error__handle(err, term->err_term,
+		parse_events_error__handle(parse_state->error, term->err_term,
 					strdup(parse_events__term_type_str(term->type_term)),
 					strdup("valid terms: call-graph,stack-size\n")
 				);
-		}
 		return -EINVAL;
 	}
 
@@ -1180,13 +1186,13 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 
 static int config_attr(struct perf_event_attr *attr,
 		       const struct parse_events_terms *head,
-		       struct parse_events_error *err,
+		       struct parse_events_state *parse_state,
 		       config_term_func_t config_term)
 {
 	struct parse_events_term *term;
 
 	list_for_each_entry(term, &head->terms, list)
-		if (config_term(attr, term, err))
+		if (config_term(attr, term, parse_state))
 			return -EINVAL;
 
 	return 0;
@@ -1378,8 +1384,7 @@ int parse_events_add_tracepoint(struct parse_events_state *parse_state,
 	if (head_config) {
 		struct perf_event_attr attr;
 
-		if (config_attr(&attr, head_config, err,
-				config_term_tracepoint))
+		if (config_attr(&attr, head_config, parse_state, config_term_tracepoint))
 			return -EINVAL;
 	}
 
@@ -1408,8 +1413,7 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 	}
 
 	if (head_config) {
-		if (config_attr(&attr, head_config, parse_state->error,
-				config_term_common))
+		if (config_attr(&attr, head_config, parse_state, config_term_common))
 			return -EINVAL;
 
 		if (get_config_terms(head_config, &config_terms))
@@ -1418,7 +1422,7 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 
 	name = get_config_name(head_config);
 	metric_id = get_config_metric_id(head_config);
-	cpus = get_config_cpu(head_config);
+	cpus = get_config_cpu(head_config, parse_state->fake_pmu);
 	ret = __add_event(list, &parse_state->idx, &attr, /*init_attr*/true, name,
 			metric_id, pmu, &config_terms, first_wildcard_match,
 			cpus, /*alternate_hw_config=*/PERF_COUNT_HW_MAX) ? 0 : -ENOMEM;
@@ -1531,7 +1535,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	fix_raw(&parsed_terms, pmu);
 
 	/* Configure attr/terms with a known PMU, this will set hardcoded terms. */
-	if (config_attr(&attr, &parsed_terms, parse_state->error, config_term_pmu)) {
+	if (config_attr(&attr, &parsed_terms, parse_state, config_term_pmu)) {
 		parse_events_terms__exit(&parsed_terms);
 		return -EINVAL;
 	}
@@ -1555,7 +1559,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 	/* Configure attr/terms again if an alias was expanded. */
 	if (alias_rewrote_terms &&
-	    config_attr(&attr, &parsed_terms, parse_state->error, config_term_pmu)) {
+	    config_attr(&attr, &parsed_terms, parse_state, config_term_pmu)) {
 		parse_events_terms__exit(&parsed_terms);
 		return -EINVAL;
 	}
@@ -1583,7 +1587,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return -EINVAL;
 	}
 
-	term_cpu = get_config_cpu(&parsed_terms);
+	term_cpu = get_config_cpu(&parsed_terms, parse_state->fake_pmu);
 	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
 			    get_config_name(&parsed_terms),
 			    get_config_metric_id(&parsed_terms), pmu,
-- 
2.51.0.rc1.167.g924127e9c0-goog

