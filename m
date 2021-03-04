Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D5AC433DB
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Mar 2021 16:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C5E64F53
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Mar 2021 16:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbhCDQe3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Mar 2021 11:34:29 -0500
Received: from foss.arm.com ([217.140.110.172]:41068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237738AbhCDQeD (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Mar 2021 11:34:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A3FDD6E;
        Thu,  4 Mar 2021 08:33:17 -0800 (PST)
Received: from e125528.arm.com (unknown [10.57.51.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E635D3F766;
        Thu,  4 Mar 2021 08:33:12 -0800 (PST)
From:   Alexandre Truong <alexandre.truong@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Alexandre Truong <alexandre.truong@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Al Grant <al.grant@arm.com>, James Clark <james.clark@arm.com>,
        Wilco Dijkstra <wilco.dijkstra@arm.com>
Subject: [PATCH RESEND WITH CCs v3 2/4] perf tools: add a mechanism to inject stack frames
Date:   Thu,  4 Mar 2021 16:32:53 +0000
Message-Id: <20210304163255.10363-2-alexandre.truong@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210304163255.10363-1-alexandre.truong@arm.com>
References: <20210304163255.10363-1-alexandre.truong@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a mechanism for platforms to inject stack frames for the leaf
frame caller if there is enough information to determine a frame
is missing from dwarf or other post processing mechanisms.

Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Kemeng Shi <shikemeng@huawei.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Al Grant <al.grant@arm.com>
Cc: James Clark <james.clark@arm.com>
Cc: Wilco Dijkstra <wilco.dijkstra@arm.com>
---
 tools/perf/util/machine.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index ab8a6b3e801d..7f03ffa016b0 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2671,6 +2671,12 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
 	return err;
 }
 
+static u64 get_leaf_frame_caller(struct perf_sample *sample __maybe_unused,
+		struct thread *thread __maybe_unused)
+{
+	return 0;
+}
+
 static int thread__resolve_callchain_sample(struct thread *thread,
 					    struct callchain_cursor *cursor,
 					    struct evsel *evsel,
@@ -2687,6 +2693,8 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	int i, j, err, nr_entries;
 	int skip_idx = -1;
 	int first_call = 0;
+	u64 leaf_frame_caller;
+	int pos;
 
 	if (chain)
 		chain_nr = chain->nr;
@@ -2811,6 +2819,21 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 			continue;
 		}
 
+		pos = callchain_param.order == ORDER_CALLEE ? 2 : chain_nr - 2;
+
+		if (i == pos) {
+			leaf_frame_caller = get_leaf_frame_caller(sample, thread);
+
+			if (leaf_frame_caller && leaf_frame_caller != ip) {
+
+				err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, leaf_frame_caller,
+					       false, NULL, NULL, 0);
+				if (err)
+					return (err < 0) ? err : 0;
+			}
+		}
+
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
 				       false, NULL, NULL, 0);
-- 
2.23.0

