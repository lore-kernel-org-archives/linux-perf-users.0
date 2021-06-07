Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D88C4743D
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 01:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BB366100B
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 01:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhFGBdl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 6 Jun 2021 21:33:41 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:45844 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhFGBdk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 6 Jun 2021 21:33:40 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 7 Jun
 2021 09:31:41 +0800
Received: from zx.zhaoxin.com (10.28.64.91) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 7 Jun
 2021 09:31:40 +0800
From:   Cody Yao-oc <CodyYao-oc@zhaoxin.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <bp@alien8.de>, <hpa@zytor.com>, <x86@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shyaololo@163.com>, CodyYao-oc <CodyYao-oc@zhaoxin.com>
Subject: [PATCH] x86/perf: Fixed kernel panic during boot on Nano processor.
Date:   Mon, 7 Jun 2021 09:31:09 +0800
Message-ID: <20210607013109.7870-1-CodyYao-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.64.91]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx2.zhaoxin.com (10.29.252.164)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: CodyYao-oc <CodyYao-oc@zhaoxin.com>

Nano processor may not fully support rdpmc instruction, it works well
for reading general pmc counter, but will lead to GP(general protection)
when accessing fixed pmc counter. Futhermore, family/model information
is same between Nano processor and ZX-C processor, it leads to zhaoxin
pmu driver is wrongly loaded for Nano processor, which resulting boot
kernal fail.

To solve this problem, stepping information will be checked to distinguish
between Nano processor and ZX-C processor.

[https://bugzilla.kernel.org/show_bug.cgi?id=212389]

Reported-by: Arjan <8vvbbqzo567a@nospam.xutrox.com>
Signed-off-by: CodyYao-oc <CodyYao-oc@zhaoxin.com>
---
 arch/x86/events/zhaoxin/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 949d845c922b..cef1de251613 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -541,7 +541,8 @@ __init int zhaoxin_pmu_init(void)
 
 	switch (boot_cpu_data.x86) {
 	case 0x06:
-		if (boot_cpu_data.x86_model == 0x0f || boot_cpu_data.x86_model == 0x19) {
+		if ((boot_cpu_data.x86_model == 0x0f && boot_cpu_data.x86_stepping >= 0x0e) ||
+			boot_cpu_data.x86_model == 0x19) {
 
 			x86_pmu.max_period = x86_pmu.cntval_mask >> 1;
 
-- 
2.17.1

