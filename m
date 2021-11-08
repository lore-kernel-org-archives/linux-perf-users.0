Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B10C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA68561244
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbhKHNpY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:45:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37405 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240034AbhKHNpX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3LECklUh2dU56mFDwW9c2rJBIaXNFXam+8b+w//sSJo=;
        b=CIVPWtbz+/med28MoBbwdCaEfi4JJESbE4Q6+8L9YMx8aQ6mgbwf6JPyKFU/jk0QppnXYI
        n/7+0R7DjtsCXw8Hx1bDDblQC/tEBcEB4xG+4IVU0csClxBglya8Yz+RTw9RSsYlqUC27E
        wywWmTQ2tsngsS+EZrwTyxSicE4QMbg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-Kwv6ZZlDNpipZ9XumZwDxg-1; Mon, 08 Nov 2021 08:42:37 -0500
X-MC-Unique: Kwv6ZZlDNpipZ9XumZwDxg-1
Received: by mail-wr1-f72.google.com with SMTP id y9-20020a5d6209000000b001684625427eso4076383wru.7
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:42:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3LECklUh2dU56mFDwW9c2rJBIaXNFXam+8b+w//sSJo=;
        b=NPYiaNzysVWNAdvGAaDimsurwfeGhNrRgJsA7l9t2quovWxKcxp9+we2r8fZ04ZZc2
         blauoCFapMd6tkBy7qh8FOgFU+MjdSYaCQ7oZNHm+3kABHCEL6KhDcCmxhxuHsiz1v8z
         2c0Dzb0fwiQnnGNvOl9d7j4KLWUTm/vKeipMczKxr8Jlh1k1brDgGAAbFcgWmKuoZ/ow
         yMeYeUWw0+Wfb1hBI4NtyOOs7Qp1IQNrEspAnqMFhBX4NcirXtDMXvn5Ajn+Nz0OT9qi
         slrrM2HV0tjgANlf/xF1CQskLZrg8T8DhxBksqWs57lixElyUqfATDRC8eoNnCbGOFM1
         BneA==
X-Gm-Message-State: AOAM531kIzbf5aWuvBn9kbrvuEBMKRboDc+5w5OdfIl72zMMTgy7wSi7
        frFWR8FjB8BbPZ5q3WJ6D6NgjOZNkbZLRWQXOeJ6QyBAsK/uAaHeFNe5iQCixbmdriIPM/FkNIJ
        ehhjBrT9oRn96H23S+OtV6eCXlQsuhA==
X-Received: by 2002:a05:600c:2dc1:: with SMTP id e1mr52256149wmh.170.1636378955742;
        Mon, 08 Nov 2021 05:42:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyc/GBU9LL4Sp4K7MXeWmSAKqpyRyEoIS2sxhO4pdYaa8yhEOktFWcsQ3gg5GS2o5bAJWCPQw==
X-Received: by 2002:a05:600c:2dc1:: with SMTP id e1mr52256135wmh.170.1636378955600;
        Mon, 08 Nov 2021 05:42:35 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id t189sm16230814wma.8.2021.11.08.05.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:42:35 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 53/59] perf tools: Add parse_check callback to struct parse_events_ops
Date:   Mon,  8 Nov 2021 14:37:04 +0100
Message-Id: <20211108133710.1352822-54-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adding parse_check callback to struct parse_events_ops,
to allow custom parse_check method in tracing flexer code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/parse-events.h |  9 +++++++++
 tools/perf/util/parse-events.c                 |  3 ++-
 tools/perf/util/parse-events.h                 | 10 ----------
 tools/perf/util/parse-events.l                 | 12 ++++++------
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index 8eb9487a2519..0a8a61219885 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -46,6 +46,13 @@ enum {
 	__PARSE_EVENTS__TERM_TYPE_NR,
 };
 
