Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F4EC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0238E61458
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbhKHNlW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:41:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38733 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235425AbhKHNlU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:41:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cb4xeltO1DDlNqYovIXsipHet5daTDCWdu9vonMgzKQ=;
        b=WTKxwY7sOZ5TUO/XkLfEaDb95F/RxYspbgi5qreJOp/eJcYle/gds21zbv/lw+7wamki3B
        1/JAoS/fod3jrdtC66qbiBmt43JB+9OQ8kaXaQ91t+rRdbLwYqjLBmL28jV6K2T+lJq4oY
        gX1Ch4hlBEHjky5/aOr+2ckz61L2BII=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-Yu_PRHjeOqajPAEqfqD1Vg-1; Mon, 08 Nov 2021 08:38:34 -0500
X-MC-Unique: Yu_PRHjeOqajPAEqfqD1Vg-1
Received: by mail-wm1-f70.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso10169169wms.4
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:38:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cb4xeltO1DDlNqYovIXsipHet5daTDCWdu9vonMgzKQ=;
        b=KIcpZaQm6li+mD5MBSL/nCAWQorbkIFeOiv8La7/PgYQAi9w5sEjAgZE0y2HeKqOWB
         Z7C4l2eLrd++Gbgngj7c3bThXuLYY7RMrEStWLhaldYvTJ9ZvGuILFzomDQEAh6TCZPg
         asi+66G7ja5BRH9FozasvlnJCJT7ugydBo6b0VctiYNHrZkv5sz7+MGp4Gd2fh9sOie4
         iO0VjAzV+UEjTe5eWec+NLbouE7R146GVb8LGfN6U49n5q+yhu6FDGMIOEmLkRBS6yzX
         1EPFQcZoN1bvofNPP3pOGZDFsz26tv3DsPTnafv2y1tQMIHHDxHtET/YL2wJBabrJU8t
         HVow==
X-Gm-Message-State: AOAM5318HBfbRsgHWg/w21ohuy3jQdJiYEGGKVMHFKI7QxvSiUXyN58v
        q+HF5OwgzGTY/bmhZeFGtfRkKHJzuDGm8bLGck7nWxK5WKWtVRpU6DytYnJOMO3TEUkup1xQ2JO
        Zva9HxGwEmoXEpFORhSFSZjFiElEoqQ==
X-Received: by 2002:a05:6000:1862:: with SMTP id d2mr58984116wri.203.1636378713581;
        Mon, 08 Nov 2021 05:38:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTIHRp3ugO3MgcEF3rT/cBZhtAPkK0WptdY2fXSaR4ER1lg/cETp7ZAg05FDiBkhyinko93w==
X-Received: by 2002:a05:6000:1862:: with SMTP id d2mr58984091wri.203.1636378713363;
        Mon, 08 Nov 2021 05:38:33 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id g18sm17706611wmq.4.2021.11.08.05.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:38:33 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 12/59] libperf: Move unit to perf_evsel
Date:   Mon,  8 Nov 2021 14:36:23 +0100
Message-Id: <20211108133710.1352822-13-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving unit to perf_evsel struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/evsel.h | 1 +
 tools/perf/builtin-stat.c               | 2 +-
 tools/perf/tests/event_update.c         | 2 +-
 tools/perf/util/evsel.c                 | 8 ++++----
 tools/perf/util/evsel.h                 | 1 -
 tools/perf/util/header.c                | 2 +-
 tools/perf/util/parse-events.c          | 4 ++--
 tools/perf/util/stat-display.c          | 8 ++++----
 tools/perf/util/synthetic-events.c      | 6 +++---
 9 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 105ff0626482..b96c9f4808ca 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -68,6 +68,7 @@ struct perf_evsel {
 		struct list_head	config_terms;
 		const char		*metric_id;
 		enum perf_tool_event	tool_event;
+		const char		*unit;
 	};
 };
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f697af989d60..f57a366b7a1a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -917,7 +917,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			continue;
 		}
 
-		l = strlen(counter->unit);
+		l = strlen(counter->core.unit);
 		if (l > stat_config.unit_width)
 			stat_config.unit_width = l;
 
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index 44a50527f9d9..556eb8e6b228 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -99,7 +99,7 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
 
 	perf_evlist__id_add(&evlist->core, &evsel->core, 0, 0, 123);
 
-	evsel->unit = unit;
+	evsel->core.unit = unit;
 
 	TEST_ASSERT_VAL("failed to synthesize attr update unit",
 			!perf_event__synthesize_event_update_unit(NULL, evsel, process_event_unit));
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3985e69123d2..133b571e1190 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -241,7 +241,7 @@ void evsel__init(struct evsel *evsel,
 {
 	perf_evsel__init(&evsel->core, attr, idx);
 	evsel->tracking	   = !idx;
-	evsel->unit	   = "";
+	evsel->core.unit   = "";
 	evsel->scale	   = 1.0;
 	evsel->max_events  = ULONG_MAX;
 	evsel->evlist	   = NULL;
@@ -282,7 +282,7 @@ struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
 		 */
 		static const char *unit = "msec";
 
-		evsel->unit = unit;
+		evsel->core.unit = unit;
 		evsel->scale = 1e-6;
 	}
 
@@ -422,7 +422,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 
 	evsel->max_events = orig->max_events;
 	evsel->core.tool_event = orig->core.tool_event;
-	evsel->unit = orig->unit;
+	evsel->core.unit = orig->core.unit;
 	evsel->scale = orig->scale;
 	evsel->snapshot = orig->snapshot;
 	evsel->per_pkg = orig->per_pkg;
@@ -1300,7 +1300,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		attr->exclude_user   = 1;
 	}
 
