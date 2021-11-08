Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831FAC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C2661505
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbhKHNmt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:42:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23660 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238667AbhKHNmt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eU27BJoE4pCRW13FSOeQJ/oTxp670FOlMOQfC7iDRX8=;
        b=Ynzb1Y9u/1pHrwY+9Lkhr0DUqZ98FcFhO9NdERaf26NDIC3QY6jeyvwaspU12LnW9fQ13P
        +vqaR399r47GmIWCamMWiWBzMwQ2aNaMKgSN6ImsAP7zHVb2UtjjTz4ckVyEaSf8fB8DRx
        ziGywfR43lIjGXsM/EPKsROSUh2if90=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-aKEqTtTzM8KLPaS4a2w92w-1; Mon, 08 Nov 2021 08:40:03 -0500
X-MC-Unique: aKEqTtTzM8KLPaS4a2w92w-1
Received: by mail-wm1-f71.google.com with SMTP id z137-20020a1c7e8f000000b0030cd1800d86so6237082wmc.2
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eU27BJoE4pCRW13FSOeQJ/oTxp670FOlMOQfC7iDRX8=;
        b=65bAw4x9NLW4KY+cwJhDHTQlELieheFc3+gSAEVzPWvLkY25ShYh/24H8RaJ4UWUov
         wEqvodKSDHUyGtHTg7BYhRAkKniBNarzoM9QNbYW1KU8puOJP8N6DlBrpvSgWjsSRbRI
         ai0uibanfsJ59EtDzcIWgU7DA83zS/+TXTOMUAsnyZHNvScVb/4nxvo7/bXbeR71rxNz
         1z8CWfnuoHgO09W+sqS96rSZ8R/yLxhCGVQ3PQNUy9N4Gdx4QrJiXl/IGzLIV1RCeVTz
         UDZPPSAtEgJa/lDgB0yfCbVIF8FFn9SrjCSltZNu7pVu2Wvve6EPj0O7iVQggCkQcDC1
         guIw==
X-Gm-Message-State: AOAM530j88q/lEZxCsFhYDKqtGPvqgh6lU5Mh8/5zuWpKftGHzEk1/V+
        ekRIS6pt8Gn46NFaeqL0UZB2W6w4KiK8s2wL4YQjjtDsVITwi3mwhBA1UJ+v+O21p1wmH+Mvy8q
        g5uKyWQZtnyUWpgqS/1azTxxRZ64qJQ==
X-Received: by 2002:adf:f947:: with SMTP id q7mr7105484wrr.260.1636378802048;
        Mon, 08 Nov 2021 05:40:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyR1uVpMHp1ifI8M4kbj7zuS+EaEofWsCGN8Wg2EXpQEX9F8h4GoKrp6HZHL9g941wbyi4dbw==
X-Received: by 2002:adf:f947:: with SMTP id q7mr7105462wrr.260.1636378801862;
        Mon, 08 Nov 2021 05:40:01 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id o4sm14643555wmq.31.2021.11.08.05.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:40:01 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 27/59] libperf: Move in struct parse_events_term code
Date:   Mon,  8 Nov 2021 14:36:38 +0100
Message-Id: <20211108133710.1352822-28-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving parse_events_term related code to libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../lib/perf/include/internal/parse-events.h  |  82 +++++++
 tools/lib/perf/parse-events.c                 | 205 ++++++++++++++++++
 tools/perf/util/parse-events.c                | 201 -----------------
 tools/perf/util/parse-events.h                |  78 +------
 4 files changed, 288 insertions(+), 278 deletions(-)

diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index cf7cc117c497..46f632efd71b 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -2,11 +2,93 @@
 #ifndef __LIBPERF_PARSE_EVENTS_H
 #define __LIBPERF_PARSE_EVENTS_H
 
+#include <linux/types.h>
+#include <linux/list.h>
+#include <unistd.h>
+
 struct event_symbol {
 	const char	*symbol;
 	const char	*alias;
 };
 extern struct event_symbol event_symbols_hw[];
 extern struct event_symbol event_symbols_sw[];
