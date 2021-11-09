Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5E9C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 08:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625FF610A6
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 08:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244608AbhKIJBc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 04:01:32 -0500
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49]:1858 "EHLO
        esa3.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244606AbhKIJBc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 04:01:32 -0500
IronPort-SDR: QN3+8lHmcnryN0CExQNo/cB19mmPsSbq+WxUx9sytPkkfeekt82PjiYHytbgpEJ/pRaSw+qwEY
 MZ5Zm2snHctyh/FW9hbkoaGCuw/KBHzgfJ09opFSxdr3cQ4rED2I+QlH/RQ0O9lSq+xp2sI0E7
 ChyIaGRH2sXC/9E/vXDPaLef2a62wj79uqXD07PirLxviHEkT9CSZo/7VFuvnkQuqB7HB5nnWl
 QsFGIE639CWaFkAVml3nawf6wr6Hjw4ruJVaGbe2jPmyVQ1i6uK7wMQj8cE5Cg1+wCJDgDW0kE
 +jn/81KIWzL/vvElUdLJyeoK
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="51953268"
X-IronPort-AV: E=Sophos;i="5.87,219,1631545200"; 
   d="scan'208";a="51953268"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 09 Nov 2021 17:58:37 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id A39D013E0B1;
        Tue,  9 Nov 2021 17:58:36 +0900 (JST)
Received: from yto-om2.fujitsu.com (yto-om2.o.css.fujitsu.com [10.128.89.163])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id BB08DD5079;
        Tue,  9 Nov 2021 17:58:35 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-om2.fujitsu.com (Postfix) with ESMTP id A014F4007B81B;
        Tue,  9 Nov 2021 17:58:35 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH v3 2/3] libperf: Remove scaling process from perf_mmap__read_self()
Date:   Tue,  9 Nov 2021 17:58:30 +0900
Message-Id: <20211109085831.3770594-3-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211109085831.3770594-1-nakamura.shun@fujitsu.com>
References: <20211109085831.3770594-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Remove the scaling process from perf_mmap__read_self(), and unify the
counters that can be obtained from perf_evsel__read() to "no scaling".

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/mmap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index c89dfa5f67b3..aaa457904008 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -353,8 +353,6 @@ int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count
 		count->ena += delta;
 		if (idx)
 			count->run += delta;
-
-		cnt = mul_u64_u64_div64(cnt, count->ena, count->run);
 	}
 
 	count->val = cnt;
-- 
2.27.0

