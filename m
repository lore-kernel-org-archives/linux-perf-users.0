Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3856274FEB
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 04:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601134; cv=none; b=Q9PwEzxwfccQteQA2hfVqGKIN+lTpoFKH8pJcGToaxXYMxlSDmrQ73EsPxT/mShQtVRxeArAESjXNWYQCbZGrgNTxOrLD9dFYX6TEpunssMJN/CfT8kloXK2YBJYXbtdNmXnMMZ2oGS9P21RfXvFN4JkaU3ji7JrIuKM00NMoWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601134; c=relaxed/simple;
	bh=L+pT+AcEatKTFNx03XP2+UW4uPwki5/m42f47BIrFO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dv08/HEpgmr6Nkrek8bVdL0XEUySU426DzIy2Q8RMLXsXJH+TWGzPi5b37ADqI6TzKn90Vh+egaudQT6eyTK+uUtF6XmErCCT68WhRDcMC4EB1DJWZTfWsEQBix+l9pvXgq0ApvHfeuijVT/EZMEUdDOIqEELhrYIq0xNcWALqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AMQxi83d; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AMQxi83d"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77df7f0d7a3so4152850b3a.2
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Sep 2025 21:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601132; x=1759205932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yU89r1Lif32XcTKVN3dVRhkhOuKCxo5EjEhuE/dx2oE=;
        b=AMQxi83dVVxnXkZDlgiQ667MZQIj5IIGfjgKmt2Ulf9Nui2FfkBPtqub8l0RvFhgYA
         RVJxYx5yz+Lxn6k/ad8PdpE8dBpqWgkvRj0VqSef9Qz/GnjqUtWzyU5j9yoXXsH6KhVe
         1YQkR9tXIs+zTJzBLsQM6EMgb30AwwujvLImIeXv+3e7Nln8Pu58aI0LNCq4JzH0kSuM
         AothPD1OJedlvxJPVwIMeuv/nJ2N/R8MzcApEXj+n+L+elbDLoHwl8tNyKNXd0U3QUsA
         4NLml+TDcajneGozSPqcFGtJCgg5vkC+mLbV0ll+AKHD3PwkVUH6IdYV+Dz4TDnzcGkw
         auBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601132; x=1759205932;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yU89r1Lif32XcTKVN3dVRhkhOuKCxo5EjEhuE/dx2oE=;
        b=hJFtFpEMNQKUgHC6wToMfryH8V2j53NeOXIxFSTlmAyN7EljYMTymGgVpSe+gKZA23
         XZaN8vZXvUo1+VlYjSaaUKHTVVUvX6Tq+jUzxFSKQY8jFsW47Af1nCnT8Km5R8mPrS2E
         oEUB7d5kK38NZsABsDxoVcgQswQXFoLCHquDt/qKQ/Z7awFhhoNoZ0hhyHTCUzntoXN6
         REvkMLwG2oYmdCfH0g8zzhfgFtMFTdDLXl0X8Q+02leU7sme5Ni+rIy2OljWEj1583GV
         DDMvGfFj7y7JkneE4oE9r9fbs0zV0fVxUw/JJBqQjzNFpi9FWEkdJ7MntgBcGciEHT/c
         qTPg==
X-Forwarded-Encrypted: i=1; AJvYcCXzlcssQczcU26/subL83cc8FAzH+HbKYNC/1lZrAeBH0teLTx3rZWAy5Qcp5RC64ViNEdHaRfTkDlRvW0RzEWd@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv4StUHVWuW03BWj5M/PnDE/h97eCXaaN181vjdPynKDlT3JZi
	52fSYOJShMQyrleoynt8F5D1sfEtMA4nfc1GkmYRxKM754Rz2hQNYQy99x1AlZyw3ycqkvACQbr
	JuhLsbG1Z2g==
X-Google-Smtp-Source: AGHT+IHt1YpfmJ/hoDdTTUoTBZxbLuXJsdaqngBJF9rDVpAKojmfWFxniP+wqcGd8RPfzriVghi47oF1PXFE
X-Received: from pgao189.prod.google.com ([2002:a63:41c6:0:b0:b55:c92:92c1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3ca6:b0:248:4d59:93d4
 with SMTP id adf61e73a8af0-2cffc6461a9mr1771977637.45.1758601132116; Mon, 22
 Sep 2025 21:18:52 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:21 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-3-irogers@google.com>
Subject: [PATCH v5 02/25] perf parse-events: Fix legacy cache events if event
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
Cc: Thomas Richter <tmricht@linux.ibm.com>
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
index 452f12191f6e..d5675471afc5 100644
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
index a5c5fc39fd6f..be8d2ac1e4e4 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -236,7 +236,8 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
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
2.51.0.534.gc79095c0ca-goog