+extern const char *config_term_names[];
+
+enum {
+	PARSE_EVENTS__TERM_TYPE_NUM,
+	PARSE_EVENTS__TERM_TYPE_STR,
+};
+
+enum {
+	PARSE_EVENTS__TERM_TYPE_USER,
+	PARSE_EVENTS__TERM_TYPE_CONFIG,
+	PARSE_EVENTS__TERM_TYPE_CONFIG1,
+	PARSE_EVENTS__TERM_TYPE_CONFIG2,
+	PARSE_EVENTS__TERM_TYPE_NAME,
+	PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD,
+	PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ,
+	PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE,
+	PARSE_EVENTS__TERM_TYPE_TIME,
+	PARSE_EVENTS__TERM_TYPE_CALLGRAPH,
+	PARSE_EVENTS__TERM_TYPE_STACKSIZE,
+	PARSE_EVENTS__TERM_TYPE_NOINHERIT,
+	PARSE_EVENTS__TERM_TYPE_INHERIT,
+	PARSE_EVENTS__TERM_TYPE_MAX_STACK,
+	PARSE_EVENTS__TERM_TYPE_MAX_EVENTS,
+	PARSE_EVENTS__TERM_TYPE_NOOVERWRITE,
+	PARSE_EVENTS__TERM_TYPE_OVERWRITE,
+	PARSE_EVENTS__TERM_TYPE_DRV_CFG,
+	PARSE_EVENTS__TERM_TYPE_PERCORE,
+	PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT,
+	PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE,
+	PARSE_EVENTS__TERM_TYPE_METRIC_ID,
+	__PARSE_EVENTS__TERM_TYPE_NR,
+};
+
+struct parse_events_array {
+	size_t nr_ranges;
+	struct {
+		unsigned int start;
+		size_t length;
+	} *ranges;
+};
+
+struct parse_events_term {
+	char *config;
+	struct parse_events_array array;
+	union {
+		char *str;
+		u64  num;
+	} val;
+	int type_val;
+	int type_term;
+	struct list_head list;
+	bool used;
+	bool no_value;
+
+	/* error string indexes for within parsed string */
+	int err_term;
+	int err_val;
+
+	/* Coming from implicit alias */
+	bool weak;
+};
 
+int parse_events_term__num(struct parse_events_term **term,
+			   int type_term, char *config, u64 num,
+			   bool novalue,
+			   int loc_term, int loc_val);
+int parse_events_term__str(struct parse_events_term **term,
+			   int type_term, char *config, char *str,
+			   int loc_term, int loc_val);
+int parse_events_term__sym_hw(struct parse_events_term **term,
+			      char *config, unsigned idx);
+int parse_events_term__clone(struct parse_events_term **new,
+			     struct parse_events_term *term);
+int parse_events__is_hardcoded_term(struct parse_events_term *term);
+void parse_events_term__delete(struct parse_events_term *term);
+void parse_events_terms__delete(struct list_head *terms);
+void parse_events_terms__purge(struct list_head *terms);
+int parse_events_copy_term_list(struct list_head *old,
+				 struct list_head **new);
 #endif /* __LIBPERF_PARSE_EVENTS_H */
diff --git a/tools/lib/perf/parse-events.c b/tools/lib/perf/parse-events.c
index 92b552b0a91a..cda7c1e5563e 100644
--- a/tools/lib/perf/parse-events.c
+++ b/tools/lib/perf/parse-events.c
@@ -2,6 +2,11 @@
 
 #include <internal/parse-events.h>
 #include <linux/perf_event.h>
+#include <linux/zalloc.h>
+#include <string.h>
+#include <internal/parse-events.h>
+#include <stdlib.h>
+#include <errno.h>
 
 struct event_symbol event_symbols_hw[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_CPU_CYCLES] = {
@@ -97,3 +102,203 @@ struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
 	},
 };
 
