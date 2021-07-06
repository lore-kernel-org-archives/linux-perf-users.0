Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFA8C11F66
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 15:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC0DB61C26
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 15:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhGFPUT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jul 2021 11:20:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41972 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232671AbhGFPUS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jul 2021 11:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625584659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IFMht/JUz7O/5nFRrh0iKmB3u/zFGuN/em4/0cNuWEQ=;
        b=ai1/MTJuKyQMEvfAHmW186Pizkwo84SddSVKqLR+gzghUBeupk2SPPB/Eg1pAythcF+Uo9
        Wc47n0NPlpcQ+4BRN7JTuebRFsnOyw28RaPOvefqb5pTJhZr7R2YtBJgVL+TP9qb76TJLv
        98tC/GKMgQ2BfSvYbHVnz36c2bdGwhc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-KbbK4EIJPb-MvhjIOgANdg-1; Tue, 06 Jul 2021 11:17:37 -0400
X-MC-Unique: KbbK4EIJPb-MvhjIOgANdg-1
Received: by mail-wr1-f72.google.com with SMTP id u7-20020a5d46870000b029012786ba1bc9so7285059wrq.21
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jul 2021 08:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IFMht/JUz7O/5nFRrh0iKmB3u/zFGuN/em4/0cNuWEQ=;
        b=TiDiEQP0G4yJV4+sQRitzuYCa07MuZKXzp51mIsnLquPnEsc/Tr65es7s+L5CSeiR/
         8PAYTuqe/gpXd3QOuNajUS+TZTMCd+TCTA9WKcsqBO5Ig9/oiNiKDOzF7Ti7xIND2k18
         W7RaiKTVh90xiET0iKxknUc0zGY644EU3JLJVfXrT45eyc4UivGS/7OFyX5WVIkEWQiA
         ZBES2n7bML9byzNFEzEW+tq5rFiOgwkcX+sINlu5ptvwgzSh2SusbpQdQzw9cTpLf2DM
         dCl5qRenyZ8IZXJ9TuYf7jjHkjI+HUuOIvbF1dpsKLDbp4Ug2UnBY50HCgSLTgSJTnHl
         MiVg==
X-Gm-Message-State: AOAM533ms9u7FSqyGzlhGzfE9fqQlZgI6Wh0OjQJiUAdfL7qeWZwINXf
        3BwG1I3vBAHYA7oXfqTwDrJPRtZZ+ue+OBUvhICZeixSyJuTfN7cP2AbFAkT2NkJK1GGhXWcCNX
        nM7LJwh3sc1tNh5x2DgX/QnHdp/ewAA==
X-Received: by 2002:adf:e488:: with SMTP id i8mr22509317wrm.285.1625584656748;
        Tue, 06 Jul 2021 08:17:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzku1fDOAQdLnC5XD15reX31b2TvZmtZUwP1ceW+OZO4hS0W5Q6FPzoZ9UQ647ToJGgaE3Lyg==
X-Received: by 2002:adf:e488:: with SMTP id i8mr22509297wrm.285.1625584656594;
        Tue, 06 Jul 2021 08:17:36 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id t9sm17042895wrq.92.2021.07.06.08.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 08:17:36 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 4/7] libperf: Move nr_groups to evlist::nr_groups
Date:   Tue,  6 Jul 2021 17:17:01 +0200
Message-Id: <20210706151704.73662-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210706151704.73662-1-jolsa@kernel.org>
References: <20210706151704.73662-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving evsel::nr_groups to perf_evsel::nr_groups, so we can move
the group interface to libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/evlist.h |  1 +
 tools/perf/builtin-record.c              |  2 +-
 tools/perf/builtin-report.c              |  2 +-
 tools/perf/tests/bpf.c                   |  2 +-
 tools/perf/tests/parse-events.c          | 22 +++++++++++-----------
 tools/perf/tests/pfm.c                   |  4 ++--
 tools/perf/util/evlist.c                 |  4 ++--
 tools/perf/util/evlist.h                 |  1 -
 tools/perf/util/header.c                 |  4 ++--
 tools/perf/util/parse-events.c           |  2 +-
 tools/perf/util/pfm.c                    |  2 +-
 11 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index 212c29063ad4..f16fa9877d27 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -16,6 +16,7 @@ struct perf_mmap_param;
 struct perf_evlist {
 	struct list_head	 entries;
 	int			 nr_entries;
+	int			 nr_groups;
 	bool			 has_user_cpus;
 	struct perf_cpu_map	*cpus;
 	struct perf_cpu_map	*all_cpus;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 6a8cc191849f..ee2a5cacbdfc 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1776,7 +1776,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		rec->tool.ordered_events = false;
 	}
 
