Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EF5245022
	for <linux-perf-users@vger.kernel.org>; Mon, 12 May 2025 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747075631; cv=none; b=oqHhIr0xxLNdp3AzjwqwGSC2U7KA0+wT5KgSpoVHS62d6MkjQrUqiGeOghY/K6XnKvdBBe//d9EDExE1e0Boj10Jtm724/6pNw7WlV25RvdTTckV7+uSKbGqde55M/sh0vjC9yo0MRJNtDkyluf5I2ziavT8pqXVZEtCohAfDC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747075631; c=relaxed/simple;
	bh=SEhKerd/haNl7wlB6BoA97ehO97jOk7VpGMWJZEARTs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=ZFfRUZb9BIJjVjkMBcWa6l17cfc3i7XCR/FXE2YeR7bfWL5fmcn0PbQZKf6QhkEAwhJYg0VdTI+xS8dX3kwRnowj6RfBI6oA34SuzDzIXfqbjsWh8DO+rQRU1+alIwdy/N285P9h1yN6I0pGHSbL/ld5wJSgwBbHuky27+q43J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1Tgzn0+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1Tgzn0+"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e7903f35980so3634432276.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 May 2025 11:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747075628; x=1747680428; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N7h6b26N/R/NGxMDZ3ohDUFhbT1oVCZDTo7x++LTbwc=;
        b=S1Tgzn0+2+6tmZ3vsEOC81GJiaTGUuDqTnyEZXhk6ruUiknWCDMk+6StZqW00KFs7g
         n7LFhtun4cNn4L3HLfEw7sK4uNmA2wapyT8vna7htbjn8CRflJiAZDKMzehvysAY5tzx
         QGjX30RvGRTiPEf9Jb/sczA8XOaEWMc2RGA/pra2fC2oKuyXV45178VJK4aYEWi0PQX4
         ZhdFkpe63H2wgEbSccSl5nA4AnG4B5F2e/G2mg+Qpt2svAROHJVAeQZ/XiHheLkSp6G5
         u8QxhmV6125PpVqjgGu3Kmf+gq5KaXzH0xEOWpCf0gS1aWI4fmzs/Qls6rwHTNTszgJP
         P+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747075628; x=1747680428;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N7h6b26N/R/NGxMDZ3ohDUFhbT1oVCZDTo7x++LTbwc=;
        b=ZJlbradw3Th/LbGYLYM/w0JS1dJuG74Qv/sHSLuHRTdtP5r8Y/uF1PyS7s9sGyChr0
         yyrD4tjKsJYghYHcKMw47DlVoSWh4TXtqgqbjBfBVrB9C6r4uOu3WSA7sarL+C+CD77A
         fep+IgaT2OqO//DohLsOoz+u19QIjNpd6cmPqLKnJT1sg1ZSvmt1WCnX7OcCDsuMC2di
         k54JAR1AfpoE7hmA9uzBgipTQ6I/2p3y/KDTfxs15QZ8/n7ZYH1ktlonn60XGU7qHAw1
         QRvtxQcZ+PCuS8S5L9cKIDUKj4IkbRDtHlJb+Nl29IH5l1qN9lAYHMV28DtpqIFfTcwa
         nzxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1kyT993VK9gZVna7JN/cU352j10fwXHNQosphl4+evPHH0M+r5Q01U3MLhWkVzGiTicKTYcO/JGWE2jQqwAeb@vger.kernel.org
X-Gm-Message-State: AOJu0YxEYJkH65vcdO+sz6+OXMyRzc0gGiU/9xqkodyFVioWjBDb+SJd
	Ig+Fw0jub0T9HI5msHmSl+mKGxu6GxWRVVUo6tz6JgFDv2K38FuCcO1uGKa4iLWLPvzmqQ4mf5+
	nxZXupQ==
