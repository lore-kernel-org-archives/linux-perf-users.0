Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FE5C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 641C06109D
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbhKHNox (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:44:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29395 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240034AbhKHNox (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1QAIhLjDcZs6evOy8Q4XyTqqGZAFB3koW9b/7BiZk6s=;
        b=T1it4U7AHqGm5KS2XfUue9bClnsDOANN5GpAfM3IIMeCtVa+qLmTd/UuD+eRLWRD6cwyOB
        9de+A7pWLWBWWEWNnU6QwDJUeEF2u86wO23FquA1OmLN2p9Cr+wb6KyhxPSKs6vqX28xRT
        ZRNR4N8sNoxetkplMRTN6uCPTFuakiA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-C9FopJREOcCA89xbtjLJPQ-1; Mon, 08 Nov 2021 08:42:07 -0500
X-MC-Unique: C9FopJREOcCA89xbtjLJPQ-1
Received: by mail-wm1-f69.google.com with SMTP id l187-20020a1c25c4000000b0030da46b76daso10132399wml.9
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1QAIhLjDcZs6evOy8Q4XyTqqGZAFB3koW9b/7BiZk6s=;
        b=lDbhGr2vwK/+oJp1g0DeR3ua+frxYJprraf5Tg3AKB1r8ryUR8hs8uwfMiklqYwqFI
         EqsedM8izcNbC7cb22mkv2MAh44ecCDOuCi0Ta5eOET2DS9r3mcxqM6j4XKJmxpSuyVm
         Ut6MvWn69io8Wd4hoVqbddqnM0kXBIMrnWoulKL7rVoLR1g47c/H/0ESuFegY1CjY4RI
         I02BhnCctU4whNBzEAqYoEkPMPC8g8IdWYhJrUrhtaTj6OucvADZWaOqz6rvneND6rqU
         udxWtfrl1jt8H5dKEr2Xoyxh8YlDI+fECidWByFpQfQXrz0GMwT1rtwFumZXW5buK0OZ
         /Thw==
X-Gm-Message-State: AOAM533X8Gt4eylyzQxgmwP/D+jF70wcNvAjwxpESNeLb5aY+N5sSyQ6
        oiJzZ6Ix9CeuiittIHLdquNGfwVUgAfvhzc76cVzs6+7hI9cz5tRFdvpHOLAituv2tYqYSIQG/7
        KyOP7hAqs+1isAZkq+H/BAGjB9PRAAQ==
X-Received: by 2002:a5d:6a4d:: with SMTP id t13mr70199854wrw.104.1636378926055;
        Mon, 08 Nov 2021 05:42:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyP1mSa+Z1pvpFLKMhNOyjqf5QdUD8MVS+fKjj3auY3nYPReEmzMYMUq1G31qnyL69f8cghWg==
X-Received: by 2002:a5d:6a4d:: with SMTP id t13mr70199843wrw.104.1636378925919;
        Mon, 08 Nov 2021 05:42:05 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id o4sm14649833wmq.31.2021.11.08.05.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:42:05 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 48/59] perf tools: Add add_breakpoint callback to struct parse_events_ops
Date:   Mon,  8 Nov 2021 14:36:59 +0100
Message-Id: <20211108133710.1352822-49-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adding add_breakpoint callback to struct parse_events_ops,
to allow custom breakpoint parsing code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/parse-events.h | 4 ++++
 tools/perf/util/parse-events.c                 | 2 ++
 tools/perf/util/parse-events.h                 | 3 ---
 tools/perf/util/parse-events.y                 | 8 ++++----
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index bc938cddb3d7..9a30155d628b 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -113,6 +113,10 @@ struct parse_events_ops {
 			 char *type, char *op_result1, char *op_result2,
 			 struct parse_events_error *err,
 			 struct list_head *head_config);
+
+	int (*add_breakpoint)(struct parse_events_state *parse_state,
+			      struct list_head *list,
+			      u64 addr, char *type, u64 len);
 };
 
 struct parse_events_state {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6bffb67f8c24..0b033c8a852a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -884,6 +884,7 @@ do {					\
 	return 0;
 }
 
+static
 int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 				struct list_head *list,
 				u64 addr, char *type, u64 len)
@@ -2908,4 +2909,5 @@ static struct parse_events_ops parse_state_ops = {
 	.add_pmu_multi      = parse_events_multi_pmu_add,
 	.add_numeric        = parse_events_add_numeric,
 	.add_cache          = parse_events_add_cache,
+	.add_breakpoint     = parse_events_add_breakpoint,
 };
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 91c3f5bdf434..6bd3ab01f063 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -82,9 +82,6 @@ int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
 int parse_events_add_tool(struct parse_events_state *parse_state,
 			  struct list_head *list,
 			  int tool_event);
-int parse_events_add_breakpoint(struct parse_events_state *parse_state,
-				struct list_head *list,
-				u64 addr, char *type, u64 len);
 
 struct evsel *parse_events__add_event(struct parse_events_state *parse_state,
 				      struct perf_event_attr *attr,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 6dcd1e1677e9..1e43e6839278 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -546,7 +546,7 @@ PE_PREFIX_MEM PE_VALUE '/' PE_VALUE ':' PE_MODIFIER_BP sep_dc
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_breakpoint(parse_state, list, $2, $6, $4);
+	err = parse_state->ops->add_breakpoint(parse_state, list, $2, $6, $4);
 	free($6);
 	if (err) {
 		free(list);
@@ -562,7 +562,7 @@ PE_PREFIX_MEM PE_VALUE '/' PE_VALUE sep_dc
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	if (parse_events_add_breakpoint(parse_state, list, $2, NULL, $4)) {
+	if (parse_state->ops->add_breakpoint(parse_state, list, $2, NULL, $4)) {
 		free(list);
 		YYABORT;
 	}
@@ -577,7 +577,7 @@ PE_PREFIX_MEM PE_VALUE ':' PE_MODIFIER_BP sep_dc
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_breakpoint(parse_state, list, $2, $4, 0);
+	err = parse_state->ops->add_breakpoint(parse_state, list, $2, $4, 0);
 	free($4);
 	if (err) {
 		free(list);
@@ -593,7 +593,7 @@ PE_PREFIX_MEM PE_VALUE sep_dc
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	if (parse_events_add_breakpoint(parse_state, list, $2, NULL, 0)) {
+	if (parse_state->ops->add_breakpoint(parse_state, list, $2, NULL, 0)) {
 		free(list);
 		YYABORT;
 	}
-- 
2.31.1

