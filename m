Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F513C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 568516152A
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbhKHNl4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:41:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhKHNl4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v80IDaVsZPqPKzHpoAO/9+Cln7qt5PCa+f5jZxAfMAs=;
        b=PxVdWdRXQoicAtcfGc9BerqIYIWp5xAXW98sIclK5ohJguxjg8mvnxCiAPx2keYb2Cr3te
        Lvtshc0JDZO/X85KH6pLp1YJbTwbEurrP0+ivKQp81dI/xICYi18pSfTbNB/yHDn1qjIxC
        UqcnbDUnVdnh6FCuFpkmXwpG5ASt/w4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-orAK-takP8uxTW6sIXy2MQ-1; Mon, 08 Nov 2021 08:39:10 -0500
X-MC-Unique: orAK-takP8uxTW6sIXy2MQ-1
Received: by mail-wm1-f69.google.com with SMTP id g11-20020a1c200b000000b003320d092d08so6218247wmg.9
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:39:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v80IDaVsZPqPKzHpoAO/9+Cln7qt5PCa+f5jZxAfMAs=;
        b=1XAf4pJ+JBLHav2qzQFIPEH4oavxYDmGRz885/F/T12ezKl/prFkgXn1M8FIRi92dB
         9HbBvIHGNsUf02y2oE25D+LPB/SlT+7twW4K0m0HiTXh9F71zUTriR56bv03O5sYDpIG
         AUdcECrCEv4fh/PtHvBEK4YLevYrooTH8jITGDKiX75+911JwzSvxK3/6pPIPq5DPtGE
         rCTvGHXBoubVgpxGvdooPBJ14MTGDWhB7XOOEy6y1y0uScgzCI+OWd+pEjq/xjY+sW75
         uKaBiJ8v7kZjSKWV7mR5ZiLI7bUl0YmyJyfQ0KaLkR+Kye58whUbPymEbo0c3E6OT4+3
         19tg==
X-Gm-Message-State: AOAM531ngsXy5cjcpY0buW+/ndizkhAcFJh0gMAeGQRbGOumReS93fi4
        6mlW78qHlk/hl1iTFlxxjd4ZE7wKUat2AHsXKK6X4RS9IpbolutSe9wLC61yjx4yq509quKrDhI
        E84Y1YqvNOz6l/tp+gsGbqagVN799Lg==
X-Received: by 2002:a1c:21d7:: with SMTP id h206mr52472405wmh.60.1636378749028;
        Mon, 08 Nov 2021 05:39:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzajnOk31vltWpDKpS6uKLn4i55ly805xOR/nsfPWYCd8egrV56qnpG5J/cAiGeMs+YXWccwA==
X-Received: by 2002:a1c:21d7:: with SMTP id h206mr52472379wmh.60.1636378748766;
        Mon, 08 Nov 2021 05:39:08 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id n15sm20912210wmq.38.2021.11.08.05.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:39:08 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 18/59] libperf: Move group_name to perf_evsel
Date:   Mon,  8 Nov 2021 14:36:29 +0100
Message-Id: <20211108133710.1352822-19-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving group_name to perf_evsel struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/evsel.h |  1 +
 tools/perf/tests/parse-events.c         | 32 ++++++++++++-------------
 tools/perf/util/auxtrace.c              |  6 ++---
 tools/perf/util/evsel.c                 | 10 ++++----
 tools/perf/util/evsel.h                 |  1 -
 tools/perf/util/evsel_fprintf.c         |  2 +-
 tools/perf/util/header.c                |  6 ++---
 tools/perf/util/parse-events.c          |  4 ++--
 8 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 81df282fa008..befcd180ef3d 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -64,6 +64,7 @@ struct perf_evsel {
 	 */
         struct {
                 char			*name;
+		const char		*group_name;
 		bool			auto_merge_stats;
 		struct list_head	config_terms;
 		const char		*metric_id;
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 15d6d3d907b7..50746bb524f0 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -782,7 +782,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong group name",
-		!strcmp(leader->group_name, "group1"));
+		!strcmp(leader->core.group_name, "group1"));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
@@ -800,7 +800,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 3);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+	TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
 
