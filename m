Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3992DEB64DC
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Jul 2023 00:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjGSASp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 18 Jul 2023 20:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjGSASo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 Jul 2023 20:18:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577CD136
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Jul 2023 17:18:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57a43b50c2fso42643437b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Jul 2023 17:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689725922; x=1692317922;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EzZfmowfpaOAxfw4qEjYh3Dd4yzwOwjsuGJmX6Wkr1Y=;
        b=JlGx8OjDED/9mGbeDU0purblcp19YsAhhm1yfmMZ5AxoB5/YnBIVJ/U+xIe03wLKmZ
         KF045vV6VIxDYj67PwbuF6ceSylQbxVCDPbUn9W+wXvL/fdkQPPQNXt6qOzJd0aioqru
         LL55ddw9h6A+ybAxScavuNT3dw4seXKoJ4LOIjLjVxHs6TAw7NpQbdssGguG+n60DshU
         iUD522FEt7WLwEErStpyo+Dp1IgZFHnwau4a9j4FI7Wc/CzQ0HVo9GevlpRV6tFjPdxQ
         aT4XxWx40ZtmI31Koarzs2xCPGSXSj6nUoHSxwvI630sTTaZpZ5CJn3n+/PSAx0wXvxH
         7ZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689725922; x=1692317922;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzZfmowfpaOAxfw4qEjYh3Dd4yzwOwjsuGJmX6Wkr1Y=;
        b=JxTle1jrNVI3bH7o+Tqst5Lq8g754AgstCh0lpK/++QvSpExgdQu3nv/2BMLk/834h
         GXHqDYktzBFA5IoAceoPPa3VEsfdbj5J1XSkwoh7XjlpGjSEqVQ0rvnuPDvbxLrWyBVn
         ukxhRxJbe+tLlMHBRkHeK5l4RWiOqAsp7I+KuOD7AtS37fWjIuWA1FuSJqYH62zs3x3B
         jiBztLgMLLvFz9lEFZgx5SZviOl+Cm1T5oFlWIluL86thSVP7vdNXUmK7JdsYr917Q61
         XvsXcAMavOcZJ6Mnqb0pRVpchtXfqw0A4a6DV0BBht/av42Xjh+XoX7zmKAoUYv4Nkln
         7gfA==
X-Gm-Message-State: ABy/qLaKDCfXGI03U4smfZqw++pPNKKCzprRw4Zlw8nnKMBcI+NBOG/Q
        772dhRnoawVIV0ArfJ+Y0W5klyLYAjp4
X-Google-Smtp-Source: APBJJlGoqw5slG37ZamIc0FtM+3St0BI0iyNqMpsLcXhIrObXzSVzC4tb8ifO4A5x/NN2TV3wfKqESDC4+Gt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c587:348f:a079:d876])
 (user=irogers job=sendgmr) by 2002:a81:8d51:0:b0:579:fa4c:1f22 with SMTP id
 w17-20020a818d51000000b00579fa4c1f22mr191864ywj.6.1689725922615; Tue, 18 Jul
 2023 17:18:42 -0700 (PDT)
Date:   Tue, 18 Jul 2023 17:18:34 -0700
In-Reply-To: <20230719001836.198363-1-irogers@google.com>
Message-Id: <20230719001836.198363-2-irogers@google.com>
Mime-Version: 1.0
References: <20230719001836.198363-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 1/3] perf parse-events: Extra care around force grouped events
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Perf metric (topdown) events on Intel Icelake+ machines require a
group, however, they may be next to events that don't require a group.
Consider:
cycles,slots,topdown-fe-bound

The cycles event needn't be grouped but slots and topdown-fe-bound
need grouping. Prior to this change, as slots and topdown-fe-bound
need a group forcing and all events share the same PMU, slots and
topdown-fe-bound would be forced into a group with cycles. This is a
bug on two fronts, cycles wasn't supposed to be grouped and cycles
can't be a group leader with a perf metric event.

This change adds recognition that cycles isn't force grouped and so it
shouldn't be force grouped with slots and topdown-fe-bound.

Fixes: a90cc5a9eeab ("perf evsel: Don't let evsel__group_pmu_name() traverse unsorted group")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5dcfbf316bf6..f10760ac1781 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2141,7 +2141,7 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 	int idx = 0, unsorted_idx = -1;
 	struct evsel *pos, *cur_leader = NULL;
 	struct perf_evsel *cur_leaders_grp = NULL;
-	bool idx_changed = false;
+	bool idx_changed = false, cur_leader_force_grouped = false;
 	int orig_num_leaders = 0, num_leaders = 0;
 	int ret;
 
@@ -2182,7 +2182,7 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 		const struct evsel *pos_leader = evsel__leader(pos);
 		const char *pos_pmu_name = pos->group_pmu_name;
 		const char *cur_leader_pmu_name, *pos_leader_pmu_name;
-		bool force_grouped = arch_evsel__must_be_in_group(pos);
+		bool pos_force_grouped = arch_evsel__must_be_in_group(pos);
 
 		/* Reset index and nr_members. */
 		if (pos->core.idx != idx)
@@ -2198,7 +2198,8 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 			cur_leader = pos;
 
 		cur_leader_pmu_name = cur_leader->group_pmu_name;
-		if ((cur_leaders_grp != pos->core.leader && !force_grouped) ||
+		if ((cur_leaders_grp != pos->core.leader &&
+		     (!pos_force_grouped || !cur_leader_force_grouped)) ||
 		    strcmp(cur_leader_pmu_name, pos_pmu_name)) {
 			/* Event is for a different group/PMU than last. */
 			cur_leader = pos;
@@ -2208,9 +2209,14 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 			 * group.
 			 */
 			cur_leaders_grp = pos->core.leader;
+			/*
+			 * Avoid forcing events into groups with events that
+			 * don't need to be in the group.
+			 */
+			cur_leader_force_grouped = pos_force_grouped;
 		}
 		pos_leader_pmu_name = pos_leader->group_pmu_name;
-		if (strcmp(pos_leader_pmu_name, pos_pmu_name) || force_grouped) {
+		if (strcmp(pos_leader_pmu_name, pos_pmu_name) || pos_force_grouped) {
 			/*
 			 * Event's PMU differs from its leader's. Groups can't
 			 * span PMUs, so update leader from the group/PMU
-- 
2.41.0.487.g6d72f3e995-goog

