Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06045C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A3561503
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240001AbhKHNlQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:41:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44389 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235425AbhKHNlO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YLBA1Oe4nN8hMmBDSo04wyRlG7j4QoM0Vc2uGB7wq2U=;
        b=jPWQlMcpJSuIm39mj9ii86AnqhskSvgiawj07HKWEepxGCEpYr+StqN5aw2dJ6fbHVKbRB
        PQBgsMILBvRZk6GSZcZYmsqH87teMu8ibQKukMuHlyg8s7fIgfSP8zaoTh6/mN35B6rAeL
        /QqeOi988Qg518z5OXY5IQcFgJ9+9To=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-H6Uc3FR5PpO8ZmcXuWu_IQ-1; Mon, 08 Nov 2021 08:38:28 -0500
X-MC-Unique: H6Uc3FR5PpO8ZmcXuWu_IQ-1
Received: by mail-wm1-f72.google.com with SMTP id a186-20020a1c7fc3000000b00332f1a308e7so10170482wmd.3
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:38:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLBA1Oe4nN8hMmBDSo04wyRlG7j4QoM0Vc2uGB7wq2U=;
        b=kZhNnZhzFLgT5rn+VCPIC2kzixg7v88ykDfzof0HJ5h3ZrI83+uJ52xpgO9KLaME53
         +n7rcvm6KBMxCWg/XDh5MUqQkqz2Y19XAYK3L/k82TJS/yy2RQr7JTitSkB0w2Uo/RC/
         EdiP15iUcBHXOqTQq6S0W2yHTfzAjbHDnR8Cmd4BUQayrdBmjdSHLBnqjSQ/LHhQtrso
         zO4GGL8PuOxb2Iy41vTRSxuJAVhiTdSHuHfIfLE2E4UQmjfV+/zqLhWnzgMEZ6hWwB4a
         MiF9yd3kn8ADkS4/OL3qpU59UKKzVnizkQnt+ncliIbQPAsob66eGypS5+sCi76QzKqZ
         udxg==
X-Gm-Message-State: AOAM532FMiuGyEWVvvVUs12cSIq3xE3JRgP18cwb868JzlAiEC8noqIM
        TZU4TxIknPZZnSUT4QRYpGLiIxBTVEQ1tm8FokQq9ISxYUyyFVivmTYOiF3EuJnkJcTJZz7ytbK
        wouRbECYH9nHgzoRFgEjN7R4SoOB0Ag==
X-Received: by 2002:a05:600c:4a27:: with SMTP id c39mr53330197wmp.101.1636378707655;
        Mon, 08 Nov 2021 05:38:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAvSvwKY8HKHA8eRAptn0NxEuHMCq/yLbbl3nGRibfargu575L+muBIMCdYB/a30vUen8g/A==
X-Received: by 2002:a05:600c:4a27:: with SMTP id c39mr53330177wmp.101.1636378707459;
        Mon, 08 Nov 2021 05:38:27 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id o10sm7169695wri.15.2021.11.08.05.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:38:27 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 11/59] libperf: Move tool_event to perf_evsel
Date:   Mon,  8 Nov 2021 14:36:22 +0100
Message-Id: <20211108133710.1352822-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving tool_event to perf_evsel struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/evsel.h | 6 ++++++
 tools/perf/builtin-stat.c               | 2 +-
 tools/perf/util/evsel.c                 | 6 +++---
 tools/perf/util/evsel.h                 | 6 ------
 tools/perf/util/parse-events.c          | 2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index dafa1d6be731..105ff0626482 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -11,6 +11,11 @@ struct perf_cpu_map;
 struct perf_thread_map;
 struct xyarray;
 
+enum perf_tool_event {
+	PERF_TOOL_NONE		= 0,
+	PERF_TOOL_DURATION_TIME	= 1,
+};
+
 /*
  * Per fd, to map back from PERF_SAMPLE_ID to evsel, only used when there are
  * more than one entry in the evlist.
@@ -62,6 +67,7 @@ struct perf_evsel {
 		bool			auto_merge_stats;
 		struct list_head	config_terms;
 		const char		*metric_id;
+		enum perf_tool_event	tool_event;
 	};
 };
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f7fda777f122..f697af989d60 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -339,7 +339,7 @@ static int evsel__write_stat_event(struct evsel *counter, u32 cpu, u32 thread,
 static int read_single_counter(struct evsel *counter, int cpu,
 			       int thread, struct timespec *rs)
 {
-	if (counter->tool_event == PERF_TOOL_DURATION_TIME) {
+	if (counter->core.tool_event == PERF_TOOL_DURATION_TIME) {
 		u64 val = rs->tv_nsec + rs->tv_sec*1000000000ULL;
 		struct perf_counts_values *count =
 			perf_counts(counter->counts, cpu, thread);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 52781210a874..3985e69123d2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -421,7 +421,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->core.leader = orig->core.leader;
 
 	evsel->max_events = orig->max_events;
-	evsel->tool_event = orig->tool_event;
+	evsel->core.tool_event = orig->core.tool_event;
 	evsel->unit = orig->unit;
 	evsel->scale = orig->scale;
 	evsel->snapshot = orig->snapshot;
@@ -756,7 +756,7 @@ const char *evsel__name(struct evsel *evsel)
 		break;
 
 	case PERF_TYPE_SOFTWARE:
-		if (evsel->tool_event)
+		if (evsel->core.tool_event)
 			evsel__tool_name(bf, sizeof(bf));
 		else
 			evsel__sw_name(evsel, bf, sizeof(bf));
@@ -789,7 +789,7 @@ const char *evsel__metric_id(const struct evsel *evsel)
 	if (evsel->core.metric_id)
 		return evsel->core.metric_id;
 
-	if (evsel->core.attr.type == PERF_TYPE_SOFTWARE && evsel->tool_event)
+	if (evsel->core.attr.type == PERF_TYPE_SOFTWARE && evsel->core.tool_event)
 		return "duration_time";
 
 	return "unknown";
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index b55173bf8f70..548d3042fa8b 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -25,11 +25,6 @@ struct bperf_follower_bpf;
 
 typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
 
-enum perf_tool_event {
-	PERF_TOOL_NONE		= 0,
-	PERF_TOOL_DURATION_TIME = 1,
-};
-
 /** struct evsel - event selector
  *
  * @evlist - evlist this evsel is in, if it is in one.
@@ -67,7 +62,6 @@ struct evsel {
 		double			scale;
 		const char		*unit;
 		struct cgroup		*cgrp;
-		enum perf_tool_event	tool_event;
 		/* parse modifier helper */
 		int			exclude_GH;
 		int			sample_read;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index ee04fec441e7..15d5880df4c2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -434,7 +434,7 @@ static int add_event_tool(struct list_head *list, int *idx,
 			    /*cpu_list=*/"0");
 	if (!evsel)
 		return -ENOMEM;
-	evsel->tool_event = tool_event;
+	evsel->core.tool_event = tool_event;
 	if (tool_event == PERF_TOOL_DURATION_TIME)
 		evsel->unit = "ns";
 	return 0;
-- 
2.31.1

