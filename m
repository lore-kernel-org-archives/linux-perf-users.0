Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A29322A4E9
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Apr 2025 04:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744779096; cv=none; b=OKIXI8ovxZ84STQFKdfnB7i6dYz7Ij2G/cBTcE9Rct+q2tlt9xdb2PSAr/f41IggYNCZ6L0QDJGzkLiuNVip7w3Oj17FiLzpPfHQimQzios7LrgIQPTqeAEEwiSPv7hqAt0sgrREkmafcC/+O/h39N4q96p8HbB51B97Vb8TAds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744779096; c=relaxed/simple;
	bh=Z3OcvrkiJ0XoTxWGo9t5E9tNKRTzp3qvFm/E7TCGt6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ahRTH3kSSVWqnLH9fcL+lYS+HMgrM8oWdI4WMfg8a0a35RdYoAUDmTGHtP8UsCxbVxyhR6lG8bGQRWf9zqzJf7w5r0p2OS55n3mFtZqE5Eg/8/RclC3XZ6zMHICRQI4+YRvGoLZcEfkpCBLvSt+G2btvr0cK6EjGT5MT4Lagx7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yp4wF3oy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yp4wF3oy"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22c31b55ac6so7541465ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Apr 2025 21:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744779092; x=1745383892; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g3ShVOfpgDEvI1032RF4ZcQ0fL2biVXBJPOL411ra/g=;
        b=Yp4wF3oyEzX4EXIW7iByUEHhhELGUoqd6yqrEr8s5RRzOTtFtRvi+fa5duPwsrnbwC
         BtOok3SYRIqzPYakwde7y2sTzhkeULtlTAe9EK/KsXt7ibzKxhojXQYv7hmyt6ruiBb6
         88AFTXulPEyFldSl8JR6MBf5veBWygmcMJZMhswMVq6hDy7SVqEPDRqKCnaa41v/7mmw
         7Z5M+BmRtl9q8thT8woDbLTJVDlof5Wq2RK7xqIMlksQaiL0cZdspLpOR/6B6FO8Ejtm
         cjBo6s4v1CK58hDim5hq/Ou9nyzaYy8Dhponzod6ov5Z8idJX0QBGgC9nfNoxSSpdmDa
         wqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744779092; x=1745383892;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3ShVOfpgDEvI1032RF4ZcQ0fL2biVXBJPOL411ra/g=;
        b=Ug5iCj2mxY6or3cVsVpC5+oqoNu8/rR7OY1iDtF3wapeVCs4meoBeMW6WN7Gq/qOiG
         BlB4+1KtXg92hXgrhjV67062mGGo5JTICO0J2ocP/fjBUalv+UNoLpr/86oKEMZu+s15
         xndMdB3Q432w9BahsQv6c02q3W3GOU8rQvfzIDrV+/XdTiNPN96haeqGyqzOeya/HKJq
         IK5xEjICRlsWUjNAHJGoHpbQN7/ndIz9cdhrQnG/0f7mqTrOqeOGqF50lq0WIOjp2AF5
         V37vU/ed+2COF/WroDiNEnAzEGIzz1zhmlO8UcSxEYHxjhHj1E36wQQZ7e1O8Y1f953B
         ceOg==
X-Forwarded-Encrypted: i=1; AJvYcCXePCSkoKeTjx6bD00q9/MdD1+NsN8ytH6eremyPizQ/yjGEms7c7CgJcvEheYb1P65d92hWTYx68rHJhKjsSwd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2aApan9kg7rT/bwsRNYyOuVDryNPd119YbJg5T9HWSnyPAxAy
	Kmd7mpK2HTptH+TK3G1U8kRMeRQK4q1bkL8BdzmrPhqiY+5t6ryAfIQL0YSnJYzIloJgfQI8EGM
	Q4GRn6g==
