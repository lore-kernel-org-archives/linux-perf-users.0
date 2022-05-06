Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFEDC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 May 2022 06:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389344AbiEFGIM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 May 2022 02:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389349AbiEFGIF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 May 2022 02:08:05 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBA665D03;
        Thu,  5 May 2022 23:04:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VCQNAcq_1651817052;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VCQNAcq_1651817052)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 May 2022 14:04:19 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] x86/events: remove set but not used variable 'hwc'
Date:   Fri,  6 May 2022 14:04:10 +0800
Message-Id: <20220506060410.104036-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Eliminate the follow clang warning:

arch/x86/events/amd/core.c:774:24: warning: variable 'hwc' set but not
used [-Wunused-but-set-variable].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/x86/events/amd/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 47ef8aee15d2..78076904daad 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -771,13 +771,11 @@ static void amd_pmu_enable_event(struct perf_event *event)
 static void amd_pmu_enable_all(int added)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct hw_perf_event *hwc;
 	int idx;
 
 	amd_brs_enable_all();
 
 	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
-		hwc = &cpuc->events[idx]->hw;
 
 		/* only activate events which are marked as active */
 		if (!test_bit(idx, cpuc->active_mask))
-- 
2.20.1.7.g153144c

