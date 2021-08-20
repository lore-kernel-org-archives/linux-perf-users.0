Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6585C432BE
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 09:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E4961075
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 09:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbhHTJrW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 05:47:22 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com ([207.54.90.48]:14538 "EHLO
        esa2.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237199AbhHTJrV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 05:47:21 -0400
IronPort-SDR: 0Xakdk7MuSXNfZDinnGNv8buX1LtB2QssyPHa9uxphyRmlA6AgGA0fL/l3/EOwzQwEMfrPGfTd
 tejpSoSDes+QdMB3+6A6GgHeuLo3plD8TtuSL9p90uBPvGnJBdBhThX+io3mIXwGfaoQoIda2g
 fnk2qv2caVMlbZLY1VsIJS60/TrYIINKIZWelLRp+AlvzOjbAIZBoO4YUqJJwEWKpnkebdoRS7
 h3cQUN3+9O9Yc8gmYL7oHtmZgz3OPyESRRbQgh6yU8tVFU9V7EfG96r2tTVWzpG9zJYkMuDwp/
 oZvTNT1/HhHGna9tYpaDNASC
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="41008764"
X-IronPort-AV: E=Sophos;i="5.84,337,1620658800"; 
   d="scan'208";a="41008764"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP; 20 Aug 2021 18:39:27 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 09B2B6CCA0;
        Fri, 20 Aug 2021 18:39:26 +0900 (JST)
Received: from oym-om1.fujitsu.com (oym-om1.o.css.fujitsu.com [10.85.58.161])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5618241A0C;
        Fri, 20 Aug 2021 18:39:25 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by oym-om1.fujitsu.com (Postfix) with ESMTP id F33F04011B615;
        Fri, 20 Aug 2021 18:39:24 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 2/3] libperf tests: Fix verbose printing
Date:   Fri, 20 Aug 2021 18:39:07 +0900
Message-Id: <20210820093908.734503-3-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820093908.734503-1-nakamura.shun@fujitsu.com>
References: <20210820093908.734503-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

libperf's verbose printing checks the -v option every time the macro _T_ START
is called.

Since there are currently four libperf tests registered, the macro _T_ START is
called four times, but verbose printing after the second time is not output.

Resets the index of the element processed by getopt() and fix verbose printing
so that it prints in all tests.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/include/internal/tests.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/perf/include/internal/tests.h b/tools/lib/perf/include/internal/tests.h
index 61052099225b..b130a6663ff8 100644
--- a/tools/lib/perf/include/internal/tests.h
+++ b/tools/lib/perf/include/internal/tests.h
@@ -23,6 +23,8 @@ static inline int get_verbose(char **argv, int argc)
 			break;
 		}
 	}
+	optind = 1;
+
 	return verbose;
 }
 
-- 
2.25.1

