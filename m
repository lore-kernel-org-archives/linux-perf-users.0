Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50297C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Nov 2022 13:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiKBNuY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Nov 2022 09:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiKBNuV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Nov 2022 09:50:21 -0400
X-Greylist: delayed 458 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Nov 2022 06:50:19 PDT
Received: from mxus.zte.com.cn (mxus.zte.com.cn [20.69.78.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D950923D
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Nov 2022 06:50:19 -0700 (PDT)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4N2SkR62NzzdmXXP
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Nov 2022 21:42:39 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4N2SkJ06f3z8RTZG;
        Wed,  2 Nov 2022 21:42:32 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2A2DgO4J003202;
        Wed, 2 Nov 2022 21:42:24 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 2 Nov 2022 21:42:28 +0800 (CST)
Date:   Wed, 2 Nov 2022 21:42:28 +0800 (CST)
X-Zmail-TransId: 2af9636273c4ffffffffdcaf2ff3
X-Mailer: Zmail v1.0
Message-ID: <202211022142286140482@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <peterz@infradead.org>
Cc:     <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zhang.songyi@zte.com.cn>,
        <jiang.xuexin@zte.com.cn>, <xue.zhihong@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHBlcmYgc3RhdDogcmVtb3ZlIHJlZHVuZGFudCByZXQgdmFyaWFibGU=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2A2DgO4J003202
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at 10-207-168-8 with ID 636273CE.000 by FangMail milter!
X-FangMail-Envelope: 1667396560/4N2SkR62NzzdmXXP/636273CE.000/192.168.250.137/[192.168.250.137]/mxhk.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 636273CE.000/4N2SkR62NzzdmXXP
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From d377abf9906fa9533d4a31b576ca9aaafdcd7402 Mon Sep 17 00:00:00 2001
From: zhang songyi <zhang.songyi@zte.com.cn>
Date: Wed, 2 Nov 2022 21:10:40 +0800
Subject: [PATCH linux-next] perf stat: remove redundant ret variable

Return value from perf_stat__get_aggr() directly instead of taking this in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 tools/perf/builtin-stat.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e52601a54b26..16dc1d72880e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1355,8 +1355,6 @@ static struct aggr_cpu_id perf_stat__get_cpu(struct perf_stat_config *config __m
 static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
                          aggr_get_id_t get_id, struct perf_cpu cpu)
 {
-   struct aggr_cpu_id id;
-
    /* per-process mode - should use global aggr mode */
    if (cpu.cpu == -1)
        return get_id(config, cpu);
@@ -1364,8 +1362,7 @@ static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
    if (aggr_cpu_id__is_empty(&config->cpus_aggr_map->map[cpu.cpu]))
        config->cpus_aggr_map->map[cpu.cpu] = get_id(config, cpu);

-   id = config->cpus_aggr_map->map[cpu.cpu];
-   return id;
+   return config->cpus_aggr_map->map[cpu.cpu];
 }

 static struct aggr_cpu_id perf_stat__get_socket_cached(struct perf_stat_config *config,
--
2.15.2