-	if (!rec->evlist->nr_groups)
+	if (!rec->evlist->core.nr_groups)
 		perf_header__clear_feat(&session->header, HEADER_GROUP_DESC);
 
 	if (data->is_pipe) {
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index f45887eb0910..9a4d8e928f46 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1426,7 +1426,7 @@ int cmd_report(int argc, const char **argv)
 
 	setup_forced_leader(&report, session->evlist);
 
-	if (symbol_conf.group_sort_idx && !session->evlist->nr_groups) {
+	if (symbol_conf.group_sort_idx && !session->evlist->core.nr_groups) {
 		parse_options_usage(NULL, options, "group-sort-idx", 0);
 		ret = -EINVAL;
 		goto error;
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index c72adbd67386..33bda9c26542 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -151,7 +151,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 	}
 
 	evlist__splice_list_tail(evlist, &parse_state.list);
-	evlist->nr_groups = parse_state.nr_groups;
+	evlist->core.nr_groups = parse_state.nr_groups;
 
 	evlist__config(evlist, &opts, NULL);
 
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index a28688b054f5..56a7b6a14195 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -49,7 +49,7 @@ static int test__checkevent_tracepoint(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 0 == evlist->nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 0 == evlist->core.nr_groups);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_TRACEPOINT == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong sample_type",
 		PERF_TP_SAMPLE_TYPE == evsel->core.attr.sample_type);
@@ -62,7 +62,7 @@ static int test__checkevent_tracepoint_multi(struct evlist *evlist)
 	struct evsel *evsel;
 
 	TEST_ASSERT_VAL("wrong number of entries", evlist->core.nr_entries > 1);
-	TEST_ASSERT_VAL("wrong number of groups", 0 == evlist->nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 0 == evlist->core.nr_groups);
 
 	evlist__for_each_entry(evlist, evsel) {
 		TEST_ASSERT_VAL("wrong type",
@@ -668,7 +668,7 @@ static int test__group1(struct evlist *evlist)
 	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->core.nr_groups);
 
 	/* instructions:k */
 	evsel = leader = evlist__first(evlist);
@@ -710,7 +710,7 @@ static int test__group2(struct evlist *evlist)
 	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->core.nr_groups);
 
 	/* faults + :ku modifier */
 	evsel = leader = evlist__first(evlist);
@@ -765,7 +765,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 5 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 2 == evlist->nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 2 == evlist->core.nr_groups);
 
 	/* group1 syscalls:sys_enter_openat:H */
 	evsel = leader = evlist__first(evlist);
@@ -857,7 +857,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->core.nr_groups);
 
 	/* cycles:u + p */
 	evsel = leader = evlist__first(evlist);
@@ -901,7 +901,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 5 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 2 == evlist->nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 2 == evlist->core.nr_groups);
 
 	/* cycles + G */
 	evsel = leader = evlist__first(evlist);
@@ -987,7 +987,7 @@ static int test__group_gh1(struct evlist *evlist)
 	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->core.nr_groups);
 
 	/* cycles + :H group modifier */
 	evsel = leader = evlist__first(evlist);
@@ -1027,7 +1027,7 @@ static int test__group_gh2(struct evlist *evlist)
 	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->core.nr_groups);
 
 	/* cycles + :G group modifier */
 	evsel = leader = evlist__first(evlist);
