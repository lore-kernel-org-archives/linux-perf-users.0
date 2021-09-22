Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C648CC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 10:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC0A960F44
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 10:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhIVKSS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 06:18:18 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com ([139.138.61.252]:44405 "EHLO
        esa7.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234499AbhIVKSL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 06:18:11 -0400
IronPort-SDR: FeTWYrLK/Q4GpKi4zlGtaRM9NIRwdbZjVEDUrMGuitFBTDhGnVgMG5RvyF8jpK33zCHdc3iJTO
 NjnfNwmJff1tt655UvIpDRMeS5k0oH3mUCmpGOi5OGB7vxn5jE7cyP+6xQa2dBcYXRxRZfdmxJ
 u1+1PYdJGcId3CyXSJN1L0N/t1te6eD9aYcmdrTkSgtKwALjBxSHwRq5ptmZu1v5qm9eswd06M
 YeN/nX7UWxf0+KR1erKj3m2UJO5k3P1KAvqQT5F8pw68zPaIKLNXplXl2ucxESgrMQlYtkL3ht
 3q5j+ZYsA5wZc/SxAcsxNPOB
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="24913021"
X-IronPort-AV: E=Sophos;i="5.85,313,1624287600"; 
   d="scan'208";a="24913021"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP; 22 Sep 2021 19:16:32 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 9A9D6E6800;
        Wed, 22 Sep 2021 19:16:31 +0900 (JST)
Received: from yto-om2.fujitsu.com (yto-om2.o.css.fujitsu.com [10.128.89.163])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id C5ECCFF44;
        Wed, 22 Sep 2021 19:16:30 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-om2.fujitsu.com (Postfix) with ESMTP id A52DE400C007A;
        Wed, 22 Sep 2021 19:16:30 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH v2 1/2] libperf: Add processing to scale the counters obtained during the read() system call when multiplexing
Date:   Wed, 22 Sep 2021 19:16:26 +0900
Message-Id: <20210922101627.3396398-2-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210922101627.3396398-1-nakamura.shun@fujitsu.com>
References: <20210922101627.3396398-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: nakamura shunsuke <nakamura.shun@fujitsu.com>

perf_evsel__read() scales counters obtained by RDPMC during multiplexing, but
does not scale counters obtained by read() system call.

Add processing to perf_evsel__read() to scale the counters obtained during the
read() system call when multiplexing.


Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/evsel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 8441e3e1aaac..0ebd1d34436f 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -18,6 +18,7 @@
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <asm/bug.h>
+#include <linux/math64.h>
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
 		      int idx)
@@ -321,6 +322,11 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 	if (readn(*fd, count->values, size) <= 0)
 		return -errno;
 
+	if (count->ena != count->run) {
+		if (count->run != 0)
+			count->val = mul_u64_u64_div64(count->val, count->ena, count->run);
+	}
+
 	return 0;
 }
 
-- 
2.27.0

