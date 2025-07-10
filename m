Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D672FD595
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179829; cv=none; b=Mcl/tNtNXC7wbGlWvZaNxcf9lnE3tM6h99YCAZ2Nhx6B81e/quJIHH9SilC9wd3gqT3Zsvo6bUJwTMCDuRTOiLDU9t91LZ02KzmHfWBMwqxzMXtZ5fJvuuPb4VwmwvIPoKxXqITaGBjYDqmMy+8cY5JDNrmyRVYpxjagUZ4GPx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179829; c=relaxed/simple;
	bh=hQokINY7w1ShrrgZa7yZzzTcBe2DFkxckj5lH340Cec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=JuuKDvEPClGHUst2IKOPdhPIXfpMbVDBWKlnNpogm8K9Wv8gDKwR2kQQjrLKybxIYdEexlxHPUYBU2vG8WraqYhbOjTqrZuDi4yiAYozObCRHf4XjBZMgAAs1QV4ekbED4ST6CZnXRIbiu3XwI0QNfR4ImdYS0vf+aoJmzMy6BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vmtBZej1; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vmtBZej1"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3184712fd8so1088517a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 13:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752179827; x=1752784627; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rlDQWnF9PwaPlaf+aejcqkoEmXJ/40GLuFVvGJ4bgdI=;
        b=vmtBZej1KuvrlEEFFeLHuIghV6L+MN/iypGvqbg535Slr5ZfDyZ0pt9EavV+wyPUx/
         Q+tTOHYzBNridXqpy81vqNzSNSL7A3Ivm171/QmFmEZJKrOF2MN+E+KOG6IBvlEktBHw
         N1m1D7+PTlMHaOBkI/yKsR4D5uWgEpDlTbgc9axnrNFPmbURanU0ekYzLIESNf/zDdhG
         KvZF/lSxlz8xclVsUAH0t40D/dJr8Y4QCpqzOoJia21Rl1j3uMLXIZXvxPb7dtx4KBf+
         bbmsYVCFu5cseBwjD9hk4F1Kq17BGtnwsWoOyT1pbaYDwebobrNsSuZdo5cSEM0xPQp5
         WJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179827; x=1752784627;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rlDQWnF9PwaPlaf+aejcqkoEmXJ/40GLuFVvGJ4bgdI=;
        b=RD8EM88LkLKcLqX6ChHloJob/Ny7Wr2VJueAJhjJ8HqHqRGbVLXZ2Oawc3mP7Cz1m0
         HP4XKzA7Y6hH3KAsZeUUcv5Y9/FQYAp77Bk3NIXoGzPgiuNkqMfvWLctdA9Mk5B9tNPp
         hjN92RUGH5awu8jiBMHY0eMCaIeThWQ4Y6bF0b+W/2H0J0U/huH+Ik/D2Ouc+y6sOxWc
         uPDsVy+PFJjmWhTIPPb3pcl07tbxYuw63F2IArwgXgQIo4zC5Mb409HGQCYCvgzG89Yf
         iVlybxu+Ta+Ddf3XLYPmlCFeGT+ykmIWYFoR0gg9HY/qzQf4LdxmA91bHwaBT9KEoP09
         cKdA==
X-Forwarded-Encrypted: i=1; AJvYcCUOD/0YDE5GcC43qPUTKpMAkZyMZmUrASirthVpjsEsEH0Z+kXkibfMnKug2R83XLLlRoLo2b5iMSAWuaRGYDaM@vger.kernel.org
X-Gm-Message-State: AOJu0YzREfevMVuJckZP9ds3aEZnWB2PDkxWiB9+52Jgj/WSFiig8IP0
	j9Cpi77bUJBE2sdSX3wMJ05EYuJOmHwBGfs854ePZ8NElHeM5WrjRw8YPkbZsGaOlx0S/nCKjHb
	y+xzyNjvmbg==
X-Google-Smtp-Source: AGHT+IGK1zsXbbDN4h/2OC00ynAjt01pQAymfehXb1PCpwBDzIX5kT9r1SlgUbW7DRsCzNjPdgbObHdMN7zK
X-Received: from plhs17.prod.google.com ([2002:a17:903:3211:b0:234:683b:5792])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf10:b0:234:d7b2:2ac5
 with SMTP id d9443c01a7336-23dede52016mr8119665ad.21.1752179827271; Thu, 10
 Jul 2025 13:37:07 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:36:44 -0700
In-Reply-To: <20250710203656.1963075-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710203656.1963075-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710203656.1963075-3-irogers@google.com>
Subject: [PATCH v5 02/14] perf parse-events: Remove non-json software events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
index e233bacaa641..c1a8708b55ab 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -521,8 +521,6 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
 {
 	print_symbol_events(print_cb, print_state, PERF_TYPE_HARDWARE,
 			event_symbols_hw, PERF_COUNT_HW_MAX);
-	print_symbol_events(print_cb, print_state, PERF_TYPE_SOFTWARE,
-			event_symbols_sw, PERF_COUNT_SW_MAX);
 
 	print_hwcache_events(print_cb, print_state);
 
-- 
2.50.0.727.gbf7dc18ff4-goog

