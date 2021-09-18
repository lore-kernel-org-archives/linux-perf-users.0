Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C61C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 18 Sep 2021 06:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A2661212
	for <linux-perf-users@archiver.kernel.org>; Sat, 18 Sep 2021 06:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239439AbhIRGhM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 18 Sep 2021 02:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbhIRGhF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 18 Sep 2021 02:37:05 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAA8C0613DE
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Sep 2021 23:35:38 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id ci14-20020a056214054e00b0037a75ff56f9so105865594qvb.23
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Sep 2021 23:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ckzNFSPhfMA1t2Vi+glRHyKBCNdGUUQPx2P62c7a3Pk=;
        b=sK0uZaaezdIibUMRu1ykPwvxpP9Jz5PnikGu5xP5uq45ilgSLoP0f93scMb5qbaW0b
         cTWE9G16KraapUSbEnpIU0inGLhtZUMZbfwpOctRQqWukrHMwAt5djiBxWqH8UojceM2
         9D5+2uByO7G49UIGL5FwWXwbUi8LZXsh9FSTBjMC7Qbnu8/ty8oB8pqr5/Ej/lSil8Io
         z9ufio3fwiHUauElycTfqkbDIDW554UtAFCkFDObMXAj7y6+iPuxKfYOQMIOQkROSQWl
         AEFPtQie+eLdVlBIRTQASnSBaJ3Dj5D78dzSLa5oG/bk7pUvu0X+rJrHAv+RyUVlw1Iv
         Zu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ckzNFSPhfMA1t2Vi+glRHyKBCNdGUUQPx2P62c7a3Pk=;
        b=Tf8JVGWvzFRe/1w7t6wYmNx3PSF1RCOO80CVWQkUcQsiLAsdZYuOeCMDB7E14lb2ck
         lIdN6IQFn/IKR5vKOhLEbBKonc2yjG/Jr8IVbceg3mBB5h0MgO6SXYYm/qkbeZTtU97G
         BaV1FdOW/Vdlom2MsnAIlEqEUxuCpClydhY/BYSlC1GpPqLMOgvy3FaY3RVI3zJUh7c+
         m4JZsiXRo7/dYiH1A0jC2qMTq2UWd3YLAykoFZ4thhf8N5ozxfaQjDHywKFkgRLUnbG4
         kuo56IdOF/ohFcVJjMoTMqfYFzjK5fNqS2MhsyXOCsx5MHcLjUfo3OCmpG1yM6i3DsWJ
         rhag==
X-Gm-Message-State: AOAM530SjhGB9lPE7q0MHNir7oka0UN4thE/EDrXtKP+iExQlDDayCCp
        GorZlFcYqgpciwSBBx/ARiYzx2q0SsYs
X-Google-Smtp-Source: ABdhPJyTFowEpO6OkMJaeTce9YidXXdnVXuGLdjoOfFKkZKC0xv/UTjTDd0YkCKBhUH3bAjgsGgCLhx0lfDP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6399:5df3:21d3:3cca])
 (user=irogers job=sendgmr) by 2002:a25:1845:: with SMTP id
 66mr18004929yby.396.1631946937447; Fri, 17 Sep 2021 23:35:37 -0700 (PDT)
Date:   Fri, 17 Sep 2021 23:35:11 -0700
In-Reply-To: <20210918063513.2356923-1-irogers@google.com>
Message-Id: <20210918063513.2356923-7-irogers@google.com>
Mime-Version: 1.0
References: <20210918063513.2356923-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v8 6/8] perf metric: Allow metrics with no events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

A metric may be a constant value, for example, some SMT metrics are
constant 0 if #smt_on is 0. If we eliminate all the events then there is
no printing. Fix this by forcing metrics like this to have a
duration_time tool event, previously the metric would fail when parsing
the events with a parse error.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 109 ++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 50 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 046fb3fe1700..34956977e907 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -198,65 +198,69 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 	struct evsel *ev, *current_leader = NULL;
 	struct expr_id_data *val_ptr;
 	int i = 0, matched_events = 0, events_to_match;
-	const int idnum = (int)hashmap__size(pctx->ids);
+	int idnum = (int)hashmap__size(pctx->ids);
 
