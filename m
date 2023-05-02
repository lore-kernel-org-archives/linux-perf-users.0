Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20923C77B75
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 May 2023 22:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjEBWmb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 May 2023 18:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjEBWmG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 May 2023 18:42:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18A93C19
        for <linux-perf-users@vger.kernel.org>; Tue,  2 May 2023 15:41:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7e3fc659so9915601276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 May 2023 15:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067295; x=1685659295;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7D6E0hATCK7e1RhJ0eODuZwXaDaxrE5gp17wu1kd6s=;
        b=D/bkUj+CvVAC7aYfNgnj4KG5nYd3eTAqh9e6DM0gZZCoQjFlJnRsvX7S3ZBoM9MfVM
         KovVZNSKZIy2UKW3qeC63Thp8iWn9rHXFjDF1VBowQR1A9soWiwMrXhk3BKdOYLbxIHi
         iy2ENXEPlZWq6HdDGDMhx6Fp+UZyezvplvUvthMQ3yN0+8U1X0zMaAvbBHvjg2hEzSGA
         8RC+TbU+v1BSw9c8YFFtAevtcRnNXp+uQh7oL0j0PWWa7H+9zbM0fQaAiO6xVNMKOSC9
         E/0k/1HdFn9HJrPvmmkZgc7CzWtGHCF3DM03VK8bXN+3zyxaRJG7karDc8BdJ147CuHc
         aKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067295; x=1685659295;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7D6E0hATCK7e1RhJ0eODuZwXaDaxrE5gp17wu1kd6s=;
        b=IkRPMCVo2m7LYBqmBBL6ylCnUPI0EMoKtywGXQSLbboekarA9dFv5cyUJhUpJJrA7r
         JTECPuGanzA2Su+ePSlaB+xNgqf+m7ftpGp07dHAYXAGJfhArvhs/ciNl1b3gE21AXgn
         AfEWdx2RhZJFM9Z2wkpIquKisT0XP8isXIHYHAYqsxI/+eNMvW0SiMomsgXutn0CE3xm
         BBq5rqzx6xoFqklusd+SeiBG8XLHaIyYpFC6P7TYY8sL24krFq7g23uv4ge6I5UrEcGa
         aHYb35v79Xt5Ajo/Lv2dKOvGZ1rZNjhqIk17rEhPrHdAuodBCa0WJjcqhI0dpWak3QT1
         MoTw==
X-Gm-Message-State: AC+VfDw3xU/uK9L7TywOk2tj41bOyPCS4h5oJHpf0f+7mB0R570k/qvl
        0JC5htGH9Sw4sasCa8/AXJjikcvzOOK0
X-Google-Smtp-Source: ACHHUZ7LYH229NyKNMZkZWsQienaXd755Yu/epnis0xg39gsfR3yA6p0IrF5aj4wIWeZaeopiMz6DL1RqYce
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a25:d08a:0:b0:b99:34c:ab15 with SMTP id
 h132-20020a25d08a000000b00b99034cab15mr7544350ybg.1.1683067295712; Tue, 02
 May 2023 15:41:35 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:26 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-20-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 19/44] perf evsel: Modify group pmu name for software events
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If we have a group of {cycles,faults} then we need the faults software
event to appear to be on the same PMU as cycles so that we don't split
the group in parse_events__sort_events_and_fix_groups. This case is
relatively easy as cycles is the leader and will have a PMU name. In
the reverse case, {faults,cycles} we still need faults to appear to
have the PMU name of cycles but the old behavior is just to return
"cpu". For hybrid this fails as cycles will be on "cpu_core" or
"cpu_atom", causing faults to be split into a different group.

Change the behavior for software events so that the whole group is
searched for the named PMU.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1cd04b5998d2..63522322e118 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -829,23 +829,26 @@ bool evsel__name_is(struct evsel *evsel, const char *name)
 
 const char *evsel__group_pmu_name(const struct evsel *evsel)
 {
-	const struct evsel *leader;
+	struct evsel *leader, *pos;
 
 	/* If the pmu_name is set use it. pmu_name isn't set for CPU and software events. */
 	if (evsel->pmu_name)
 		return evsel->pmu_name;
 	/*
 	 * Software events may be in a group with other uncore PMU events. Use
-	 * the pmu_name of the group leader to avoid breaking the software event
-	 * out of the group.
+	 * the pmu_name of the first non-software event to avoid breaking the
+	 * software event out of the group.
 	 *
 	 * Aux event leaders, like intel_pt, expect a group with events from
 	 * other PMUs, so substitute the AUX event's PMU in this case.
 	 */
 	leader  = evsel__leader(evsel);
-	if ((evsel->core.attr.type == PERF_TYPE_SOFTWARE || evsel__is_aux_event(leader)) &&
-	    leader->pmu_name) {
-		return leader->pmu_name;
+	if (evsel->core.attr.type == PERF_TYPE_SOFTWARE || evsel__is_aux_event(leader)) {
+		/* Starting with the leader, find the first event with a named PMU. */
+		for_each_group_evsel(pos, leader) {
+			if (pos->pmu_name)
+				return pos->pmu_name;
+		}
 	}
 
 	return "cpu";
-- 
2.40.1.495.gc816e09b53d-goog

