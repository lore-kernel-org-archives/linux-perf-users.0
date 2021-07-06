Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD35C07E9B
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 13:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1472261C30
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 13:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhGFNXj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jul 2021 09:23:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58128 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231989AbhGFNXj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jul 2021 09:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625577660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=44+IODerUsnTozKPPyomEImGXKTAFr5u/z4eqsInlu4=;
        b=PpEsOkWP+CifZUzVDXX9ZJfq8lfGkIE55r7P+9A2JAjgOMa/St94AtoaVIbFdP5zFxpg29
        7xin0KUk7Qrik1hQ2LUBx13dpJ668lVv2zWOtMmwraS18H4DdgBVP+wT9lnnblOmSGch9+
        M2tJxWN4sOHFOp2KCz+2J8IYndpeR5M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-AN9hApmbOoiNFRr0l05V5A-1; Tue, 06 Jul 2021 09:20:57 -0400
X-MC-Unique: AN9hApmbOoiNFRr0l05V5A-1
Received: by mail-wr1-f70.google.com with SMTP id r11-20020a5d52cb0000b02901309f5e7298so3812959wrv.0
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jul 2021 06:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=44+IODerUsnTozKPPyomEImGXKTAFr5u/z4eqsInlu4=;
        b=q9cKA4gs7qWFHzkk9j7d7DwK2nYZEZmuFAnPSG/9rfrMHrYyXO8PRTh0WO5M92r9ge
         lfGXtfK4CAr+cQJEX8JjQk8zjCGOAL+zrH/Vf0te6NA3WI1FhVW9yRdLRADH27RwDqmM
         8uxTVPfT4BdgFBXYp/Jd4okUA02z3Vt/FWLw8zbSfj8h7atUA+dKAeJoYmMIJ3m2g4Ea
         F6RpfEGK0AcFi7m0phyl6N3vJOvxLkR8scY4wPvWD31UIWfChli/N7KKyotNviCIZ8Rm
         3F7uSrXA8jVLXt0N6OOuX7ddGPVxva6QUlJFH40Sbd2tqEsN5HqFwrlIpfcJcvF05E7w
         iuxw==
X-Gm-Message-State: AOAM530SWmK1hHRy36l+za5IuojBJDtlnW7BFZyeg0DyPBunXCJaHD7n
        cAxcsB0JK9J3wlADT342Srv1NMAQ55Gx68rXmfl0aHjAFabJOlmnMy54vBh2jKYQgH7s46iGjk4
        u5XDoQzSJzGoR++mD+S+UIyHDu2ibTQ==
X-Received: by 2002:a1c:1f8a:: with SMTP id f132mr19810033wmf.56.1625577654583;
        Tue, 06 Jul 2021 06:20:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhxScdi1TUqzLlFG2QwNF3FALsNoeYiByAgj6qEw3G/ecZ9JKN2bmKnWJZKNZIy1naL18kbg==
X-Received: by 2002:a1c:1f8a:: with SMTP id f132mr19809979wmf.56.1625577654199;
        Tue, 06 Jul 2021 06:20:54 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id t11sm17119412wrz.7.2021.07.06.06.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 06:20:53 -0700 (PDT)
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
Subject: [PATCH 3/7] libperf: Move leader to perf_evsel::leader
Date:   Tue,  6 Jul 2021 15:20:39 +0200
Message-Id: <20210706132043.70195-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210706132043.70195-1-jolsa@kernel.org>
References: <20210706132043.70195-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving evsel::leader to perf_evsel::leader, so we can move
the group interface to libperf.

