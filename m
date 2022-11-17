Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54883C4321E
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Nov 2022 08:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbiKQIZd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Nov 2022 03:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239446AbiKQIZS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Nov 2022 03:25:18 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D906DCF8
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Nov 2022 00:25:18 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NCXtt2SyFzqSVC;
        Thu, 17 Nov 2022 16:21:26 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 16:25:15 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 16:25:14 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <ak@linux.intel.com>, <kan.liang@linux.intel.com>,
        <alexander.shishkin@linux.intel.com>,
        <alexander.antonov@linux.intel.com>, <acme@kernel.org>,
        <jolsa@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <yangyingliang@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH v3 3/4] perf/x86/intel/uncore: Fix reference count leak in snr_uncore_mmio_map()
Date:   Thu, 17 Nov 2022 16:43:26 +0800
Message-ID: <20221117084327.192058-4-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221117084327.192058-1-wangxiongfeng2@huawei.com>
References: <20221117084327.192058-1-wangxiongfeng2@huawei.com>
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
pci_dev, so snr_uncore_get_mc_dev() will return a pci_dev with its
reference count increased. We need to call pci_dev_put() to decrease the
reference count before exiting from snr_uncore_mmio_map(). Add
pci_dev_put() for both normal and error path.

Fixes: ee49532b38dd ("perf/x86/intel/uncore: Add IMC uncore support for Snow Ridge")
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 arch/x86/events/intel/uncore_snbep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index f35cd89dee43..6a21ac6cb2e9 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4866,9 +4866,12 @@ static int snr_uncore_mmio_map(struct intel_uncore_box *box,
 	box->io_addr = ioremap(addr, type->mmio_map_size);
 	if (!box->io_addr) {
 		pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
+		pci_dev_put(pdev);
 		return -EINVAL;
 	}
 
+	pci_dev_put(pdev);
+
 	return 0;
 }
 
-- 
2.20.1