-	/*
-	 * duration_time is always grouped separately, when events are grouped
-	 * (ie has_constraint is false) then ignore it in the matching loop and
-	 * add it to metric_events at the end.
-	 */
-	if (!has_constraint &&
-	    hashmap__find(pctx->ids, "duration_time", (void **)&val_ptr))
-		events_to_match = idnum - 1;
-	else
-		events_to_match = idnum;
-
-	evlist__for_each_entry (perf_evlist, ev) {
+	if (idnum != 0) {
 		/*
-		 * Events with a constraint aren't grouped and match the first
-		 * events available.
+		 * duration_time is always grouped separately, when events are
+		 * grouped (ie has_constraint is false) then ignore it in the
+		 * matching loop and add it to metric_events at the end.
 		 */
-		if (has_constraint && ev->weak_group)
-			continue;
-		/* Ignore event if already used and merging is disabled. */
-		if (metric_no_merge && test_bit(ev->core.idx, evlist_used))
-			continue;
-		if (!has_constraint && !evsel__has_leader(ev, current_leader)) {
+		events_to_match = idnum;
+		if (!has_constraint && hashmap__find(pctx->ids, "duration_time", (void **)&val_ptr))
+			events_to_match--;
+
+		evlist__for_each_entry(perf_evlist, ev) {
+			/*
+			 * Events with a constraint aren't grouped and match the
+			 * first events available.
+			 */
+			if (has_constraint && ev->weak_group)
+				continue;
+			/* Ignore event if already used and merging is disabled. */
+			if (metric_no_merge && test_bit(ev->core.idx, evlist_used))
+				continue;
+			if (!has_constraint && !evsel__has_leader(ev, current_leader)) {
+				/*
+				 * Start of a new group, discard the whole match
+				 * and start again.
+				 */
+				matched_events = 0;
+				memset(metric_events, 0, sizeof(struct evsel *) * idnum);
+				current_leader = evsel__leader(ev);
+			}
 			/*
-			 * Start of a new group, discard the whole match and
-			 * start again.
+			 * Check for duplicate events with the same name. For
+			 * example, uncore_imc/cas_count_read/ will turn into 6
+			 * events per socket on skylakex. Only the first such
+			 * event is placed in metric_events. If events aren't
+			 * grouped then this also ensures that the same event in
+			 * different sibling groups aren't both added to
+			 * metric_events.
 			 */
-			matched_events = 0;
-			memset(metric_events, 0,
-				sizeof(struct evsel *) * idnum);
-			current_leader = evsel__leader(ev);
+			if (contains_event(metric_events, matched_events, ev->name))
+				continue;
+			/* Does this event belong to the parse context? */
+			if (hashmap__find(pctx->ids, ev->name, (void **)&val_ptr))
+				metric_events[matched_events++] = ev;
+
+			if (matched_events == events_to_match)
+				break;
 		}
+	} else {
 		/*
-		 * Check for duplicate events with the same name. For example,
-		 * uncore_imc/cas_count_read/ will turn into 6 events per socket
-		 * on skylakex. Only the first such event is placed in
-		 * metric_events. If events aren't grouped then this also
-		 * ensures that the same event in different sibling groups
-		 * aren't both added to metric_events.
+		 * There are no events to match, but we need to associate the
+		 * metric with an event for printing. A duration_time event was
+		 * parsed for this.
 		 */
-		if (contains_event(metric_events, matched_events, ev->name))
-			continue;
-		/* Does this event belong to the parse context? */
-		if (hashmap__find(pctx->ids, ev->name, (void **)&val_ptr))
-			metric_events[matched_events++] = ev;
-
-		if (matched_events == events_to_match)
-			break;
+		idnum = 1;
+		events_to_match = 0;
 	}
-
 	if (events_to_match != idnum) {
 		/* Add the first duration_time. */
-		evlist__for_each_entry(perf_evlist, ev) {
-			if (!strcmp(ev->name, "duration_time")) {
-				metric_events[matched_events++] = ev;
-				break;
-			}
-		}
+		ev = evlist__find_evsel_by_str(perf_evlist, "duration_time");
+		if (ev)
+			metric_events[matched_events++] = ev;
 	}
 
 	if (matched_events != idnum) {
@@ -320,9 +324,10 @@ static int metricgroup__setup_events(struct list_head *groups,
 	list_for_each_entry (m, groups, nd) {
 		struct evsel **metric_events;
 		struct metric_ref *metric_refs = NULL;
+		const size_t ids_size = hashmap__size(m->pctx->ids);
 
 		metric_events = calloc(sizeof(void *),
-				hashmap__size(m->pctx->ids) + 1);
+				ids_size == 0 ? 2 : ids_size + 1);
 		if (!metric_events) {
 			ret = -ENOMEM;
 			break;
@@ -1240,7 +1245,11 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 		goto out;
 	pr_debug("adding %s\n", extra_events.buf);
 	bzero(&parse_error, sizeof(parse_error));
-	ret = __parse_events(perf_evlist, extra_events.buf, &parse_error, fake_pmu);
+	ret = __parse_events(perf_evlist,
+			extra_events.len > 0
+			? extra_events.buf
+			: "duration_time",
+			&parse_error, fake_pmu);
 	if (ret) {
 		parse_events_print_error(&parse_error, extra_events.buf);
 		goto out;
-- 
2.33.0.464.g1972c5931b-goog

