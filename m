Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FA6C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B44A6115A
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbhKHNn0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:43:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237467AbhKHNn0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y5PfsRI8QbVTtkSeslJpXfmQURd/wTCXVzJUE1+96/A=;
        b=iPVf6lpx7zSVgvcuWvcsotU9qMJhFfUazersRJgJ5VV8sylvab7d1Re9gUnFX1+pg8V3Lb
        nbxU9QF/HyGkUxkXschs25kAKyGhfPJUM8BEMC+ENBo5sq65V4GZn4GGW6NPS7FuDrvgg7
        C4P61oBYUq9B57U/Q9S/uuRRgsTu+ko=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-OdpNNODkPsqr6AT_VU3VHQ-1; Mon, 08 Nov 2021 08:40:38 -0500
X-MC-Unique: OdpNNODkPsqr6AT_VU3VHQ-1
Received: by mail-wr1-f70.google.com with SMTP id w14-20020adfbace000000b001884bf6e902so3357138wrg.3
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:40:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5PfsRI8QbVTtkSeslJpXfmQURd/wTCXVzJUE1+96/A=;
        b=tjpw7BUeRDQFegW02wkGrXSXcsdGoG4Bz59MWRthXLTKpf1wLjxhoXal7Nop7QUwMx
         cETJ7/6PJhsMTLyP53xib+HOjaJM5XhrfygR/57UwZtLvsr+pyovZ83jJEGy7coKR1BC
         IDG+aYs18DMkGQf23uzQptEGyXchyKf0vY1xVIVz3eJ87vfnXtA5H3AQ5bdDvtJEjXsF
         XUwrxCzjhnGjIKUhT+V8BmVSV+6LKQLz6A6nHUBjpXRjQLLo11IBg2aL3o/hf5Za5sSY
         yeLGPB8AZ58J3IRnwfwW92YkK4OvASoCaerY/7BIDsin76JQTP+Mzb23kdu2MARObPhV
         fh6A==
X-Gm-Message-State: AOAM5320RkCzUF+KjjOOchC459ck8UUMkIM7u1w4STIRzV2AfCMDp/PR
        PvpFvFXuBcYQS8zT8j1GFiGRPz4AydOtMEvuXEjJ/1ZkTNDt+/LduAoYE+wcrYvpN7spiiXUgRJ
        M+NF2URUFzpxJn73a/ZNCkV9UDyGCzA==
X-Received: by 2002:a1c:9814:: with SMTP id a20mr52309953wme.18.1636378837322;
        Mon, 08 Nov 2021 05:40:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynr+Gm0RD5Cs66Y6ZI2CKcKqSLr4kx7N9bUIxrGaYeYKNIDtEYE14s9xChTqMCXDxbMn3ypw==
X-Received: by 2002:a1c:9814:: with SMTP id a20mr52309927wme.18.1636378837105;
        Mon, 08 Nov 2021 05:40:37 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id s24sm15508232wmj.26.2021.11.08.05.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:40:36 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 33/59] libperf: Move in perf_evsel__add_event function
Date:   Mon,  8 Nov 2021 14:36:44 +0100
Message-Id: <20211108133710.1352822-34-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving perf_evsel__add_event function to libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../lib/perf/include/internal/parse-events.h  |  9 ++++
 tools/lib/perf/parse-events.c                 | 47 +++++++++++++++++++
 tools/perf/util/parse-events.c                | 44 -----------------
 3 files changed, 56 insertions(+), 44 deletions(-)

diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index b314c8639c78..7bf58f6fc53f 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -120,4 +120,13 @@ void parse_events_terms__delete(struct list_head *terms);
 void parse_events_terms__purge(struct list_head *terms);
 int parse_events_copy_term_list(struct list_head *old,
 				 struct list_head **new);
+
+struct perf_evsel *
+perf_evsel__add_event(struct parse_events_state *parse_state,
+		      struct list_head *list,
+		      struct perf_event_attr *attr,
+		      bool init_attr,
+		      const char *name, const char *metric_id, struct perf_pmu *pmu,
+		      struct list_head *config_terms, bool auto_merge_stats,
+		      const char *cpu_list);
 #endif /* __LIBPERF_PARSE_EVENTS_H */
