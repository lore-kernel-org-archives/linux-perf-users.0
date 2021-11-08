Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD866C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F7BF61505
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbhKHNnN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:43:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240039AbhKHNnM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ugMQEiazIJksZhHRZ22g3Xprv9G4CBhxbMHRAaqjJJ4=;
        b=Vp4Rk9KK0VGd0gXHSbntlATcH0rA+0CWWMGY3tzILHCbnYHD8Nc9rLjuOCRGiAXIlFiE0D
        QUNBvqbEwQlQa+K+DImvPaL0Ao8JesI5U4uafKNEhhgiwPuCZCmZl1tDI50hbEb+ByNLmG
        ljIdRuQY0opy3/bVgZWsH0+dB84uTs8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-LdBRNBb4Nfat0cA9qsoUUQ-1; Mon, 08 Nov 2021 08:40:26 -0500
X-MC-Unique: LdBRNBb4Nfat0cA9qsoUUQ-1
Received: by mail-wm1-f72.google.com with SMTP id g11-20020a1c200b000000b003320d092d08so6219868wmg.9
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:40:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ugMQEiazIJksZhHRZ22g3Xprv9G4CBhxbMHRAaqjJJ4=;
        b=tKsWnD7W/34NddMzlSD96a/9zvUV59rqZhdwRw7IUVpQHKIdWIUcjMi4ry6G0zIq8m
         QnmbzyMURGqfVIPL0v7j5L/fkYPBcz/sC/Q1GUqs+jh/eF8hDJlMzvDcqqIv0a1OZ2ES
         7M7CDYA73PG6AsF6+CgYD5htya1/8YTvCmhDK0mWUEpxAVKpAuOxs/XIn+0+t/h0r/OM
         iU79BzNDo09eh8JkSZguVBT5/p2fxsTSpRr5a9PWWIyW5i7Ml0t1gS6As0UgOGhGdiZ0
         kLmJa+PzDee0jxXb/sJW103wsbOHdAwpHEMVY+y38d4XypRFn1ZOHK2fuqEDalw9iGNn
         a4MQ==
X-Gm-Message-State: AOAM531cs221waR/2aoy0HWv891DDc8hrNyvImJqqMqjhQnSUMVxetoO
        9BXfW4HA/s09lb9WZkTm1vUet68JVrboPBT8ZvX8T97eRXLr9u1TowHS7z2O2u+lowGJKLcFIWk
        POvhWl4JLLu4EaISvGniQDBzq4GzfIw==
X-Received: by 2002:adf:ba87:: with SMTP id p7mr98134900wrg.282.1636378825370;
        Mon, 08 Nov 2021 05:40:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx3pEqKTVCyadiXtG0v4s4BY1+LnI3oTXJBPfA3YlkQ2/18IsTQH/lVZ3PuvDqFi0M3y0wzNw==
X-Received: by 2002:adf:ba87:: with SMTP id p7mr98134884wrg.282.1636378825219;
        Mon, 08 Nov 2021 05:40:25 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id h17sm19156482wmb.44.2021.11.08.05.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:40:24 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 31/59] perf tools: Move event_attr_init in evsel__new_idx function
Date:   Mon,  8 Nov 2021 14:36:42 +0100
Message-Id: <20211108133710.1352822-32-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving event_attr_init in evsel__new_idx function so we can
move perf_evsel__add_event into libperf later.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/parse-events.h | 2 +-
 tools/perf/util/evlist.c                       | 4 ++--
 tools/perf/util/evsel.c                        | 5 ++++-
 tools/perf/util/evsel.h                        | 4 ++--
 tools/perf/util/parse-events.c                 | 9 +++------
 tools/perf/util/sideband_evlist.c              | 2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index aff13afa08e1..b314c8639c78 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -86,7 +86,7 @@ struct parse_events_error {
 };
 
 struct parse_events_ops {
-	struct perf_evsel* (*perf_evsel__new)(struct perf_event_attr *attr, int idx);
+	struct perf_evsel* (*perf_evsel__new)(struct perf_event_attr *attr, int idx, bool init_attr);
 	struct perf_evsel* (*perf_evsel__new_tp)(const char *sys, const char *name, int idx);
 };
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 8a2da1365666..89146f4aa00d 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -249,7 +249,7 @@ int evlist__add_dummy(struct evlist *evlist)
 		.config = PERF_COUNT_SW_DUMMY,
 		.size	= sizeof(attr), /* to capture ABI version */
 	};
