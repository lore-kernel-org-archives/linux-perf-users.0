Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE3BC19F20
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 May 2023 22:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjEBWkH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 May 2023 18:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjEBWkD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 May 2023 18:40:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FDE26A9
        for <linux-perf-users@vger.kernel.org>; Tue,  2 May 2023 15:39:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7550dca3so7674248276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 May 2023 15:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067177; x=1685659177;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dIl1kUAo9IYD/UhzcgxFmKKCjB+AQPORsd+rIG9tHuw=;
        b=vlmuRJR29pht0Gp3pNW+5EH0OUu/iLD4+LrJjhclGh+ZyS7JovyFHhS4SNpxGnSS1N
         x892EOk8Wi/p6/5ZpEQEmLXWRhDiM0F2E+3W95Dg4DMllizoLNxZvxxFltLWct8Q8jls
         ezVuzXoF46wy31d5zCVf8OGKlqQaGVFSCfr5xTFyx4I8VSqqAOlw1mcjZhEs9q+CD2Kk
         gpeGdlWr2A6MXpDa4h5iSK54Dpua0MVOnlwKzHIULOnuQsy2xmLnS3zRNATvW9iNn3H0
         nu7FYfNvLyf4IqU+uYkUAhtEzlyizYHtAhHw8DEuHVAVGWpEwa+/3jU7QCpfL0NYySo8
         hBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067177; x=1685659177;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIl1kUAo9IYD/UhzcgxFmKKCjB+AQPORsd+rIG9tHuw=;
        b=bTm8u95sMwhrFCWmTnSVChg7LqX+9Q3IT8RMvsTojYR6KQM+JM2Ic+Q/s9OAJ5jYDK
         oLROz+kotWjyiW/PhPg6oubBS2UWWKe/MUf8AAjvMXA6m/OlOZnJkGUKwtOpWTTaJjlB
         Wb0lB+mNMeRsa6eoHfeM7cwqogfi2IrZetUIdVz5w5B/wyTLk3lXi8MeVbUl/yD8a11V
         ljF7I34pK2uzLXwS0GlAJ+CcQHGu05u0JVt1U8rS5HeFX8AjPpaMPgAEVbMgIL9LcQJL
         PgyEJ7z1PV0BkYxnW4NTXUPddXPaBAZsWTRzqgHIpuMVkUIlu9uArVafrUSHp/bwC4vr
         mfkw==
X-Gm-Message-State: AC+VfDw5NaBDx+EpwZeAmY5v7Ot7nV79g2x7/QWd0rCH1OShtAMWCBbE
        EzkFblOFs54saYJMaYbqbW+K1tDAbkrd
X-Google-Smtp-Source: ACHHUZ658OJAc3DqZHBjuqUr7dv/cjG8MEsPVkZxQ9G6ZD7qckXXN4VR4ZUDntaQKmJ1CB1SF4RKb3ZyaXI+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a25:ea53:0:b0:b99:3b72:39a with SMTP id
 o19-20020a25ea53000000b00b993b72039amr6857243ybe.7.1683067177345; Tue, 02 May
 2023 15:39:37 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:11 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-5-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 04/44] perf parse-events: Don't reorder ungrouped events by pmu
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

The pmu_group_name by default returns "cpu" which on non-hybrid/ARM
means that ungrouped software, and hardware events are all going to
sort by the original insertion index. However, on hybrid and ARM
wildcard expansion may mean the PMU name is set and events will be
unnecessarily reordered - triggering the reordering warning.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d71019dcd614..34ba840ae19a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2140,25 +2140,32 @@ static int evlist__cmp(void *state, const struct list_head *l, const struct list
 	int *leader_idx = state;
 	int lhs_leader_idx = *leader_idx, rhs_leader_idx = *leader_idx, ret;
 	const char *lhs_pmu_name, *rhs_pmu_name;
+	bool lhs_has_group = false, rhs_has_group = false;
 
 	/*
 	 * First sort by grouping/leader. Read the leader idx only if the evsel
 	 * is part of a group, as -1 indicates no group.
 	 */
-	if (lhs_core->leader != lhs_core || lhs_core->nr_members > 1)
+	if (lhs_core->leader != lhs_core || lhs_core->nr_members > 1) {
+		lhs_has_group = true;
 		lhs_leader_idx = lhs_core->leader->idx;
-	if (rhs_core->leader != rhs_core || rhs_core->nr_members > 1)
+	}
+	if (rhs_core->leader != rhs_core || rhs_core->nr_members > 1) {
+		rhs_has_group = true;
 		rhs_leader_idx = rhs_core->leader->idx;
+	}
 
 	if (lhs_leader_idx != rhs_leader_idx)
 		return lhs_leader_idx - rhs_leader_idx;
 
-	/* Group by PMU. Groups can't span PMUs. */
-	lhs_pmu_name = evsel__group_pmu_name(lhs);
-	rhs_pmu_name = evsel__group_pmu_name(rhs);
-	ret = strcmp(lhs_pmu_name, rhs_pmu_name);
-	if (ret)
-		return ret;
+	/* Group by PMU if there is a group. Groups can't span PMUs. */
+	if (lhs_has_group && rhs_has_group) {
+		lhs_pmu_name = evsel__group_pmu_name(lhs);
+		rhs_pmu_name = evsel__group_pmu_name(rhs);
+		ret = strcmp(lhs_pmu_name, rhs_pmu_name);
+		if (ret)
+			return ret;
+	}
 
 	/* Architecture specific sorting. */
 	return arch_evlist__cmp(lhs, rhs);
-- 
2.40.1.495.gc816e09b53d-goog

