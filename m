Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B329E3CF5E
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2024 06:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248149; cv=none; b=IgmGg9Pre6Hk14J+oym8XxSr4rPTpddmn1ynoGcdHlbPo4gzTPheVt03Cc46oKdwAeXiy/GqivOkpy8N9HhdDmtOiuDNnJDtDwGSsQ7XT53q7GwJGqetVPWNXegQT2MPMj07yNC1hKxak8kaLFf5/xUYC4fCP5Ubkk2BWxa8Jss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248149; c=relaxed/simple;
	bh=EEkwQ6nsrkJfCdd+xL56HS073O9RsNgTTq8Kh2mCF+E=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jIt4cfv4CcUrP3XfqbgkYr1oNAB1g/mu+8c+ZHT4z3eoX8zMkGinMk/8dZlTw6wSOnOuTTOnySPa68VyYVsnzFGzXhb/Z8YBhX9Yd6Zd1AsFPodG8RBauf/ZEUxWSLa5d3i/OiYS0oerOnhkULxXqQbGt+lcRA7/dODK8u8zc3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TI3wmC4w; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TI3wmC4w"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc746178515so6407766276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Apr 2024 23:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248147; x=1713852947; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZDaJNkBNQzqTbOVORPBbpHI26H/bVA4sAmx4hPV1q4=;
        b=TI3wmC4wh53vlomE12i7TZXlYXONmBke+E4CaqqfK/jDW0REFesz48UqOnrgfKxjTS
         Rmh6VS97YkwbYprAbeFkGzjxT+390lL9RDwmooLhxjUMpn60wNBrmoiNXA8mJFPiczao
         3sF5D5hjcqWZk2zNKXk5pGWKlRq9X0IjaZlAOb1O+Dcixjr1ARBjO1U1AAZlJLK8AhTu
         mN13eYEKYoPJjQlWGc5DdN6xTRekhZACQ66Te/7k2AAAUZdXL2gdGpgfCB9vw8YTJ4bw
         /IMgE3RME4hsvNtFXAw2216s+22yaz1IRxTf00Qw2il5oitfcly/Mlo2cxp7+meOLJSf
         wajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248147; x=1713852947;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZDaJNkBNQzqTbOVORPBbpHI26H/bVA4sAmx4hPV1q4=;
        b=Qk5zbHGsoRvwW52lYk7PKevx68HO3sgXu1lqOp1m/uRUK7Z5fxbFpS+BY4sdRa11n+
         3Ex5wizi7kQ7lJkEbG2nl6IsniKORx1t5asrvh1t1ShXBhDNWyH6EPYhTn7sE+o2T46J
         wA4Vjk+51b0y46V09FOIauSZup+NwZQc3xhZp/KnHJzpW7Bwa0PNqL41HVUz6l/2KPXz
         ZeA8eN8TddeopHgGcoegmV/klX+11rkitVX8tk6YHEc4cd89GDrW4RgwgeCrVT4aMkm8
         jb0sGhQ+oB6pDDYaDgxcHv1yhOngeQPyGNabnpxromrF0P/Bv8yGnx4tutOOPVOy6e0q
         57Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUX+qGRyil4IMlodqGUFIm0AsOflzJiIGNynSLjygtzkOQA0aon0OIs/EXgQxbydGE+2QkZ3ZFLZrtRdYmxTuNsYdAcYWgrEiSuJGD9tT2YHg==
X-Gm-Message-State: AOJu0Yx5cLShVHlwnpqWrj0JURDeJIXKQkha4L9/sSufmwz0jxUqevWb
	Q5o6+GvsvPxAsu68JgT9BplAyxg0xbAKVcCJjpqQ1I/n7RPNgA9XGzLoTMZDXXucjx6u+x6wPCk
	eF7czIA==
X-Google-Smtp-Source: AGHT+IGb1Z1MH8mrJs7TUuzjYGsHip0fG+66XHrIF4uEyiZCBMkf4G0cyFGOrCW/aJTepnynA8OowMuWg4As
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a25:addf:0:b0:dd9:1db5:8348 with SMTP id
 d31-20020a25addf000000b00dd91db58348mr3597111ybe.8.1713248146694; Mon, 15 Apr
 2024 23:15:46 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:17 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 01/16] perf parse-events: Factor out '<event_or_pmu>/.../' parsing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Factor out the case of an event or PMU name followed by a slash based
term list. This is with a view to sharing the code with new legacy
hardware parsing. Use early return to reduce indentation in the code.
Make parse_events_add_pmu static now it doesn't need sharing with
parse-events.y.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 70 +++++++++++++++++++++++++++++++-
 tools/perf/util/parse-events.h | 10 +++--
 tools/perf/util/parse-events.y | 73 +++-------------------------------
 3 files changed, 80 insertions(+), 73 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6f8b0fa17689..a6f71165ee1a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1385,7 +1385,7 @@ static bool config_term_percore(struct list_head *config_terms)
 	return false;
 }
 
-int parse_events_add_pmu(struct parse_events_state *parse_state,
+static int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, const char *name,
 			 const struct parse_events_terms *const_parsed_terms,
 			 bool auto_merge_stats, void *loc_)
@@ -1618,6 +1618,74 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 	return ok ? 0 : -1;
 }
 