-	struct evsel *evsel = evsel__new_idx(&attr, evlist->core.nr_entries);
+	struct evsel *evsel = evsel__new_idx(&attr, evlist->core.nr_entries, false);
 
 	if (evsel == NULL)
 		return -ENOMEM;
@@ -265,7 +265,7 @@ static int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attr
 	size_t i;
 
 	for (i = 0; i < nr_attrs; i++) {
-		evsel = evsel__new_idx(attrs + i, evlist->core.nr_entries + i);
+		evsel = evsel__new_idx(attrs + i, evlist->core.nr_entries + i, false);
 		if (evsel == NULL)
 			goto out_delete_partial_list;
 		list_add_tail(&evsel->core.node, &head);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7621eddc8e58..fec92fc8c97a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -261,12 +261,15 @@ void evsel__init(struct evsel *evsel,
 	evsel->pmu_name      = NULL;
 }
 
-struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
+struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx, bool init_attr)
 {
 	struct evsel *evsel = zalloc(perf_evsel__object.size);
 
 	if (!evsel)
 		return NULL;
+	if (init_attr)
+		event_attr_init(attr);
+
 	evsel__init(evsel, attr, idx);
 
 	if (evsel__is_bpf_output(evsel)) {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index e06d171baba3..203abab2c48d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -187,11 +187,11 @@ int evsel__object_config(size_t object_size,
 struct perf_pmu *evsel__find_pmu(struct evsel *evsel);
 bool evsel__is_aux_event(struct evsel *evsel);
 
-struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx);
+struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx, bool init_attr);
 
 static inline struct evsel *evsel__new(struct perf_event_attr *attr)
 {
-	return evsel__new_idx(attr, 0);
+	return evsel__new_idx(attr, 0, false);
 }
 
 struct evsel *evsel__clone(struct evsel *orig);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7e4bc4c1190e..c971291f2ec7 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -60,9 +60,9 @@ static struct perf_pmu_event_symbol *perf_pmu_events_list;
  */
 static int perf_pmu_events_list_num;
 
-static struct perf_evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
+static struct perf_evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx, bool init_attr)
 {
-	struct evsel *evsel = evsel__new_idx(attr, idx);
+	struct evsel *evsel = evsel__new_idx(attr, idx, init_attr);
 
 	return evsel ? &evsel->core : NULL;
 }
@@ -298,10 +298,7 @@ perf_evsel__add_event(struct parse_events_state *parse_state,
 	if (pmu && attr->type == PERF_TYPE_RAW)
 		perf_pmu__warn_invalid_config(pmu, attr->config, name);
 
-	if (init_attr)
-		event_attr_init(attr);
-
-	evsel = parse_state->ops->perf_evsel__new(attr, *idx);
+	evsel = parse_state->ops->perf_evsel__new(attr, *idx, init_attr);
 	if (!evsel) {
 		perf_cpu_map__put(cpus);
 		return NULL;
diff --git a/tools/perf/util/sideband_evlist.c b/tools/perf/util/sideband_evlist.c
index 748371ac22be..9bc5760436a4 100644
--- a/tools/perf/util/sideband_evlist.c
+++ b/tools/perf/util/sideband_evlist.c
@@ -22,7 +22,7 @@ int evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
 		attr->sample_id_all = 1;
 	}
 
-	evsel = evsel__new_idx(attr, evlist->core.nr_entries);
+	evsel = evsel__new_idx(attr, evlist->core.nr_entries, false);
 	if (!evsel)
 		return -1;
 
-- 
2.31.1

