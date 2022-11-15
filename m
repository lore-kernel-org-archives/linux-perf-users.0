Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235F3C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Nov 2022 11:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbiKOLHn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Nov 2022 06:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238553AbiKOLHF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Nov 2022 06:07:05 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FAE26DA
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 03:07:03 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NBNfH3hr2zHvsT;
        Tue, 15 Nov 2022 19:06:31 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 19:07:01 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 19:07:00 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <ak@linux.intel.com>, <kan.liang@linux.intel.com>,
        <alexander.shishkin@linux.intel.com>,
        <alexander.antonov@linux.intel.com>, <acme@kernel.org>,
        <jolsa@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <yangyingliang@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH] perf/x86/intel/uncore: decrease reference count in error path
Date:   Tue, 15 Nov 2022 19:25:15 +0800
Message-ID: <20221115112515.53177-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

pci_get_device() will increase the reference count for the returned
pci_dev, and also decrease the reference count for the input parameter
*from* if it is not NULL.

If we break the loop in sad_cfg_iio_topology() with 'dev' not NULL. We
need to use pci_dev_put() to decrease the reference count. Let's add it.

Fixes: c1777be3646b ("perf/x86/intel/uncore: Enable I/O stacks to IIO PMON mapping on SNR")
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 arch/x86/events/intel/uncore_snbep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index ed869443efb2..83fe3d80c9a7 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4469,6 +4469,7 @@ static int sad_cfg_iio_topology(struct intel_uncore_type *type, u8 *sad_pmon_map
 	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, SNR_ICX_MESH2IIO_MMAP_DID, dev))) {
 		ret = pci_read_config_dword(dev, SNR_ICX_SAD_CONTROL_CFG, &sad_cfg);
 		if (ret) {
+			pci_dev_put(dev);
 			ret = pcibios_err_to_errno(ret);
 			break;
 		}
@@ -4476,6 +4477,7 @@ static int sad_cfg_iio_topology(struct intel_uncore_type *type, u8 *sad_pmon_map
 		die = uncore_pcibus_to_dieid(dev->bus);
 		stack_id = SAD_CONTROL_STACK_ID(sad_cfg);
 		if (die < 0 || stack_id >= type->num_boxes) {
+			pci_dev_put(dev);
 			ret = -EPERM;
 			break;
 		}
-- 
2.20.1