X-Google-Smtp-Source: AGHT+IFg1pHHx9ZpaAAazdww9/od6FLTiU3dXw8OsrGkutfRWjSeeDsX06Fai87Cf6iqpTkL2kh696d3z8K8
X-Received: from plpn4.prod.google.com ([2002:a17:902:9684:b0:220:c367:eb6d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea0c:b0:224:10a2:cad5
 with SMTP id d9443c01a7336-22c358c4fa9mr7419335ad.10.1744779092450; Tue, 15
 Apr 2025 21:51:32 -0700 (PDT)
Date: Tue, 15 Apr 2025 21:51:15 -0700
In-Reply-To: <20250416045117.876775-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250416045117.876775-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250416045117.876775-3-irogers@google.com>
Subject: [PATCH v8 2/4] perf parse-events: Reapply "Prefer sysfs/JSON hardware
 events over legacy"
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
Cc: Beeman Strong <beeman@rivosinc.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Originally posted and merged from:
https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
This reverts commit 4f1b067359ac8364cdb7f9fda41085fa85789d0f although
the patch is now smaller due to related fixes being applied in commit
22a4db3c3603 ("perf evsel: Add alternate_hw_config and use in
evsel__match").
The original commit message was:

It was requested that RISC-V be able to add events to the perf tool so
the PMU driver didn't need to map legacy events to config encodings:
https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com/

This change makes the priority of events specified without a PMU the
same as those specified with a PMU, namely sysfs and JSON events are
checked first before using the legacy encoding.

The hw_term is made more generic as a hardware_event that encodes a
pair of string and int value, allowing parse_events_multi_pmu_add to
fall back on a known encoding when the sysfs/JSON adding fails for
core events. As this covers PE_VALUE_SYM_HW, that token is removed and
related code simplified.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Atish Patra <atishp@rivosinc.com>
Tested-by: James Clark <james.clark@linaro.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Beeman Strong <beeman@rivosinc.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 27 +++++++++---
 tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
 tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
 3 files changed, 99 insertions(+), 64 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5152fd5a6ead..f4236570aa4c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1551,8 +1551,8 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 	struct list_head *list = NULL;
 	struct perf_pmu *pmu = NULL;
 	YYLTYPE *loc = loc_;
-	int ok = 0;
-	const char *config;
+	int ok = 0, core_ok = 0;
+	const char *tmp;
 	struct parse_events_terms parsed_terms;
 
 	*listp = NULL;
@@ -1565,15 +1565,15 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			return ret;
 	}
 
-	config = strdup(event_name);
-	if (!config)
+	tmp = strdup(event_name);
+	if (!tmp)
 		goto out_err;
 
 	if (parse_events_term__num(&term,
 				   PARSE_EVENTS__TERM_TYPE_USER,
-				   config, /*num=*/1, /*novalue=*/true,
+				   tmp, /*num=*/1, /*novalue=*/true,
 				   loc, /*loc_val=*/NULL) < 0) {
-		zfree(&config);
+		zfree(&tmp);
 		goto out_err;
 	}
 	list_add_tail(&term->list, &parsed_terms.terms);
@@ -1604,6 +1604,8 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			pr_debug("%s -> %s/%s/\n", event_name, pmu->name, sb.buf);
 			strbuf_release(&sb);
 			ok++;
+			if (pmu->is_core)
+				core_ok++;
 		}
 	}
 
@@ -1617,9 +1619,22 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			pr_debug("%s -> fake/%s/\n", event_name, sb.buf);
 			strbuf_release(&sb);
 			ok++;
+			core_ok++;
 		}
 	}
 
+	if (hw_config != PERF_COUNT_HW_MAX && !core_ok) {
+		/*
+		 * The event wasn't found on core PMUs but it has a hardware
+		 * config version to try.
+		 */
+		if (!parse_events_add_numeric(parse_state, list,
+						PERF_TYPE_HARDWARE, hw_config,
+						const_parsed_terms,
+						/*wildcard=*/true))
+			ok++;
+	}
+
 out_err:
 	parse_events_terms__exit(&parsed_terms);
 	if (ok)
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 7ed86e3e34e3..324b7dc8a0d3 100644
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
+	return PE_VALUE_SYM_SW;
 }
 
 static int term(yyscan_t scanner, enum parse_events__term_type type)
@@ -133,13 +133,13 @@ static int term(yyscan_t scanner, enum parse_events__term_type type)
 	return PE_TERM;
 }
 
-static int hw_term(yyscan_t scanner, int config)
+static int hw(yyscan_t scanner, int config)
 {
 	YYSTYPE *yylval = parse_events_get_lval(scanner);
 	char *text = parse_events_get_text(scanner);
 
-	yylval->hardware_term.str = strdup(text);
-	yylval->hardware_term.num = PERF_TYPE_HARDWARE + config;
+	yylval->hardware_event.str = strdup(text);
+	yylval->hardware_event.num = config;
 	return PE_TERM_HW;
 }
 
