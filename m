Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3857C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Oct 2022 19:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJDT0l (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Oct 2022 15:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJDT0k (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Oct 2022 15:26:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47BD67C90
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Oct 2022 12:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664911599; x=1696447599;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kUXhM6bWph//WGmBvYwwtURqo/BwSpOkw4u/l8hshPM=;
  b=nmIne8Ww/+YFoOWQ4N6Q5NEilh71Kw/KUXvAXVc8tN+XkFgqT1W6Apzk
   z6vXCwX9dro63ryl10H/W0/dLq5gWPv/bKhGhgCv3xgDVGESdyogoRI9y
   8D4aa0fe2G/cqlfGBmrQHY6YnOAPVm/dQETYgecvItecEkwMk/Zz/YsxG
   ehtbaoTWAKN6T3oudTUYwJxXv8MlvbGX2Caxhsb85CInHuKlooe6Na2v8
   6Ro034ALLJ5AiX40ipchh6KOrwZvhHMRb88CRkpcfLbAxfFWyb03vEEKB
   Hct1wkwFEidCLXYuozX1pOxfbew1oLsUd7pthTf+mWyuWimUlLKRlzNic
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="282718005"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="282718005"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 12:26:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="624052921"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="624052921"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 12:26:39 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf list: Fix title message
Date:   Tue,  4 Oct 2022 12:26:34 -0700
Message-Id: <20221004192634.998984-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf list metricgroups

gives

List of pre-defined events (to be used in -e):

Metric Groups:

Backend
Bad
BadSpec

But that's incorrect of course because metric groups or metrics can only
be specified with -M. So fix the message to say -e or -M

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 744dd3520584..58e1ec1654ef 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -60,7 +60,7 @@ int cmd_list(int argc, const char **argv)
 	setup_pager();
 
 	if (!raw_dump && pager_in_use())
-		printf("\nList of pre-defined events (to be used in -e):\n\n");
+		printf("\nList of pre-defined events (to be used in -e or -M):\n\n");
 
 	if (hybrid_type) {
 		pmu_name = perf_pmu__hybrid_type_to_pmu(hybrid_type);
-- 
2.37.2

