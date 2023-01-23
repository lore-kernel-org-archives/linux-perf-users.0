Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1122AC38142
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Jan 2023 13:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjAWNAS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Jan 2023 08:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjAWNAS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Jan 2023 08:00:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F31810E9;
        Mon, 23 Jan 2023 05:00:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4662143D;
        Mon, 23 Jan 2023 05:00:57 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.50.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E36FC3F64C;
        Mon, 23 Jan 2023 05:00:10 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V8 1/6] drivers: perf: arm_pmu: Add new sched_task() callback
Date:   Mon, 23 Jan 2023 18:29:51 +0530
Message-Id: <20230123125956.1350336-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123125956.1350336-1-anshuman.khandual@arm.com>
References: <20230123125956.1350336-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This adds armpmu_sched_task(), as generic pmu's sched_task() override which
in turn can utilize a new arm_pmu.sched_task() callback when available from
the arm_pmu instance. This new callback will be used while enabling BRBE in
ARMV8 PMU.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/perf/arm_pmu.c       | 9 +++++++++
 include/linux/perf/arm_pmu.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 9b593f985805..14a3ed3bdb0b 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -517,6 +517,14 @@ static int armpmu_event_init(struct perf_event *event)
 	return __hw_perf_event_init(event);
 }
 
+static void armpmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+{
+	struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
+
+	if (armpmu->sched_task)
+		armpmu->sched_task(pmu_ctx, sched_in);
+}
+
 static void armpmu_enable(struct pmu *pmu)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(pmu);
@@ -873,6 +881,7 @@ struct arm_pmu *armpmu_alloc(void)
 	}
 
 	pmu->pmu = (struct pmu) {
+		.sched_task	= armpmu_sched_task,
 		.pmu_enable	= armpmu_enable,
 		.pmu_disable	= armpmu_disable,
 		.event_init	= armpmu_event_init,
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index ef914a600087..2a9d07cee927 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -101,6 +101,7 @@ struct arm_pmu {
 	void		(*reset)(void *);
 	int		(*map_event)(struct perf_event *event);
 	bool		(*filter)(struct pmu *pmu, int cpu);
+	void		(*sched_task)(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
 	int		num_events;
 	bool		secure_access; /* 32-bit ARM only */
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
-- 
2.25.1

