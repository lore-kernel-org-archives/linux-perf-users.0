Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6148EC4338F
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Jul 2021 09:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B7F60F9C
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Jul 2021 09:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhG1JMh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Jul 2021 05:12:37 -0400
Received: from foss.arm.com ([217.140.110.172]:53442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231392AbhG1JMd (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Jul 2021 05:12:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC48D1FB;
        Wed, 28 Jul 2021 02:12:31 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6384C3F73D;
        Wed, 28 Jul 2021 02:12:30 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mike.leach@linaro.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH] tools: perf: Report collisions in AUX records
Date:   Wed, 28 Jul 2021 10:12:19 +0100
Message-Id: <20210728091219.527886-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210723124456.3828769-1-suzuki.poulose@arm.com>
References: <20210723124456.3828769-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Just like the other flags in the AUX records, report a summary
of the Collisions if there were any.

Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: linux-perf-users@vger.kernel.org
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 tools/perf/util/events_stats.h | 1 +
 tools/perf/util/session.c      | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/tools/perf/util/events_stats.h b/tools/perf/util/events_stats.h
index 3480bafd414b..1b0006092265 100644
--- a/tools/perf/util/events_stats.h
+++ b/tools/perf/util/events_stats.h
@@ -30,6 +30,7 @@ struct events_stats {
 	u64 total_lost_samples;
 	u64 total_aux_lost;
 	u64 total_aux_partial;
+	u64 total_aux_collision;
 	u64 total_invalid_chains;
 	u32 nr_events[PERF_RECORD_HEADER_MAX];
 	u32 nr_lost_warned;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 51f727402912..59b6c3fe0d01 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1540,6 +1540,8 @@ static int machines__deliver_event(struct machines *machines,
 				evlist->stats.total_aux_lost += 1;
 			if (event->aux.flags & PERF_AUX_FLAG_PARTIAL)
 				evlist->stats.total_aux_partial += 1;
+			if (event->aux.flags & PERF_AUX_FLAG_COLLISION)
+				evlist->stats.total_aux_collision += 1;
 		}
 		return tool->aux(tool, event, sample, machine);
 	case PERF_RECORD_ITRACE_START:
@@ -1895,6 +1897,13 @@ static void perf_session__warn_about_errors(const struct perf_session *session)
 			    "");
 	}
 
+	if (session->tool->aux == perf_event__process_aux &&
+	    stats->total_aux_collision != 0) {
+		ui__warning("AUX data detected collision  %" PRIu64 " times out of %u!\n\n",
+			    stats->total_aux_collision,
+			    stats->nr_events[PERF_RECORD_AUX]);
+	}
+
 	if (stats->nr_unknown_events != 0) {
 		ui__warning("Found %u unknown events!\n\n"
 			    "Is this an older tool processing a perf.data "
-- 
2.24.1

