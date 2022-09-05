Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1B6ECAAD5
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Sep 2022 05:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiIEFn1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Sep 2022 01:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbiIEFnX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Sep 2022 01:43:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75C802F653;
        Sun,  4 Sep 2022 22:43:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C992D6E;
        Sun,  4 Sep 2022 22:43:21 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1985E3F73D;
        Sun,  4 Sep 2022 22:43:38 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH V2 3/4] arm64/perf: Assert all platform event flags are within PERF_EVENT_FLAG_ARCH
Date:   Mon,  5 Sep 2022 11:12:38 +0530
Message-Id: <20220905054239.324029-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905054239.324029-1-anshuman.khandual@arm.com>
References: <20220905054239.324029-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Ensure all platform specific event flags are within PERF_EVENT_FLAG_ARCH.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/perf/arm_spe_pmu.c   | 4 +++-
 include/linux/perf/arm_pmu.h | 9 +++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index b65a7d9640e1..db8a0a841062 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -44,7 +44,9 @@
  * This allows us to perform the check, i.e, perfmon_capable(),
  * in the context of the event owner, once, during the event_init().
  */
-#define SPE_PMU_HW_FLAGS_CX			BIT(0)
+#define SPE_PMU_HW_FLAGS_CX			0x00001
+
+static_assert((PERF_EVENT_FLAG_ARCH & SPE_PMU_HW_FLAGS_CX) == SPE_PMU_HW_FLAGS_CX);
 
 static void set_spe_event_has_cx(struct perf_event *event)
 {
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 0407a38b470a..0356cb6a215d 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -24,10 +24,11 @@
 /*
  * ARM PMU hw_event flags
  */
-/* Event uses a 64bit counter */
-#define ARMPMU_EVT_64BIT		1
-/* Event uses a 47bit counter */
-#define ARMPMU_EVT_47BIT		2
+#define ARMPMU_EVT_64BIT		0x00001 /* Event uses a 64bit counter */
+#define ARMPMU_EVT_47BIT		0x00002 /* Event uses a 47bit counter */
+
+static_assert((PERF_EVENT_FLAG_ARCH & ARMPMU_EVT_64BIT) == ARMPMU_EVT_64BIT);
+static_assert((PERF_EVENT_FLAG_ARCH & ARMPMU_EVT_47BIT) == ARMPMU_EVT_47BIT);
 
 #define HW_OP_UNSUPPORTED		0xFFFF
 #define C(_x)				PERF_COUNT_HW_CACHE_##_x
-- 
2.25.1

