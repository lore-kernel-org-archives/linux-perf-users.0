Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FA31D63F5
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751069400; cv=none; b=lt7ekCOD9hbM4Mi0GLSmGQpGuivAOIgQ/ECH7WxEacp82QKZ9CUlqayP4bAKjYGOfCgobBmEI1JpkYAyXWamQphUzH/auTV3D7xrz0NISmq9exAGdASSzl0bbUy7vBAdqvFlcG2YoYeqsucWBGM3nmntfNH8uRgxjOBNqryz06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751069400; c=relaxed/simple;
	bh=G72bnfuAzESwqoklX8PNfdwVx67YCWOYAKzlNjKKZ4c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PjXet3kXTokatZEXw5X6OM/XnvYpm6BNiX8fUPcyBw5cq5/kH4D96WMsmGYolPCJdYtL/SxmGGkPg547H+3bDUeKAKr6z9xka6I+OYz95wST01hj6EJM6qJ5a0xybphvTN42Rir1DUMrX1l5/i7UChKybpc/qZa70jaZT27Z/DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b1b7dZF8; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b1b7dZF8"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-740774348f6so2301707b3a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 17:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751069397; x=1751674197; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLjJFNtTS5wrZiD3O0j9/NWWZofN5Wd2O/PmGh4D0Bc=;
        b=b1b7dZF82t1GPIkB7Xuph7pPRty78+wwHTiHY1dd6q/cr2DxdPYpMAON+la0v7d+Fu
         3yQKKh5cEy2UyvSjXdSh2hokpZ2C2SiXtR1u2X7q7c/J1JOqnTWLcPyiRj837NJ40F7J
         8JCMk7ESlONk9xwQYpFiVFWfJCIvyjaHM71stI7qnT4iN5EIuAkrAqTfBfC+YJzjTAiU
         YTVatC7oRja3hkzEj2ejJtvaQG7uqTKRyPl9BQ+A+9iIF6KgPpa0LPiUPpmRfWdHjQAV
         zQ3WpEC5qaQKOnv0e6cK4tZXEbf8JhwQahB3LQzvEokrkGrH2Oda5dLwstlUCFAi5AL7
         +A1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751069397; x=1751674197;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLjJFNtTS5wrZiD3O0j9/NWWZofN5Wd2O/PmGh4D0Bc=;
        b=G5nqxGhIEFY7Oyo98/Wuk0p+WfZnaIi7FFDe3Rs0a4hiQKmsys3h0IEpoKAN8D1Lom
         1XPEQhJP3ijEYu+SJOek8VyfVMDjH6WF7mTxevabbpEGlSregYVjdrURsf6AabvaH5v7
         FuSzE4MBKkKJRToZKYSXSA745fTZNwdT74CX+7+mLCZZjvESLibqOr8V7RdqtmV19XDW
         FOmLCxNz5bZdmChurA7opVVqXxNLUGMcbB8qAviVGbH7dX78Q4TohDDnHAQozA1molEL
         1JZXAzdPQTKhE7Vo211onjTb/kLlxvAP6GCoBKr/Jg5I+ZhPUyst5GcbLNKmVFsXZmCX
         y0xw==
X-Forwarded-Encrypted: i=1; AJvYcCVP+STwDAAsrqoo7aP0/C0JCcmmIb8aSLGpqcLx3fD6OGc4AdvY9jqB+DfvBlqMmG/S/k5sOjns5HSKC2d+Vklx@vger.kernel.org
X-Gm-Message-State: AOJu0YxnKyz/pQzchA1VUH5+EGiQtOziAvRPZnqqSdfK6XP36ZK0oZBu
	QXMqyIi1o4B5iyI0BW4yP1qB+lywVZjwkaCp8xk0hBj2myPceWNPM16z35qZ3cqjDkgsSF4Pelj
	xXMigyHUBcA==
