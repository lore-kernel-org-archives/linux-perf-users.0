Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354D71C69D
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Apr 2024 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162994; cv=none; b=nMHMRdkZiR07lu4LDkB1H7U0eaWuGn5V2lWJ7Y6QjvReXxdYmy76MMbNHrZMLns+Hi6DoaDWsAeXfCrudSLhJLxu7tod4VRKHCl0FG1QxUDFgFWmMbkl00IYOOoCjWFg3KjgFwStvReqpPPhlYw4oQ1GiC6HawJrCvTrmMsONrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162994; c=relaxed/simple;
	bh=z8AXrLaNzb+8gvaf2At9VNLcG0t9xXxT/9GG0wDhFkQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=nRBmAWZmToTWeMPSOV+IdP8X9p9NjensnrmXvPjolJ5f8p8h793ck7iKWC4ftTCxxP17kANGeg1FL0o+ixmWJ7ssDe2/Pg9NAhjMBUNCtLsnSKMuzoV7Syq8bUItX0OBHgSDnR2FK58vjt5Ux2FrPL1Nzy1UVrnrYYPT9dclr50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OTNc3jkL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OTNc3jkL"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61ab19438a3so20874797b3.1
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Apr 2024 23:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713162992; x=1713767792; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3/UXsGbRM4hk6gURXUv3cQgeMnu1X8cp+uoMKx5i54A=;
        b=OTNc3jkL+v+erdDSZdzg/S3AjxCAHS3Mz3hT2Vz7SHU1ioER5IVMa8pQ8w08cawmhe
         tVtD2yxWWPI+l2XAMd2rnJ6xzKmxF6tqDMistNs63bSMt/C9Ky1gVNVv2X92TghAuzp1
         dww58Y+bopQN1QMryoSS0TU1fVmAqNC4PZUYT9BV/cXB1FUVRDUBKcMrX99kivjI8IaO
         oyRPJq3P1bGMfk36ReKGmbYneRy1t//HeYr1+LpEIXTgX7FbuG/Tc13D2J+FX725wDUZ
         gLKt1L/TJULVYDBSZJ4mjLBo2Ip98fzikjo9MiPo7/ROJ/djwa5nmZsc4kPjXQpLlSba
         p9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713162992; x=1713767792;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/UXsGbRM4hk6gURXUv3cQgeMnu1X8cp+uoMKx5i54A=;
        b=V7iF3qLYdZFZeSKaYNVk5ijqXg1+aoRIuWGrNq6+nX5OFxN9iDAml/UoiIOaw0abup
         yWLqMvRN1eGuJK7stCWqd3DgAZH5JUxhDKXPlipSJ4scjSMya6KiZr+v65IEZ/bZJtiN
         sjx/qPJvbww/OO1THmxrF1b6hcsTxhffWtEDs+4YELPdyS9aOFI9wElbu9Chgqi7O7FU
         8C12JlwP5CD65VRCDAMiJJn5cvd4hCLqJ6U0+mIlxR+o1glWrlXgoIMELDlqlWJC0C/8
         dwJ0Lyno1klM8ySvnTsvosf0cS/jPWZ9UEodsJO6+pHVmvJpBLehSQx9unV6zGs/cY4j
         Z3UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlDVCR+jZ9NNvVklr/cbbSszdEa9BfV532GmPrATvOv94MGdGGGfUpk2zyfjiOVBSqy+eqxgGG6SQxqgVDKnfxzw5jeNpmxkIvRFbdscx9HA==
X-Gm-Message-State: AOJu0Yx8/IzdM4tSwXoo6ygSdYqtiHuqSuOol4ufrfrwkOlu0u4GMEkK
	bQLVMKkxk3drOi6tLhGhIavLTvTtVkcv5S8TC6R3yopmjgtcgYNlc4TlDkFkDyODqAfAsu/oD/H
	8WNjQ1w==
X-Google-Smtp-Source: AGHT+IEpPwiuctvi4YKU+jbWzpMd0bbjy29hbZCztwCayE2Xpwu2Te6+qRZrYddkUXa58px17V/U1JOs3MD6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f304:d776:d707:4b57])
 (user=irogers job=sendgmr) by 2002:a0d:c241:0:b0:615:80c8:94eb with SMTP id
 e62-20020a0dc241000000b0061580c894ebmr2287735ywd.10.1713162992269; Sun, 14
 Apr 2024 23:36:32 -0700 (PDT)
Date: Sun, 14 Apr 2024 23:36:18 -0700
In-Reply-To: <20240415063626.453987-1-irogers@google.com>
Message-Id: <20240415063626.453987-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415063626.453987-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v1 1/9] perf parse-events: Factor out '<event_or_pmu>/.../' parsing
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
 tools/perf/util/parse-events.c | 69 +++++++++++++++++++++++++++++++-
 tools/perf/util/parse-events.h | 10 +++--
 tools/perf/util/parse-events.y | 73 +++-------------------------------
 3 files changed, 80 insertions(+), 72 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6f8b0fa17689..b16c75bf5580 100644
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
@@ -1618,6 +1618,73 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
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
+			if (!parse_events_add_pmu(parse_state, *listp, pmu->name, const_parsed_terms,
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
index d70f5d84af92..14175eee9489 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -273,78 +273,17 @@ event_def: event_pmu |
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
+	parse_events_terms__delete($2);
+	free($1);
+	if (err == -ENOMEM)
 		YYNOMEM;
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
+	if (err)
+		YYABORT;
 	$$ = list;
-	list = NULL;
-	CLEANUP;
-#undef CLEANUP
 }
 |
 PE_NAME sep_dc
-- 
2.44.0.683.g7961c838ac-goog

