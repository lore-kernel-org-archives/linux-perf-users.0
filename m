Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78469C4332F
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Mar 2022 17:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244406AbiCGRUW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Mar 2022 12:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240304AbiCGRUV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Mar 2022 12:20:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB17774847;
        Mon,  7 Mar 2022 09:19:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADB0C153B;
        Mon,  7 Mar 2022 09:19:26 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.41.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E7FA53FA45;
        Mon,  7 Mar 2022 09:19:24 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        anshuman.khandual@arm.com
Cc:     german.gomez@arm.com, leo.yan@linaro.com,
        James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] perf: Add error message for unsupported branch stack cases
Date:   Mon,  7 Mar 2022 17:19:14 +0000
Message-Id: <20220307171917.2555829-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220307171917.2555829-1-james.clark@arm.com>
References: <20220307171917.2555829-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

EOPNOTSUPP is a possible return value when branch stacks are requested
but they aren't enabled in the kernel or hardware. It's also returned if
they aren't supported on the specific event type. The currently printed
error message about sampling/overflow-interrupts is not correct in this
case.

Add a check for branch stacks before sample_period is checked because
sample_period is also set (to the default value) when using branch
stacks.

Before this change (when branch stacks aren't supported):

  perf record -j any
  Error:
  cycles: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'

After this change:

  perf record -j any
  Error:
  cycles: PMU Hardware or event type doesn't support branch stack sampling.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/evsel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 22d3267ce294..4e10a4ec11c7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2909,6 +2909,10 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 	 "No such device - did you specify an out-of-range profile CPU?");
 		break;
 	case EOPNOTSUPP:
+		if (evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK)
+			return scnprintf(msg, size,
+	"%s: PMU Hardware or event type doesn't support branch stack sampling.",
+					 evsel__name(evsel));
 		if (evsel->core.attr.aux_output)
 			return scnprintf(msg, size,
 	"%s: PMU Hardware doesn't support 'aux_output' feature",
-- 
2.28.0