Also adding several evsel helpers to ease up the transition:

  struct evsel *evsel__leader(struct evsel *evsel);
  - get leader evsel

  bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
  - true if evsel has leader as leader

  bool evsel__is_leader(struct evsel *evsel);
  - true if evsel is itw own leader

  void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
  - set leader for evsel

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/evsel.c                  |  1 +
 tools/lib/perf/include/internal/evsel.h |  1 +
 tools/perf/builtin-record.c             |  2 +-
 tools/perf/builtin-report.c             |  2 +-
 tools/perf/builtin-script.c             |  9 +++--
 tools/perf/builtin-stat.c               | 12 +++---
 tools/perf/builtin-top.c                |  2 +-
 tools/perf/tests/parse-events.c         | 52 ++++++++++++-------------
 tools/perf/util/auxtrace.c              | 12 +++---
 tools/perf/util/cgroup.c                |  2 +-
 tools/perf/util/evlist.c                | 17 ++++----
 tools/perf/util/evsel.c                 | 29 +++++++++++---
 tools/perf/util/evsel.h                 | 13 ++++---
 tools/perf/util/header.c                |  4 +-
 tools/perf/util/metricgroup.c           |  8 ++--
 tools/perf/util/parse-events.c          |  2 +-
 tools/perf/util/record.c                |  6 +--
 tools/perf/util/stat-shadow.c           |  2 +-
 tools/perf/util/stat.c                  |  2 +-
 19 files changed, 102 insertions(+), 76 deletions(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index dccdc3456b23..3e6638d27c45 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -24,6 +24,7 @@ void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
 	INIT_LIST_HEAD(&evsel->node);
 	evsel->attr = *attr;
 	evsel->idx  = idx;
+	evsel->leader = evsel;
 }
 
 struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr)
diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 86f674e36f62..1f3eacbad2e8 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -45,6 +45,7 @@ struct perf_evsel {
 	struct xyarray		*sample_id;
 	u64			*id;
 	u32			 ids;
+	struct perf_evsel	*leader;
 
 	/* parse modifier helper */
 	int			 nr_members;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 71efe6573ee7..6a8cc191849f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -926,7 +926,7 @@ static int record__open(struct record *rec)
 				goto try_again;
 			}
 			if ((errno == EINVAL || errno == EBADF) &&
-			    pos->leader != pos &&
+			    pos->core.leader != &pos->core &&
 			    pos->weak_group) {
 			        pos = evlist__reset_weak_group(evlist, pos, true);
 				goto try_again;
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 4014de4da33b..f45887eb0910 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -677,7 +677,7 @@ static int report__collapse_hists(struct report *rep)
 
 		/* Non-group events are considered as leader */
 		if (symbol_conf.event_group && !evsel__is_group_leader(pos)) {
-			struct hists *leader_hists = evsel__hists(pos->leader);
+			struct hists *leader_hists = evsel__hists(evsel__leader(pos));
 
 			hists__match(leader_hists, hists);
 			hists__link(leader_hists, hists);
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 2030936cc891..8c03a9862872 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1899,6 +1899,7 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 				       struct perf_sample *sample,
 				       FILE *fp)
 {
+	struct evsel *leader = evsel__leader(evsel);
 	struct perf_stat_output_ctx ctx = {
 		.print_metric = script_print_metric,
 		.new_line = script_new_line,
@@ -1915,7 +1916,7 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 
 	if (!evsel->stats)
 		evlist__alloc_stats(script->session->evlist, false);
-	if (evsel_script(evsel->leader)->gnum++ == 0)
+	if (evsel_script(leader)->gnum++ == 0)
 		perf_stat__reset_shadow_stats();
 	val = sample->period * evsel->scale;
 	perf_stat__update_shadow_stats(evsel,
@@ -1923,8 +1924,8 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 				       sample->cpu,
 				       &rt_stat);
 	evsel_script(evsel)->val = val;
-	if (evsel_script(evsel->leader)->gnum == evsel->leader->core.nr_members) {
-		for_each_group_member (ev2, evsel->leader) {
+	if (evsel_script(leader)->gnum == leader->core.nr_members) {
+		for_each_group_member (ev2, leader) {
 			perf_stat__print_shadow_stats(&stat_config, ev2,
 						      evsel_script(ev2)->val,
 						      sample->cpu,
@@ -1932,7 +1933,7 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 						      NULL,
 						      &rt_stat);
 		}
-		evsel_script(evsel->leader)->gnum = 0;
+		evsel_script(leader)->gnum = 0;
 	}
 }
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f9f74a514315..111192c4c5e0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -248,7 +248,7 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
 		evlist__warn_hybrid_group(evlist);
 
 	evlist__for_each_entry(evlist, evsel) {
-		leader = evsel->leader;
+		leader = evsel__leader(evsel);
 
 		/* Check that leader matches cpus with each member. */
 		if (leader == evsel)
@@ -269,10 +269,10 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
 		}
 
 		for_each_group_evsel(pos, leader) {
-			pos->leader = pos;
+			evsel__set_leader(pos, pos);
 			pos->core.nr_members = 0;
 		}
-		evsel->leader->core.nr_members = 0;
+		evsel->core.leader->nr_members = 0;
 	}
 }
 
@@ -745,8 +745,8 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 		 */
 		counter->errored = true;
 
-		if ((counter->leader != counter) ||
-		    !(counter->leader->core.nr_members > 1))
+		if ((evsel__leader(counter) != counter) ||
+		    !(counter->core.leader->nr_members > 1))
 			return COUNTER_SKIP;
 	} else if (evsel__fallback(counter, errno, msg, sizeof(msg))) {
 		if (verbose > 0)
@@ -839,7 +839,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 				 * Don't close here because we're in the wrong affinity.
 				 */
 				if ((errno == EINVAL || errno == EBADF) &&
-				    counter->leader != counter &&
+				    evsel__leader(counter) != counter &&
 				    counter->weak_group) {
 					evlist__reset_weak_group(evsel_list, counter, false);
 					assert(counter->reset_group);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 76343a418e67..02f8bb5dbc0f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -301,7 +301,7 @@ static void perf_top__resort_hists(struct perf_top *t)
 
 		/* Non-group events are considered as leader */
 		if (symbol_conf.event_group && !evsel__is_group_leader(pos)) {
-			struct hists *leader_hists = evsel__hists(pos->leader);
+			struct hists *leader_hists = evsel__hists(evsel__leader(pos));
 
 			hists__match(leader_hists, hists);
 			hists__link(leader_hists, hists);
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 0f113b2b36a3..a28688b054f5 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -698,7 +698,7 @@ static int test__group1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 2);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
@@ -739,7 +739,7 @@ static int test__group2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
@@ -798,7 +798,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 3);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
@@ -831,7 +831,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
@@ -889,7 +889,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 2);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
@@ -931,7 +931,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
@@ -963,7 +963,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 
 	/* cycles */
@@ -1016,7 +1016,7 @@ static int test__group_gh1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 
 	return 0;
@@ -1056,7 +1056,7 @@ static int test__group_gh2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 
 	return 0;
@@ -1096,7 +1096,7 @@ static int test__group_gh3(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 
 	return 0;
@@ -1136,7 +1136,7 @@ static int test__group_gh4(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 
 	return 0;
@@ -1160,7 +1160,7 @@ static int test__leader_sample1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
 
 	/* cache-misses - not sampling */
@@ -1174,7 +1174,7 @@ static int test__leader_sample1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
 
 	/* branch-misses - not sampling */
@@ -1189,7 +1189,7 @@ static int test__leader_sample1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
 
 	return 0;
@@ -1213,7 +1213,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
 
 	/* branch-misses - not sampling */
@@ -1228,7 +1228,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
 
 	return 0;
@@ -1259,7 +1259,7 @@ static int test__pinned_group(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong pinned", evsel->core.attr.pinned);
 
 	/* cache-misses - can not be pinned, but will go on with the leader */
@@ -1303,7 +1303,7 @@ static int test__exclusive_group(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong exclusive", evsel->core.attr.exclusive);
 
 	/* cache-misses - can not be pinned, but will go on with the leader */
@@ -1530,12 +1530,12 @@ static int test__hybrid_hw_group_event(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0x3c == evsel->core.attr.config);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0xc0 == evsel->core.attr.config);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	return 0;
 }
 
@@ -1546,12 +1546,12 @@ static int test__hybrid_sw_hw_group_event(struct evlist *evlist)
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0x3c == evsel->core.attr.config);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	return 0;
 }
 
@@ -1563,11 +1563,11 @@ static int test__hybrid_hw_sw_group_event(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0x3c == evsel->core.attr.config);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	return 0;
 }
 
