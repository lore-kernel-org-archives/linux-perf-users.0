Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA382C001DE
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Jul 2023 13:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjGXNs1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Jul 2023 09:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjGXNsK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Jul 2023 09:48:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B14D849D7;
        Mon, 24 Jul 2023 06:45:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 778B015BF;
        Mon, 24 Jul 2023 06:46:05 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9A1823F67D;
        Mon, 24 Jul 2023 06:45:19 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com,
        anshuman.khandual@arm.com, will@kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/4] arm_pmu: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS capability
Date:   Mon, 24 Jul 2023 14:44:58 +0100
Message-Id: <20230724134500.970496-4-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724134500.970496-1-james.clark@arm.com>
References: <20230724134500.970496-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since commit bd2756811766 ("perf: Rewrite core context handling") the
relationship between perf_event_context and PMUs has changed so that
the error scenario that PERF_PMU_CAP_HETEROGENEOUS_CPUS originally
silenced no longer exists.

Remove the capability and associated comment to avoid confusion that it
actually influences any perf core behavior. This change should be a
no-op.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/perf/arm_pmu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 2e79201daa4a..d712a19e47ac 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -877,15 +877,12 @@ struct arm_pmu *armpmu_alloc(void)
 		.attr_groups	= pmu->attr_groups,
 		/*
 		 * This is a CPU PMU potentially in a heterogeneous
-		 * configuration (e.g. big.LITTLE). This is not an uncore PMU,
-		 * and we have taken ctx sharing into account (e.g. with our
-		 * pmu::filter callback and pmu::event_init group validation).
-		 *
+		 * configuration (e.g. big.LITTLE) so
 		 * PERF_PMU_CAP_EXTENDED_HW_TYPE is required to open
 		 * PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE events on a
 		 * specific PMU.
 		 */
-		.capabilities	= PERF_PMU_CAP_HETEROGENEOUS_CPUS | PERF_PMU_CAP_EXTENDED_REGS |
+		.capabilities	= PERF_PMU_CAP_EXTENDED_REGS |
 				  PERF_PMU_CAP_EXTENDED_HW_TYPE,
 	};
 
-- 
2.34.1

