Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DE9C433F5
	for <linux-perf-users@archiver.kernel.org>; Sun,  8 May 2022 02:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiEHCaC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 7 May 2022 22:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiEHCaC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 7 May 2022 22:30:02 -0400
X-Greylist: delayed 115 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 07 May 2022 19:26:05 PDT
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6E75FA4;
        Sat,  7 May 2022 19:26:04 -0700 (PDT)
X-QQ-mid: bizesmtp73t1651976607tq4hk2fm
Received: from localhost.localdomain ( [125.69.42.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 08 May 2022 10:23:25 +0800 (CST)
X-QQ-SSF: 01000000002000E0S000B00A0000000
X-QQ-FEAT: 6gErTyJCHhwejptIFuc8wZvRxbU2cVPiaq5l6wbXIdAR0VTpNVPvPcaDa2crJ
        4fAmHj3T9gjyaOsJY+mNJOX65KGijJNArs4GaULMCLTwv1YKKMZ4SXbHyo1AmTWUVjdX5Qd
        8QTi0TjMtkBsqsQhTbrNAqMunm7/odEsf6RTxEyhoRz8GQMIOakv7szcUzS4QL99KbOjH3d
        GbDqYjp4tlgs5sBQdkAq81fAeXm2tx6niKKgcGBBh3nbQpcGSbJbvzIEAi2QMaY2ldldnTi
        o1mFffur4n4cvhmHj/WEhUTVWtqLpwr4xgr9WS0jg2pRrl
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mark.rutland@arm.com
Cc:     will@kernel.org, catalin.marinas@arm.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] arm64: perf: no need to initialise statics to 0
Date:   Sun,  8 May 2022 10:23:12 +0800
Message-Id: <20220508022312.93905-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Static variables do not need to be initialised to 0, because compiler
will initialise all uninitialised statics to 0. Thus, remove the
unneeded initializations.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/arm64/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cb69ff1e6138..919fdcf8fce6 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1226,7 +1226,7 @@ static struct ctl_table armv8_pmu_sysctl_table[] = {
 
 static void armv8_pmu_register_sysctl_table(void)
 {
-	static u32 tbl_registered = 0;
+	static u32 tbl_registered;
 
 	if (!cmpxchg_relaxed(&tbl_registered, 0, 1))
 		register_sysctl("kernel", armv8_pmu_sysctl_table);
-- 
2.35.1