-	if (evsel->core.own_cpus || evsel->unit)
+	if (evsel->core.own_cpus || evsel->core.unit)
 		evsel->core.attr.read_format |= PERF_FORMAT_ID;
 
 	/*
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 548d3042fa8b..f6cc1e78903f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -60,7 +60,6 @@ struct evsel {
 		char			*filter;
 		unsigned long		max_events;
 		double			scale;
-		const char		*unit;
 		struct cgroup		*cgrp;
 		/* parse modifier helper */
 		int			exclude_GH;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 949d24da7000..4610b23fed28 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4256,7 +4256,7 @@ int perf_event__process_event_update(struct perf_tool *tool __maybe_unused,
 
 	switch (ev->type) {
 	case PERF_EVENT_UPDATE__UNIT:
-		evsel->unit = strdup(ev->data);
+		evsel->core.unit = strdup(ev->data);
 		break;
 	case PERF_EVENT_UPDATE__NAME:
 		evsel->core.name = strdup(ev->data);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 15d5880df4c2..1878ea1310d3 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -436,7 +436,7 @@ static int add_event_tool(struct list_head *list, int *idx,
 		return -ENOMEM;
 	evsel->core.tool_event = tool_event;
 	if (tool_event == PERF_TOOL_DURATION_TIME)
-		evsel->unit = "ns";
+		evsel->core.unit = "ns";
 	return 0;
 }
 
@@ -1663,7 +1663,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	if (parse_state->fake_pmu)
 		return 0;
 
-	evsel->unit = info.unit;
+	evsel->core.unit = info.unit;
 	evsel->scale = info.scale;
 	evsel->per_pkg = info.per_pkg;
 	evsel->snapshot = info.snapshot;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index b00097e86c85..5f5467c55323 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -372,10 +372,10 @@ static void abs_printout(struct perf_stat_config *config,
 
 	fprintf(output, fmt, avg, config->csv_sep);
 
-	if (evsel->unit)
+	if (evsel->core.unit)
 		fprintf(output, "%-*s%s",
 			config->csv_output ? 0 : config->unit_width,
-			evsel->unit, config->csv_sep);
+			evsel->core.unit, config->csv_sep);
 
 	fprintf(output, "%-*s", config->csv_output ? 0 : 25, evsel__name(evsel));
 
@@ -476,7 +476,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 
 		fprintf(config->output, "%-*s%s",
 			config->csv_output ? 0 : config->unit_width,
-			counter->unit, config->csv_sep);
+			counter->core.unit, config->csv_sep);
 
 		fprintf(config->output, "%*s",
 			config->csv_output ? 0 : -25, evsel__name(counter));
@@ -588,7 +588,7 @@ static void collect_all_aliases(struct perf_stat_config *config, struct evsel *c
 		if (strcmp(evsel__name(alias), evsel__name(counter)) ||
 		    alias->scale != counter->scale ||
 		    alias->cgrp != counter->cgrp ||
-		    strcmp(alias->unit, counter->unit) ||
+		    strcmp(alias->core.unit, counter->core.unit) ||
 		    evsel__is_clock(alias) != evsel__is_clock(counter) ||
 		    !strcmp(alias->pmu_name, counter->pmu_name))
 			break;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 2528c22792be..27c97f22d855 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1824,7 +1824,7 @@ static struct perf_record_event_update *event_update_event__new(size_t size, u64
 int perf_event__synthesize_event_update_unit(struct perf_tool *tool, struct evsel *evsel,
 					     perf_event__handler_t process)
 {
-	size_t size = strlen(evsel->unit);
+	size_t size = strlen(evsel->core.unit);
 	struct perf_record_event_update *ev;
 	int err;
 
@@ -1832,7 +1832,7 @@ int perf_event__synthesize_event_update_unit(struct perf_tool *tool, struct evse
 	if (ev == NULL)
 		return -ENOMEM;
 
-	strlcpy(ev->data, evsel->unit, size + 1);
+	strlcpy(ev->data, evsel->core.unit, size + 1);
 	err = process(tool, (union perf_event *)ev, NULL, NULL);
 	free(ev);
 	return err;
@@ -1921,7 +1921,7 @@ int perf_event__synthesize_attrs(struct perf_tool *tool, struct evlist *evlist,
 
 static bool has_unit(struct evsel *evsel)
 {
-	return evsel->unit && *evsel->unit;
+	return evsel->core.unit && *evsel->core.unit;
 }
 
 static bool has_scale(struct evsel *evsel)
-- 
2.31.1

