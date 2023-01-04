Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DEFC4708E
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Jan 2023 14:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbjADOwM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 4 Jan 2023 09:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239498AbjADOwE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 4 Jan 2023 09:52:04 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3B66478;
        Wed,  4 Jan 2023 06:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672843924; x=1704379924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=elel7+bS3L05dbWw4U9vGK7LSsvQ2mQBav5PivsMYGo=;
  b=AQvL8bPO2AGewMyQefoysKq8DALbGGbyLOfPYpxf28Vsc5sSoIUOuZwM
   f+ejdKiLt6QiMN/tkV3IGRkW7FdO12TXm1JTUn5z70G1EjMPnxr5+Fjk4
   VGUuTqHixn7wlbeLSU1j7/fzbNg8Mguo/XYGfDA1q3bBdFHtawkW41yEa
   nJA+cR1sV9lz+V/gifWqrqnUT2ZSD2fuHEU6siYsfJRcwBHdtXzcPt7w5
   m+e0q3sXB7pC9LXSIvbkL9ehiMjLECm3c8DTBSxcCyyfA3TodWUsUqUnW
   vJz0K3GjZ8S2OeopWiFrgrf7FM5z2b0jBVUq4tnR0YbSvewcd2+lhD1dx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="384240228"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="384240228"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 06:51:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="900575821"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="900575821"
Received: from power-sh.sh.intel.com ([10.239.183.7])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2023 06:51:38 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@linux.intel.com
Subject: [PATCH 2/2] perf/x86/rapl: Add support for Intel Emerald Rapids
Date:   Wed,  4 Jan 2023 22:58:31 +0800
Message-Id: <20230104145831.25498-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230104145831.25498-1-rui.zhang@intel.com>
References: <20230104145831.25498-1-rui.zhang@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Emerald Rapids RAPL support is the same as previous Sapphire Rapids.
Add Emerald Rapids model for RAPL.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/events/rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 0ef255602aa8..8ccf4a36e386 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -804,6 +804,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&model_spr),
+	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&model_spr),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&model_skl),
-- 
2.25.1