X-Google-Smtp-Source: AGHT+IGy8/5DMSVrm1V5Nn0D6X/7V833WTU9rhXyBdG3tq8u/sFgcEV4161bk8fXo788cImQuMct0zF75g0R
X-Received: from ybbgv9.prod.google.com ([2002:a05:6902:4389:b0:e79:cbca:44e5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:2585:b0:e75:6432:4b26
 with SMTP id 3f1490d57ef6-e78fdbe9926mr17317084276.13.1747075628248; Mon, 12
 May 2025 11:47:08 -0700 (PDT)
Date: Mon, 12 May 2025 11:46:59 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512184700.11691-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf list: Display the PMU name associated with a perf
 metric in json
From: Ian Rogers <irogers@google.com>
To: Weilin Wang <weilin.wang@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The perf stat --cputype option can be used to filter which metrics
will be applied, for this reason the json metrics have an associated
PMU. List this PMU name in the perf list output in json mode so that
tooling may access it.

An example of the new field is:
```
{
        "MetricGroup": "Backend",
        "MetricName": "tma_core_bound",
        "MetricExpr": "max(0, tma_backend_bound - tma_memory_bound)",
        "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2",
        "ScaleUnit": "100%",
        "BriefDescription": "This metric represents fraction of slots where ...
        "PublicDescription": "This metric represents fraction of slots where ...
        "Unit": "cpu_core"
},
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c      | 12 ++++++++++--
 tools/perf/util/metricgroup.c  |  5 ++++-
 tools/perf/util/print-events.h |  3 ++-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index fed482adb039..e9b595d75df2 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -197,7 +197,8 @@ static void default_print_metric(void *ps,
 				const char *long_desc,
 				const char *expr,
 				const char *threshold,
-				const char *unit __maybe_unused)
+				const char *unit __maybe_unused,
+				const char *pmu_name __maybe_unused)
 {
 	struct print_state *print_state = ps;
 	FILE *fp = print_state->fp;
@@ -433,7 +434,8 @@ static void json_print_event(void *ps, const char *topic, const char *pmu_name,
 static void json_print_metric(void *ps __maybe_unused, const char *group,
 			      const char *name, const char *desc,
 			      const char *long_desc, const char *expr,
-			      const char *threshold, const char *unit)
+			      const char *threshold, const char *unit,
+			      const char *pmu_name)
 {
 	struct json_print_state *print_state = ps;
 	bool need_sep = false;
@@ -483,6 +485,12 @@ static void json_print_metric(void *ps __maybe_unused, const char *group,
 				   long_desc);
 		need_sep = true;
 	}
+	if (pmu_name) {
+		fix_escape_fprintf(fp, &buf, "%s\t\"Unit\": \"%S\"",
+				   need_sep ? ",\n" : "",
+				   pmu_name);
+		need_sep = true;
+	}
 	fprintf(fp, "%s}", need_sep ? "\n" : "");
 	strbuf_release(&buf);
 }
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 126a631686b0..43d35f956a33 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -396,6 +396,7 @@ struct mep {
 	const char *metric_expr;
 	const char *metric_threshold;
 	const char *metric_unit;
+	const char *pmu_name;
 };
 
 static int mep_cmp(struct rb_node *rb_node, const void *entry)
@@ -476,6 +477,7 @@ static int metricgroup__add_to_mep_groups(const struct pmu_metric *pm,
 			me->metric_expr = pm->metric_expr;
 			me->metric_threshold = pm->metric_threshold;
 			me->metric_unit = pm->unit;
+			me->pmu_name = pm->pmu;
 		}
 	}
 	free(omg);
@@ -551,7 +553,8 @@ void metricgroup__print(const struct print_callbacks *print_cb, void *print_stat
 				me->metric_long_desc,
 				me->metric_expr,
 				me->metric_threshold,
-				me->metric_unit);
+				me->metric_unit,
+				me->pmu_name);
 		next = rb_next(node);
 		rblist__remove_node(&groups, node);
 	}
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index 445efa1636c1..8f19c2bea64a 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -25,7 +25,8 @@ struct print_callbacks {
 			const char *long_desc,
 			const char *expr,
 			const char *threshold,
-			const char *unit);
+			const char *unit,
+			const char *pmu_name);
 	bool (*skip_duplicate_pmus)(void *print_state);
 };
 
-- 
2.49.0.1045.g170613ef41-goog

