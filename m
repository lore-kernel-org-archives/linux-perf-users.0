Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A05C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B50E561506
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239992AbhKHNld (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:41:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35623 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237209AbhKHNlc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1f1DcEAIMlZ4wNZITcHcjElcF/yuqwR8X1cOQPTdrOs=;
        b=fWuT9t0Lf+fESYz1e8DANsMDZEBWYXKP87S82T1PVMyIRbZKPkkQ1bS/OH/kMjfOyDzwgK
        63yLdhPZUSxP34HBFqCh44RMOMr16MsBfw5dX48poRCBWp7vqICnmK3CaPoOZNJDMPiUIK
        JBKK4GkJg4rlGvC3SyXJMzQF4YikNg4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-rqPxk_KOPjyIRLZ_a8BNGw-1; Mon, 08 Nov 2021 08:38:46 -0500
X-MC-Unique: rqPxk_KOPjyIRLZ_a8BNGw-1
Received: by mail-wm1-f71.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso10169379wms.4
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:38:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1f1DcEAIMlZ4wNZITcHcjElcF/yuqwR8X1cOQPTdrOs=;
        b=16wY9AVNh62zPh7rInILVp7R/Ak6dML7uq+OaV/ESvb6vZRhefdXmKKJlRAdQX6N4z
         3Fr3a4FHHqtff/v+wDMSwLg+2219zY2C0GEUlYYrCInmqm7R/t3rKpEQC1za8wy/JqMX
         GXhGlw37Z8cjXoK/o/6WPHeb2LLzLgvYZL2IwWD5TSILaPb9GER7TzeQWipvkyH3zh4W
         JUHkwdB4doDfpNNB7ZEuVa39dM4nH9z5Gh/HTlAYwNUbdtcRuiXi2hjbRR8vaDeeVPqT
         Fs5Mjwtc8OtVVCt3JBAf7Df4DA+gwh67pZkjIMFFwhCVZbOSLpN2UJb8lg1QU54JcJQJ
         adeA==
X-Gm-Message-State: AOAM530pcPD7PnwAhmzl2+YKLxDQTTm364KJjw3emnRYxuwNQ5NSQmFv
        F4zCmg4p7xZnhCkl3VqlOXva77FBguL0yQvv0ZrFK4DApRXG1sElIyCNtTUSYAcQ1TKVKUk0LYp
        CuUofdMHAI5QpmTXmF3XFkwRPtE1X5g==
X-Received: by 2002:a1c:f615:: with SMTP id w21mr50361347wmc.16.1636378725379;
        Mon, 08 Nov 2021 05:38:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyK4Ge24jt7wevDXOSkAzAJvgyhtGEfFRiAZ1tBpRid64q7r8pGWy/0SvWAh6w0/VUHhu9fow==
X-Received: by 2002:a1c:f615:: with SMTP id w21mr50361324wmc.16.1636378725134;
        Mon, 08 Nov 2021 05:38:45 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id x8sm16468151wrw.6.2021.11.08.05.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:38:44 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 14/59] libperf: Move sample_read to perf_evsel
Date:   Mon,  8 Nov 2021 14:36:25 +0100
Message-Id: <20211108133710.1352822-15-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving sample_read to perf_evsel struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/evsel.h |  1 +
 tools/perf/tests/parse-events.c         | 40 ++++++++++++-------------
 tools/perf/util/evsel.c                 |  4 +--
 tools/perf/util/evsel.h                 |  1 -
 tools/perf/util/parse-events.c          |  2 +-
 tools/perf/util/record.c                |  2 +-
 6 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 7f3ee73c5aa5..6f820742615c 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -70,6 +70,7 @@ struct perf_evsel {
 		enum perf_tool_event	tool_event;
 		const char		*unit;
 		int			exclude_GH;
+		int			sample_read;
 	};
 };
 
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index c06cc2c155fd..15d6d3d907b7 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -685,7 +685,7 @@ static int test__group1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
 
 	/* cycles:upp */
 	evsel = evsel__next(evsel);
@@ -701,7 +701,7 @@ static int test__group1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 2);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
 
 	return 0;
 }
@@ -727,7 +727,7 @@ static int test__group2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
 
 	/* cache-references + :u modifier */
 	evsel = evsel__next(evsel);
@@ -742,7 +742,7 @@ static int test__group2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
 
 	/* cycles:k */
 	evsel = evsel__next(evsel);
@@ -756,7 +756,7 @@ static int test__group2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
 
 	return 0;
 }