@@ -1579,14 +1579,14 @@ static int test__hybrid_group_modifier1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0x3c == evsel->core.attr.config);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0xc0 == evsel->core.attr.config);
-	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	return 0;
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 9350eeb3a3fc..cb19669d2a5b 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -73,8 +73,8 @@ static int evlist__regroup(struct evlist *evlist, struct evsel *leader, struct e
 	grp = false;
 	evlist__for_each_entry(evlist, evsel) {
 		if (grp) {
-			if (!(evsel->leader == leader ||
-			     (evsel->leader == evsel &&
+			if (!(evsel__leader(evsel) == leader ||
+			     (evsel__leader(evsel) == evsel &&
 			      evsel->core.nr_members <= 1)))
 				return -EINVAL;
 		} else if (evsel == leader) {
@@ -87,8 +87,8 @@ static int evlist__regroup(struct evlist *evlist, struct evsel *leader, struct e
 	grp = false;
 	evlist__for_each_entry(evlist, evsel) {
 		if (grp) {
-			if (evsel->leader != leader) {
-				evsel->leader = leader;
+			if (!evsel__has_leader(evsel, leader)) {
+				evsel__set_leader(evsel, leader);
 				if (leader->core.nr_members < 1)
 					leader->core.nr_members = 1;
 				leader->core.nr_members += 1;
@@ -1231,11 +1231,11 @@ static void unleader_evsel(struct evlist *evlist, struct evsel *leader)
 
 	/* Find new leader for the group */
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->leader != leader || evsel == leader)
+		if (!evsel__has_leader(evsel, leader) || evsel == leader)
 			continue;
 		if (!new_leader)
 			new_leader = evsel;
-		evsel->leader = new_leader;
+		evsel__set_leader(evsel, new_leader);
 	}
 
 	/* Update group information */
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index e819a4f30fc2..094aea276d45 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -458,7 +458,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 
 			if (evsel__is_group_leader(pos))
 				leader = evsel;
-			evsel->leader = leader;
+			evsel__set_leader(evsel, leader);
 
 			evlist__add(tmp_list, evsel);
 		}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6563ce3b9541..9cb663882273 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -192,7 +192,7 @@ void evlist__splice_list_tail(struct evlist *evlist, struct list_head *list)
 		}
 
 		__evlist__for_each_entry_safe(list, temp, evsel) {
-			if (evsel->leader == leader) {
+			if (evsel__has_leader(evsel, leader)) {
 				list_del_init(&evsel->core.node);
 				evlist__add(evlist, evsel);
 			}
@@ -233,7 +233,7 @@ void __evlist__set_leader(struct list_head *list)
 	leader->core.nr_members = evsel->core.idx - leader->core.idx + 1;
 
 	__evlist__for_each_entry(list, evsel) {
-		evsel->leader = leader;
+		evsel->core.leader = &leader->core;
 	}
 }
 
@@ -1624,7 +1624,7 @@ void evlist__to_front(struct evlist *evlist, struct evsel *move_evsel)
 		return;
 
 	evlist__for_each_entry_safe(evlist, n, evsel) {
-		if (evsel->leader == move_evsel->leader)
+		if (evsel__leader(evsel) == evsel__leader(move_evsel))
 			list_move_tail(&evsel->core.node, &move);
 	}
 
@@ -1761,7 +1761,8 @@ struct evsel *evlist__reset_weak_group(struct evlist *evsel_list, struct evsel *
 	struct evsel *c2, *leader;
 	bool is_open = true;
 
-	leader = evsel->leader;
+	leader = evsel__leader(evsel);
+
 	pr_debug("Weak group for %s/%d failed\n",
 			leader->name, leader->core.nr_members);
 
@@ -1772,10 +1773,10 @@ struct evsel *evlist__reset_weak_group(struct evlist *evsel_list, struct evsel *
 	evlist__for_each_entry(evsel_list, c2) {
 		if (c2 == evsel)
 			is_open = false;
-		if (c2->leader == leader) {
+		if (evsel__has_leader(c2, leader)) {
 			if (is_open && close)
 				perf_evsel__close(&c2->core);
-			c2->leader = c2;
+			evsel__set_leader(c2, c2);
 			c2->core.nr_members = 0;
 			/*
 			 * Set this for all former members of the group
@@ -2172,13 +2173,13 @@ void evlist__check_mem_load_aux(struct evlist *evlist)
 	 * any valid memory load information.
 	 */
 	evlist__for_each_entry(evlist, evsel) {
-		leader = evsel->leader;
+		leader = evsel__leader(evsel);
 		if (leader == evsel)
 			continue;
 
 		if (leader->name && strstr(leader->name, "mem-loads-aux")) {
 			for_each_group_evsel(pos, leader) {
-				pos->leader = pos;
+				evsel__set_leader(pos, pos);
 				pos->core.nr_members = 0;
 			}
 		}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index cce16814dc2c..f61e5dd53f5d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -241,7 +241,6 @@ void evsel__init(struct evsel *evsel,
 {
 	perf_evsel__init(&evsel->core, attr, idx);
 	evsel->tracking	   = !idx;
-	evsel->leader	   = evsel;
 	evsel->unit	   = "";
 	evsel->scale	   = 1.0;
 	evsel->max_events  = ULONG_MAX;
@@ -409,7 +408,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->cgrp = cgroup__get(orig->cgrp);
 	evsel->tp_format = orig->tp_format;
 	evsel->handler = orig->handler;
-	evsel->leader = orig->leader;
+	evsel->core.leader = orig->core.leader;
 
 	evsel->max_events = orig->max_events;
 	evsel->tool_event = orig->tool_event;
@@ -1074,7 +1073,7 @@ void __weak arch_evsel__set_sample_weight(struct evsel *evsel)
 void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		   struct callchain_param *callchain)
 {
-	struct evsel *leader = evsel->leader;
+	struct evsel *leader = evsel__leader(evsel);
 	struct perf_event_attr *attr = &evsel->core.attr;
 	int track = evsel->tracking;
 	bool per_cpu = opts->target.default_per_cpu && !opts->target.per_thread;
@@ -1592,7 +1591,7 @@ static int evsel__match_other_cpu(struct evsel *evsel, struct evsel *other,
 
 static int evsel__hybrid_group_cpu(struct evsel *evsel, int cpu)
 {
-	struct evsel *leader = evsel->leader;
+	struct evsel *leader = evsel__leader(evsel);
 
 	if ((evsel__is_hybrid(evsel) && !evsel__is_hybrid(leader)) ||
 	    (!evsel__is_hybrid(evsel) && evsel__is_hybrid(leader))) {
@@ -1604,7 +1603,7 @@ static int evsel__hybrid_group_cpu(struct evsel *evsel, int cpu)
 
 static int get_group_fd(struct evsel *evsel, int cpu, int thread)
 {
-	struct evsel *leader = evsel->leader;
+	struct evsel *leader = evsel__leader(evsel);
 	int fd;
 
 	if (evsel__is_group_leader(evsel))
@@ -2850,3 +2849,23 @@ bool evsel__is_hybrid(struct evsel *evsel)
 {
 	return evsel->pmu_name && perf_pmu__is_hybrid(evsel->pmu_name);
 }
+
+struct evsel *evsel__leader(struct evsel *evsel)
+{
+	return container_of(evsel->core.leader, struct evsel, core);
+}
+
+bool evsel__has_leader(struct evsel *evsel, struct evsel *leader)
+{
+	return evsel->core.leader == &leader->core;
+}
+
+bool evsel__is_leader(struct evsel *evsel)
+{
+	return evsel__has_leader(evsel, evsel);
+}
+
+void evsel__set_leader(struct evsel *evsel, struct evsel *leader)
+{
+	evsel->core.leader = &leader->core;
+}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 09c290bce3cc..80383096d51c 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -118,7 +118,6 @@ struct evsel {
 	bool			reset_group;
 	bool			errored;
 	struct hashmap		*per_pkg_mask;
-	struct evsel		*leader;
 	int			err;
 	int			cpu_iter;
 	struct {
@@ -367,7 +366,7 @@ static inline struct evsel *evsel__prev(struct evsel *evsel)
  */
 static inline bool evsel__is_group_leader(const struct evsel *evsel)
 {
-	return evsel->leader == evsel;
+	return evsel->core.leader == &evsel->core;
 }
 
 /**
@@ -405,19 +404,19 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 
 static inline int evsel__group_idx(struct evsel *evsel)
 {
-	return evsel->core.idx - evsel->leader->core.idx;
+	return evsel->core.idx - evsel->core.leader->idx;
 }
 
 /* Iterates group WITHOUT the leader. */
 #define for_each_group_member(_evsel, _leader) 					\
 for ((_evsel) = list_entry((_leader)->core.node.next, struct evsel, core.node); \
-     (_evsel) && (_evsel)->leader == (_leader);					\
+     (_evsel) && (_evsel)->core.leader == (&_leader->core);					\
      (_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
 
 /* Iterates group WITH the leader. */
 #define for_each_group_evsel(_evsel, _leader) 					\
 for ((_evsel) = _leader; 							\
-     (_evsel) && (_evsel)->leader == (_leader);					\
+     (_evsel) && (_evsel)->core.leader == (&_leader->core);					\
      (_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
 
 static inline bool evsel__has_branch_callstack(const struct evsel *evsel)
@@ -462,4 +461,8 @@ int evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
 
 void evsel__zero_per_pkg(struct evsel *evsel);
 bool evsel__is_hybrid(struct evsel *evsel);
+struct evsel *evsel__leader(struct evsel *evsel);
+bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
+bool evsel__is_leader(struct evsel *evsel);
+void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
 #endif /* __PERF_EVSEL_H */
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 9c8efb1898a0..a1056540c13b 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2740,7 +2740,7 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 	i = nr = 0;
 	evlist__for_each_entry(session->evlist, evsel) {
 		if (evsel->core.idx == (int) desc[i].leader_idx) {
-			evsel->leader = evsel;
+			evsel__set_leader(evsel, evsel);
 			/* {anon_group} is a dummy name */
 			if (strcmp(desc[i].name, "{anon_group}")) {
 				evsel->group_name = desc[i].name;
@@ -2758,7 +2758,7 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 			i++;
 		} else if (nr) {
 			/* This is a group member */
-			evsel->leader = leader;
+			evsel__set_leader(evsel, leader);
 
 			nr--;
 		}
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index d956d9cf73f7..99d047c5ead0 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -221,7 +221,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 		/* Ignore event if already used and merging is disabled. */
 		if (metric_no_merge && test_bit(ev->core.idx, evlist_used))
 			continue;
-		if (!has_constraint && ev->leader != current_leader) {
+		if (!has_constraint && !evsel__has_leader(ev, current_leader)) {
 			/*
 			 * Start of a new group, discard the whole match and
 			 * start again.
@@ -229,7 +229,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			matched_events = 0;
 			memset(metric_events, 0,
 				sizeof(struct evsel *) * idnum);
-			current_leader = ev->leader;
+			current_leader = evsel__leader(ev);
 		}
 		/*
 		 * Check for duplicate events with the same name. For example,
@@ -287,8 +287,8 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			 * when then group is left.
 			 */
 			if (!has_constraint &&
-			    ev->leader != metric_events[i]->leader &&
-			    evsel_same_pmu_or_none(ev->leader, metric_events[i]->leader))
+			    ev->core.leader != metric_events[i]->core.leader &&
+			    evsel_same_pmu_or_none(evsel__leader(ev), evsel__leader(metric_events[i])))
 				break;
 			if (!strcmp(metric_events[i]->name, ev->name)) {
 				set_bit(ev->core.idx, evlist_used);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e936c7c02d14..6fb1830097cb 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1800,7 +1800,7 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
 	__evlist__for_each_entry(list, evsel) {
 		if (i >= nr_pmu)
 			i = 0;
-		evsel->leader = (struct evsel *) leaders[i++];
+		evsel__set_leader(evsel, (struct evsel *) leaders[i++]);
 	}
 
 	/* The number of members and group name are same for each group */
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 43e5b563dee8..bff669b615ee 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -25,12 +25,12 @@
  */
 static struct evsel *evsel__read_sampler(struct evsel *evsel, struct evlist *evlist)
 {
-	struct evsel *leader = evsel->leader;
+	struct evsel *leader = evsel__leader(evsel);
 
 	if (evsel__is_aux_event(leader) || arch_topdown_sample_read(leader) ||
 	    is_mem_loads_aux_event(leader)) {
 		evlist__for_each_entry(evlist, evsel) {
-			if (evsel->leader == leader && evsel != evsel->leader)
+			if (evsel__leader(evsel) == leader && evsel != evsel__leader(evsel))
 				return evsel;
 		}
 	}
@@ -53,7 +53,7 @@ static u64 evsel__config_term_mask(struct evsel *evsel)
 static void evsel__config_leader_sampling(struct evsel *evsel, struct evlist *evlist)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
-	struct evsel *leader = evsel->leader;
+	struct evsel *leader = evsel__leader(evsel);
 	struct evsel *read_sampler;
 	u64 term_types, freq_mask;
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 39967a45f55b..34a7f5c1fff7 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -379,7 +379,7 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
 	evlist__for_each_entry(evsel_list, counter) {
 		bool invalid = false;
 
-		leader = counter->leader;
+		leader = evsel__leader(counter);
 		if (!counter->metric_expr)
 			continue;
 
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index d3ec2624e036..09ea334586f2 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -534,7 +534,7 @@ int create_perf_stat_counter(struct evsel *evsel,
 			     int cpu)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
-	struct evsel *leader = evsel->leader;
+	struct evsel *leader = evsel__leader(evsel);
 
 	attr->read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
 			    PERF_FORMAT_TOTAL_TIME_RUNNING;
-- 
2.31.1