@@ -1067,7 +1067,7 @@ static int test__group_gh3(struct evlist *evlist)
 	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->core.nr_groups);
 
 	/* cycles:G + :u group modifier */
 	evsel = leader = evlist__first(evlist);
@@ -1107,7 +1107,7 @@ static int test__group_gh4(struct evlist *evlist)
 	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->core.nr_groups);
 
 	/* cycles:G + :uG group modifier */
 	evsel = leader = evlist__first(evlist);
diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
index acd50944f6af..e8fd0da0762b 100644
--- a/tools/perf/tests/pfm.c
+++ b/tools/perf/tests/pfm.c
@@ -96,7 +96,7 @@ static int test__pfm_events(void)
 				count_pfm_events(&evlist->core),
 				table[i].nr_events);
 		TEST_ASSERT_EQUAL(table[i].events,
-				evlist->nr_groups,
+				evlist->core.nr_groups,
 				0);
 
 		evlist__delete(evlist);
@@ -180,7 +180,7 @@ static int test__pfm_group(void)
 				count_pfm_events(&evlist->core),
 				table[i].nr_events);
 		TEST_ASSERT_EQUAL(table[i].events,
-				evlist->nr_groups,
+				evlist->core.nr_groups,
 				table[i].nr_groups);
 
 		evlist__delete(evlist);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 9cb663882273..752f64afd622 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -240,7 +240,7 @@ void __evlist__set_leader(struct list_head *list)
 void evlist__set_leader(struct evlist *evlist)
 {
 	if (evlist->core.nr_entries) {
-		evlist->nr_groups = evlist->core.nr_entries > 1 ? 1 : 0;
+		evlist->core.nr_groups = evlist->core.nr_entries > 1 ? 1 : 0;
 		__evlist__set_leader(&evlist->core.entries);
 	}
 }
@@ -1748,7 +1748,7 @@ bool evlist__exclude_kernel(struct evlist *evlist)
  */
 void evlist__force_leader(struct evlist *evlist)
 {
-	if (!evlist->nr_groups) {
+	if (!evlist->core.nr_groups) {
 		struct evsel *leader = evlist__first(evlist);
 
 		evlist__set_leader(evlist);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 2073cfa79f79..cb2bf5f4866a 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -50,7 +50,6 @@ enum bkw_mmap_state {
 
 struct evlist {
 	struct perf_evlist core;
-	int		 nr_groups;
 	bool		 enabled;
 	int		 id_pos;
 	int		 is_pos;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a1056540c13b..44249027507a 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -778,7 +778,7 @@ static int write_pmu_mappings(struct feat_fd *ff,
 static int write_group_desc(struct feat_fd *ff,
 			    struct evlist *evlist)
 {
-	u32 nr_groups = evlist->nr_groups;
+	u32 nr_groups = evlist->core.nr_groups;
 	struct evsel *evsel;
 	int ret;
 
@@ -2735,7 +2735,7 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 	 * Rebuild group relationship based on the group_desc
 	 */
 	session = container_of(ff->ph, struct perf_session, header);
-	session->evlist->nr_groups = nr_groups;
+	session->evlist->core.nr_groups = nr_groups;
 
 	i = nr = 0;
 	evlist__for_each_entry(session->evlist, evsel) {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6fb1830097cb..f6d77cb44007 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2285,7 +2285,7 @@ int __parse_events(struct evlist *evlist, const char *str,
 	if (!ret) {
 		struct evsel *last;
 
-		evlist->nr_groups += parse_state.nr_groups;
+		evlist->core.nr_groups += parse_state.nr_groups;
 		last = evlist__last(evlist);
 		last->cmdline_group_boundary = true;
 
diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index 6eef6dfeaa57..dd9ed56e0504 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -110,7 +110,7 @@ int parse_libpfm_events_option(const struct option *opt, const char *str,
 				   "cannot close a non-existing event group\n");
 				goto error;
 			}
-			evlist->nr_groups++;
+			evlist->core.nr_groups++;
 			grp_leader = NULL;
 			grp_evt = -1;
 		}
-- 
2.31.1

