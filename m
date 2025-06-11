Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB57E22FE19
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 03:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749613595; cv=none; b=SYG27+yz5oG09f80nc9N5hyDkJRsjAVk8faX4F4Okjf8Y133zte4pMTpaJwqGFvgQzfNBDj3HPCWI42chahJCWA5QqJqicmv24ZXD0LaX57hH0N5xzz0SmAc46bpPnVTl6IgSbrDJyQZV0g24tTs0uPVuX2fOZbN5tFCcNPYz+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749613595; c=relaxed/simple;
	bh=Fs3uHti4v9yZBEfnxjYlK8USSwEfLJL7x0TeuyWPZac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Wl1Dtzv0c/Im5y3xH/AGKyvILUVC0E7RWbJYuwr7CguvfO20Xn2DS5J+kdqAIb4gKfcOX8EM+olz6btWFFXwVR7Jp9pU143PG0Ps2uBCtpVU84AMrQvXseyZZamMv3LK722MIyu9QWZZfuWr6Yctm5zSD+4yuNh06SdbdVGvdEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x/x+MmtG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x/x+MmtG"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311b6d25278so6006511a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Jun 2025 20:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749613593; x=1750218393; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jidK+J8wHLfCsvEOoUhiFZtnoCzubn3Ue91/pZrFcok=;
        b=x/x+MmtGayPanncdINHgRsfvswusw1YZPcrCqDU6EbXaae9tupwk3v4RMDwos/r9/I
         3do3PYt5cb/8g2JDT9wneRcvg20y+oAogK6jYnu6AWhD5BfFOaTe8DTax22vXC3dEcUq
         y+HO0sKfKi7rHBqiFVp4RXtzp18wWqglWB0ozIjAT5iTfyjFxxHo6aFBggh5aFcAEbvS
         SYikvik6dpI2FPWACsnLVO1npwJIQd/xJH0W7XijBwuEOAvXBt6De6KArNq2FG7v6Ek2
         dePbQMbN4YpfsEXOSk3LDV6XrsgMbARAG6VJeauL6VEnYXHuaXeo6adB5fpGUUSL45zh
         tf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749613593; x=1750218393;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jidK+J8wHLfCsvEOoUhiFZtnoCzubn3Ue91/pZrFcok=;
        b=ZESO35SRYcu+jHpi+NqT4BS++K8Ap/IxOu1jc8PgESEqcVjgv7V0xWQ4nFvNlvA3gt
         MLyE6uSrrpzAstJMKmXNz/MB89vUN+GFKAI0hu1eLYoqUrBiwvN44XlYf5GE5Ksv4HjG
         UQGT9D2zQ7581ods1b1RcD0qHXD90fzUe7dF3Xf3oWYIPfmwyPjvHeS4VrCrhOsy/vOu
         VBSyq0EelVi3ryL3DwAoEDJXnre9KHSA7ho5MUxIIhZ80RdnwitV3IytBwk/MwPhC2Ii
         vB4T3T6Jo5YXwknx9AcWMIxuQDnWisg37QdN6iCoejygOyGad8oZ8ae3hWBmRgsLkQ2R
         C6mg==
X-Forwarded-Encrypted: i=1; AJvYcCVOZ99rswobjRZQq7zj4dkHNnqn6wYjLNs0oLSU7jdkKs4t6wgqjdtcRtXY96qyWDyXpM+G8mH3W9vAgwXS0BZt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0hyviLFKZHkTPgBIz4mo0c65CcdV4D/PQjg2daqBOWlcA4Zi2
	s4zj+CcKxY9+bT0xgVlVTG48+iGFCSbpbFUUuU1PJB3AMWAOawfRGeMAD7Uw7z8zh8ZsXZaNwQg
	4u/fnNnpnyA==
X-Google-Smtp-Source: AGHT+IHEpctjetcrUFYFNNWUtBi8eMfwIhpazhhw1MJ4MbFFaxqzVAqC224ifoC9fxbdCla06CQM02OGYTrY
X-Received: from pjv12.prod.google.com ([2002:a17:90b:564c:b0:313:2b27:3f90])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d647:b0:313:287c:74bd
 with SMTP id 98e67ed59e1d1-313af266d46mr2917264a91.33.1749613593238; Tue, 10
 Jun 2025 20:46:33 -0700 (PDT)
Date: Tue, 10 Jun 2025 20:45:25 -0700
In-Reply-To: <20250611034529.508842-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611034529.508842-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611034529.508842-12-irogers@google.com>
Subject: [PATCH v1 11/15] perf parse-events: Remove non-json software events
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
index 9dd0216cfae4..4dbae59dccb3 100644
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
index a786cbfb0ff5..362e93fc33d2 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -387,8 +387,6 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
 {
 	print_symbol_events(print_cb, print_state, PERF_TYPE_HARDWARE,
 			event_symbols_hw, PERF_COUNT_HW_MAX);
-	print_symbol_events(print_cb, print_state, PERF_TYPE_SOFTWARE,
-			event_symbols_sw, PERF_COUNT_SW_MAX);
 
 	print_hwcache_events(print_cb, print_state);
 
-- 
2.50.0.rc0.642.g800a2b2222-goog

