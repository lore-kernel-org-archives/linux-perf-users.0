Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9690AC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8067E61406
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbhKHNoY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:44:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43394 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238757AbhKHNoX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=reWvbOCIzNspdKVDKJ9MD2l10I0h4w4/M268jBBExFo=;
        b=jArNo90pwaXuAha+6uwT3V9hBUiW9sPpJiUyauLKGIfv6B/EOO1MlmkeI/Fn7xpZiT82S9
        fIz0IbRdOQexrFq3S9intSdL2jielHUB1iwrouyRlFoXZNnjG9aGVTDqryM34fbSmYEam5
        X70KhDy8deB3nhcS8xzbz9tVNR6Sx4g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-3D2OH67vMLG9rUpxA5_9Xg-1; Mon, 08 Nov 2021 08:41:37 -0500
X-MC-Unique: 3D2OH67vMLG9rUpxA5_9Xg-1
Received: by mail-wr1-f72.google.com with SMTP id p17-20020adff211000000b0017b902a7701so4049795wro.19
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:41:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=reWvbOCIzNspdKVDKJ9MD2l10I0h4w4/M268jBBExFo=;
        b=vvlV0Uhr5On00HbsBLBepeit019Y4fWPRpuJA/hjCvPd8Hfh58yzPJpupT5jtLts6b
         f1BQACZ1fUWw5C1BXRCInTTE4sqdKCWWq3EjqSLWv86+4qD7em5nZ9MPTYRmGQxIEG8E
         pN6z/BJ7/gTplms2suadjVSNkDZFSDKrks8+ZD0LX2TWHXrp7jj4MxjOeG4tcRgDqE48
         R9nGLAmWT4RVFiwlGf+dKj4qoLKRxlxkTJEBoPwCqDhbOuZa7eP6iYL9me7mKG9/8cPU
         3KJTk49FtaX7hJTI1HBOMYUKdVfHCxanML7bx9q3klCRL+FdqEC+NVU8zUPKC3+KVO7+
         hNHQ==
X-Gm-Message-State: AOAM5322AeaxfoT/KsQOntnmi580n5v1wd85+JRJKfgfGe7c/Mpb+QWj
        Oda/HTNi74ejKKT21OUaBnGhbWd8QQjZA+ozKtclL2XlFEMiuAzVYOk1rkeUVsyBQwXkuzs79oH
        ZvJLXFr4MSj56PUyIdxBVBJXL6DLo2A==
X-Received: by 2002:a1c:1b08:: with SMTP id b8mr50680726wmb.28.1636378896567;
        Mon, 08 Nov 2021 05:41:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyR0wVb762I4hcBrcrL6vIOj80ucJNR/iPQmYsB/z5xpzTbdWR8ZCjXbcio4NDEnbgbrr7EZw==
X-Received: by 2002:a1c:1b08:: with SMTP id b8mr50680704wmb.28.1636378896354;
        Mon, 08 Nov 2021 05:41:36 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id c17sm17059635wmk.23.2021.11.08.05.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:41:36 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 43/59] perf tools: Move out parse_events_add_pmu fallback from parser code
Date:   Mon,  8 Nov 2021 14:36:54 +0100
Message-Id: <20211108133710.1352822-44-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving out parse_events_add_pmu fallback from parser code
into parse_events_add_pmu, so we can easily move parser
code to libperf later.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/parse-events.c | 60 +++++++++++++++++++++++++++++-----
 tools/perf/util/parse-events.h |  1 +
 tools/perf/util/parse-events.y | 37 +++------------------
 3 files changed, 58 insertions(+), 40 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 1469bdf88f2b..57f59253322d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1396,11 +1396,11 @@ static int parse_events__inside_hybrid_pmu(struct parse_events_state *parse_stat
 	return ret;
 }
 
-int parse_events_add_pmu(struct parse_events_state *parse_state,
-			 struct list_head *list, char *name,
-			 struct list_head *head_config,
-			 bool auto_merge_stats,
-			 bool use_alias)
+static int __parse_events_add_pmu(struct parse_events_state *parse_state,
+				  struct list_head *list, char *name,
+				  struct list_head *head_config,
+				  bool auto_merge_stats,
+				  bool use_alias)
 {
 	struct perf_event_attr attr;
 	struct perf_pmu_info info;
@@ -1528,6 +1528,50 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	return 0;
 }
 
