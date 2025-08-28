Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19D72797A1
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 06:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363359; cv=none; b=MMyQAA1DFGJ+0Xo/yFIcmgcEr+DdbRhoWvv7QlVKmj/2Arw1KFrnlX8wQH6bptLq2Pi1ZzlV2au1czm003KVl3FIhMiD7P3kP/GNfjKV88WU7mCi4vkt4dJ/yBhjlBMeXxPvJ1i97n2tkJZDDhlBWKQJF//rKG1VqZOqrAN+3DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363359; c=relaxed/simple;
	bh=J11KFE1Be/Xr62/bc+bzuCs7KvWgB6SiP/dHHQRBxgQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=t9401hbOhJH5ExSQsEoi5DDX6cVhMAkDc/voG18CDum46YHrwYMK6fl7nYF02ueqEBzqiMLzFVJTTb+VA2/IxbgzcTvPrqNnU8K6XRTf7XLb7Z4D8JMJpH63D5/jFvIqlj+w0Fef7PyiEus4yYnsymOTXHzRedw1/pp45kiA7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4I38djJk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4I38djJk"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3276f51798dso1958927a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Aug 2025 23:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756363357; x=1756968157; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQ/ghY8pg6tJyPFakofOZholK8TaewPdt9a6aHSESZA=;
        b=4I38djJk5Jfks+CR8EYgBiYduB/07JA3XmOxFbnsGlkWXC+x2Pilj+gXbguWyJg2kY
         NelJPkQFTU1py8p0eGDADs3b9m3GTJX5nG5xfRZQLWPOqnh7iP7td8ko2KSaDhTWc1sW
         cjUFgZvRvCoCP2mw+xwd1kMHZ3hPrt3GPg1QnB1GKUpdhmgHKwJm+CPWYfUF4k9ikNVu
         IWb8YOuASq4cEYX4yFhqGqaHCMUOIc0C+udh5PI+cCgfUpKCv/P1NgVTxccLVlXFmsdj
         pAhPC17DCKDb/gVyMB/o3hWMawWJwKqb4xqufSavSNnKXd/zVUBcr4HIoovJEP6UFwn5
         NW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756363357; x=1756968157;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQ/ghY8pg6tJyPFakofOZholK8TaewPdt9a6aHSESZA=;
        b=JJAxEEyqhNxFYYRyxiFBavpBXYg8r9mRnSLzHsaj+8FMyKe7prP8rokJ4y7t6ovZk/
         9li3K61xpQI7WzSZTshnhdH0ojLGOJ3uUbSYtxyQMreY1EC7nJMDnMJ/IfExyybtr4TT
         wQ2Y59mLCxcF7W/cQUps6FnXf4Rld6L0pFXECZ/YW9JX5RllkfH7WVo9O23rhc1E1h4C
         EZlwAg6B6JW+FgtgH5+h63P4ngj9DlR6WVunC8X9AY0b1+tE7/VkCAwxGVLlNyam1put
         0G+dIsxcpm4Ey5kwqk9S3Pp0OPt9EHwI/5fdlFNXCWOq6TtfsTbTQVwuD69e3RskU9JX
         vCag==
X-Forwarded-Encrypted: i=1; AJvYcCU2BdQOH7cYe2CDUqs2Z5EHoA8KkO1G/0IAR9+IENjcBTNR1mc68cRNiB3paeuCHhKpO0Ko5h6wenIBabPyMr7w@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7797bE7K7sR6J5q6Kvm1sgJzD/NgA+R7otSpg91c99Kd0IvUa
	IoryOHCveh9xo8r+i6Zf98hgpN7CJjP5GdG+7ooqycJU0/4ixhrCt1ctEIbMv3YXIJv4AAVZdwR
	PmVbKFJyGHw==
X-Google-Smtp-Source: AGHT+IEzx0qAvHtKrMlphcUqFxckFi7ecwTjcK6nifIhNkPX7mvuq35j2hOeabcXtlhwMfpuOO85m6fStcq+
X-Received: from pji6.prod.google.com ([2002:a17:90b:3fc6:b0:327:7035:d848])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:380a:b0:321:335e:19cc
 with SMTP id 98e67ed59e1d1-3275085e80dmr10021787a91.4.1756363357011; Wed, 27
 Aug 2025 23:42:37 -0700 (PDT)
Date: Wed, 27 Aug 2025 23:42:19 -0700
In-Reply-To: <20250828064231.1762997-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828064231.1762997-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828064231.1762997-2-irogers@google.com>
Subject: [PATCH v1 01/13] perf parse-events: Fix legacy cache events if event
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
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>
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
2.51.0.268.g9569e192d0-goog