+/*
+ * Update according to parse-events.l
+ */
+const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
+	[PARSE_EVENTS__TERM_TYPE_USER]			= "<sysfs term>",
+	[PARSE_EVENTS__TERM_TYPE_CONFIG]		= "config",
+	[PARSE_EVENTS__TERM_TYPE_CONFIG1]		= "config1",
+	[PARSE_EVENTS__TERM_TYPE_CONFIG2]		= "config2",
+	[PARSE_EVENTS__TERM_TYPE_NAME]			= "name",
+	[PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD]		= "period",
+	[PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ]		= "freq",
+	[PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE]	= "branch_type",
+	[PARSE_EVENTS__TERM_TYPE_TIME]			= "time",
+	[PARSE_EVENTS__TERM_TYPE_CALLGRAPH]		= "call-graph",
+	[PARSE_EVENTS__TERM_TYPE_STACKSIZE]		= "stack-size",
+	[PARSE_EVENTS__TERM_TYPE_NOINHERIT]		= "no-inherit",
+	[PARSE_EVENTS__TERM_TYPE_INHERIT]		= "inherit",
+	[PARSE_EVENTS__TERM_TYPE_MAX_STACK]		= "max-stack",
+	[PARSE_EVENTS__TERM_TYPE_MAX_EVENTS]		= "nr",
+	[PARSE_EVENTS__TERM_TYPE_OVERWRITE]		= "overwrite",
+	[PARSE_EVENTS__TERM_TYPE_NOOVERWRITE]		= "no-overwrite",
+	[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
+	[PARSE_EVENTS__TERM_TYPE_PERCORE]		= "percore",
+	[PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT]		= "aux-output",
+	[PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE]	= "aux-sample-size",
+	[PARSE_EVENTS__TERM_TYPE_METRIC_ID]		= "metric-id",
+};
+
+static int new_term(struct parse_events_term **_term,
+		    struct parse_events_term *temp,
+		    char *str, u64 num)
+{
+	struct parse_events_term *term;
+
+	term = malloc(sizeof(*term));
+	if (!term)
+		return -ENOMEM;
+
+	*term = *temp;
+	INIT_LIST_HEAD(&term->list);
+	term->weak = false;
+
+	switch (term->type_val) {
+	case PARSE_EVENTS__TERM_TYPE_NUM:
+		term->val.num = num;
+		break;
+	case PARSE_EVENTS__TERM_TYPE_STR:
+		term->val.str = str;
+		break;
+	default:
+		free(term);
+		return -EINVAL;
+	}
+
+	*_term = term;
+	return 0;
+}
+
+int parse_events_term__num(struct parse_events_term **term,
+			   int type_term, char *config, u64 num,
+			   bool no_value,
+			   int loc_term, int loc_val)
+{
+	struct parse_events_term temp = {
+		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
+		.type_term = type_term,
+		.config    = config ? : strdup(config_term_names[type_term]),
+		.no_value  = no_value,
+		.err_term  = loc_term,
+		.err_val   = loc_val,
+	};
+
+	return new_term(term, &temp, NULL, num);
+}
+
+int parse_events_term__str(struct parse_events_term **term,
+			   int type_term, char *config, char *str,
+			   int loc_term, int loc_val)
+{
+	struct parse_events_term temp = {
+		.type_val  = PARSE_EVENTS__TERM_TYPE_STR,
+		.type_term = type_term,
+		.config    = config,
+		.err_term  = loc_term,
+		.err_val   = loc_val,
+	};
+
+	return new_term(term, &temp, str, 0);
+}
+
+int parse_events_term__sym_hw(struct parse_events_term **term,
+			      char *config, unsigned idx)
+{
+	struct event_symbol *sym;
+	char *str;
+	struct parse_events_term temp = {
+		.type_val  = PARSE_EVENTS__TERM_TYPE_STR,
+		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
+		.config    = config,
+	};
+
+	if (!temp.config) {
+		temp.config = strdup("event");
+		if (!temp.config)
+			return -ENOMEM;
+	}
+	BUG_ON(idx >= PERF_COUNT_HW_MAX);
+	sym = &event_symbols_hw[idx];
+
+	str = strdup(sym->symbol);
+	if (!str)
+		return -ENOMEM;
+	return new_term(term, &temp, str, 0);
+}
+
+int parse_events_term__clone(struct parse_events_term **new,
+			     struct parse_events_term *term)
+{
+	char *str;
+	struct parse_events_term temp = {
+		.type_val  = term->type_val,
+		.type_term = term->type_term,
+		.config    = NULL,
+		.err_term  = term->err_term,
+		.err_val   = term->err_val,
+	};
+
+	if (term->config) {
+		temp.config = strdup(term->config);
+		if (!temp.config)
+			return -ENOMEM;
+	}
+	if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
+		return new_term(new, &temp, NULL, term->val.num);
+
+	str = strdup(term->val.str);
+	if (!str)
+		return -ENOMEM;
+	return new_term(new, &temp, str, 0);
+}
+
+int parse_events__is_hardcoded_term(struct parse_events_term *term)
+{
+	return term->type_term != PARSE_EVENTS__TERM_TYPE_USER;
+}
+
+void parse_events_term__delete(struct parse_events_term *term)
+{
+	if (term->array.nr_ranges)
+		zfree(&term->array.ranges);
+
+	if (term->type_val != PARSE_EVENTS__TERM_TYPE_NUM)
+		zfree(&term->val.str);
+
+	zfree(&term->config);
+	free(term);
+}
+
+int parse_events_copy_term_list(struct list_head *old,
+				 struct list_head **new)
+{
+	struct parse_events_term *term, *n;
+	int ret;
+
+	if (!old) {
+		*new = NULL;
+		return 0;
+	}
+
+	*new = malloc(sizeof(struct list_head));
+	if (!*new)
+		return -ENOMEM;
+	INIT_LIST_HEAD(*new);
+
+	list_for_each_entry (term, old, list) {
+		ret = parse_events_term__clone(&n, term);
+		if (ret)
+			return ret;
+		list_add_tail(&n->list, *new);
+	}
+	return 0;
+}
+
+void parse_events_terms__purge(struct list_head *terms)
+{
+	struct parse_events_term *term, *h;
+
+	list_for_each_entry_safe(term, h, terms, list) {
+		list_del_init(&term->list);
+		parse_events_term__delete(term);
+	}
+}
+
+void parse_events_terms__delete(struct list_head *terms)
+{
+	if (!terms)
+		return;
+	parse_events_terms__purge(terms);
+	free(terms);
+}
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 1c62b2c31832..d98e8c4388ac 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -973,34 +973,6 @@ static int check_type_val(struct parse_events_term *term,
 	return -EINVAL;
 }
 
