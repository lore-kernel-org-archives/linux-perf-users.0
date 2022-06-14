Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F14EC43334
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Jun 2022 10:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiFNKiM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Jun 2022 06:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiFNKiJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Jun 2022 06:38:09 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973E62ED53;
        Tue, 14 Jun 2022 03:38:08 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655203086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h30HHa9jF+uZdIEOGOAgUHK0WvfWButVsj8i2bL6Vio=;
        b=Sh8gtiA1sKFv8/Ql9eFUL/Ok8GiV66l69lGl/WsbFhcgfTSJfEF3pdAfC9Z58sulDCO6nM
        p+t8pBlPRjZbRB9r689/7AwZHFTl2quBZBTHXx/rKSoHDnpdcazCvIHL8zRcZT2w8kOKhT
        sAAdyLrQyOBMOnUnKVSE1V2AnEyrGvg=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] perf/core: fix perf_event_mux_interval_ms when set zero
Date:   Tue, 14 Jun 2022 18:37:51 +0800
Message-Id: <20220614103751.1395645-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The perf_event_mux_interval_ms is set to zero or one by default.
It can't change back when someone changes it from zero to another
value.

Make perf_event_mux_interval_ms to PERF_CPU_HRTIMER when set zero.

Fixes: 62b856397927 ("perf: Add sysfs entry to adjust multiplexing interval per PMU")
Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 kernel/events/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 61ad10862c21..73c8c7462bbf 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10954,9 +10954,12 @@ perf_event_mux_interval_ms_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (timer < 1)
+	if (timer < 0)
 		return -EINVAL;
 
+	if (timer < 1)
+		timer = PERF_CPU_HRTIMER;
+
 	/* same value, noting to do */
 	if (timer == pmu->hrtimer_interval_ms)
 		return count;
-- 
2.25.1

