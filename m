Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6615CC4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Nov 2022 06:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241071AbiKRGNe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 18 Nov 2022 01:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbiKRGNb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Nov 2022 01:13:31 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEE9C2F
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Nov 2022 22:13:29 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ND60H4rGfzmVhY;
        Fri, 18 Nov 2022 14:13:03 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 14:13:28 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 14:13:27 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <ak@linux.intel.com>, <kan.liang@linux.intel.com>,
        <alexander.shishkin@linux.intel.com>,
        <alexander.antonov@linux.intel.com>, <acme@kernel.org>,
        <jolsa@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <yangyingliang@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH v5 4/4] perf/x86/intel/uncore: Fix reference count leak in __uncore_imc_init_box()
Date:   Fri, 18 Nov 2022 14:31:37 +0800
Message-ID: <20221118063137.121512-5-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221118063137.121512-1-wangxiongfeng2@huawei.com>
References: <20221118063137.121512-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

pci_get_device() will increase the reference count for the returned
pci_dev, so tgl_uncore_get_mc_dev() will return a pci_dev with its
reference count increased. We need to call pci_dev_put() to decrease the
reference count before exiting from __uncore_imc_init_box(). Add
pci_dev_put() for both normal and error path.

Fixes: fdb64822443e ("perf/x86: Add Intel Tiger Lake uncore support")
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 arch/x86/events/intel/uncore_snb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 1ef4f7861e2e..1f4869227efb 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1338,6 +1338,7 @@ static void __uncore_imc_init_box(struct intel_uncore_box *box,
 	/* MCHBAR is disabled */
 	if (!(mch_bar & BIT(0))) {
 		pr_warn("perf uncore: MCHBAR is disabled. Failed to map IMC free-running counters.\n");
+		pci_dev_put(pdev);
 		return;
 	}
 	mch_bar &= ~BIT(0);
@@ -1352,6 +1353,8 @@ static void __uncore_imc_init_box(struct intel_uncore_box *box,
 	box->io_addr = ioremap(addr, type->mmio_map_size);
 	if (!box->io_addr)
 		pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
+
+	pci_dev_put(pdev);
 }
 
 static void tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
-- 
2.20.1