@@ -335,16 +335,16 @@ aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 aux-action		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_ACTION); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
-cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
-stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
-stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
-instructions					{ return hw_term(yyscanner, PERF_COUNT_HW_INSTRUCTIONS); }
-cache-references				{ return hw_term(yyscanner, PERF_COUNT_HW_CACHE_REFERENCES); }
-cache-misses					{ return hw_term(yyscanner, PERF_COUNT_HW_CACHE_MISSES); }
-branch-instructions|branches			{ return hw_term(yyscanner, PERF_COUNT_HW_BRANCH_INSTRUCTIONS); }
-branch-misses					{ return hw_term(yyscanner, PERF_COUNT_HW_BRANCH_MISSES); }
-bus-cycles					{ return hw_term(yyscanner, PERF_COUNT_HW_BUS_CYCLES); }
-ref-cycles					{ return hw_term(yyscanner, PERF_COUNT_HW_REF_CPU_CYCLES); }
+cpu-cycles|cycles				{ return hw(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
+stalled-cycles-frontend|idle-cycles-frontend	{ return hw(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
+stalled-cycles-backend|idle-cycles-backend	{ return hw(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
+instructions					{ return hw(yyscanner, PERF_COUNT_HW_INSTRUCTIONS); }
+cache-references				{ return hw(yyscanner, PERF_COUNT_HW_CACHE_REFERENCES); }
+cache-misses					{ return hw(yyscanner, PERF_COUNT_HW_CACHE_MISSES); }
+branch-instructions|branches			{ return hw(yyscanner, PERF_COUNT_HW_BRANCH_INSTRUCTIONS); }
+branch-misses					{ return hw(yyscanner, PERF_COUNT_HW_BRANCH_MISSES); }
+bus-cycles					{ return hw(yyscanner, PERF_COUNT_HW_BUS_CYCLES); }
+ref-cycles					{ return hw(yyscanner, PERF_COUNT_HW_REF_CPU_CYCLES); }
 r{num_raw_hex}		{ return str(yyscanner, PE_RAW); }
 r0x{num_raw_hex}	{ return str(yyscanner, PE_RAW); }
 ,			{ return ','; }
@@ -390,28 +390,28 @@ r0x{num_raw_hex}	{ return str(yyscanner, PE_RAW); }
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
+cpu-cycles|cycles				{ return hw(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
+stalled-cycles-frontend|idle-cycles-frontend	{ return hw(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
+stalled-cycles-backend|idle-cycles-backend	{ return hw(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
+instructions					{ return hw(yyscanner, PERF_COUNT_HW_INSTRUCTIONS); }
+cache-references				{ return hw(yyscanner, PERF_COUNT_HW_CACHE_REFERENCES); }
+cache-misses					{ return hw(yyscanner, PERF_COUNT_HW_CACHE_MISSES); }
+branch-instructions|branches			{ return hw(yyscanner, PERF_COUNT_HW_BRANCH_INSTRUCTIONS); }
+branch-misses					{ return hw(yyscanner, PERF_COUNT_HW_BRANCH_MISSES); }
+bus-cycles					{ return hw(yyscanner, PERF_COUNT_HW_BUS_CYCLES); }
+ref-cycles					{ return hw(yyscanner, PERF_COUNT_HW_REF_CPU_CYCLES); }
+cpu-clock					{ return sym(yyscanner, PERF_COUNT_SW_CPU_CLOCK); }
+task-clock					{ return sym(yyscanner, PERF_COUNT_SW_TASK_CLOCK); }
+page-faults|faults				{ return sym(yyscanner, PERF_COUNT_SW_PAGE_FAULTS); }
+minor-faults					{ return sym(yyscanner, PERF_COUNT_SW_PAGE_FAULTS_MIN); }
+major-faults					{ return sym(yyscanner, PERF_COUNT_SW_PAGE_FAULTS_MAJ); }
+context-switches|cs				{ return sym(yyscanner, PERF_COUNT_SW_CONTEXT_SWITCHES); }
+cpu-migrations|migrations			{ return sym(yyscanner, PERF_COUNT_SW_CPU_MIGRATIONS); }
+alignment-faults				{ return sym(yyscanner, PERF_COUNT_SW_ALIGNMENT_FAULTS); }
+emulation-faults				{ return sym(yyscanner, PERF_COUNT_SW_EMULATION_FAULTS); }
+dummy						{ return sym(yyscanner, PERF_COUNT_SW_DUMMY); }
+bpf-output					{ return sym(yyscanner, PERF_COUNT_SW_BPF_OUTPUT); }
+cgroup-switches					{ return sym(yyscanner, PERF_COUNT_SW_CGROUP_SWITCHES); }
 
 {lc_type}			{ return str(yyscanner, PE_LEGACY_CACHE); }
 {lc_type}-{lc_op_result}	{ return str(yyscanner, PE_LEGACY_CACHE); }
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index f888cbb076d6..d2ef1890007e 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -55,7 +55,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %}
 
 %token PE_START_EVENTS PE_START_TERMS
-%token PE_VALUE PE_VALUE_SYM_HW PE_VALUE_SYM_SW PE_TERM
+%token PE_VALUE PE_VALUE_SYM_SW PE_TERM
 %token PE_EVENT_NAME
 %token PE_RAW PE_NAME
 %token PE_MODIFIER_EVENT PE_MODIFIER_BP PE_BP_COLON PE_BP_SLASH
@@ -65,11 +65,9 @@ static void free_list_evsel(struct list_head* list_evsel)
 %token PE_DRV_CFG_TERM
 %token PE_TERM_HW
 %type <num> PE_VALUE
-%type <num> PE_VALUE_SYM_HW
 %type <num> PE_VALUE_SYM_SW
 %type <mod> PE_MODIFIER_EVENT
 %type <term_type> PE_TERM
-%type <num> value_sym
 %type <str> PE_RAW
 %type <str> PE_NAME
 %type <str> PE_LEGACY_CACHE
@@ -85,6 +83,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <list_terms> opt_pmu_config
 %destructor { parse_events_terms__delete ($$); } <list_terms>
 %type <list_evsel> event_pmu
+%type <list_evsel> event_legacy_hardware
 %type <list_evsel> event_legacy_symbol
 %type <list_evsel> event_legacy_cache
 %type <list_evsel> event_legacy_mem
@@ -102,8 +101,8 @@ static void free_list_evsel(struct list_head* list_evsel)
 %destructor { free_list_evsel ($$); } <list_evsel>
 %type <tracepoint_name> tracepoint_name
 %destructor { free ($$.sys); free ($$.event); } <tracepoint_name>
-%type <hardware_term> PE_TERM_HW
-%destructor { free ($$.str); } <hardware_term>
+%type <hardware_event> PE_TERM_HW
+%destructor { free ($$.str); } <hardware_event>
 
 %union
 {
@@ -118,10 +117,10 @@ static void free_list_evsel(struct list_head* list_evsel)
 		char *sys;
 		char *event;
 	} tracepoint_name;
-	struct hardware_term {
+	struct hardware_event {
 		char *str;
 		u64 num;
-	} hardware_term;
+	} hardware_event;
 }
 %%
 
@@ -264,6 +263,7 @@ PE_EVENT_NAME event_def
 event_def
 
 event_def: event_pmu |
+	   event_legacy_hardware |
 	   event_legacy_symbol |
 	   event_legacy_cache sep_dc |
 	   event_legacy_mem sep_dc |
@@ -306,24 +306,45 @@ PE_NAME sep_dc
 	$$ = list;
 }
 
-value_sym:
-PE_VALUE_SYM_HW
+event_legacy_hardware:
+PE_TERM_HW opt_pmu_config
+{
+	/* List of created evsels. */
+	struct list_head *list = NULL;
+	int err = parse_events_multi_pmu_add(_parse_state, $1.str, $1.num, $2, &list, &@1);
+
+	free($1.str);
+	parse_events_terms__delete($2);
+	if (err)
+		PE_ABORT(err);
+
+	$$ = list;
+}
 |
-PE_VALUE_SYM_SW
+PE_TERM_HW sep_dc
+{
+	struct list_head *list;
+	int err;
+
+	err = parse_events_multi_pmu_add(_parse_state, $1.str, $1.num, NULL, &list, &@1);
+	free($1.str);
+	if (err)
+		PE_ABORT(err);
+	$$ = list;
+}
 
 event_legacy_symbol:
-value_sym '/' event_config '/'
+PE_VALUE_SYM_SW '/' event_config '/'
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
+				/*type=*/PERF_TYPE_SOFTWARE, /*config=*/$1,
+				$3, /*wildcard=*/false);
 	parse_events_terms__delete($3);
 	if (err) {
 		free_list_evsel(list);
@@ -332,18 +353,17 @@ value_sym '/' event_config '/'
 	$$ = list;
 }
 |
-value_sym sep_slash_slash_dc
+PE_VALUE_SYM_SW sep_slash_slash_dc
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
+				/*type=*/PERF_TYPE_SOFTWARE, /*config=*/$1,
+				/*head_config=*/NULL, /*wildcard=*/false);
 	if (err)
 		PE_ABORT(err);
 	$$ = list;
-- 
2.49.0.777.g153de2bbd5-goog

