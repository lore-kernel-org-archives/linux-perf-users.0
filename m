Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AC4C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Nov 2022 08:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbiKQIZa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Nov 2022 03:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbiKQIZR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Nov 2022 03:25:17 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E5949B5F
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Nov 2022 00:25:16 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NCXyp5YbTz15Ml9;
        Thu, 17 Nov 2022 16:24:50 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 16:25:13 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 16:25:12 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <ak@linux.intel.com>, <kan.liang@linux.intel.com>,
        <alexander.shishkin@linux.intel.com>,
        <alexander.antonov@linux.intel.com>, <acme@kernel.org>,
        <jolsa@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <yangyingliang@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH v3 0/4] perf/x86/intel/uncore: Fix PCI device reference count leak
Date:   Thu, 17 Nov 2022 16:43:23 +0800
Message-ID: <20221117084327.192058-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
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
pci_dev, and also decrease the reference count for the input parameter
*from* if it is not NULL. We add missing pci_dev_put() to decrease the
reference count.


ChangeLog:
v1->v2:
  move pci_dev_put() to the last of function sad_cfg_iio_topology()
  add fixes for snr_uncore_mmio_map(), hswep_has_limit_sbox() and __uncore_imc_init_box()
v2->v3:
  split one patch into several patches, one patch for one fix
  

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

