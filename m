Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEE3C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B305061458
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240024AbhKHNom (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:44:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237817AbhKHNol (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9GPbIOj8/ucONe9gEW52+gAfyG5hh+o6S6NwQwDCdMA=;
        b=cdYUATFIg0CswJowvRPnHw/hG7wlnqA4IRztZGmwExLUBx2vQmmYBwz8xCtb88tEVrOMEQ
        XElNOVHgDPlOf8lhNcEd0rkXAXjkjHV+FhkgaXDwS8v/sFL8DiOlpIPDOsXdR8pC4pdPYW
        A81kC3oVBWf4DO6ueHdEd8x9YNbwkAo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-9XxLN78WMo2VDCtjyaScNA-1; Mon, 08 Nov 2021 08:41:55 -0500
X-MC-Unique: 9XxLN78WMo2VDCtjyaScNA-1
Received: by mail-wr1-f70.google.com with SMTP id q5-20020a5d5745000000b00178abb72486so4055198wrw.9
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:41:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9GPbIOj8/ucONe9gEW52+gAfyG5hh+o6S6NwQwDCdMA=;
        b=0lIycAfJZExdMAszZuS+4DlOo6+tuIaQrlSmmF3FZpP6QwvkAhtNVU8pJw1AvSPmEM
         d+sQVpKPqnuJm6sywBBeGtQM6c8jWP4kesG26lPT9meqdWqbOQ+kFt1yOWmoCEiM0qWL
         YSkLeWv0jwPwPV1iHMogA7dhD0ZGTwJqdGHVIFHSuSST6IirNGxsEllIkRYLvBu6K1WX
         2d1qteFL03PNrMgkBZt4377Gro8WtPSWXRH5FKwWG25XWio/rcqSGx6sNuKNqyh7SVzI
         ABdFatNog1zfI2BOG/BcY5tsVK+L0z/WkcJIqljjsVh1hUv5Mnyb8SYE+QvpROizP0uj
         MeiQ==
X-Gm-Message-State: AOAM532sEnpgBtU//lu19xMnxt4ax53a/NDIXQtl9XJsqKbTLsqnBas6
        rcbn7gmhlDs3eJwLHH8CUkTlPG/O2cJeuPq8lQQsbiPd7zbChT098CcjXyQTLriMHgxKu3RyJwQ
        7omPx03Q1IVtoXS6ju/3CXGQ6rn2sjA==
X-Received: by 2002:adf:dec9:: with SMTP id i9mr80220212wrn.18.1636378914247;
        Mon, 08 Nov 2021 05:41:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIS/zoUC1BQVNAIzfB7lK3ZOqcvIi3M21RGl66adf9YtVWLGz05zt3UqrhNI6jA+NELPoHyA==
X-Received: by 2002:adf:dec9:: with SMTP id i9mr80220192wrn.18.1636378914093;
        Mon, 08 Nov 2021 05:41:54 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id a9sm16612515wrt.66.2021.11.08.05.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:41:53 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 46/59] perf tools: Add add_numeric callback to struct parse_events_ops
Date:   Mon,  8 Nov 2021 14:36:57 +0100
Message-Id: <20211108133710.1352822-47-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adding add_numeric callback to struct parse_events_ops,
to allow custom numeric parsing code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/parse-events.h |  5 +++++
 tools/perf/util/parse-events.c                 |  2 ++
 tools/perf/util/parse-events.h                 |  4 ----
 tools/perf/util/parse-events.y                 | 12 ++++++++----
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index 78dd3f989346..cbcf799f8969 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -102,6 +102,11 @@ struct parse_events_ops {
 	int (*add_pmu_multi)(struct parse_events_state *parse_state,
 			     char *str, struct list_head *head,
 			     struct list_head **listp);
+
+	int (*add_numeric)(struct parse_events_state *parse_state,
+			   struct list_head *list,
+			   u32 type, u64 config,
+			   struct list_head *head_config);
 };
 
 struct parse_events_state {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c67634c9de0d..a05e1bdb4e60 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1306,6 +1306,7 @@ int parse_events_add_tracepoint(struct parse_events_state *parse_state,
 					    err, head_config);
 }
 
+static
 int parse_events_add_numeric(struct parse_events_state *parse_state,
 			     struct list_head *list,
 			     u32 type, u64 config,
@@ -2904,4 +2905,5 @@ static struct parse_events_ops parse_state_ops = {
 	.perf_evsel__delete = perf_evsel__delete_helper,
 	.add_pmu            = parse_events_add_pmu,
 	.add_pmu_multi      = parse_events_multi_pmu_add,
+	.add_numeric        = parse_events_add_numeric,
 };
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index fa03f8f70f33..40d192cace03 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -79,10 +79,6 @@ int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
 			      struct list_head *list,
 			      struct bpf_object *obj,
 			      struct list_head *head_config);
-int parse_events_add_numeric(struct parse_events_state *parse_state,
-			     struct list_head *list,
-			     u32 type, u64 config,
-			     struct list_head *head_config);
 int parse_events_add_tool(struct parse_events_state *parse_state,
 			  struct list_head *list,
 			  int tool_event);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index f903690b3c8a..b23691397374 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -436,6 +436,7 @@ PE_VALUE_SYM_SW
 event_legacy_symbol:
 value_sym '/' event_config '/'
 {
+	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list;
 	int type = $1 >> 16;
 	int config = $1 & 255;
@@ -443,7 +444,7 @@ value_sym '/' event_config '/'
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_numeric(_parse_state, list, type, config, $3);
+	err = parse_state->ops->add_numeric(parse_state, list, type, config, $3);
 	parse_events_terms__delete($3);
 	if (err) {
 		free_list_evsel(_parse_state, list);
@@ -454,13 +455,14 @@ value_sym '/' event_config '/'
 |
 value_sym sep_slash_slash_dc
 {
+	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list;
 	int type = $1 >> 16;
 	int config = $1 & 255;
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	ABORT_ON(parse_events_add_numeric(_parse_state, list, type, config, NULL));
+	ABORT_ON(parse_state->ops->add_numeric(parse_state, list, type, config, NULL));
 	$$ = list;
 }
 |
@@ -646,12 +648,13 @@ PE_NAME ':' PE_NAME
 event_legacy_numeric:
 PE_VALUE ':' PE_VALUE opt_event_config
 {
+	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list;
 	int err;
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_numeric(_parse_state, list, (u32)$1, $3, $4);
+	err = parse_state->ops->add_numeric(_parse_state, list, (u32)$1, $3, $4);
 	parse_events_terms__delete($4);
 	if (err) {
 		free(list);
@@ -663,12 +666,13 @@ PE_VALUE ':' PE_VALUE opt_event_config
 event_legacy_raw:
 PE_RAW opt_event_config
 {
+	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list;
 	int err;
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_numeric(_parse_state, list, PERF_TYPE_RAW, $1, $2);
+	err = parse_state->ops->add_numeric(_parse_state, list, PERF_TYPE_RAW, $1, $2);
 	parse_events_terms__delete($2);
 	if (err) {
 		free(list);
-- 
2.31.1