@@ -785,7 +785,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 		!strcmp(leader->group_name, "group1"));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
 
 	/* group1 cycles:kppp */
 	evsel = evsel__next(evsel);
@@ -802,7 +802,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
 
 	/* group2 cycles + G modifier */
 	evsel = leader = evsel__next(evsel);
@@ -820,7 +820,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 		!strcmp(leader->group_name, "group2"));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
 
 	/* group2 1:3 + G modifier */
 	evsel = evsel__next(evsel);
@@ -834,7 +834,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
 
 	/* instructions:u */
 	evsel = evsel__next(evsel);
@@ -848,7 +848,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
 
 	return 0;
 }
@@ -876,7 +876,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
 
 	/* instructions:kp + p */
 	evsel = evsel__next(evsel);
@@ -892,7 +892,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 2);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
 
 	return 0;
 }
@@ -919,7 +919,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
 
 	/* instructions + G */
 	evsel = evsel__next(evsel);
@@ -934,7 +934,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
 
 	/* cycles:G */
 	evsel = leader = evsel__next(evsel);
@@ -951,7 +951,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
 
 	/* instructions:G */
 	evsel = evsel__next(evsel);
@@ -1162,7 +1162,7 @@ static int test__leader_sample1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
+	TEST_ASSERT_VAL("wrong sample_read", evsel->core.sample_read);
 
 	/* cache-misses - not sampling */
 	evsel = evsel__next(evsel);
@@ -1176,7 +1176,7 @@ static int test__leader_sample1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
+	TEST_ASSERT_VAL("wrong sample_read", evsel->core.sample_read);
 
 	/* branch-misses - not sampling */
 	evsel = evsel__next(evsel);
@@ -1191,7 +1191,7 @@ static int test__leader_sample1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
+	TEST_ASSERT_VAL("wrong sample_read", evsel->core.sample_read);
 
 	return 0;
 }
@@ -1215,7 +1215,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
+	TEST_ASSERT_VAL("wrong sample_read", evsel->core.sample_read);
 
 	/* branch-misses - not sampling */
 	evsel = evsel__next(evsel);
@@ -1230,7 +1230,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
+	TEST_ASSERT_VAL("wrong sample_read", evsel->core.sample_read);
 
 	return 0;
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 802c7de9e8e3..e0fde07ae9b6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -432,7 +432,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->is_libpfm_event = orig->is_libpfm_event;
 
 	evsel->core.exclude_GH = orig->core.exclude_GH;
-	evsel->sample_read = orig->sample_read;
+	evsel->core.sample_read = orig->core.sample_read;
 	evsel->core.auto_merge_stats = orig->core.auto_merge_stats;
 	evsel->collect_stat = orig->collect_stat;
 	evsel->weak_group = orig->weak_group;
@@ -1106,7 +1106,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	evsel__set_sample_bit(evsel, IP);
 	evsel__set_sample_bit(evsel, TID);
 
-	if (evsel->sample_read) {
+	if (evsel->core.sample_read) {
 		evsel__set_sample_bit(evsel, READ);
 
 		/*
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 6c3634ed169a..83722fce3d04 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -62,7 +62,6 @@ struct evsel {
 		double			scale;
 		struct cgroup		*cgrp;
 		/* parse modifier helper */
-		int			sample_read;
 		bool			snapshot;
 		bool			per_pkg;
 		bool			percore;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 89787ebc23ef..da171f549e54 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2050,7 +2050,7 @@ int parse_events__modifier_event(struct list_head *list, char *str, bool add)
 		evsel->core.attr.exclude_guest  = mod.eG;
 		evsel->core.attr.exclude_idle   = mod.eI;
 		evsel->core.exclude_GH          = mod.exclude_GH;
-		evsel->sample_read         = mod.sample_read;
+		evsel->core.sample_read         = mod.sample_read;
 		evsel->precise_max         = mod.precise_max;
 		evsel->weak_group	   = mod.weak;
 		evsel->bpf_counter	   = mod.bpf_counter;
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 83e3a8cce9ba..97dd3314047c 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -57,7 +57,7 @@ static void evsel__config_leader_sampling(struct evsel *evsel, struct evlist *ev
 	struct evsel *read_sampler;
 	u64 term_types, freq_mask;
 
-	if (!leader->sample_read)
+	if (!leader->core.sample_read)
 		return;
 
 	read_sampler = evsel__read_sampler(evsel, evlist);
-- 
2.31.1