+int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state,
+					const char *event_or_pmu,
+					const struct parse_events_terms *const_parsed_terms,
+					struct list_head **listp,
+					void *loc_)
+{
+	char *pattern = NULL;
+	YYLTYPE *loc = loc_;
+	struct perf_pmu *pmu = NULL;
+	int ok = 0;
+	char *help;
+
+	*listp = malloc(sizeof(**listp));
+	if (!*listp)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(*listp);
+
+	/* Attempt to add to list assuming event_or_pmu is a PMU name. */
+	if (!parse_events_add_pmu(parse_state, *listp, event_or_pmu, const_parsed_terms,
+					/*auto_merge_stats=*/false, loc))
+		return 0;
+
+	/* Failed to add, try wildcard expansion of event_or_pmu as a PMU name. */
+	if (asprintf(&pattern, "%s*", event_or_pmu) < 0) {
+		zfree(listp);
+		return -ENOMEM;
+	}
+
+	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+		const char *name = pmu->name;
+
+		if (parse_events__filter_pmu(parse_state, pmu))
+			continue;
+
+		if (!strncmp(name, "uncore_", 7) &&
+		    strncmp(event_or_pmu, "uncore_", 7))
+			name += 7;
+		if (!perf_pmu__match(pattern, name, event_or_pmu) ||
+		    !perf_pmu__match(pattern, pmu->alias_name, event_or_pmu)) {
+			bool auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
+
+			if (!parse_events_add_pmu(parse_state, *listp, pmu->name,
+						  const_parsed_terms,
+						  auto_merge_stats, loc)) {
+				ok++;
+				parse_state->wild_card_pmus = true;
+			}
+		}
+	}
+	zfree(&pattern);
+	if (ok)
+		return 0;
+
+	/* Failure to add, assume event_or_pmu is an event name. */
+	zfree(listp);
+	if (!parse_events_multi_pmu_add(parse_state, event_or_pmu, const_parsed_terms, listp, loc))
+		return 0;
+
+	if (asprintf(&help, "Unable to find PMU or event on a PMU of '%s'", event_or_pmu) < 0)
+		help = NULL;
+	parse_events_error__handle(parse_state->error, loc->first_column,
+				strdup("Bad event or PMU"),
+				help);
+	zfree(listp);
+	return -EINVAL;
+}
+
 int parse_events__modifier_group(struct list_head *list,
 				 char *event_mod)
 {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 809359e8544e..a331b9f0da2b 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -209,10 +209,6 @@ int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 				struct list_head *list,
 				u64 addr, char *type, u64 len,
 				struct parse_events_terms *head_config);
-int parse_events_add_pmu(struct parse_events_state *parse_state,
-			 struct list_head *list, const char *name,
-			 const struct parse_events_terms *const_parsed_terms,
-			bool auto_merge_stats, void *loc);
 
 struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
 				      const char *name, const char *metric_id,
@@ -223,6 +219,12 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			       const struct parse_events_terms *const_parsed_terms,
 			       struct list_head **listp, void *loc);
 
+int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state,
+					const char *event_or_pmu,
+					const struct parse_events_terms *const_parsed_terms,
+					struct list_head **listp,
+					void *loc_);
+
 void parse_events__set_leader(char *name, struct list_head *list);
 void parse_events_update_lists(struct list_head *list_event,
 			       struct list_head *list_all);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index d70f5d84af92..7764e5895210 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -273,78 +273,15 @@ event_def: event_pmu |
 event_pmu:
 PE_NAME opt_pmu_config
 {
-	struct parse_events_state *parse_state = _parse_state;
 	/* List of created evsels. */
 	struct list_head *list = NULL;
-	char *pattern = NULL;
-
-#define CLEANUP						\
-	do {						\
-		parse_events_terms__delete($2);		\
-		free(list);				\
-		free($1);				\
-		free(pattern);				\
-	} while(0)
+	int err = parse_events_multi_pmu_add_or_add_pmu(_parse_state, $1, $2, &list, &@1);
 
-	list = alloc_list();
-	if (!list) {
-		CLEANUP;
-		YYNOMEM;
-	}
-	/* Attempt to add to list assuming $1 is a PMU name. */
-	if (parse_events_add_pmu(parse_state, list, $1, $2, /*auto_merge_stats=*/false, &@1)) {
-		struct perf_pmu *pmu = NULL;
-		int ok = 0;
-
-		/* Failure to add, try wildcard expansion of $1 as a PMU name. */
-		if (asprintf(&pattern, "%s*", $1) < 0) {
-			CLEANUP;
-			YYNOMEM;
-		}
-
-		while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-			const char *name = pmu->name;
-
-			if (parse_events__filter_pmu(parse_state, pmu))
-				continue;
-
-			if (!strncmp(name, "uncore_", 7) &&
-			    strncmp($1, "uncore_", 7))
-				name += 7;
-			if (!perf_pmu__match(pattern, name, $1) ||
-			    !perf_pmu__match(pattern, pmu->alias_name, $1)) {
-				bool auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
-
-				if (!parse_events_add_pmu(parse_state, list, pmu->name, $2,
-							  auto_merge_stats, &@1)) {
-					ok++;
-					parse_state->wild_card_pmus = true;
-				}
-			}
-		}
-
-		if (!ok) {
-			/* Failure to add, assume $1 is an event name. */
-			zfree(&list);
-			ok = !parse_events_multi_pmu_add(parse_state, $1, $2, &list, &@1);
-		}
-		if (!ok) {
-			struct parse_events_error *error = parse_state->error;
-			char *help;
-
-			if (asprintf(&help, "Unable to find PMU or event on a PMU of '%s'", $1) < 0)
-				help = NULL;
-			parse_events_error__handle(error, @1.first_column,
-						   strdup("Bad event or PMU"),
-						   help);
-			CLEANUP;
-			YYABORT;
-		}
-	}
+	parse_events_terms__delete($2);
+	free($1);
+	if (err)
+		PE_ABORT(err);
 	$$ = list;
-	list = NULL;
-	CLEANUP;
-#undef CLEANUP
 }
 |
 PE_NAME sep_dc
-- 
2.44.0.683.g7961c838ac-goog