+enum perf_pmu_event_symbol_type {
+	PMU_EVENT_SYMBOL_ERR,		/* not a PMU EVENT */
+	PMU_EVENT_SYMBOL,		/* normal style PMU event */
+	PMU_EVENT_SYMBOL_PREFIX,	/* prefix of pre-suf style event */
+	PMU_EVENT_SYMBOL_SUFFIX,	/* suffix of pre-suf style event */
+};
+
 struct parse_events_array {
 	size_t nr_ranges;
 	struct {
@@ -136,6 +143,8 @@ struct parse_events_ops {
 
 	void (*set_leader)(char *name, struct list_head *list,
 			   struct parse_events_state *parse_state);
+
+	enum perf_pmu_event_symbol_type (*parse_check)(const char *name);
 };
 
 struct parse_events_state {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2c1bc9644c42..aa79ce2f2d44 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1889,7 +1889,7 @@ int perf_pmu__test_parse_init(void)
 	return 0;
 }
 
-enum perf_pmu_event_symbol_type
+static enum perf_pmu_event_symbol_type
 perf_pmu__parse_check(const char *name)
 {
 	struct perf_pmu_event_symbol p, *r;
@@ -2924,4 +2924,5 @@ static struct parse_events_ops parse_state_ops = {
 	.add_bpf            = parse_events_load_bpf,
 	.add_tool           = parse_events_add_tool,
 	.set_leader         = parse_events_set_leader,
+	.parse_check        = perf_pmu__parse_check,
 };
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index c62a2e3a1f34..7ab06ae8355f 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -49,13 +49,6 @@ int exclude_perf(const struct option *opt, const char *arg, int unset);
 
 #define EVENTS_HELP_MAX (128*1024)
 
-enum perf_pmu_event_symbol_type {
-	PMU_EVENT_SYMBOL_ERR,		/* not a PMU EVENT */
-	PMU_EVENT_SYMBOL,		/* normal style PMU event */
-	PMU_EVENT_SYMBOL_PREFIX,	/* prefix of pre-suf style event */
-	PMU_EVENT_SYMBOL_SUFFIX,	/* suffix of pre-suf style event */
-};
-
 struct perf_pmu_event_symbol {
 	char	*symbol;
 	enum perf_pmu_event_symbol_type	type;
@@ -75,9 +68,6 @@ struct evsel *parse_events__add_event(struct parse_events_state *parse_state,
 				      const char *name, const char *metric_id,
 				      struct perf_pmu *pmu);
 
-enum perf_pmu_event_symbol_type
-perf_pmu__parse_check(const char *name);
-
 void print_events(const char *event_glob, bool name_only, bool quiet,
 		  bool long_desc, bool details_flag, bool deprecated,
 		  const char *pmu_name);
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 4efe9872c667..1cebd5fcdb5d 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -63,12 +63,12 @@ static int str(yyscan_t scanner, int token)
 	return token;
 }
 
-static int raw(yyscan_t scanner)
+static int raw(yyscan_t scanner, struct parse_events_state *parse_state)
 {
 	YYSTYPE *yylval = parse_events_get_lval(scanner);
 	char *text = parse_events_get_text(scanner);
 
-	if (perf_pmu__parse_check(text) == PMU_EVENT_SYMBOL)
+	if (parse_state->ops->parse_check(text) == PMU_EVENT_SYMBOL)
 		return str(scanner, PE_NAME);
 
 	return __value(yylval, text + 1, 16, PE_RAW);
@@ -144,7 +144,7 @@ static int pmu_str_check(yyscan_t scanner, struct parse_events_state *parse_stat
 	 * parse check can't be trusted so we return PE_PMU_EVENT_FAKE unless
 	 * an '!' is present in which case the text can't be a PMU name.
 	 */
-	switch (perf_pmu__parse_check(text)) {
+	switch (parse_state->ops->parse_check(text)) {
 		case PMU_EVENT_SYMBOL_PREFIX:
 			return PE_PMU_EVENT_PRE;
 		case PMU_EVENT_SYMBOL_SUFFIX:
@@ -300,8 +300,8 @@ percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
 aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
-r{num_raw_hex}		{ return raw(yyscanner); }
-r0x{num_raw_hex}	{ return raw(yyscanner); }
+r{num_raw_hex}		{ return raw(yyscanner, _parse_state); }
+r0x{num_raw_hex}	{ return raw(yyscanner, _parse_state); }
 ,			{ return ','; }
 "/"			{ BEGIN(INITIAL); return '/'; }
 {name_minus}		{ return str(yyscanner, PE_NAME); }
@@ -384,7 +384,7 @@ refs|Reference|ops|access		|
 misses|miss				{ return str(yyscanner, PE_NAME_CACHE_OP_RESULT); }
 
 mem:			{ BEGIN(mem); return PE_PREFIX_MEM; }
-r{num_raw_hex}		{ return raw(yyscanner); }
+r{num_raw_hex}		{ return raw(yyscanner, _parse_state); }
 {num_dec}		{ return value(yyscanner, 10); }
 {num_hex}		{ return value(yyscanner, 16); }
 
-- 
2.31.1

