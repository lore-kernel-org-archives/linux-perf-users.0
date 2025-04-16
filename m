Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317F322A802
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Apr 2025 04:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744779097; cv=none; b=dPbiOss1Bvjpy38MC3Yq/Wdzllh3sDd0wZBtcEVJ9K1jHRcybwbwsmVBHku7WHvSpgHn6H1ge3ZuGswCPRpvPRNjj/8swYjr9/42Uiug98A6LRCoSlDMarLpedAYNg7EXqdu7UuBgjk9/RwueCu4oGBln6zP4cs0w8bMpSNIMaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744779097; c=relaxed/simple;
	bh=+02A8xjTJSay0AmeM/5FcWc3Udtw6E2swW89rzUzsJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Z1AWByRNWqHZuHOGAS1LZKFVVxOdUwQuQ2qu8E69Sxbm8G2NNvoiTxrQfk2VW0irwJ7nDsn1/GYGOrpTteVo13KGBGDMQVJ5AhGkO/t17GLsXGlfJRCb8BfRTfh1Wih4HIdlCeIAiedoQMi4UlUTsyXHE5hh7ZsBBiQwcIDLrTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JCZ5VbKo; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCZ5VbKo"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so5199450a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Apr 2025 21:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744779094; x=1745383894; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h7+NEHtGwUKznWHoYGvIc99VKsCsRILkozJ+tQcf7Wk=;
        b=JCZ5VbKo1IiVkhLyIbkfjZr8Jq08VO8td3qXxcJeEbbT7i1PIADQwoyJsvMampiVNy
         ZFsOupEOTfIYlnzgCPnk9J/4h5rQYEVNisNOiv3Q+tb2bm+asbSPX5NPaObic0xM3DQQ
         fHjqEP+TIF9+6EZoq8wAqKO1Ebv+z9JkHLbsJmkvRMW9UboBF9o53r0OZNB09UDuCE/m
         aPiGq+AH8KZIWlqtwAW8e0rQQj1X3wtC6Lbg0Mibb6j075z8qw/NbTyCw8GsPmCdcGbq
         0jvV5geWtKYb2QsAa/P/k90bUGhp9YhCWsoM2P5AjOwM0DYV0vuWcQfbWf31Gntk2Bay
         k+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744779094; x=1745383894;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7+NEHtGwUKznWHoYGvIc99VKsCsRILkozJ+tQcf7Wk=;
        b=O3wQmUOagPvdExwTSZeRQ0rkhwppsyaVjLzi+AT+pBymn7ukpvQHRCnRksVt8lRBaa
         VuXPYcmkKA9kWJtkdoKju2/T9e0ICQDj0CJxCf7wcGAAmDMSz6SNzDbngEi3E3Us35Gy
         KCdPTyIdEaNNAyUWMSTevp64aB/eIQ/jBU7n9q21QrTx5xxMutdII/NkG06Bn0OiCFuk
         HWHCqvk0Bj5hN1fl9x6ruu+anyOsxYlFfpd2Vy/Q4K+Ms9udjxSqEytXKokhyC3Yerng
         pPDG9xMbMQlWuBUblnYhooPhJk5v6KPQc/pC2HW6KHpmEts1lU2OGL+MRKPPdBRIWxAy
         GlvA==
X-Forwarded-Encrypted: i=1; AJvYcCVU+UHUw08RJTwuHH92T6cvwbp883poABsgc8U+4RBkoAzSXroSOjoaliMqImjyFxnvYhGPccPHCk9Gmd4qv5F3@vger.kernel.org
X-Gm-Message-State: AOJu0YwR5CmQwUxG8nrK8akWXDdeCSvI1MADXcrVNFDLqnIKgY2/ZgnK
	kvFhFvlbfN/BVGaXKB45WGNQCfo7tN54N6G4SI13y1dIJhbFOqgbEx56b252RGW+GLvOf3H6SXX
	kQs8Miw==
