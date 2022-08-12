Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3FFC25B0F
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Aug 2022 08:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237733AbiHLIvi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Aug 2022 04:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbiHLIvh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Aug 2022 04:51:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0347EA9257;
        Fri, 12 Aug 2022 01:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660294297; x=1691830297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a0hYsjf9lb5aUXxCyQMN5Po0mqNtfWcfZlLYgfTNcHE=;
  b=WewMFgMi/whYMIH8O5FLBuscKGGwVeDfkCI16+tVwKAZah56pIt4pN5w
   Twff3wwXCocvrLiC+eusgES1Lrcej5gBOdvFbfJaiUGu2WYAoHU8fTHI0
   iHT3L4DIaQLOW4J3Y47GDF2DnQNRnKzaZiBo5yN7a4C8ClOIo8Q6VtOdz
   AALAg4LxEeEaaX0mvC9Rh22uwS9uQ5+uVLP3MsdIqunJNwt/Iam67+uxy
   p+rdg4IsxqDeLaSnMSNUmaeLug8+sMar7tGP57cQXe5esgPyZ5zQh36s7
   hyQDBzKKckGitgOlqSYKWoMQXus3HF2celasRANILV7pDz6LNZ6G/fo1V
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="353297756"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="353297756"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 01:51:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="602451382"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 12 Aug 2022 01:51:32 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH 01/11] perf vendor events: Update metrics for broadwellde
Date:   Fri, 12 Aug 2022 16:52:29 +0800
Message-Id: <20220812085239.3089231-2-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812085239.3089231-1-zhengjun.xing@linux.intel.com>
References: <20220812085239.3089231-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

The metrics are based on TMA 4.4 full, add new metrics “UNCORE_FREQ” for
broadwellde.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py

to download and generate the latest events and metrics. Manually copy
the broadwellde files into perf.

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
 .../perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
index 6789285555f0..b6fdf5ba2c9a 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
@@ -450,6 +450,12 @@
         "MetricGroup": "SoC",
         "MetricName": "Socket_CLKS"
     },
+    {
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "cbox_0@event\\=0x0@ / #num_dies / duration_time / 1000000000",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ"
+    },
     {
         "BriefDescription": "Instructions per Far Branch ( Far Branches apply upon transition from application to operating system, handling interrupts, exceptions) [lower number means higher occurrence rate]",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
-- 
2.25.1

