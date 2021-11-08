Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0895C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A7561503
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239989AbhKHNlJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:41:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20657 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235425AbhKHNlI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iq75l8KMyXGioTZyKECemfzDha8zstLfwSA7g3k3PVc=;
        b=BasVp+/Cmg3CJHasMZrK5li7RfKqMS1FnLYk3iA9MpTNJMwyaHL3wkgnikTalSm1nZT4h6
        FanFayGEHfdfImc3QI3vaM/aj5Jmy/Ek1ROdQC0IYZthzVE4ttm+LyWAQ07E6v/BiiR2yS
        Vud9SXVJEuN7dZLmPPtKrzg1fqzL3qI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-oMImS9W_NOm1u2Gx3hJfAw-1; Mon, 08 Nov 2021 08:38:23 -0500
X-MC-Unique: oMImS9W_NOm1u2Gx3hJfAw-1
Received: by mail-wm1-f70.google.com with SMTP id 145-20020a1c0197000000b0032efc3eb9bcso10170208wmb.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:38:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iq75l8KMyXGioTZyKECemfzDha8zstLfwSA7g3k3PVc=;
        b=JgC7aqIe1OecSfZjdDaDwVj00aV0FRzTRiZ/h4KDoyg23Y4lkqoeBc+D7quT209U9F
         mm4N1bgRmIJtiu5/NT5/uCRAuNtVVjWYQO0HqnHTYLf8LOjFiOxL06BJP8aUg2yoOc6V
         7fpAI6gZv8Jt3s75WAblYmUqUhLDoiuGaQZ3C/Pl5hp4IxWsG3G60Zjr1wmDh9hznWks
         zZJ0TyB2xcXsq5LWeH9z3HT51XPYWOELqaJBCGVsloaOrZY4/ArRSWA6vmX2CX1U7n3Y
         iku9YxPpEiTBhr4nuJNMrB3BL66+p5ke5rFkFYy808ddI9F9X4NcewZ4aB8LBzcps8ah
         V5Vg==
X-Gm-Message-State: AOAM533uXtG4BW2mJI8xYx+sXrjVN0ZAw6bXESX1lBHPt70izDPERWri
        FGrZBvzJ74AaNsYGUlptxe2WIjeLQtkw48UIgz4pidJzUDFdRC0XIty48QyihAUnitiKNG5zeyl
        zbox0laseDcEg1YQYHxGszYo5xTypfw==
X-Received: by 2002:a5d:6d49:: with SMTP id k9mr93827608wri.352.1636378701774;
        Mon, 08 Nov 2021 05:38:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysgT/lfDF6voLrcjgE9+mwJQ2Z82gGDcMBVWqQaqik2NkA+my9eE7rkecXAu/hxe73a5+WOQ==
X-Received: by 2002:a5d:6d49:: with SMTP id k9mr93827594wri.352.1636378701644;
        Mon, 08 Nov 2021 05:38:21 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id r15sm17688706wru.9.2021.11.08.05.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:38:21 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 10/59] libperf: Move metric_id to perf_evsel
Date:   Mon,  8 Nov 2021 14:36:21 +0100
Message-Id: <20211108133710.1352822-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving metric_id to perf_evsel struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/evsel.h |  1 +
 tools/perf/util/evsel.c                 | 12 ++++++------
 tools/perf/util/evsel.h                 |  1 -
 tools/perf/util/metricgroup.c           | 10 +++++-----
 tools/perf/util/parse-events.c          |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index ef5a85de7ba9..dafa1d6be731 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -61,6 +61,7 @@ struct perf_evsel {
                 char			*name;
 		bool			auto_merge_stats;
 		struct list_head	config_terms;
+		const char		*metric_id;
 	};
 };
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bc5a213b3955..52781210a874 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -410,9 +410,9 @@ struct evsel *evsel__clone(struct evsel *orig)
 		if (evsel->filter == NULL)
 			goto out_err;
 	}
-	if (orig->metric_id) {
-		evsel->metric_id = strdup(orig->metric_id);
-		if (evsel->metric_id == NULL)
+	if (orig->core.metric_id) {
+		evsel->core.metric_id = strdup(orig->core.metric_id);
+		if (evsel->core.metric_id == NULL)
 			goto out_err;
 	}
 	evsel->cgrp = cgroup__get(orig->cgrp);
@@ -786,8 +786,8 @@ const char *evsel__name(struct evsel *evsel)
 
 const char *evsel__metric_id(const struct evsel *evsel)
 {
-	if (evsel->metric_id)
-		return evsel->metric_id;
+	if (evsel->core.metric_id)
+		return evsel->core.metric_id;
 
 	if (evsel->core.attr.type == PERF_TYPE_SOFTWARE && evsel->tool_event)
 		return "duration_time";
@@ -1439,7 +1439,7 @@ void evsel__exit(struct evsel *evsel)
 	zfree(&evsel->group_name);
 	zfree(&evsel->core.name);
 	zfree(&evsel->pmu_name);
-	zfree(&evsel->metric_id);
+	zfree(&evsel->core.metric_id);
 	evsel__zero_per_pkg(evsel);
 	hashmap__free(evsel->per_pkg_mask);
 	evsel->per_pkg_mask = NULL;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index b703e78ace23..b55173bf8f70 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -67,7 +67,6 @@ struct evsel {
 		double			scale;
 		const char		*unit;
 		struct cgroup		*cgrp;
-		const char		*metric_id;
 		enum perf_tool_event	tool_event;
 		/* parse modifier helper */
 		int			exclude_GH;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index b54856cb14d0..3c8afef83ebd 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -669,20 +669,20 @@ static int decode_all_metric_ids(struct evlist *perf_evlist, const char *modifie
 	int ret = 0;
 
 	evlist__for_each_entry(perf_evlist, ev) {
-		if (!ev->metric_id)
+		if (!ev->core.metric_id)
 			continue;
 
 		ret = strbuf_setlen(&sb, 0);
 		if (ret)
 			break;
 
-		ret = decode_metric_id(&sb, ev->metric_id);
+		ret = decode_metric_id(&sb, ev->core.metric_id);
 		if (ret)
 			break;
 
-		free((char *)ev->metric_id);
-		ev->metric_id = strdup(sb.buf);
-		if (!ev->metric_id) {
+		free((char *)ev->core.metric_id);
+		ev->core.metric_id = strdup(sb.buf);
+		if (!ev->core.metric_id) {
 			ret = -ENOMEM;
 			break;
 		}
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c08b7fa8dae4..ee04fec441e7 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -390,7 +390,7 @@ __add_event(struct list_head *list, int *idx,
 		evsel->core.name = strdup(name);
 
 	if (metric_id)
-		evsel->metric_id = strdup(metric_id);
+		evsel->core.metric_id = strdup(metric_id);
 
 	if (config_terms)
 		list_splice_init(config_terms, &evsel->core.config_terms);
-- 
2.31.1

