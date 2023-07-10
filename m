Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DE9EB64DC
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Jul 2023 12:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjGJMWI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Jul 2023 08:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjGJMWH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Jul 2023 08:22:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00289FF;
        Mon, 10 Jul 2023 05:22:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF973113E;
        Mon, 10 Jul 2023 05:22:47 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.29.214])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D04C03F67D;
        Mon, 10 Jul 2023 05:22:02 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com
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
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] perf/x86: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS capability
Date:   Mon, 10 Jul 2023 13:21:35 +0100
Message-Id: <20230710122138.1450930-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710122138.1450930-1-james.clark@arm.com>
References: <20230710122138.1450930-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since commit bd2756811766 ("perf: Rewrite core context handling") the
relationship between perf_event_context and PMUs has changed so that
the error scenario that PERF_PMU_CAP_HETEROGENEOUS_CPUS originally
silenced no longer exists.

Remove the capability to avoid confusion that it actually influences
any perf core behavior. This change should be a no-op.

Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/x86/events/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 9d248703cbdd..2353aaf0b248 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2168,7 +2168,6 @@ static int __init init_hw_perf_events(void)
 			hybrid_pmu->pmu = pmu;
 			hybrid_pmu->pmu.type = -1;
 			hybrid_pmu->pmu.attr_update = x86_pmu.attr_update;
-			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_HETEROGENEOUS_CPUS;
 			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_EXTENDED_HW_TYPE;
 
 			err = perf_pmu_register(&hybrid_pmu->pmu, hybrid_pmu->name,
-- 
2.34.1