-/*
- * Update according to parse-events.l
- */
-static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
-	[PARSE_EVENTS__TERM_TYPE_USER]			= "<sysfs term>",
-	[PARSE_EVENTS__TERM_TYPE_CONFIG]		= "config",
-	[PARSE_EVENTS__TERM_TYPE_CONFIG1]		= "config1",
-	[PARSE_EVENTS__TERM_TYPE_CONFIG2]		= "config2",
-	[PARSE_EVENTS__TERM_TYPE_NAME]			= "name",
-	[PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD]		= "period",
-	[PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ]		= "freq",
-	[PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE]	= "branch_type",
-	[PARSE_EVENTS__TERM_TYPE_TIME]			= "time",
-	[PARSE_EVENTS__TERM_TYPE_CALLGRAPH]		= "call-graph",
-	[PARSE_EVENTS__TERM_TYPE_STACKSIZE]		= "stack-size",
-	[PARSE_EVENTS__TERM_TYPE_NOINHERIT]		= "no-inherit",
-	[PARSE_EVENTS__TERM_TYPE_INHERIT]		= "inherit",
-	[PARSE_EVENTS__TERM_TYPE_MAX_STACK]		= "max-stack",
-	[PARSE_EVENTS__TERM_TYPE_MAX_EVENTS]		= "nr",
-	[PARSE_EVENTS__TERM_TYPE_OVERWRITE]		= "overwrite",
-	[PARSE_EVENTS__TERM_TYPE_NOOVERWRITE]		= "no-overwrite",
-	[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
-	[PARSE_EVENTS__TERM_TYPE_PERCORE]		= "percore",
-	[PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT]		= "aux-output",
-	[PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE]	= "aux-sample-size",
-	[PARSE_EVENTS__TERM_TYPE_METRIC_ID]		= "metric-id",
-};
-
 static bool config_term_shrinked;
 
 static bool
@@ -3059,179 +3031,6 @@ void print_events(const char *event_glob, bool name_only, bool quiet_flag,
 	print_libpfm_events(name_only, long_desc);
 }
 
