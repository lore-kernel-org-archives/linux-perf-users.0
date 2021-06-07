Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ECFC4743F
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 06:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E518A6121D
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 06:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhFGGht (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Jun 2021 02:37:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:7552 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230242AbhFGGht (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Jun 2021 02:37:49 -0400
IronPort-SDR: kMCDUTvk8kbnronzQhDqgJttRqyrJHx6c83qPjaHQklYrswcVsMd36Ohpaw3DkxpvBgldWLRIs
 9+szFXdutzJQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="184251047"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="184251047"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2021 23:35:58 -0700
IronPort-SDR: 6JFMm9SbdzYxAcjOvzePy8ttAA9IqZryiTGG/ecPFtj+XccTZ5uxjRgdx49KaVHi+PtLCjIXZb
 /n32W2dzru7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="447379235"
Received: from power-sh.sh.intel.com ([10.239.48.130])
  by orsmga008.jf.intel.com with ESMTP; 06 Jun 2021 23:35:55 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, artem.bityutskiy@linux.intel.com,
        ak@linux.intel.com, yao.jin@intel.com
Subject: [PATCH] perf/x86/cstate: Add ICELAKE_X and ICELAKE_D support
Date:   Mon,  7 Jun 2021 14:46:03 +0800
Message-Id: <20210607064603.26354-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Introduce icx_cstates for ICELAKE_X and ICELAKE_D, and also update the
comments.

On ICELAKE_X and ICELAKE_D, Core C1, Core C6, Package C2 and Package C6
Residency MSRs are supported.

This patch has been tested on real hardware.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/cstate.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 433399069e27..c6262b154c3a 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -40,7 +40,7 @@
  * Model specific counters:
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
- *			 Available model: SLM,AMT,GLM,CNL,TNT,ADL
+ *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -50,8 +50,8 @@
  *	MSR_CORE_C6_RESIDENCY: CORE C6 Residency Counter
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
- *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL,
- *						TNT,RKL,ADL
+ *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
+ *						TGL,TNT,RKL,ADL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
@@ -61,7 +61,7 @@
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
- *						KBL,CML,ICL,TGL,TNT,RKL,ADL
+ *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
@@ -72,8 +72,8 @@
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
- *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL,
- *						TNT,RKL,ADL
+ *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
+ *						TGL,TNT,RKL,ADL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
@@ -566,6 +566,14 @@ static const struct cstate_model icl_cstates __initconst = {
 				  BIT(PERF_CSTATE_PKG_C10_RES),
 };
 
+static const struct cstate_model icx_cstates __initconst = {
+	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
+				  BIT(PERF_CSTATE_CORE_C6_RES),
+
+	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
+				  BIT(PERF_CSTATE_PKG_C6_RES),
+};
+
 static const struct cstate_model adl_cstates __initconst = {
 	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES) |
@@ -664,6 +672,9 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&icx_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&icx_cstates),
+
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&icl_cstates),
-- 
2.17.1

