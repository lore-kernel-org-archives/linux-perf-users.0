Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9F9C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Nov 2022 11:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbiKPLNb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Nov 2022 06:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbiKPLNR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Nov 2022 06:13:17 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2178657B48
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Nov 2022 03:00:38 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NC0PM3V8CzJnnR;
        Wed, 16 Nov 2022 18:57:27 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 19:00:36 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 19:00:35 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <ak@linux.intel.com>, <kan.liang@linux.intel.com>,
        <alexander.shishkin@linux.intel.com>,
        <alexander.antonov@linux.intel.com>, <acme@kernel.org>,
        <jolsa@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <yangyingliang@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH v2] perf/x86/intel/uncore: Fix reference count issues
Date:   Wed, 16 Nov 2022 19:18:53 +0800
Message-ID: <20221116111853.168539-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

pci_get_device() will increase the reference count for the returned
pci_dev, and also decrease the reference count for the input parameter
*from* if it is not NULL.

This commit fix the reference count issues in the following four
functions:
  sad_cfg_iio_topology()
  snr_uncore_mmio_map()
  hswep_has_limit_sbox()
  __uncore_imc_init_box()

For sad_cfg_iio_topology(), if we break the loop with 'dev' not NULL, we
need to use pci_dev_put() to decrease the reference count. Since
pci_dev_put() can handle the NULL input parameter, we can add it just
before 'return ret'.

For the other three functions, we add pci_dev_put() for both the normal
case and the error case.

Fixes: c1777be3646b ("perf/x86/intel/uncore: Enable I/O stacks to IIO PMON mapping on SNR")
Fixes: ee49532b38dd ("perf/x86/intel/uncore: Add IMC uncore support for Snow Ridge")
Fixes: 9d480158ee86 ("perf/x86/intel/uncore: Remove uncore extra PCI dev HSWEP_PCI_PCU_3")
Fixes: fdb64822443e ("perf/x86: Add Intel Tiger Lake uncore support")
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
Changelog:
v1->v2:
  1. move pci_dev_put() to the last of function sad_cfg_iio_topology()
  2. add fixes for snr_uncore_mmio_map(), hswep_has_limit_sbox() and
     __uncore_imc_init_box()

  *Note that* we also add pci_dev_put() for the normal case not only
  error case for the above three functions.
---
 arch/x86/events/intel/uncore_snb.c   |  3 +++
 arch/x86/events/intel/uncore_snbep.c | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

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
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index ed869443efb2..0481f5135cb1 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -2891,8 +2891,12 @@ static bool hswep_has_limit_sbox(unsigned int device)
 		return false;
 
 	pci_read_config_dword(dev, HSWEP_PCU_CAPID4_OFFET, &capid4);
-	if (!hswep_get_chop(capid4))
+	if (!hswep_get_chop(capid4)) {
+		pci_dev_put(dev);
 		return true;
+	}
+
+	pci_dev_put(dev);
 
 	return false;
 }
@@ -4492,6 +4496,8 @@ static int sad_cfg_iio_topology(struct intel_uncore_type *type, u8 *sad_pmon_map
 		type->topology = NULL;
 	}
 
+	pci_dev_put(dev);
+
 	return ret;
 }
 
@@ -4860,9 +4866,12 @@ static int snr_uncore_mmio_map(struct intel_uncore_box *box,
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