+int parse_events_add_pmu(struct parse_events_state *parse_state,
+			 struct list_head *list, char *pmu_name,
+			 struct list_head *head_config,
+			 struct list_head *orig_terms,
+			 bool auto_merge_stats,
+			 bool use_alias)
+{
+	int err;
+
+	err = __parse_events_add_pmu(parse_state, list, pmu_name, head_config,
+				     auto_merge_stats, use_alias);
+	if (err && orig_terms) {
+		struct list_head *terms;
+		struct perf_pmu *pmu = NULL;
+		char *pattern = NULL;
+		int ok = 0;
+
+		if (asprintf(&pattern, "%s*", pmu_name) < 0)
+			return -1;
+
+		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+			char *name = pmu->name;
+
+			if (!strncmp(name, "uncore_", 7) &&
+			    strncmp(pmu_name, "uncore_", 7))
+				name += 7;
+			if (!perf_pmu__match(pattern, name, pmu_name) ||
+			    !perf_pmu__match(pattern, pmu->alias_name, pmu_name)) {
+				if (parse_events_copy_term_list(orig_terms, &terms)) {
+					free(pattern);
+					return -1;
+				}
+				if (!__parse_events_add_pmu(parse_state, list, pmu->name, terms, true, false))
+					ok++;
+				parse_events_terms__delete(terms);
+			}
+		}
+		free(pattern);
+		if (!ok)
+			return -1;
+	}
+	return err;
+}
+
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			       char *str, struct list_head *head,
 			       struct list_head **listp)
@@ -1572,9 +1616,9 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 		list_for_each_entry(alias, &pmu->aliases, list) {
 			if (!strcasecmp(alias->name, str)) {
-				if (!parse_events_add_pmu(parse_state, list,
-							  pmu->name, head,
-							  true, true)) {
+				if (!__parse_events_add_pmu(parse_state, list,
+							    pmu->name, head,
+							    true, true)) {
 					pr_debug("%s -> %s/%s/\n", str,
 						 pmu->name, alias->str);
 					ok++;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 5530614e7a10..74bf778400a9 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -97,6 +97,7 @@ int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, char *name,
 			 struct list_head *head_config,
+			 struct list_head *orig_terms,
 			 bool auto_merge_stats,
 			 bool use_alias);
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 0ac863e06352..b963c023bd40 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -319,8 +319,7 @@ event_pmu_name opt_pmu_config
 {
 	struct parse_events_state *parse_state = _parse_state;
 	struct parse_events_error *error = parse_state->error;
-	struct list_head *list = NULL, *orig_terms = NULL, *terms= NULL;
-	char *pattern = NULL;
+	struct list_head *list = NULL, *orig_terms = NULL;
 
 #define CLEANUP_YYABORT					\
 	do {						\
@@ -328,7 +327,6 @@ event_pmu_name opt_pmu_config
 		parse_events_terms__delete(orig_terms);	\
 		free(list);				\
 		free($1);				\
-		free(pattern);				\
 		YYABORT;				\
 	} while(0)
 
@@ -341,35 +339,10 @@ event_pmu_name opt_pmu_config
 	list = alloc_list();
 	if (!list)
 		CLEANUP_YYABORT;
-	if (parse_events_add_pmu(_parse_state, list, $1, $2, false, false)) {
-		struct perf_pmu *pmu = NULL;
-		int ok = 0;
-
-		if (asprintf(&pattern, "%s*", $1) < 0)
-			CLEANUP_YYABORT;
-
-		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
-			char *name = pmu->name;
-
-			if (!strncmp(name, "uncore_", 7) &&
-			    strncmp($1, "uncore_", 7))
-				name += 7;
-			if (!perf_pmu__match(pattern, name, $1) ||
-			    !perf_pmu__match(pattern, pmu->alias_name, $1)) {
-				if (parse_events_copy_term_list(orig_terms, &terms))
-					CLEANUP_YYABORT;
-				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
-					ok++;
-				parse_events_terms__delete(terms);
-			}
-		}
-
-		if (!ok)
-			CLEANUP_YYABORT;
-	}
+	if (parse_events_add_pmu(_parse_state, list, $1, $2, orig_terms, false, false))
+		CLEANUP_YYABORT;
 	parse_events_terms__delete($2);
 	parse_events_terms__delete(orig_terms);
-	free(pattern);
 	free($1);
 	$$ = list;
 #undef CLEANUP_YYABORT
@@ -422,7 +395,7 @@ PE_PMU_EVENT_FAKE sep_dc
 	if (!list)
 		YYABORT;
 
-	err = parse_events_add_pmu(_parse_state, list, $1, NULL, false, false);
+	err = parse_events_add_pmu(_parse_state, list, $1, NULL, NULL, false, false);
 	free($1);
 	if (err < 0) {
 		free(list);
@@ -440,7 +413,7 @@ PE_PMU_EVENT_FAKE opt_pmu_config
 	if (!list)
 		YYABORT;
 
-	err = parse_events_add_pmu(_parse_state, list, $1, $2, false, false);
+	err = parse_events_add_pmu(_parse_state, list, $1, $2, NULL, false, false);
 	free($1);
 	parse_events_terms__delete($2);
 	if (err < 0) {
-- 
2.31.1

