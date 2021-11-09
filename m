Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC537C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 11:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B35FE611CC
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 11:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343617AbhKILxe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 06:53:34 -0500
Received: from foss.arm.com ([217.140.110.172]:60822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343609AbhKILx1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 06:53:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94D92ED1;
        Tue,  9 Nov 2021 03:50:41 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 71FA93F7F5;
        Tue,  9 Nov 2021 03:50:39 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/4] perf arm-spe: Update --switch-events docs in perf-record
Date:   Tue,  9 Nov 2021 11:50:18 +0000
Message-Id: <20211109115020.31623-3-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211109115020.31623-1-german.gomez@arm.com>
References: <20211109115020.31623-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Update perf-record docs and Arm SPE recording options so that they are
consistent. This includes supporting the --no-switch-events flag in Arm
SPE as well.

Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/Documentation/perf-record.txt | 2 +-
 tools/perf/arch/arm64/util/arm-spe.c     | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 2d7df8703..3cf7bac67 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -469,7 +469,7 @@ This option sets the time out limit. The default value is 500 ms.
 
 --switch-events::
 Record context switch events i.e. events of type PERF_RECORD_SWITCH or
-PERF_RECORD_SWITCH_CPU_WIDE. In some cases (e.g. Intel PT or CoreSight)
+PERF_RECORD_SWITCH_CPU_WIDE. In some cases (e.g. Intel PT, CoreSight or Arm SPE)
 switch events will be enabled automatically, which can be suppressed by
 by the option --no-switch-events.
 
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 58ba8d15c..725a06cd2 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -169,8 +169,10 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	if (!perf_cpu_map__empty(cpus)) {
 		evsel__set_sample_bit(tracking_evsel, TIME);
 		evsel__set_sample_bit(tracking_evsel, CPU);
+
 		/* also track task context switch */
-		tracking_evsel->core.attr.context_switch = 1;
+		if (!record_opts__no_switch_events(opts))
+			tracking_evsel->core.attr.context_switch = 1;
 	}
 
 	return 0;
-- 
2.25.1