-int parse_events__is_hardcoded_term(struct parse_events_term *term)
-{
-	return term->type_term != PARSE_EVENTS__TERM_TYPE_USER;
-}
-
-static int new_term(struct parse_events_term **_term,
-		    struct parse_events_term *temp,
-		    char *str, u64 num)
-{
-	struct parse_events_term *term;
-
-	term = malloc(sizeof(*term));
-	if (!term)
-		return -ENOMEM;
-
-	*term = *temp;
-	INIT_LIST_HEAD(&term->list);
-	term->weak = false;
-
-	switch (term->type_val) {
-	case PARSE_EVENTS__TERM_TYPE_NUM:
-		term->val.num = num;
-		break;
-	case PARSE_EVENTS__TERM_TYPE_STR:
-		term->val.str = str;
-		break;
-	default:
-		free(term);
-		return -EINVAL;
-	}
-
-	*_term = term;
-	return 0;
-}
-
-int parse_events_term__num(struct parse_events_term **term,
-			   int type_term, char *config, u64 num,
-			   bool no_value,
-			   int loc_term, int loc_val)
-{
-	struct parse_events_term temp = {
-		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
-		.type_term = type_term,
-		.config    = config ? : strdup(config_term_names[type_term]),
-		.no_value  = no_value,
-		.err_term  = loc_term,
-		.err_val   = loc_val,
-	};
-
-	return new_term(term, &temp, NULL, num);
-}
-
-int parse_events_term__str(struct parse_events_term **term,
-			   int type_term, char *config, char *str,
-			   int loc_term, int loc_val)
-{
-	struct parse_events_term temp = {
-		.type_val  = PARSE_EVENTS__TERM_TYPE_STR,
-		.type_term = type_term,
-		.config    = config,
-		.err_term  = loc_term,
-		.err_val   = loc_val,
-	};
-
-	return new_term(term, &temp, str, 0);
-}
-
-int parse_events_term__sym_hw(struct parse_events_term **term,
-			      char *config, unsigned idx)
-{
-	struct event_symbol *sym;
-	char *str;
-	struct parse_events_term temp = {
-		.type_val  = PARSE_EVENTS__TERM_TYPE_STR,
-		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
-		.config    = config,
-	};
-
-	if (!temp.config) {
-		temp.config = strdup("event");
-		if (!temp.config)
-			return -ENOMEM;
-	}
-	BUG_ON(idx >= PERF_COUNT_HW_MAX);
-	sym = &event_symbols_hw[idx];
-
-	str = strdup(sym->symbol);
-	if (!str)
-		return -ENOMEM;
-	return new_term(term, &temp, str, 0);
-}
-
-int parse_events_term__clone(struct parse_events_term **new,
-			     struct parse_events_term *term)
-{
-	char *str;
-	struct parse_events_term temp = {
-		.type_val  = term->type_val,
-		.type_term = term->type_term,
-		.config    = NULL,
-		.err_term  = term->err_term,
-		.err_val   = term->err_val,
-	};
-
-	if (term->config) {
-		temp.config = strdup(term->config);
-		if (!temp.config)
-			return -ENOMEM;
-	}
-	if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
-		return new_term(new, &temp, NULL, term->val.num);
-
-	str = strdup(term->val.str);
-	if (!str)
-		return -ENOMEM;
-	return new_term(new, &temp, str, 0);
-}
-
-void parse_events_term__delete(struct parse_events_term *term)
-{
-	if (term->array.nr_ranges)
-		zfree(&term->array.ranges);
-
-	if (term->type_val != PARSE_EVENTS__TERM_TYPE_NUM)
-		zfree(&term->val.str);
-
-	zfree(&term->config);
-	free(term);
-}
-
-int parse_events_copy_term_list(struct list_head *old,
-				 struct list_head **new)
-{
-	struct parse_events_term *term, *n;
-	int ret;
-
-	if (!old) {
-		*new = NULL;
-		return 0;
-	}
-
-	*new = malloc(sizeof(struct list_head));
-	if (!*new)
-		return -ENOMEM;
-	INIT_LIST_HEAD(*new);
-
-	list_for_each_entry (term, old, list) {
-		ret = parse_events_term__clone(&n, term);
-		if (ret)
-			return ret;
-		list_add_tail(&n->list, *new);
-	}
-	return 0;
-}
-
-void parse_events_terms__purge(struct list_head *terms)
-{
-	struct parse_events_term *term, *h;
-
-	list_for_each_entry_safe(term, h, terms, list) {
-		list_del_init(&term->list);
-		parse_events_term__delete(term);
-	}
-}
-
-void parse_events_terms__delete(struct list_head *terms)
-{
-	if (!terms)
-		return;
-	parse_events_terms__purge(terms);
-	free(terms);
-}
-
 void parse_events__clear_array(struct parse_events_array *a)
 {
 	zfree(&a->ranges);
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 181bd72ade6b..5e30977bdb07 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/perf_event.h>
 #include <string.h>
+#include <internal/parse-events.h>
 
 struct list_head;
 struct evsel;
@@ -60,66 +61,6 @@ struct perf_pmu_event_symbol {
 	enum perf_pmu_event_symbol_type	type;
 };
 
-enum {
-	PARSE_EVENTS__TERM_TYPE_NUM,
-	PARSE_EVENTS__TERM_TYPE_STR,
-};
-
-enum {
-	PARSE_EVENTS__TERM_TYPE_USER,
-	PARSE_EVENTS__TERM_TYPE_CONFIG,
-	PARSE_EVENTS__TERM_TYPE_CONFIG1,
-	PARSE_EVENTS__TERM_TYPE_CONFIG2,
-	PARSE_EVENTS__TERM_TYPE_NAME,
-	PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD,
-	PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ,
-	PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE,
-	PARSE_EVENTS__TERM_TYPE_TIME,
-	PARSE_EVENTS__TERM_TYPE_CALLGRAPH,
-	PARSE_EVENTS__TERM_TYPE_STACKSIZE,
-	PARSE_EVENTS__TERM_TYPE_NOINHERIT,
-	PARSE_EVENTS__TERM_TYPE_INHERIT,
-	PARSE_EVENTS__TERM_TYPE_MAX_STACK,
-	PARSE_EVENTS__TERM_TYPE_MAX_EVENTS,
-	PARSE_EVENTS__TERM_TYPE_NOOVERWRITE,
-	PARSE_EVENTS__TERM_TYPE_OVERWRITE,
-	PARSE_EVENTS__TERM_TYPE_DRV_CFG,
-	PARSE_EVENTS__TERM_TYPE_PERCORE,
-	PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT,
-	PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE,
-	PARSE_EVENTS__TERM_TYPE_METRIC_ID,
-	__PARSE_EVENTS__TERM_TYPE_NR,
-};
-
-struct parse_events_array {
-	size_t nr_ranges;
-	struct {
-		unsigned int start;
-		size_t length;
-	} *ranges;
-};
-
-struct parse_events_term {
-	char *config;
-	struct parse_events_array array;
-	union {
-		char *str;
-		u64  num;
-	} val;
-	int type_val;
-	int type_term;
-	struct list_head list;
-	bool used;
-	bool no_value;
-
-	/* error string indexes for within parsed string */
-	int err_term;
-	int err_val;
-
-	/* Coming from implicit alias */
-	bool weak;
-};
-
 struct parse_events_error {
 	int   num_errors;       /* number of errors encountered */
 	int   idx;	/* index in the parsed string */
@@ -151,21 +92,6 @@ struct parse_events_state {
 void parse_events__handle_error(struct parse_events_error *err, int idx,
 				char *str, char *help);
 void parse_events__shrink_config_terms(void);
-int parse_events__is_hardcoded_term(struct parse_events_term *term);
-int parse_events_term__num(struct parse_events_term **term,
-			   int type_term, char *config, u64 num,
-			   bool novalue,
-			   int loc_term, int loc_val);
-int parse_events_term__str(struct parse_events_term **term,
-			   int type_term, char *config, char *str,
-			   int loc_term, int loc_val);
-int parse_events_term__sym_hw(struct parse_events_term **term,
-			      char *config, unsigned idx);
-int parse_events_term__clone(struct parse_events_term **new,
-			     struct parse_events_term *term);
-void parse_events_term__delete(struct parse_events_term *term);
-void parse_events_terms__delete(struct list_head *terms);
-void parse_events_terms__purge(struct list_head *terms);
 void parse_events__clear_array(struct parse_events_array *a);
 int parse_events__modifier_event(struct list_head *list, char *str, bool add);
 int parse_events__modifier_group(struct list_head *list, char *event_mod);
@@ -217,8 +143,6 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			       struct list_head *head_config,
 			       struct list_head **listp);
 
-int parse_events_copy_term_list(struct list_head *old,
-				 struct list_head **new);
 
 enum perf_pmu_event_symbol_type
 perf_pmu__parse_check(const char *name);
-- 
2.31.1

