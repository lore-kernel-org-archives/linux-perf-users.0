Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FB429AAF7
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 20:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414798; cv=none; b=qvaiIpVxFYVkC1LMDmU02m3oqnMCRH80kIWM4gWrWadRjmtb9hpGCPe95XX81EIJQBTtRgYx39PTD9BKiWoTXHLey13qZzLeCo/er+FllQTxQTjpwnd1xaQOO3wvKX1KNfsscOlN1wZGWJHdaUh0G28TDkNeWRvFF1JdjV9OqsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414798; c=relaxed/simple;
	bh=HP2hsRF/T6DsMoG88ZIORykf1DmPqLqdbYaGBKIMD4A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DqLLTGUbT+e+mbAHMPA5h9TrMz195Y9wSoeIpgZb+SEjzC21yxQyXcI28hR94Ykex6xDdu1Lv3ylRB4fQmt4jky9Z9YXK/jOl+UeTvOrT5CLsxgqbvMsRIOfaIJzypcpKhvd+AnzLbixw/Ro0qnDkF3YM35/gGQfnK/T/lmc7nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SfBdZuEo; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SfBdZuEo"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4c724d27f8so435448a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 13:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756414795; x=1757019595; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uFuVdKQbWtAWkfjn4WwxF7ezypb8BrOvzInrkmEPeas=;
        b=SfBdZuEoBy+uXcA1+XQRamX77dZtusbeJWdGiTB/ZG2J5ng9PlwjFJOlVwCJV/KrzL
         V7OzU8vNQLhHEmnV6sFqhbDUhUhMpBcnSYIk9GSciI4r7Sxx+AtSo3IE51GvCrprU9dz
         6vQ2TlR45XorMOmA10sgC2cjJDInlD83K/UtAvyu2Hw3lssp1BbLYLrsM/bs+KgobOES
         /QPuB2vLYHI2rImPtiQiHkS+cjvB6iMP1hyDvPDxaSzfRQV3HmDCWX1ePexyQQkvRdun
         pQLk0jpcgDpdZpel5DAKLnd2DAoaf8AmE+VPrQOVJYv+v+8fzbOPp87A+8S2QGSPtMCK
         ZvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414795; x=1757019595;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFuVdKQbWtAWkfjn4WwxF7ezypb8BrOvzInrkmEPeas=;
        b=oo583ZSM4og6Z6Uy1qSVNtFIO+eooTDjxqWhnvZVzPysj8JY/EqICOC/6SfW8aqA35
         EoKSj+sIsd5jknOGPiqtVktVuatM8/EkbZK/lNYonnUJnqxu7c85zCCE9hNlnaH2p0nH
         kMKcHa/bmXcEwesLAO8QSQUnE7EFAwSksp7AGxl7nU3qEEKx+Wm0CPElUmgldRLew/OY
         qkwGx/y8zOj1a0re9y0xRqRlOAizvRHm54La16u2GYJQyj9b0uFfy0RLk6Ga+z6XenM0
         3jvx2Fn9T0ifwm2l3mhkalV9YJc5N+8sEiCZJxPlK/2An3XVCNyXo827l4U7r52b55SB
         6jXw==
X-Forwarded-Encrypted: i=1; AJvYcCWIy/QMvC0zU7h4pbYE8v9+my+sZ/EPwm0y3uqSFXNJyWE+HHeXlIdW8Mlj+jX1E5Yjijoz/529p53E32iS9B/0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0JaS250feIpTSJdch1R5dLNofg8nOWeMGTmsmfOC1C5d4q95f
	fZz16wcIX3TkJsWM6NQ3kQduKQ7CmfFI9NXBc/W4MmDZIpxjdE2Ow2TuNp40XA0D/ujZbiMT0By
	TjWoL6OpDeg==
X-Google-Smtp-Source: AGHT+IE8pbUPgReMEKQLmcbkY5a56WN83ZuLshDVRHMu7w8Lya4sJi8+4DhEP9CqzDo4ZZazT7Bha/6TfqZa
X-Received: from plbkg5.prod.google.com ([2002:a17:903:605:b0:246:9673:3625])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e783:b0:246:d98e:630
 with SMTP id d9443c01a7336-246d98e09c1mr187591525ad.44.1756414795293; Thu, 28
 Aug 2025 13:59:55 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:59:16 -0700
In-Reply-To: <20250828205930.4007284-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828205930.4007284-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828205930.4007284-2-irogers@google.com>
Subject: [PATCH v3 01/15] perf parse-events: Fix legacy cache events if event
 is duplicated in a PMU
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

The term list when adding an event to a PMU is expected to have the
event name for the alias lookup. Also, set found_supported so that
-EINVAL isn't returned.

Fixes: 62593394f66a ("perf parse-events: Legacy cache names on all
PMUs and lower priority")

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 28 +++++++++++++++++++++++++++-
 tools/perf/util/parse-events.h |  3 ++-
 tools/perf/util/parse-events.y |  2 +-
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 8282ddf68b98..c219e3ffae65 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -465,8 +465,10 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
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
@@ -487,12 +489,36 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
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
index 62dc7202e3ba..c498d896badf 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -235,7 +235,8 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
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
2.51.0.318.gd7df087d1a-goog

