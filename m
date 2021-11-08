Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5993CC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40189617E3
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240011AbhKHNmX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:42:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24092 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhKHNmV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Z1ZOoK0htUZ4WZ/bvvCUZGNYCJsggMhC0AyrE8H2Cc=;
        b=UIAasI0NNyOG+xQsTKkUt6aKSKznVSOObW4yiOCx5+0GEbOhgAksRMeCfzuGtQoEJhOcjW
        DWnNI7//4aJp4eGNEWIPnzIFauGlUb0rW2w6epKSt93Q/vTEeKxYBG8abfS0727cS+OUbh
        Lelwxv8y3vPjxOdqCN1OntVgbW7K9jE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-LTqbj8t7O5mRE8_K0vTH-w-1; Mon, 08 Nov 2021 08:39:33 -0500
X-MC-Unique: LTqbj8t7O5mRE8_K0vTH-w-1
Received: by mail-wm1-f69.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso10170146wms.4
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Z1ZOoK0htUZ4WZ/bvvCUZGNYCJsggMhC0AyrE8H2Cc=;
        b=pwd1QyuUGRWujGIDf64SieGX3qRgjxo7BeazcI1I7jeEtZPwaiwgcdVTKgdyNoQZEM
         /tAoGdjvQXFrMgqPghhRWNFHrK+d5fiCZApZXdniQSSLfmvb24kMXj08KlG4lNuVAA6O
         hynHx2YPwZK7WiBwAEWajDIC5ncqBOB9taSTZCLy6GIyWYThs7IrmwyFczRmngncH6jR
         Kl0P37yG2rFiIwZydMJxIaLL7KaJ7brAwlvG2TnwZMXYIHgPpjWUL6++J4PwAnJuXty4
         Tx5rvlChU3rsvZUCuBwwZSxysRoaNldccCUhbfy7gyV/F7GFVGD/n0dGliiNNv0+zlpx
         WIBQ==
X-Gm-Message-State: AOAM530oRpnp2I9S15+GPipNPAWrfX5JV4W0sqStDHHuu7Vn39Aile31
        5kSV2wYsvIFpR4mjXKJzu7snAu5WTgk8Mw+t5xzV4XMIgMZC9MB60hn0251UjtpPAb8//LHZmvI
        6XuaRuFeKaBMhLEtSlblJdMAnMB34Uw==
X-Received: by 2002:a1c:6a0e:: with SMTP id f14mr51298866wmc.58.1636378772480;
        Mon, 08 Nov 2021 05:39:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyk0dtnBowz4pzdEmH381gSmt70o/V8mVQqm/40TttGFY28hBWdfR5+v8VHuy5r0p90ypCdoQ==
X-Received: by 2002:a1c:6a0e:: with SMTP id f14mr51298854wmc.58.1636378772360;
        Mon, 08 Nov 2021 05:39:32 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id j17sm11639093wmq.41.2021.11.08.05.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:39:32 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 22/59] perf tools: Add evsel__new callback to parse_state_ops
Date:   Mon,  8 Nov 2021 14:36:33 +0100
Message-Id: <20211108133710.1352822-23-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adding evsel__new callback to parse_state_ops to allow
custom event allocation for event parsing.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/parse-events.c | 13 ++++++++++---
 tools/perf/util/parse-events.h |  5 +++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 8f8151738a78..e782a329484e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -154,6 +154,10 @@ struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
 	},
 };
 
+static struct parse_events_ops parse_state_ops = {
+	.evsel__new = evsel__new_idx,
+};
+
 #define __PERF_EVENT_FIELD(config, name) \
 	((config & PERF_EVENT_##name##_MASK) >> PERF_EVENT_##name##_SHIFT)
 
@@ -376,7 +380,7 @@ __add_event(struct parse_events_state *parse_state,
 	if (init_attr)
 		event_attr_init(attr);
 
-	evsel = evsel__new_idx(attr, *idx);
+	evsel = parse_state->ops->evsel__new(attr, *idx);
 	if (!evsel) {
 		perf_cpu_map__put(cpus);
 		return NULL;
@@ -2256,8 +2260,9 @@ static int parse_events__scanner(const char *str,
 int parse_events_terms(struct list_head *terms, const char *str)
 {
 	struct parse_events_state parse_state = {
-		.terms  = NULL,
-		.stoken = PE_START_TERMS,
+		.ops     = &parse_state_ops,
+		.terms   = NULL,
+		.stoken  = PE_START_TERMS,
 	};
 	int ret;
 
@@ -2283,6 +2288,7 @@ static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
 		.stoken          = PE_START_EVENTS,
 		.hybrid_pmu_name = pmu_name,
 		.idx             = parse_state->idx,
+		.ops             = &parse_state_ops,
 	};
 	int ret;
 
@@ -2311,6 +2317,7 @@ int __parse_events(struct evlist *evlist, const char *str,
 		.evlist	  = evlist,
 		.stoken	  = PE_START_EVENTS,
 		.fake_pmu = fake_pmu,
+		.ops	  = &parse_state_ops,
 	};
 	int ret;
 
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index aedb1153a1a1..346c3a8cd381 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -130,6 +130,10 @@ struct parse_events_error {
 	char *first_help;
 };
 
+struct parse_events_ops {
+	struct evsel* (*evsel__new)(struct perf_event_attr *attr, int idx);
+};
+
 struct parse_events_state {
 	struct list_head	   list;
 	int			   idx;
@@ -140,6 +144,7 @@ struct parse_events_state {
 	int			   stoken;
 	struct perf_pmu		  *fake_pmu;
 	char			  *hybrid_pmu_name;
+	struct parse_events_ops	  *ops;
 };
 
 void parse_events__handle_error(struct parse_events_error *err, int idx,
-- 
2.31.1

