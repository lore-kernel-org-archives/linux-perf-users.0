Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D5F200BF
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Apr 2024 06:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162997; cv=none; b=ZfBgZeyG/Nx7Y0aJJ77h3ovFPkHzA+DUS59hRdinp+xYXhm+eEEslIDrl7wA7kKHYGi/GmeNscIhwphBNutUIB7hOef5XVOPpqJoI7UYQlTVdsBks7PohDGJFldhAPThs1JYcZej7ovJDzR+EpUhdkoXaB8ptm+q/103pjoZnxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162997; c=relaxed/simple;
	bh=O7hIVbr0xqoOv6vBJUBcktxWCtmfzAofbpA7+d5SIhs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=A7R5rs/VyimQ7Ym5hVYcKs1AAcSxU8T+b+NhU+85x6CiU5EclwdGDv4GyNpIgOdXGKfEj3jlGQW2yOEHzf4ziLLfkKC3lbGipXfYbNdbMbRse5JdPFXPSVjFPTPCau/E+Ui2xmXk82nfWXZFh2UDbojgIH80jtxfLcyyPgpAzns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RrgtutIL; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RrgtutIL"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5dcbb769a71so3111604a12.3
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Apr 2024 23:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713162995; x=1713767795; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cBIPczyGmK1H1pt2G8mgcHP61YsaqzYuWfuwlwliFdk=;
        b=RrgtutILUolHbtiLYDeQ7CZbZ872b3LlbNocS+Hx6FpRHOOeyRY5wLvAQUCgtP80f/
         rIWx3yQPAKNA9UozRK6c9+Cb7lLPPqDqAVqiy4ebspFhVIMUlbOgRWk6gVwpmgGEhly0
         yoc5uYsXIMOrLvn9TW27reVlWkLXAKxAW/FePBVb9boAkxRZCrCHfdoQN7Gq8rwFYBFe
         ejjmQ2ciD2C79XsVRgul3H6X9GU//Yu2/3g1VXyACIveSTWyopXGevm6mFKle+TMKnbm
         rHaP8b6wuAz7cYM6LBKRVw75sTEIZzhnJEBELE0eqPz4whaSpj7FhpbNcJ7Erd9ifX/j
         2yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713162995; x=1713767795;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBIPczyGmK1H1pt2G8mgcHP61YsaqzYuWfuwlwliFdk=;
        b=fS2l+8OpH2gjbU9tWas4gycXTD3+B6aSSo9NrfYwV/ApMKcUTmFgM86dVuXwPylQ2x
         lblc0k+Nq0Unl4TOzXuDY2W20JTm5K1GzfoVcAneItfTKE4TRnAdGfn9EJ2oruRfVCSX
         VXkFB6hXDCwchXqVQmxsS2T1EgcebZsH/kESKNXK6N6KcuOvqYk7gxptz2KDmVd6LrR4
         LOcoH3KqeIOKRA6dLBEu5VwizWNXT8MSTNKdLarSw3ymaxqJNDSRVaeA8iRpQUlWeoPm
         QX4yCvjCGyOyHWZINIQmdJbEAuDaMevpCN0t+EC+W6+6XiSSCHctsNA103/Qr4UcF7YF
         oE0g==
X-Forwarded-Encrypted: i=1; AJvYcCUF4AqZXcHBuaZd4O1r3IlXjEQii4ip2JKbYvxT9yR1i2lBWsYUaYfpcyNkAjIHUxZeVi/ZOP4JptMpcM82JqL0SL5mzEwt+7nk4C4HiQ9/Qw==
X-Gm-Message-State: AOJu0YwuyqsL6j+g95FPca6ejFShYjnLCSVSyeg/JgSBCAjWCuv6aZXw
	/ErLl1pIM/CeBGo6aAzVshQ/hZvkYr+mpnBMKhjoNPQ8dwxlh16ynliH4my8F3O3iOu5dwWIw8C
	uH8xUrw==
X-Google-Smtp-Source: AGHT+IHksE11INoODcmfSA8PUTVNGXIlCH66XxnH2VvOntZKJzWoEyBWTiUDIjjhs1caK8c5pV3a1jp10fJX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f304:d776:d707:4b57])
 (user=irogers job=sendgmr) by 2002:a63:f919:0:b0:5db:edca:d171 with SMTP id
 h25-20020a63f919000000b005dbedcad171mr25389pgi.6.1713162994834; Sun, 14 Apr
 2024 23:36:34 -0700 (PDT)
Date: Sun, 14 Apr 2024 23:36:19 -0700
In-Reply-To: <20240415063626.453987-1-irogers@google.com>
Message-Id: <20240415063626.453987-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415063626.453987-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v1 2/9] perf parse-events: Directly pass PMU to parse_events_add_pmu
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

