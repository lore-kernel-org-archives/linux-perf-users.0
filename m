Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E93EC4320A
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 09:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D1461051
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 09:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbhHTJrP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 05:47:15 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253]:53237 "EHLO
        esa8.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234846AbhHTJrP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 05:47:15 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Aug 2021 05:47:14 EDT
IronPort-SDR: CZrJBTQRY+uDy5jSxNIqDPf+D9BKQj/zj/4F6ehcQ974l6vs1Krz6Tl8/yii54mh/15uY4VjTF
 1Oy5nMwo6PPW6g943NANjmzuYAyoqj4hj76ev95vx4gf4EJNOiZnYypvdrTsgPcemp53xPYJXy
 zm8oc4ZTrFlSJdqxYBreFGUBTIzIviA79/N7LGIn4FpTY2QHNxC4CK+HLHKSPEmQjbscBLexYj
 woC+8kYCWW6CG+LB7kOsDnOu5Jacp+L5aVywKMD9YC1cYotelWLzNiHRupOpFeGtIebFnbeJcz
 Qn86dnlGE12h7Ue6rSCg5z7l
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="28949079"
X-IronPort-AV: E=Sophos;i="5.84,337,1620658800"; 
   d="scan'208";a="28949079"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 20 Aug 2021 18:39:23 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 70FE16ABE0;
        Fri, 20 Aug 2021 18:39:22 +0900 (JST)
Received: from oym-om1.fujitsu.com (oym-om1.o.css.fujitsu.com [10.85.58.161])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id BE048AA5BB;
        Fri, 20 Aug 2021 18:39:21 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by oym-om1.fujitsu.com (Postfix) with ESMTP id 659504011B615;
        Fri, 20 Aug 2021 18:39:21 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 1/3] libperf: Add processing to scale the counters obtained during the read() system call when multiplexing
Date:   Fri, 20 Aug 2021 18:39:06 +0900
Message-Id: <20210820093908.734503-2-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820093908.734503-1-nakamura.shun@fujitsu.com>
References: <20210820093908.734503-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf_evsel__read() scales counters obtained by RDPMC during multiplexing, but
does not scale counters obtained by read() system call.

Add processing to perf_evsel__read() to scale the counters obtained during the
read() system call when multiplexing.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/evsel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index d8886720e83d..005cf64a1ad7 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -18,6 +18,7 @@
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <asm/bug.h>
+#include <linux/math64.h>
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
 		      int idx)
@@ -308,6 +309,9 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 	if (readn(FD(evsel, cpu, thread), count->values, size) <= 0)
 		return -errno;
 
+	if (count->ena != count->run)
+		count->val = mul_u64_u64_div64(count->val, count->ena, count->run);
+
 	return 0;
 }
 
-- 
2.25.1

