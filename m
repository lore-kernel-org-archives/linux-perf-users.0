Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1CAC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4806161458
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbhKHNo3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:44:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23144 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240024AbhKHNo3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WFGYuXugtTPPNCUJsYLk6ok4aQMVBc76/pEuVby3MxM=;
        b=RxcUlR7duk5AKr2kSkk4VayEPA+xuzp+OuI5yogNG+fT2BnqSK3zKDU0IwmNa1JILEy3ij
        JG037uhhthhPktViMKseO28q5J6IfJZQV8wLXqq5VVff7nLRlr+AcsuRpsP14Fo/KCOLe3
        Q3BRJ2NaH1KQJR46k1HwGjBItpK7ANo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-jy1JoWb5O5KkbIC8U-ph-A-1; Mon, 08 Nov 2021 08:41:43 -0500
X-MC-Unique: jy1JoWb5O5KkbIC8U-ph-A-1
Received: by mail-wr1-f70.google.com with SMTP id u4-20020a5d4684000000b0017c8c1de97dso4046597wrq.16
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WFGYuXugtTPPNCUJsYLk6ok4aQMVBc76/pEuVby3MxM=;
        b=x9cuEnsQW5FjwRv4f8eiiJncYlPUy66ZUaRe1H/i/uaeSIQRxQQeWwUpSwsf4ckUKv
         Okk5g7wirsP8aP6YVESA7gpOwo7ie/px6Mr/14mQ2FC9gu8k3cY2HT3V1+mgecGS3ZsK
         AVpt39foCDECTZpCHm1eE0Qm6+8RApESNNdDoARZO+wKIs6QMocH6iUyaZscZUBsKQ14
         EMWyc0YoFZ8QCgnOZFQh8uVHJPRaSjoEf/q4pnRvFhxDcKaRqvCCl1z4PlKoJU5bGh99
         kZtvpirvwuAMjjhFZhRkNsrwYfRgd/ph9TN9DtMiFKhrzjzAqKWZqE2UngXpbblzL+28
         ZLdg==
X-Gm-Message-State: AOAM530QLk2rZ3V81jZU+FF+k0IDn1ZpPFmqogP/NSmCV9BuFCtDMVF4
        RAZZxgpYxM965CHB4hCOZNpt3XG9kj6ea/aU9ltryahQVPnmfsw8Xhlee7gV62KjUNYjIMOcKZO
        XV3Hhkfi1Iq8KuYC0ZVa5fLAddwtYag==
X-Received: by 2002:a05:6000:1541:: with SMTP id 1mr73799345wry.347.1636378902471;
        Mon, 08 Nov 2021 05:41:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWDaBBLS3TF4/++DbOdr/1IvJ6zHhARGXnGazqVSWwG6qGwlsjr+6vLj3PalbpLxlV3jEDGw==
X-Received: by 2002:a05:6000:1541:: with SMTP id 1mr73799329wry.347.1636378902333;
        Mon, 08 Nov 2021 05:41:42 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id h17sm19159446wmb.44.2021.11.08.05.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:41:42 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 44/59] perf tools: Add add_pmu callback to struct parse_events_ops
Date:   Mon,  8 Nov 2021 14:36:55 +0100
Message-Id: <20211108133710.1352822-45-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adding add_pmu callback to struct parse_events_ops,
to allow custom pmu parsing code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/parse-events.h |  9 +++++++++
 tools/perf/util/parse-events.c                 | 15 +++++++++------
 tools/perf/util/parse-events.h                 |  6 ------
 tools/perf/util/parse-events.y                 |  8 +++++---
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index 11a85a118480..6733068879a7 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -85,10 +85,19 @@ struct parse_events_error {
 	char *first_help;
 };
 
+struct parse_events_state;
+
 struct parse_events_ops {
 	struct perf_evsel* (*perf_evsel__new)(struct perf_event_attr *attr, int idx, bool init_attr);
 	struct perf_evsel* (*perf_evsel__new_tp)(const char *sys, const char *name, int idx);
 	void (*perf_evsel__delete)(struct perf_evsel *evsel);
+
+	int (*add_pmu)(struct parse_events_state *parse_state,
+		       struct list_head *list, char *pmu_name,
+		       struct list_head *head_config,
+		       struct list_head *orig_terms,
+		       bool auto_merge_stats,
+		       bool use_alias);
 };
 
 struct parse_events_state {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 57f59253322d..78f10083f917 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -51,6 +51,7 @@ static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
 					 const char *str, char *pmu_name,
 					 struct list_head *list);
 