Avoid passing the name of a PMU then finding it again, just directly
pass the PMU. parse_events_multi_pmu_add_or_add_pmu is the only
version that needs to find a PMU, so move the find there. Remove the
error message as parse_events_multi_pmu_add_or_add_pmu will given an
error at the end when a name isn't either a PMU name or event
name. Without the error message being created the location in the
input parameter (loc) can be removed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 46 +++++++++++++---------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index b16c75bf5580..bc4a5e3c6c21 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1386,32 +1386,18 @@ static bool config_term_percore(struct list_head *config_terms)
 }
 
 static int parse_events_add_pmu(struct parse_events_state *parse_state,
-			 struct list_head *list, const char *name,
-			 const struct parse_events_terms *const_parsed_terms,
-			 bool auto_merge_stats, void *loc_)
+				struct list_head *list, struct perf_pmu *pmu,
+				const struct parse_events_terms *const_parsed_terms,
+				bool auto_merge_stats)
 {
 	struct perf_event_attr attr;
 	struct perf_pmu_info info;
-	struct perf_pmu *pmu;
 	struct evsel *evsel;
 	struct parse_events_error *err = parse_state->error;
-	YYLTYPE *loc = loc_;
 	LIST_HEAD(config_terms);
 	struct parse_events_terms parsed_terms;
 	bool alias_rewrote_terms = false;
 
-	pmu = parse_state->fake_pmu ?: perf_pmus__find(name);
-
-	if (!pmu) {
-		char *err_str;
-
-		if (asprintf(&err_str,
-				"Cannot find PMU `%s'. Missing kernel support?",
-				name) >= 0)
-			parse_events_error__handle(err, loc->first_column, err_str, NULL);
-		return -EINVAL;
-	}
-
 	parse_events_terms__init(&parsed_terms);
 	if (const_parsed_terms) {
 		int ret = parse_events_terms__copy(const_parsed_terms, &parsed_terms);
@@ -1425,9 +1411,9 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 		strbuf_init(&sb, /*hint=*/ 0);
 		if (pmu->selectable && list_empty(&parsed_terms.terms)) {
-			strbuf_addf(&sb, "%s//", name);
+			strbuf_addf(&sb, "%s//", pmu->name);
 		} else {
-			strbuf_addf(&sb, "%s/", name);
+			strbuf_addf(&sb, "%s/", pmu->name);
 			parse_events_terms__to_strbuf(&parsed_terms, &sb);
 			strbuf_addch(&sb, '/');
 		}
@@ -1469,7 +1455,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 		strbuf_init(&sb, /*hint=*/ 0);
 		parse_events_terms__to_strbuf(&parsed_terms, &sb);
-		fprintf(stderr, "..after resolving event: %s/%s/\n", name, sb.buf);
+		fprintf(stderr, "..after resolving event: %s/%s/\n", pmu->name, sb.buf);
 		strbuf_release(&sb);
 	}
 
@@ -1583,8 +1569,8 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			continue;
 
 		auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
-		if (!parse_events_add_pmu(parse_state, list, pmu->name,
-					  &parsed_terms, auto_merge_stats, loc)) {
+		if (!parse_events_add_pmu(parse_state, list, pmu,
+					  &parsed_terms, auto_merge_stats)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
@@ -1596,8 +1582,8 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 	}
 
 	if (parse_state->fake_pmu) {
-		if (!parse_events_add_pmu(parse_state, list, event_name, &parsed_terms,
-					  /*auto_merge_stats=*/true, loc)) {
+		if (!parse_events_add_pmu(parse_state, list, parse_state->fake_pmu, &parsed_terms,
+					  /*auto_merge_stats=*/true)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
@@ -1626,7 +1612,7 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 {
 	char *pattern = NULL;
 	YYLTYPE *loc = loc_;
-	struct perf_pmu *pmu = NULL;
+	struct perf_pmu *pmu;
 	int ok = 0;
 	char *help;
 
@@ -1637,10 +1623,12 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 	INIT_LIST_HEAD(*listp);
 
 	/* Attempt to add to list assuming event_or_pmu is a PMU name. */
-	if (!parse_events_add_pmu(parse_state, *listp, event_or_pmu, const_parsed_terms,
-					/*auto_merge_stats=*/false, loc))
+	pmu = parse_state->fake_pmu ?: perf_pmus__find(event_or_pmu);
+	if (pmu && !parse_events_add_pmu(parse_state, *listp, pmu, const_parsed_terms,
+					/*auto_merge_stats=*/false))
 		return 0;
 
+	pmu = NULL;
 	/* Failed to add, try wildcard expansion of event_or_pmu as a PMU name. */
 	if (asprintf(&pattern, "%s*", event_or_pmu) < 0) {
 		zfree(listp);
@@ -1660,8 +1648,8 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 		    !perf_pmu__match(pattern, pmu->alias_name, event_or_pmu)) {
 			bool auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
 
-			if (!parse_events_add_pmu(parse_state, *listp, pmu->name, const_parsed_terms,
-						  auto_merge_stats, loc)) {
+			if (!parse_events_add_pmu(parse_state, *listp, pmu, const_parsed_terms,
+						  auto_merge_stats)) {
 				ok++;
 				parse_state->wild_card_pmus = true;
 			}
-- 
2.44.0.683.g7961c838ac-goog

