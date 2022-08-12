Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DF2C00140
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Aug 2022 08:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbiHLIxD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Aug 2022 04:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237911AbiHLIwc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Aug 2022 04:52:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0B6A98FF;
        Fri, 12 Aug 2022 01:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660294340; x=1691830340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=laEOfMe4g1KdqDy6BUWRPxbhDSL3m2f6FSfHTEMjB+U=;
  b=KrmqMT8L+x6U5sNx7ae2JqdM9+GKNrnkXxeHIRYw/iNheAORrMQTlEaX
   Ag/DrNlHk6xgD+W+e4hUIcrdo3nt7RjXCsfH1M8VFi7n8+f1zXg5XEZbl
   kB0X+YPiPFEI3LjzXUbN6iONRxHgW6Cdsx1I3efmvANhdMw4Br8bNcVjj
   1geH8o2OlNgoEci20DxeANYEYbkk5rCjNNXewVjqqfalXN9Na3GbN1ga9
   KHEZt0GYBvk05AdJxfBTcZizTLsn7mPLuBfLRoB5h6Xc/fgtrrYdbL4eV
   iiQNWTE8W8XpWy4zae0JivHZ7GjdlIQCW6CSjJz6e6BVi6/nJNcINUFd+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="292819546"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="292819546"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 01:52:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="602451499"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 12 Aug 2022 01:52:17 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH 09/11] perf vendor events: Update metrics for sapphirerapids
Date:   Fri, 12 Aug 2022 16:52:37 +0800
Message-Id: <20220812085239.3089231-10-zhengjun.xing@linux.intel.com>
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
sapphirerapids.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py

to download and generate the latest events and metrics. Manually copy
the sapphirerapids files into perf.

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
 .../pmu-events/arch/x86/sapphirerapids/spr-metrics.json     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
index b9adef1fb72e..e194dfc5c25b 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
@@ -491,6 +491,12 @@
         "MetricGroup": "SoC",
         "MetricName": "Socket_CLKS"
     },
+    {
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "uncore_cha_0@event\\=0x1@ / #num_dies / duration_time / 1000000000",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ"
+    },
     {
         "BriefDescription": "Instructions per Far Branch ( Far Branches apply upon transition from application to operating system, handling interrupts, exceptions) [lower number means higher occurrence rate]",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
-- 
2.25.1