X-Google-Smtp-Source: AGHT+IHWMy1Kqp83lLK+2KsTyyTJ2bfqVkuMAHHQbCsIYBoQ13GK0VtEBDNZ6lyiQB9ACXAys8eoTDvUfn14
X-Received: from pfbhw14.prod.google.com ([2002:a05:6a00:890e:b0:748:fb38:1909])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:cc1:b0:736:50d1:fc84
 with SMTP id d2e1a72fcca58-74af6f57829mr6430055b3a.21.1751069397176; Fri, 27
 Jun 2025 17:09:57 -0700 (PDT)
Date: Fri, 27 Jun 2025 17:09:25 -0700
In-Reply-To: <20250628000929.230406-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628000929.230406-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628000929.230406-12-irogers@google.com>
Subject: [PATCH v4 11/15] perf parse-events: Remove non-json software events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove the hard coded encodings from parse-events. This has the
consequence that software events are matched using the sysfs/json
priority, will be case insensitive and will be wildcarded across PMUs.
As there were software and hardware types in the parsing code, the
removal means software vs hardware logic can be removed and hardware
assumed.

Now the perf json provides detailed descriptions of software events,
remove the previous listing support that didn't contain event
descriptions. When globbing is required for the "sw" option in perf
list, use string PMU globbing as was done previously for the tool PMU.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c      | 19 ++++++-------
 tools/perf/util/parse-events.c | 51 ----------------------------------
 tools/perf/util/parse-events.h |  1 -
 tools/perf/util/parse-events.l | 38 +++++++++----------------
 tools/perf/util/parse-events.y | 29 ++++++++-----------
 tools/perf/util/print-events.c |  2 --
 6 files changed, 33 insertions(+), 107 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index e9b595d75df2..674bb0afbf93 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -623,16 +623,17 @@ int cmd_list(int argc, const char **argv)
 		else if (strcmp(argv[i], "sw") == 0 ||
 			 strcmp(argv[i], "software") == 0) {
 			char *old_pmu_glob = default_ps.pmu_glob;
+			static const char * const sw_globs[] = { "software", "tool" };
 
-			print_symbol_events(&print_cb, ps, PERF_TYPE_SOFTWARE,
-					event_symbols_sw, PERF_COUNT_SW_MAX);
-			default_ps.pmu_glob = strdup("tool");
-			if (!default_ps.pmu_glob) {
-				ret = -1;
-				goto out;
+			for (size_t j = 0; j < ARRAY_SIZE(sw_globs); j++) {
+				default_ps.pmu_glob = strdup(sw_globs[j]);
+				if (!default_ps.pmu_glob) {
+					ret = -1;
+					goto out;
+				}
+				perf_pmus__print_pmu_events(&print_cb, ps);
+				zfree(&default_ps.pmu_glob);
 			}
-			perf_pmus__print_pmu_events(&print_cb, ps);
-			zfree(&default_ps.pmu_glob);
 			default_ps.pmu_glob = old_pmu_glob;
 		} else if (strcmp(argv[i], "cache") == 0 ||
 			 strcmp(argv[i], "hwcache") == 0)
@@ -679,8 +680,6 @@ int cmd_list(int argc, const char **argv)
 			default_ps.event_glob = s;
 			print_symbol_events(&print_cb, ps, PERF_TYPE_HARDWARE,
 					event_symbols_hw, PERF_COUNT_HW_MAX);
-			print_symbol_events(&print_cb, ps, PERF_TYPE_SOFTWARE,
-					event_symbols_sw, PERF_COUNT_SW_MAX);
 			print_hwcache_events(&print_cb, ps);
 			perf_pmus__print_pmu_events(&print_cb, ps);
 			print_tracepoint_events(&print_cb, ps);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a59ae5ca0f89..1ae481c9802b 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -84,57 +84,6 @@ const struct event_symbol event_symbols_hw[PERF_COUNT_HW_MAX] = {
 	},
 };
 