@@ -817,7 +817,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong group name",
-		!strcmp(leader->group_name, "group2"));
+		!strcmp(leader->core.group_name, "group2"));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
@@ -872,7 +872,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 1);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+	TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
@@ -915,7 +915,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+	TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
@@ -947,7 +947,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+	TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
@@ -1001,7 +1001,7 @@ static int test__group_gh1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+	TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
@@ -1041,7 +1041,7 @@ static int test__group_gh2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+	TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
@@ -1081,7 +1081,7 @@ static int test__group_gh3(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+	TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
@@ -1121,7 +1121,7 @@ static int test__group_gh4(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+	TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
@@ -1160,7 +1160,7 @@ static int test__leader_sample1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+	TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong sample_read", evsel->core.sample_read);
 
@@ -1189,7 +1189,7 @@ static int test__leader_sample1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+	TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong sample_read", evsel->core.sample_read);
 
@@ -1213,7 +1213,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+	TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong sample_read", evsel->core.sample_read);
 
@@ -1228,7 +1228,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+	TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong sample_read", evsel->core.sample_read);
 
@@ -1259,7 +1259,7 @@ static int test__pinned_group(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+	TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong pinned", evsel->core.attr.pinned);
 
@@ -1303,7 +1303,7 @@ static int test__exclusive_group(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+	TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong exclusive", evsel->core.attr.exclusive);
 
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index c679394b898d..a882bc81e0fb 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1235,9 +1235,9 @@ static void unleader_evsel(struct evlist *evlist, struct evsel *leader)
 
 	/* Update group information */
 	if (new_leader) {
-		zfree(&new_leader->group_name);
-		new_leader->group_name = leader->group_name;
-		leader->group_name = NULL;
+		zfree(&new_leader->core.group_name);
+		new_leader->core.group_name = leader->core.group_name;
+		leader->core.group_name = NULL;
 
 		new_leader->core.nr_members = leader->core.nr_members - 1;
 		leader->core.nr_members = 1;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index aafd91805870..7621eddc8e58 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -395,9 +395,9 @@ struct evsel *evsel__clone(struct evsel *orig)
 		if (evsel->core.name == NULL)
 			goto out_err;
 	}
-	if (orig->group_name) {
-		evsel->group_name = strdup(orig->group_name);
-		if (evsel->group_name == NULL)
+	if (orig->core.group_name) {
+		evsel->core.group_name = strdup(orig->core.group_name);
+		if (evsel->core.group_name == NULL)
 			goto out_err;
 	}
 	if (orig->pmu_name) {
@@ -797,7 +797,7 @@ const char *evsel__metric_id(const struct evsel *evsel)
 
 const char *evsel__group_name(struct evsel *evsel)
 {
-	return evsel->group_name ?: "anon group";
+	return evsel->core.group_name ?: "anon group";
 }
 
 /*
@@ -1436,7 +1436,7 @@ void evsel__exit(struct evsel *evsel)
 	perf_cpu_map__put(evsel->core.cpus);
 	perf_cpu_map__put(evsel->core.own_cpus);
 	perf_thread_map__put(evsel->core.threads);
-	zfree(&evsel->group_name);
+	zfree(&evsel->core.group_name);
 	zfree(&evsel->core.name);
 	zfree(&evsel->pmu_name);
 	zfree(&evsel->core.metric_id);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index c09bbddd5da0..e06d171baba3 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -54,7 +54,6 @@ struct evsel {
 	 * they can be released properly.
 	 */
 	struct {
-		char			*group_name;
 		const char		*pmu_name;
 		struct tep_event	*tp_format;
 		char			*filter;
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 8c2ea8001329..4670d1e745b2 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -48,7 +48,7 @@ int evsel__fprintf(struct evsel *evsel, struct perf_attr_details *details, FILE
 			return 0;
 
 		if (evsel->core.nr_members > 1)
-			printed += fprintf(fp, "%s{", evsel->group_name ?: "");
+			printed += fprintf(fp, "%s{", evsel->core.group_name ?: "");
 
 		printed += fprintf(fp, "%s", evsel__name(evsel));
 		for_each_group_member(pos, evsel)
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4610b23fed28..a14b690a6025 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -788,7 +788,7 @@ static int write_group_desc(struct feat_fd *ff,
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel__is_group_leader(evsel) && evsel->core.nr_members > 1) {
-			const char *name = evsel->group_name ?: "{anon_group}";
+			const char *name = evsel->core.group_name ?: "{anon_group}";
 			u32 leader_idx = evsel->core.idx;
 			u32 nr_members = evsel->core.nr_members;
 
@@ -2094,7 +2094,7 @@ static void print_group_desc(struct feat_fd *ff, FILE *fp)
 
 	evlist__for_each_entry(session->evlist, evsel) {
 		if (evsel__is_group_leader(evsel) && evsel->core.nr_members > 1) {
-			fprintf(fp, "# group: %s{%s", evsel->group_name ?: "", evsel__name(evsel));
+			fprintf(fp, "# group: %s{%s", evsel->core.group_name ?: "", evsel__name(evsel));
 
 			nr = evsel->core.nr_members - 1;
 		} else if (nr) {
@@ -2743,7 +2743,7 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 			evsel__set_leader(evsel, evsel);
 			/* {anon_group} is a dummy name */
 			if (strcmp(desc[i].name, "{anon_group}")) {
-				evsel->group_name = desc[i].name;
+				evsel->core.group_name = desc[i].name;
 				desc[i].name = NULL;
 			}
 			evsel->core.nr_members = desc[i].nr_members;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 24d01b768078..05a96b0f7b41 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1841,7 +1841,7 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
 	for (i = 0; i < nr_pmu; i++) {
 		evsel = (struct evsel *) leaders[i];
 		evsel->core.nr_members = total_members / nr_pmu;
-		evsel->group_name = name ? strdup(name) : NULL;
+		evsel->core.group_name = name ? strdup(name) : NULL;
 	}
 
 	/* Take the new small groups into account */
@@ -1869,7 +1869,7 @@ void parse_events__set_leader(char *name, struct list_head *list,
 
 	__perf_evlist__set_leader(list);
 	leader = list_entry(list->next, struct evsel, core.node);
-	leader->group_name = name ? strdup(name) : NULL;
+	leader->core.group_name = name ? strdup(name) : NULL;
 }
 
 /* list_event is assumed to point to malloc'ed memory */
-- 
2.31.1

