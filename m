Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E2E1D9324
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688678; cv=none; b=EvTouMoHNAykAINsGSAQXQ/WdMj3heLaSrPyhZFD6BNeuOQoJt22jRpJXnrNcvT2opXvpKyozQyX+5mKQ85HK6fz0zWutRDQ9g9WYVrEe2rsXGikRKxJuYIiXnmOIIT7IQmwYLNJ0enbusGoaE6S1kxvg1+YP2YhtGg6fvMizPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688678; c=relaxed/simple;
	bh=yg7ruaWlIRtZAvQrpYXVORYeu9v3Cru2iR1rI8d795g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ckZaKnAWureHlUTbos3TuGl0j/56sgn59JVFD752BIAOqNILBqr8itU92Y4wGtNcpMMIX8ZoJDka2rhMtngYdb6zFXuX0yh+fLU69J0mCRxIaVLYx5qt/HRbmqtw++1qexpsaxr7l0JZEF7aBG1vK6UW4xICmv6VhzuygT1jjo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iY6PQdzi; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iY6PQdzi"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-28d1747f23bso37865345ad.3
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 11:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688677; x=1760293477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m2pZgTBBdaqr+RFoC8nM1cDgcgCfYPeRk72RktioG6Y=;
        b=iY6PQdzitS6FM2EFHBuU715NXe0UOgwgcOIJfayr0AlR/C2/FFFqE8ZfmuAMF5+ng8
         W8dYL+FmRK/bZyK+3X9IdjFn+94XvXmh0bYqfXSBWf5WD94ja9YAcRWqagxThQ5NsxBK
         VoPblll0XlA3GE3Epvl5z3/CZCynkO/TT6gZmf/sdT7srdfdWCEFD/q3oSUNE2Uh1a5f
         IgmmUxQI5qG7neblh2Xi86kjvuwanvXh4uQmOdMiOe6syG4UykshWHBCiahOHMQOY2ko
         t0soLwg1K4Pla0s6VgtiH3MCwMhQU16jHGNFcY3pLPLRvWFK32B/xlgjdQOtQ68jBRwo
         EaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688677; x=1760293477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m2pZgTBBdaqr+RFoC8nM1cDgcgCfYPeRk72RktioG6Y=;
        b=H4+2sN5B+qfocgdHSDJwB700wGNqXenKCVn/sUcWhp+FKVm3cRH9ApiwNxNvJEmRcw
         0lOl0f1lz9haUe0VSQHM8ATSk5bZPIf912ehsYNpYjOez03pa7PO+HckB1i8FNOwExou
         BZG/SeSjTh1OFVbX8sEkmSp9PHXjVo+G3nL2SauBywAETP4QdT8T7QlfMjhZP8czL952
         i4C5n6v61elfYqIu7lbO0zjqW1PtOI1pOqXtPJh+0OMoEbMsZdcJbd4Zah19yC3/BqjN
         rEYfYKP00NOmJEbG0Ri4bcFfpaAxcsBL++PhmKJlFTd8f9QLVSH600Ur9FSoLYhDGIhC
         ghow==
X-Forwarded-Encrypted: i=1; AJvYcCXAHV9meT8eSlo2+yvcT2AwqQM3ecERYX8iU4ovv/hEkv6r8htNN+/rGghWLL2B/7WKlwOhMwOlH1C08n6IbKJ8@vger.kernel.org
X-Gm-Message-State: AOJu0YwdCC7+EfmfPj9DwWANzwUs0Zw3dQnKXvMrNRLwf2pZn5aC7mmH
	aLocg4/HRRgmuYMYLTYgzy5Ie9sCVdDiFOnUip2rY0fdeSzUguaJD8WouGOHRtW1av/KssuX2HL
	jWOZyKD4uRQ==
X-Google-Smtp-Source: AGHT+IFwGnLGPuf73xtzWLhmrj147LvFYYlB93w3NP9DGhcT2MQoJai5xOPnsZf10CgPEVVdh7kCWkuXvyaH
X-Received: from plcy19.prod.google.com ([2002:a17:903:113:b0:273:67d3:6303])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e883:b0:24e:81d2:cfda
 with SMTP id d9443c01a7336-28e9a3068d5mr119131545ad.0.1759688676749; Sun, 05
 Oct 2025 11:24:36 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:04 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-2-irogers@google.com>
Subject: [PATCH v7 01/27] perf parse-events: Fix legacy cache events if event
 is duplicated in a PMU
From: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

The term list when adding an event to a PMU is expected to have the
event name for the alias lookup. Also, set found_supported so that
-EINVAL isn't returned.

Fixes: 62593394f66a ("perf parse-events: Legacy cache names on all
PMUs and lower priority")

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 28 +++++++++++++++++++++++++++-
 tools/perf/util/parse-events.h |  3 ++-
 tools/perf/util/parse-events.y |  2 +-
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index da73d686f6b9..90a765016f64 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -475,8 +475,10 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
-			   struct parse_events_terms *parsed_terms)
+			   struct parse_events_terms *parsed_terms,
+			   void *loc_)
 {
+	YYLTYPE *loc = loc_;
 	struct perf_pmu *pmu = NULL;
 	bool found_supported = false;
 	const char *config_name = get_config_name(parsed_terms);
@@ -497,12 +499,36 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			 * The PMU has the event so add as not a legacy cache
 			 * event.
 			 */
+			struct parse_events_terms temp_terms;
+			struct parse_events_term *term;
+			char *config = strdup(name);
+
+			if (!config)
+				goto out_err;
+
+			parse_events_terms__init(&temp_terms);
+			if (!parsed_terms)
+				parsed_terms = &temp_terms;
+
+			if (parse_events_term__num(&term,
+						    PARSE_EVENTS__TERM_TYPE_USER,
+						    config, /*num=*/1, /*novalue=*/true,
+						    loc, /*loc_val=*/NULL) < 0) {
+				zfree(&config);
+				goto out_err;
+			}
+			list_add(&term->list, &parsed_terms->terms);
+
 			ret = parse_events_add_pmu(parse_state, list, pmu,
 						   parsed_terms,
 						   first_wildcard_match,
 						   /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
+			list_del_init(&term->list);
+			parse_events_term__delete(term);
+			parse_events_terms__exit(&temp_terms);
 			if (ret)
 				goto out_err;
+			found_supported = true;
 			if (first_wildcard_match == NULL)
 				first_wildcard_match =
 					container_of(list->prev, struct evsel, core.node);
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 8f8c8e7fbcf1..8af19dec6a17 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -237,7 +237,8 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 			     bool wildcard);
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
-			   struct parse_events_terms *parsed_terms);
+			   struct parse_events_terms *parsed_terms,
+			   void *loc);
 int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u64 *config);
 int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 				struct list_head *list,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index a2361c0040d7..ced26c549c33 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -353,7 +353,7 @@ PE_LEGACY_CACHE opt_event_config
 	if (!list)
 		YYNOMEM;
 
-	err = parse_events_add_cache(list, &parse_state->idx, $1, parse_state, $2);
+	err = parse_events_add_cache(list, &parse_state->idx, $1, parse_state, $2, &@1);
 
 	parse_events_terms__delete($2);
 	free($1);
-- 
2.51.0.618.g983fd99d29-goog

