Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E96C433ED
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 May 2021 07:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B28CB61059
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 May 2021 07:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhETIBL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 May 2021 04:01:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4554 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETIBL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 May 2021 04:01:11 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fm2Bk2z7FzkWP0;
        Thu, 20 May 2021 15:57:02 +0800 (CST)
Received: from dggeme759-chm.china.huawei.com (10.3.19.105) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 15:59:48 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 20 May 2021 15:59:48 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH] arm64: perf: Convert snprintf to sysfs_emit
Date:   Thu, 20 May 2021 15:59:45 +0800
Message-ID: <1621497585-30887-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use sysfs_emit instead of snprintf to avoid buf overrun,because in
sysfs_emit it strictly checks whether buf is null or buf whether
pagesize aligned, otherwise it returns an error.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 arch/arm64/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index f594957..44b6eda 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -312,7 +312,7 @@ static ssize_t slots_show(struct device *dev, struct device_attribute *attr,
 	struct arm_pmu *cpu_pmu = container_of(pmu, struct arm_pmu, pmu);
 	u32 slots = cpu_pmu->reg_pmmir & ARMV8_PMU_SLOTS_MASK;
 
-	return snprintf(page, PAGE_SIZE, "0x%08x\n", slots);
+	return sysfs_emit(page, "0x%08x\n", slots);
 }
 
 static DEVICE_ATTR_RO(slots);
-- 
2.7.4

