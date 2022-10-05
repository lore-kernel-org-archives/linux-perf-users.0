Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A27CC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Oct 2022 14:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJEOF0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Oct 2022 10:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJEOFZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Oct 2022 10:05:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CA1A75FD0;
        Wed,  5 Oct 2022 07:05:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48B86113E;
        Wed,  5 Oct 2022 07:05:24 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.3.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 33AEE3F792;
        Wed,  5 Oct 2022 07:05:15 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, acme@kernel.org
Cc:     suzuki.poulose@arm.com, linux-perf-users@vger.kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf test: Fix test_arm_coresight.sh failures on Juno
Date:   Wed,  5 Oct 2022 15:05:08 +0100
Message-Id: <20221005140508.1537277-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This test commonly fails on Arm Juno because the instruction interval
is large enough to miss generating any samples for Perf in system-wide
mode.

Fix this by lowering the interval until a comfortable number of Perf
instructions are generated. The test is still quick to run because only
a small amount of trace is gathered.

Before:

  sudo ./perf test coresight -vvv
  ...
  Recording trace with system wide mode
  Looking at perf.data file for dumping branch samples:
  Looking at perf.data file for reporting branch samples:
  Looking at perf.data file for instruction samples:
  CoreSight system wide testing: FAIL
  ...

After:

  sudo ./perf test coresight -vvv
  ...
  Recording trace with system wide mode
  Looking at perf.data file for dumping branch samples:
  Looking at perf.data file for reporting branch samples:
  Looking at perf.data file for instruction samples:
  CoreSight system wide testing: PASS
  ...

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/shell/test_arm_coresight.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index e4cb4f1806ff..daad786cf48d 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -70,7 +70,7 @@ perf_report_instruction_samples() {
 	#   68.12%  touch    libc-2.27.so   [.] _dl_addr
 	#    5.80%  touch    libc-2.27.so   [.] getenv
 	#    4.35%  touch    ld-2.27.so     [.] _dl_fixup
-	perf report --itrace=i1000i --stdio -i ${perfdata} 2>&1 | \
+	perf report --itrace=i20i --stdio -i ${perfdata} 2>&1 | \
 		egrep " +[0-9]+\.[0-9]+% +$1" > /dev/null 2>&1
 }
 
-- 
2.28.0