-const struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
-	[PERF_COUNT_SW_CPU_CLOCK] = {
-		.symbol = "cpu-clock",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_TASK_CLOCK] = {
-		.symbol = "task-clock",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_PAGE_FAULTS] = {
-		.symbol = "page-faults",
-		.alias  = "faults",
-	},
-	[PERF_COUNT_SW_CONTEXT_SWITCHES] = {
-		.symbol = "context-switches",
-		.alias  = "cs",
-	},
-	[PERF_COUNT_SW_CPU_MIGRATIONS] = {
-		.symbol = "cpu-migrations",
-		.alias  = "migrations",
-	},
-	[PERF_COUNT_SW_PAGE_FAULTS_MIN] = {
-		.symbol = "minor-faults",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_PAGE_FAULTS_MAJ] = {
-		.symbol = "major-faults",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_ALIGNMENT_FAULTS] = {
-		.symbol = "alignment-faults",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_EMULATION_FAULTS] = {
-		.symbol = "emulation-faults",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_DUMMY] = {
-		.symbol = "dummy",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_BPF_OUTPUT] = {
-		.symbol = "bpf-output",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_CGROUP_SWITCHES] = {
-		.symbol = "cgroup-switches",
-		.alias  = "",
-	},
-};
-
 static const char *const event_types[] = {
 	[PERF_TYPE_HARDWARE]	= "hardware",
 	[PERF_TYPE_SOFTWARE]	= "software",
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index b47bf2810112..62dc7202e3ba 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -264,7 +264,6 @@ struct event_symbol {
 	const char	*alias;
 };
 extern const struct event_symbol event_symbols_hw[];
-extern const struct event_symbol event_symbols_sw[];
 
 char *parse_events_formats_error_string(char *additional_terms);
 
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 4af7b9c1f44d..2034590eb789 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -117,12 +117,12 @@ do {								\
 	yyless(0);						\
 } while (0)
 
-static int sym(yyscan_t scanner, int type, int config)
+static int sym(yyscan_t scanner, int config)
 {
 	YYSTYPE *yylval = parse_events_get_lval(scanner);
 
-	yylval->num = (type << 16) + config;
-	return type == PERF_TYPE_HARDWARE ? PE_VALUE_SYM_HW : PE_VALUE_SYM_SW;
+	yylval->num = config;
+	return PE_VALUE_SYM_HW;
 }
 
 static int term(yyscan_t scanner, enum parse_events__term_type type)
@@ -391,28 +391,16 @@ r0x{num_raw_hex}	{ return str(yyscanner, PE_RAW); }
 <<EOF>>			{ BEGIN(INITIAL); }
 }
 
