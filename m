Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A27C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E92F61406
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbhKHNof (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:44:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45042 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237817AbhKHNof (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u5xbbTp7GprCzC2uay//pIzNUEa8lhmiRP93n0N17T8=;
        b=Ny+rfi73dDUqPUBeKz1AtdW7fsETyTxLYwPAMyEEua6z0Mz2suaDi0avR1/YQBIWSB9zyI
        6AUlIcHql2J69F19oY9kExaC840s8p31kjz1K6D97ZKqJGII8gaTsoKlp+nj2teo05OVyH
        HEvn5Ay1dXIYPtWsv1v27rWBgmr3GCU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-ZMxmMqg3Nn-UhakpKnBqcQ-1; Mon, 08 Nov 2021 08:41:49 -0500
X-MC-Unique: ZMxmMqg3Nn-UhakpKnBqcQ-1
Received: by mail-wm1-f72.google.com with SMTP id g81-20020a1c9d54000000b003330e488323so1638929wme.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:41:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u5xbbTp7GprCzC2uay//pIzNUEa8lhmiRP93n0N17T8=;
        b=ZicVQ/CXq78RFS2awESMpakJ6Prddl6I94WfJY6MUJAPj0X9JLmBVFZQ5YpVYjof5z
         J7+3HPh2ZkHZQFMYSCI9cNLGDMucVAVO82+x/jYK06k6me7+G5qbqO6HlbSqQ3h7B6ws
         hSXSidmyIQ6OhgpJhytPhNVeqQOnEVG4UWYv8EeGu7NFy+yF9j38ZeQJjtngTfmvek14
         ob5jpudvoV78jOVdnBNHNm7gMIdW5isfkpmZ2ixLOohvQXRsywhnHvETzTCEdCRh8iXW
         8ORv2qFc86zfp1ASSYKAhl+bn/qgw6+5DjZO4nSTHaVGOQSRkJYl2ecidSx0yGbkrZog
         ZcbQ==
X-Gm-Message-State: AOAM531ySOCOuKi9Y3JPb0K6WVAAyUy/DAk0qAJTeJPh4NWfMWvu682u
        D2jRZKYm+yuxg2hS64ysOjr9eJcUhRzWKdsRHylijwViwyaHdkn4Mnnen9g7RumJFy3PrR1TJsk
        M8gjGhDlswFllBf8JS/hseBfbQ4599A==
X-Received: by 2002:a05:6000:186e:: with SMTP id d14mr46664007wri.376.1636378908410;
        Mon, 08 Nov 2021 05:41:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxlU+qidp0Jbas7hVHBCFgaUNEEhHs5GFEEltjJYZl45bNhMg0rjkmKLoWILQseNSU/+cKJzw==
X-Received: by 2002:a05:6000:186e:: with SMTP id d14mr46663977wri.376.1636378908188;
        Mon, 08 Nov 2021 05:41:48 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id h17sm17057316wrp.34.2021.11.08.05.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:41:47 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 45/59] perf tools: Add add_pmu_multi callback to struct parse_events_ops
Date:   Mon,  8 Nov 2021 14:36:56 +0100
Message-Id: <20211108133710.1352822-46-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adding add_pmu_multi callback to struct parse_events_ops,
to allow custom multi pmu parsing code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/parse-events.h | 4 ++++
 tools/perf/util/parse-events.c                 | 2 ++
 tools/perf/util/parse-events.h                 | 6 ------
 tools/perf/util/parse-events.y                 | 9 ++++++---
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index 6733068879a7..78dd3f989346 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -98,6 +98,10 @@ struct parse_events_ops {
 		       struct list_head *orig_terms,
 		       bool auto_merge_stats,
 		       bool use_alias);
+
+	int (*add_pmu_multi)(struct parse_events_state *parse_state,
+			     char *str, struct list_head *head,
+			     struct list_head **listp);
 };
 
 struct parse_events_state {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 78f10083f917..c67634c9de0d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1568,6 +1568,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	return err;
 }
 
+static
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			       char *str, struct list_head *head,
 			       struct list_head **listp)
@@ -2902,4 +2903,5 @@ static struct parse_events_ops parse_state_ops = {
 	.perf_evsel__new_tp = perf_evsel__newtp_idx,
 	.perf_evsel__delete = perf_evsel__delete_helper,
 	.add_pmu            = parse_events_add_pmu,
+	.add_pmu_multi      = parse_events_multi_pmu_add,
 };
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index d1057942825d..fa03f8f70f33 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -100,12 +100,6 @@ struct evsel *parse_events__add_event(struct parse_events_state *parse_state,
 				      const char *name, const char *metric_id,
 				      struct perf_pmu *pmu);
 
-int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
-			       char *str,
-			       struct list_head *head_config,
-			       struct list_head **listp);
-
-
 enum perf_pmu_event_symbol_type
 perf_pmu__parse_check(const char *name);
 void parse_events__set_leader(char *name, struct list_head *list,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 5c57c8424323..f903690b3c8a 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -350,10 +350,11 @@ event_pmu_name opt_pmu_config
 |
 PE_KERNEL_PMU_EVENT sep_dc
 {
+	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list;
 	int err;
 
-	err = parse_events_multi_pmu_add(_parse_state, $1, NULL, &list);
+	err = parse_state->ops->add_pmu_multi(parse_state, $1, NULL, &list);
 	free($1);
 	if (err < 0)
 		YYABORT;
@@ -362,11 +363,12 @@ PE_KERNEL_PMU_EVENT sep_dc
 |
 PE_KERNEL_PMU_EVENT opt_pmu_config
 {
+	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list;
 	int err;
 
 	/* frees $2 */
-	err = parse_events_multi_pmu_add(_parse_state, $1, $2, &list);
+	err = parse_state->ops->add_pmu_multi(_parse_state, $1, $2, &list);
 	free($1);
 	if (err < 0)
 		YYABORT;
@@ -375,13 +377,14 @@ PE_KERNEL_PMU_EVENT opt_pmu_config
 |
 PE_PMU_EVENT_PRE '-' PE_PMU_EVENT_SUF sep_dc
 {
+	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list;
 	char pmu_name[128];
 
 	snprintf(pmu_name, sizeof(pmu_name), "%s-%s", $1, $3);
 	free($1);
 	free($3);
-	if (parse_events_multi_pmu_add(_parse_state, pmu_name, NULL, &list) < 0)
+	if (parse_state->ops->add_pmu_multi(_parse_state, pmu_name, NULL, &list) < 0)
 		YYABORT;
 	$$ = list;
 }
-- 
2.31.1