+static struct parse_events_ops parse_state_ops;
 static struct perf_pmu_event_symbol *perf_pmu_events_list;
 /*
  * The variable indicates the number of supported pmu event symbols.
@@ -81,12 +82,6 @@ static void perf_evsel__delete_helper(struct perf_evsel *evsel)
 	free(tmp);
 }
 
-static struct parse_events_ops parse_state_ops = {
-	.perf_evsel__new    = perf_evsel__new_idx,
-	.perf_evsel__new_tp = perf_evsel__newtp_idx,
-	.perf_evsel__delete = perf_evsel__delete_helper,
-};
-
 #define __PERF_EVENT_FIELD(config, name) \
 	((config & PERF_EVENT_##name##_MASK) >> PERF_EVENT_##name##_SHIFT)
 
@@ -1528,6 +1523,7 @@ static int __parse_events_add_pmu(struct parse_events_state *parse_state,
 	return 0;
 }
 
+static
 int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, char *pmu_name,
 			 struct list_head *head_config,
@@ -2900,3 +2896,10 @@ struct evsel *parse_events__add_event_hybrid(struct parse_events_state *parse_st
 				pmu, config_terms, /*auto_merge_stats=*/false,
 				/*cpu_list=*/NULL);
 }
+
+static struct parse_events_ops parse_state_ops = {
+	.perf_evsel__new    = perf_evsel__new_idx,
+	.perf_evsel__new_tp = perf_evsel__newtp_idx,
+	.perf_evsel__delete = perf_evsel__delete_helper,
+	.add_pmu            = parse_events_add_pmu,
+};
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 74bf778400a9..d1057942825d 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -94,12 +94,6 @@ int parse_events_add_cache(struct parse_events_state *parse_state,
 int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 				struct list_head *list,
 				u64 addr, char *type, u64 len);
-int parse_events_add_pmu(struct parse_events_state *parse_state,
-			 struct list_head *list, char *name,
-			 struct list_head *head_config,
-			 struct list_head *orig_terms,
-			 bool auto_merge_stats,
-			 bool use_alias);
 
 struct evsel *parse_events__add_event(struct parse_events_state *parse_state,
 				      struct perf_event_attr *attr,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index b963c023bd40..5c57c8424323 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -339,7 +339,7 @@ event_pmu_name opt_pmu_config
 	list = alloc_list();
 	if (!list)
 		CLEANUP_YYABORT;
-	if (parse_events_add_pmu(_parse_state, list, $1, $2, orig_terms, false, false))
+	if (parse_state->ops->add_pmu(parse_state, list, $1, $2, orig_terms, false, false))
 		CLEANUP_YYABORT;
 	parse_events_terms__delete($2);
 	parse_events_terms__delete(orig_terms);
@@ -388,6 +388,7 @@ PE_PMU_EVENT_PRE '-' PE_PMU_EVENT_SUF sep_dc
 |
 PE_PMU_EVENT_FAKE sep_dc
 {
+	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list;
 	int err;
 
@@ -395,7 +396,7 @@ PE_PMU_EVENT_FAKE sep_dc
 	if (!list)
 		YYABORT;
 
-	err = parse_events_add_pmu(_parse_state, list, $1, NULL, NULL, false, false);
+	err = parse_state->ops->add_pmu(parse_state, list, $1, NULL, NULL, false, false);
 	free($1);
 	if (err < 0) {
 		free(list);
@@ -406,6 +407,7 @@ PE_PMU_EVENT_FAKE sep_dc
 |
 PE_PMU_EVENT_FAKE opt_pmu_config
 {
+	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list;
 	int err;
 
@@ -413,7 +415,7 @@ PE_PMU_EVENT_FAKE opt_pmu_config
 	if (!list)
 		YYABORT;
 
-	err = parse_events_add_pmu(_parse_state, list, $1, $2, NULL, false, false);
+	err = parse_state->ops->add_pmu(parse_state, list, $1, $2, NULL, false, false);
 	free($1);
 	parse_events_terms__delete($2);
 	if (err < 0) {
-- 
2.31.1

