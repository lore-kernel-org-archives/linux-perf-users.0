Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17013C43217
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Nov 2022 09:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239907AbiKQJZ3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Nov 2022 04:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbiKQJZZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Nov 2022 04:25:25 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4420C7D
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Nov 2022 01:25:23 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NCZJD5rjkzRpPH;
        Thu, 17 Nov 2022 17:25:00 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 17:25:21 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 17:25:21 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <ak@linux.intel.com>, <kan.liang@linux.intel.com>,
        <alexander.shishkin@linux.intel.com>,
        <alexander.antonov@linux.intel.com>, <acme@kernel.org>,
        <jolsa@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <yangyingliang@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH v4 0/4] perf/x86/intel/uncore: Fix PCI device reference count leak
Date:   Thu, 17 Nov 2022 17:43:32 +0800
Message-ID: <20221117094336.10846-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

pci_get_device() will increase the reference count for the returned
pci_dev, and also decrease the reference count for the input parameter
*from* if it is not NULL. We add missing pci_dev_put() to decrease the
reference count.


ChangeLog:
v1->v2:
  move pci_dev_put() to the last of function sad_cfg_iio_topology()
  add fixes for snr_uncore_mmio_map(), hswep_has_limit_sbox() and __uncore_imc_init_box()
v2->v3:
  split one patch into several patches, one patch for one fix
v3->v4:
  change 'pci_dev_put(pdev)' to 'pci_dev_put(dev)' in the first patch

Xiongfeng Wang (4):
  perf/x86/intel/uncore: Fix reference count leak in
    sad_cfg_iio_topology()
  perf/x86/intel/uncore: Fix reference count leak in
    hswep_has_limit_sbox()
  perf/x86/intel/uncore: Fix reference count leak in
    snr_uncore_mmio_map()
  perf/x86/intel/uncore: Fix reference count leak in
    __uncore_imc_init_box()

 arch/x86/events/intel/uncore_snb.c   |  3 +++
 arch/x86/events/intel/uncore_snbep.c | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.20.1