diff --git a/tools/lib/perf/parse-events.c b/tools/lib/perf/parse-events.c
index cda7c1e5563e..6d840764c84d 100644
--- a/tools/lib/perf/parse-events.c
+++ b/tools/lib/perf/parse-events.c
@@ -5,6 +5,9 @@
 #include <linux/zalloc.h>
 #include <string.h>
 #include <internal/parse-events.h>
+#include <internal/pmu.h>
+#include <internal/evsel.h>
+#include <perf/cpumap.h>
 #include <stdlib.h>
 #include <errno.h>
 
@@ -302,3 +305,47 @@ void parse_events_terms__delete(struct list_head *terms)
 	parse_events_terms__purge(terms);
 	free(terms);
 }
+
+struct perf_evsel *
+perf_evsel__add_event(struct parse_events_state *parse_state,
+		      struct list_head *list,
+		      struct perf_event_attr *attr,
+		      bool init_attr,
+		      const char *name, const char *metric_id, struct perf_pmu *pmu,
+		      struct list_head *config_terms, bool auto_merge_stats,
+		      const char *cpu_list)
+{
+	struct perf_evsel *evsel;
+	struct perf_cpu_map *cpus = pmu ? perf_cpu_map__get(pmu->cpus) :
+			       cpu_list ? perf_cpu_map__new(cpu_list) : NULL;
+	int *idx = &parse_state->idx;
+
+	if (pmu && attr->type == PERF_TYPE_RAW)
+		perf_pmu__warn_invalid_config(pmu, attr->config, name);
+
+	evsel = parse_state->ops->perf_evsel__new(attr, *idx, init_attr);
+	if (!evsel) {
+		perf_cpu_map__put(cpus);
+		return NULL;
+	}
+
+	(*idx)++;
+	evsel->cpus = cpus;
+	evsel->own_cpus = perf_cpu_map__get(cpus);
+	evsel->system_wide = pmu ? pmu->is_uncore : false;
+	evsel->auto_merge_stats = auto_merge_stats;
+
+	if (name)
+		evsel->name = strdup(name);
+
+	if (metric_id)
+		evsel->metric_id = strdup(metric_id);
+
+	if (config_terms)
+		list_splice_init(config_terms, &evsel->config_terms);
+
+	if (list)
+		list_add_tail(&evsel->node, list);
+
+	return evsel;
+}
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c971291f2ec7..77e122eb5601 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -281,50 +281,6 @@ static char *get_config_name(struct list_head *head_terms)
 	return get_config_str(head_terms, PARSE_EVENTS__TERM_TYPE_NAME);
 }
 
-static struct perf_evsel *
-perf_evsel__add_event(struct parse_events_state *parse_state,
-		      struct list_head *list,
-		      struct perf_event_attr *attr,
-		      bool init_attr,
-		      const char *name, const char *metric_id, struct perf_pmu *pmu,
-		      struct list_head *config_terms, bool auto_merge_stats,
-		      const char *cpu_list)
-{
-	struct perf_evsel *evsel;
-	struct perf_cpu_map *cpus = pmu ? perf_cpu_map__get(pmu->cpus) :
-			       cpu_list ? perf_cpu_map__new(cpu_list) : NULL;
-	int *idx = &parse_state->idx;
-
-	if (pmu && attr->type == PERF_TYPE_RAW)
-		perf_pmu__warn_invalid_config(pmu, attr->config, name);
-
-	evsel = parse_state->ops->perf_evsel__new(attr, *idx, init_attr);
-	if (!evsel) {
-		perf_cpu_map__put(cpus);
-		return NULL;
-	}
-
-	(*idx)++;
-	evsel->cpus = cpus;
-	evsel->own_cpus = perf_cpu_map__get(cpus);
-	evsel->system_wide = pmu ? pmu->is_uncore : false;
-	evsel->auto_merge_stats = auto_merge_stats;
-
-	if (name)
-		evsel->name = strdup(name);
-
-	if (metric_id)
-		evsel->metric_id = strdup(metric_id);
-
-	if (config_terms)
-		list_splice_init(config_terms, &evsel->config_terms);
-
-	if (list)
-		list_add_tail(&evsel->node, list);
-
-	return evsel;
-}
-
 static struct evsel *
 evsel__add_event(struct parse_events_state *parse_state,
 		 struct list_head *list,
-- 
2.31.1