X-Google-Smtp-Source: AGHT+IFYHuTziH5y/f7XYexO/oNO5b7ZwIk5bPJYuWDGfkU3Z1cpF7YWz5g/x+0yBHrrQ14ip0gkN69NemSa
X-Received: from pjbsm16.prod.google.com ([2002:a17:90b:2e50:b0:301:2a0f:b03d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:582e:b0:2fe:afbc:cd53
 with SMTP id 98e67ed59e1d1-3086415e8c4mr544184a91.28.1744779094442; Tue, 15
 Apr 2025 21:51:34 -0700 (PDT)
Date: Tue, 15 Apr 2025 21:51:16 -0700
In-Reply-To: <20250416045117.876775-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250416045117.876775-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250416045117.876775-4-irogers@google.com>
Subject: [PATCH v8 3/4] perf parse-events: Allow software events to be terms
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Allow legacy software events to be specified as, for example,
software/cpu-clock/u for consistency in parsing with hardware
events. Rename the type for hardware_event to legacy_event given its
new dual role.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 20 +++++++++++---
 tools/perf/util/parse-events.h |  3 ++-
 tools/perf/util/parse-events.l | 48 ++++++++++++++++++++++------------
 tools/perf/util/parse-events.y | 43 ++++++++++++++++++++++--------
 tools/perf/util/pmu.c          |  9 ++++---
 5 files changed, 86 insertions(+), 37 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f4236570aa4c..21506fcf0bfa 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -805,6 +805,7 @@ const char *parse_events__term_type_str(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
 		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
 		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
+		[PARSE_EVENTS__TERM_TYPE_SOFTWARE]              = "software",
 	};
 	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
 		return "unknown term";
@@ -854,6 +855,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_RAW:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+	case PARSE_EVENTS__TERM_TYPE_SOFTWARE:
 	default:
 		if (!err)
 			return false;
@@ -985,6 +987,7 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+	case PARSE_EVENTS__TERM_TYPE_SOFTWARE:
 	default:
 		parse_events_error__handle(err, term->err_term,
 					strdup(parse_events__term_type_str(term->type_term)),
@@ -1037,7 +1040,8 @@ static int config_term_pmu(struct perf_event_attr *attr,
 			term->no_value = true;
 		}
 	}
-	if (term->type_term == PARSE_EVENTS__TERM_TYPE_HARDWARE) {
+	if (term->type_term == PARSE_EVENTS__TERM_TYPE_HARDWARE ||
+	    term->type_term == PARSE_EVENTS__TERM_TYPE_SOFTWARE) {
 		struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
 
 		if (!pmu) {
@@ -1057,10 +1061,15 @@ static int config_term_pmu(struct perf_event_attr *attr,
 			term->no_value = true;
 			term->alternate_hw_config = true;
 		} else {
-			attr->type = PERF_TYPE_HARDWARE;
 			attr->config = term->val.num;
-			if (perf_pmus__supports_extended_type())
-				attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+			if (term->type_term == PARSE_EVENTS__TERM_TYPE_HARDWARE) {
+				attr->type = PERF_TYPE_HARDWARE;
+				if (perf_pmus__supports_extended_type())
+					attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+
+			} else {
+				attr->type = PERF_TYPE_SOFTWARE;
+			}
 		}
 		return 0;
 	}
@@ -1108,6 +1117,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_RAW:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+	case PARSE_EVENTS__TERM_TYPE_SOFTWARE:
 	default:
 		if (err) {
 			parse_events_error__handle(err, term->err_term,
@@ -1242,6 +1252,7 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_RAW:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_SOFTWARE:
 		default:
 			break;
 		}
@@ -1296,6 +1307,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_RAW:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_SOFTWARE:
 		default:
 			break;
 		}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index e176a34ab088..c0a594827f4f 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -80,7 +80,8 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_RAW,
 	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
 	PARSE_EVENTS__TERM_TYPE_HARDWARE,
-#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_HARDWARE + 1)
+	PARSE_EVENTS__TERM_TYPE_SOFTWARE,
+#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_SOFTWARE + 1)
 };
 
 struct parse_events_term {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 324b7dc8a0d3..a670d23ea9cc 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -117,12 +117,14 @@ do {								\
 	yyless(0);						\
 } while (0)
 
-static int sym(yyscan_t scanner, int config)
+static int sw(yyscan_t scanner, int config)
 {
 	YYSTYPE *yylval = parse_events_get_lval(scanner);
+	char *text = parse_events_get_text(scanner);
 
-	yylval->num = config;
-	return PE_VALUE_SYM_SW;
+	yylval->legacy_event.str = strdup(text);
+	yylval->legacy_event.num = config;
+	return PE_TERM_SW;
 }
 
 static int term(yyscan_t scanner, enum parse_events__term_type type)
@@ -138,8 +140,8 @@ static int hw(yyscan_t scanner, int config)
 	YYSTYPE *yylval = parse_events_get_lval(scanner);
 	char *text = parse_events_get_text(scanner);
 
-	yylval->hardware_event.str = strdup(text);
-	yylval->hardware_event.num = config;
+	yylval->legacy_event.str = strdup(text);
+	yylval->legacy_event.num = config;
 	return PE_TERM_HW;
 }
 
@@ -345,6 +347,18 @@ branch-instructions|branches			{ return hw(yyscanner, PERF_COUNT_HW_BRANCH_INSTR
 branch-misses					{ return hw(yyscanner, PERF_COUNT_HW_BRANCH_MISSES); }
 bus-cycles					{ return hw(yyscanner, PERF_COUNT_HW_BUS_CYCLES); }
 ref-cycles					{ return hw(yyscanner, PERF_COUNT_HW_REF_CPU_CYCLES); }
+cpu-clock					{ return sw(yyscanner, PERF_COUNT_SW_CPU_CLOCK); }
+task-clock					{ return sw(yyscanner, PERF_COUNT_SW_TASK_CLOCK); }
+page-faults|faults				{ return sw(yyscanner, PERF_COUNT_SW_PAGE_FAULTS); }
+minor-faults					{ return sw(yyscanner, PERF_COUNT_SW_PAGE_FAULTS_MIN); }
+major-faults					{ return sw(yyscanner, PERF_COUNT_SW_PAGE_FAULTS_MAJ); }
+context-switches|cs				{ return sw(yyscanner, PERF_COUNT_SW_CONTEXT_SWITCHES); }
+cpu-migrations|migrations			{ return sw(yyscanner, PERF_COUNT_SW_CPU_MIGRATIONS); }
+alignment-faults				{ return sw(yyscanner, PERF_COUNT_SW_ALIGNMENT_FAULTS); }
+emulation-faults				{ return sw(yyscanner, PERF_COUNT_SW_EMULATION_FAULTS); }
+dummy						{ return sw(yyscanner, PERF_COUNT_SW_DUMMY); }
+bpf-output					{ return sw(yyscanner, PERF_COUNT_SW_BPF_OUTPUT); }
+cgroup-switches					{ return sw(yyscanner, PERF_COUNT_SW_CGROUP_SWITCHES); }
 r{num_raw_hex}		{ return str(yyscanner, PE_RAW); }
 r0x{num_raw_hex}	{ return str(yyscanner, PE_RAW); }
 ,			{ return ','; }
@@ -400,18 +414,18 @@ branch-instructions|branches			{ return hw(yyscanner, PERF_COUNT_HW_BRANCH_INSTR
 branch-misses					{ return hw(yyscanner, PERF_COUNT_HW_BRANCH_MISSES); }
 bus-cycles					{ return hw(yyscanner, PERF_COUNT_HW_BUS_CYCLES); }
 ref-cycles					{ return hw(yyscanner, PERF_COUNT_HW_REF_CPU_CYCLES); }
-cpu-clock					{ return sym(yyscanner, PERF_COUNT_SW_CPU_CLOCK); }
-task-clock					{ return sym(yyscanner, PERF_COUNT_SW_TASK_CLOCK); }
-page-faults|faults				{ return sym(yyscanner, PERF_COUNT_SW_PAGE_FAULTS); }
-minor-faults					{ return sym(yyscanner, PERF_COUNT_SW_PAGE_FAULTS_MIN); }
-major-faults					{ return sym(yyscanner, PERF_COUNT_SW_PAGE_FAULTS_MAJ); }
-context-switches|cs				{ return sym(yyscanner, PERF_COUNT_SW_CONTEXT_SWITCHES); }
-cpu-migrations|migrations			{ return sym(yyscanner, PERF_COUNT_SW_CPU_MIGRATIONS); }
-alignment-faults				{ return sym(yyscanner, PERF_COUNT_SW_ALIGNMENT_FAULTS); }
-emulation-faults				{ return sym(yyscanner, PERF_COUNT_SW_EMULATION_FAULTS); }
-dummy						{ return sym(yyscanner, PERF_COUNT_SW_DUMMY); }
-bpf-output					{ return sym(yyscanner, PERF_COUNT_SW_BPF_OUTPUT); }
-cgroup-switches					{ return sym(yyscanner, PERF_COUNT_SW_CGROUP_SWITCHES); }
+cpu-clock					{ return sw(yyscanner, PERF_COUNT_SW_CPU_CLOCK); }
+task-clock					{ return sw(yyscanner, PERF_COUNT_SW_TASK_CLOCK); }
+page-faults|faults				{ return sw(yyscanner, PERF_COUNT_SW_PAGE_FAULTS); }
+minor-faults					{ return sw(yyscanner, PERF_COUNT_SW_PAGE_FAULTS_MIN); }
+major-faults					{ return sw(yyscanner, PERF_COUNT_SW_PAGE_FAULTS_MAJ); }
+context-switches|cs				{ return sw(yyscanner, PERF_COUNT_SW_CONTEXT_SWITCHES); }
+cpu-migrations|migrations			{ return sw(yyscanner, PERF_COUNT_SW_CPU_MIGRATIONS); }
+alignment-faults				{ return sw(yyscanner, PERF_COUNT_SW_ALIGNMENT_FAULTS); }
+emulation-faults				{ return sw(yyscanner, PERF_COUNT_SW_EMULATION_FAULTS); }
+dummy						{ return sw(yyscanner, PERF_COUNT_SW_DUMMY); }
+bpf-output					{ return sw(yyscanner, PERF_COUNT_SW_BPF_OUTPUT); }
+cgroup-switches					{ return sw(yyscanner, PERF_COUNT_SW_CGROUP_SWITCHES); }
 
 {lc_type}			{ return str(yyscanner, PE_LEGACY_CACHE); }
 {lc_type}-{lc_op_result}	{ return str(yyscanner, PE_LEGACY_CACHE); }
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index d2ef1890007e..4992a5bf3c44 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -55,7 +55,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %}
 
 %token PE_START_EVENTS PE_START_TERMS
-%token PE_VALUE PE_VALUE_SYM_SW PE_TERM
+%token PE_VALUE PE_TERM
 %token PE_EVENT_NAME
 %token PE_RAW PE_NAME
 %token PE_MODIFIER_EVENT PE_MODIFIER_BP PE_BP_COLON PE_BP_SLASH
@@ -63,9 +63,8 @@ static void free_list_evsel(struct list_head* list_evsel)
 %token PE_PREFIX_MEM
 %token PE_ERROR
 %token PE_DRV_CFG_TERM
-%token PE_TERM_HW
+%token PE_TERM_HW PE_TERM_SW
 %type <num> PE_VALUE
-%type <num> PE_VALUE_SYM_SW
 %type <mod> PE_MODIFIER_EVENT
 %type <term_type> PE_TERM
 %type <str> PE_RAW
@@ -101,8 +100,9 @@ static void free_list_evsel(struct list_head* list_evsel)
 %destructor { free_list_evsel ($$); } <list_evsel>
 %type <tracepoint_name> tracepoint_name
 %destructor { free ($$.sys); free ($$.event); } <tracepoint_name>
-%type <hardware_event> PE_TERM_HW
-%destructor { free ($$.str); } <hardware_event>
+%type <legacy_event> PE_TERM_HW
+%type <legacy_event> PE_TERM_SW
+%destructor { free ($$.str); } <legacy_event>
 
 %union
 {
@@ -117,10 +117,10 @@ static void free_list_evsel(struct list_head* list_evsel)
 		char *sys;
 		char *event;
 	} tracepoint_name;
-	struct hardware_event {
+	struct legacy_event {
 		char *str;
 		u64 num;
-	} hardware_event;
+	} legacy_event;
 }
 %%
 
@@ -334,16 +334,17 @@ PE_TERM_HW sep_dc
 }
 
 event_legacy_symbol:
-PE_VALUE_SYM_SW '/' event_config '/'
+PE_TERM_SW '/' event_config '/'
 {
 	struct list_head *list;
 	int err;
 
+	free($1.str);
 	list = alloc_list();
 	if (!list)
 		YYNOMEM;
 	err = parse_events_add_numeric(_parse_state, list,
-				/*type=*/PERF_TYPE_SOFTWARE, /*config=*/$1,
+				/*type=*/PERF_TYPE_SOFTWARE, /*config=*/$1.num,
 				$3, /*wildcard=*/false);
 	parse_events_terms__delete($3);
 	if (err) {
@@ -353,16 +354,17 @@ PE_VALUE_SYM_SW '/' event_config '/'
 	$$ = list;
 }
 |
-PE_VALUE_SYM_SW sep_slash_slash_dc
+PE_TERM_SW sep_slash_slash_dc
 {
 	struct list_head *list;
 	int err;
 
+	free($1.str);
 	list = alloc_list();
 	if (!list)
 		YYNOMEM;
 	err = parse_events_add_numeric(_parse_state, list,
-				/*type=*/PERF_TYPE_SOFTWARE, /*config=*/$1,
+				/*type=*/PERF_TYPE_SOFTWARE, /*config=*/$1.num,
 				/*head_config=*/NULL, /*wildcard=*/false);
 	if (err)
 		PE_ABORT(err);
@@ -615,6 +617,11 @@ PE_TERM_HW
 {
 	$$ = $1.str;
 }
+|
+PE_TERM_SW
+{
+	$$ = $1.str;
+}
 
 event_term:
 PE_RAW
@@ -696,6 +703,20 @@ PE_TERM_HW
 	$$ = term;
 }
 |
+PE_TERM_SW
+{
+	struct parse_events_term *term;
+	int err = parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_SOFTWARE,
+					 $1.str, $1.num & 255, /*novalue=*/false,
+					 &@1, /*loc_val=*/NULL);
+
+	if (err) {
+		free($1.str);
+		PE_ABORT(err);
+	}
+	$$ = term;
+}
+|
 PE_TERM '=' name_or_raw
 {
 	struct parse_events_term *term;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b7ebac5ab1d1..ac1149658d9b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1429,7 +1429,7 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 			break;
 		case PARSE_EVENTS__TERM_TYPE_USER: /* Not hardcoded. */
 			return -EINVAL;
-		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_SOFTWARE:
 			/* Skip non-config terms. */
 			break;
 		default:
@@ -1810,10 +1810,11 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 
 	/*
 	 * max-events and driver-config are missing above as are the internal
-	 * types user, metric-id, raw, legacy cache and hardware. Assert against
-	 * the enum parse_events__term_type so they are kept in sync.
+	 * types user, metric-id, raw, legacy cache, hardware and
+	 * software. Assert against the enum parse_events__term_type so they are
+	 * kept in sync.
 	 */
-	_Static_assert(ARRAY_SIZE(terms) == __PARSE_EVENTS__TERM_TYPE_NR - 6,
+	_Static_assert(ARRAY_SIZE(terms) == __PARSE_EVENTS__TERM_TYPE_NR - 7,
 		       "perf_pmu__for_each_format()'s terms must be kept in sync with enum parse_events__term_type");
 	list_for_each_entry(format, &pmu->format, list) {
 		perf_pmu_format__load(pmu, format);
-- 
2.49.0.777.g153de2bbd5-goog

