Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B24C433ED
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 May 2021 14:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E2D86109F
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 May 2021 14:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhERO2X (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 18 May 2021 10:28:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:5998 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230393AbhERO2X (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 May 2021 10:28:23 -0400
IronPort-SDR: gEd1fJsuXUBuXMz+KEUuKoQLudXm0SOsBmP56sCPGWG3NTRJ/PC3LvqEuEwgA1P2awL4GpaJGi
 rf2dWnTl6j9Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="221776741"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="221776741"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 07:27:04 -0700
IronPort-SDR: nvYy8cUBMtkdKxFc1dNdWGvE0e9nYapYZKo7mUpXFukhrFYKyNrzwWbWjO2e28uZTkjv9Jieyl
 LteE3oZkyspw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="472978466"
Received: from clx-ap-likexu.sh.intel.com ([10.239.48.108])
  by orsmga001.jf.intel.com with ESMTP; 18 May 2021 07:27:01 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <like.xu@linux.intel.com>
Subject: [PATCH v3 1/2] perf/x86: Skip checking x86_pmu.lbr_tos if it doesn't exist
Date:   Tue, 18 May 2021 22:26:11 +0800
Message-Id: <20210518142612.200111-1-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The Architecture LBR does not have MSR_LBR_TOS (0x000001c9).
In a guest that should support Architecture LBR, check_msr()
will be a non-related check for the architecture MSR 0x0
(IA32_P5_MC_ADDR) that is also not supported by KVM.

The failure will cause x86_pmu.lbr_nr = 0, thereby preventing
the initialization of the guest Arch LBR. Fix it by avoiding
this extraneous check in intel_pmu_init() for Arch LBR.

Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
v2->v3 Changelog:
- Make it simpler.

 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2521d03de5e0..e28892270c58 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6253,7 +6253,7 @@ __init int intel_pmu_init(void)
 	 * Check all LBT MSR here.
 	 * Disable LBR access if any LBR MSRs can not be accessed.
 	 */
-	if (x86_pmu.lbr_nr && !check_msr(x86_pmu.lbr_tos, 0x3UL))
+	if (x86_pmu.lbr_tos && !check_msr(x86_pmu.lbr_tos, 0x3UL))
 		x86_pmu.lbr_nr = 0;
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		if (!(check_msr(x86_pmu.lbr_from + i, 0xffffUL) &&
-- 
2.31.1