-cpu-cycles|cycles				{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_CPU_CYCLES); }
-stalled-cycles-frontend|idle-cycles-frontend	{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
-stalled-cycles-backend|idle-cycles-backend	{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
-instructions					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_INSTRUCTIONS); }
-cache-references				{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_CACHE_REFERENCES); }
-cache-misses					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_CACHE_MISSES); }
-branch-instructions|branches			{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_BRANCH_INSTRUCTIONS); }
-branch-misses					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_BRANCH_MISSES); }
-bus-cycles					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_BUS_CYCLES); }
-ref-cycles					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_REF_CPU_CYCLES); }
-cpu-clock					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CPU_CLOCK); }
-task-clock					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_TASK_CLOCK); }
-page-faults|faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_PAGE_FAULTS); }
-minor-faults					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_PAGE_FAULTS_MIN); }
-major-faults					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_PAGE_FAULTS_MAJ); }
-context-switches|cs				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CONTEXT_SWITCHES); }
-cpu-migrations|migrations			{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CPU_MIGRATIONS); }
-alignment-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_ALIGNMENT_FAULTS); }
-emulation-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_EMULATION_FAULTS); }
-dummy						{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
-bpf-output					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
-cgroup-switches					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CGROUP_SWITCHES); }
+cpu-cycles|cycles				{ return sym(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
+stalled-cycles-frontend|idle-cycles-frontend	{ return sym(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
+stalled-cycles-backend|idle-cycles-backend	{ return sym(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
+instructions					{ return sym(yyscanner, PERF_COUNT_HW_INSTRUCTIONS); }
+cache-references				{ return sym(yyscanner, PERF_COUNT_HW_CACHE_REFERENCES); }
+cache-misses					{ return sym(yyscanner, PERF_COUNT_HW_CACHE_MISSES); }
+branch-instructions|branches			{ return sym(yyscanner, PERF_COUNT_HW_BRANCH_INSTRUCTIONS); }
+branch-misses					{ return sym(yyscanner, PERF_COUNT_HW_BRANCH_MISSES); }
+bus-cycles					{ return sym(yyscanner, PERF_COUNT_HW_BUS_CYCLES); }
+ref-cycles					{ return sym(yyscanner, PERF_COUNT_HW_REF_CPU_CYCLES); }
 
 {lc_type}			{ return str(yyscanner, PE_LEGACY_CACHE); }
 {lc_type}-{lc_op_result}	{ return str(yyscanner, PE_LEGACY_CACHE); }
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index f888cbb076d6..a2361c0040d7 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -55,7 +55,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %}
 
 %token PE_START_EVENTS PE_START_TERMS
-%token PE_VALUE PE_VALUE_SYM_HW PE_VALUE_SYM_SW PE_TERM
+%token PE_VALUE PE_VALUE_SYM_HW PE_TERM
 %token PE_EVENT_NAME
 %token PE_RAW PE_NAME
 %token PE_MODIFIER_EVENT PE_MODIFIER_BP PE_BP_COLON PE_BP_SLASH
@@ -66,10 +66,8 @@ static void free_list_evsel(struct list_head* list_evsel)
 %token PE_TERM_HW
 %type <num> PE_VALUE
 %type <num> PE_VALUE_SYM_HW
-%type <num> PE_VALUE_SYM_SW
 %type <mod> PE_MODIFIER_EVENT
 %type <term_type> PE_TERM
-%type <num> value_sym
 %type <str> PE_RAW
 %type <str> PE_NAME
 %type <str> PE_LEGACY_CACHE
@@ -306,24 +304,19 @@ PE_NAME sep_dc
 	$$ = list;
 }
 
-value_sym:
-PE_VALUE_SYM_HW
-|
-PE_VALUE_SYM_SW
-
 event_legacy_symbol:
-value_sym '/' event_config '/'
+PE_VALUE_SYM_HW '/' event_config '/'
 {
 	struct list_head *list;
-	int type = $1 >> 16;
-	int config = $1 & 255;
 	int err;
-	bool wildcard = (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE);
 
 	list = alloc_list();
 	if (!list)
 		YYNOMEM;
-	err = parse_events_add_numeric(_parse_state, list, type, config, $3, wildcard);
+	err = parse_events_add_numeric(_parse_state, list,
+				       PERF_TYPE_HARDWARE, $1,
+				       $3,
+				       /*wildcard=*/true);
 	parse_events_terms__delete($3);
 	if (err) {
 		free_list_evsel(list);
@@ -332,18 +325,18 @@ value_sym '/' event_config '/'
 	$$ = list;
 }
 |
-value_sym sep_slash_slash_dc
+PE_VALUE_SYM_HW sep_slash_slash_dc
 {
 	struct list_head *list;
-	int type = $1 >> 16;
-	int config = $1 & 255;
-	bool wildcard = (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE);
 	int err;
 
 	list = alloc_list();
 	if (!list)
 		YYNOMEM;
-	err = parse_events_add_numeric(_parse_state, list, type, config, /*head_config=*/NULL, wildcard);
+	err = parse_events_add_numeric(_parse_state, list,
+				       PERF_TYPE_HARDWARE, $1,
+				       /*head_config=*/NULL,
+				       /*wildcard=*/true);
 	if (err)
 		PE_ABORT(err);
 	$$ = list;
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 83aaf7cda635..5c10d8fdfd7d 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -388,8 +388,6 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
 {
 	print_symbol_events(print_cb, print_state, PERF_TYPE_HARDWARE,
 			event_symbols_hw, PERF_COUNT_HW_MAX);
-	print_symbol_events(print_cb, print_state, PERF_TYPE_SOFTWARE,
-			event_symbols_sw, PERF_COUNT_SW_MAX);
 
 	print_hwcache_events(print_cb, print_state);
 
-- 
2.50.0.727.gbf7dc18ff4-goog

