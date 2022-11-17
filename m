Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9139DC4332F
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Nov 2022 08:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbiKQIZc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Nov 2022 03:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239421AbiKQIZR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Nov 2022 03:25:17 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232A7532E2
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Nov 2022 00:25:16 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NCXyq6Rm9z15MkY;
        Thu, 17 Nov 2022 16:24:51 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 16:25:14 +0800
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
Subject: [PATCH v3 2/4] perf/x86/intel/uncore: Fix reference count leak in hswep_has_limit_sbox()
Date:   Thu, 17 Nov 2022 16:43:25 +0800
Message-ID: <20221117084327.192058-3-wangxiongfeng2@huawei.com>
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
pci_dev. We need to call pci_dev_put() to decrease the reference count
before exiting from hswep_has_limit_sbox(). Add pci_dev_put() for both
normal and error path.

Fixes: 9d480158ee86 ("perf/x86/intel/uncore: Remove uncore extra PCI dev HSWEP_PCI_PCU_3")
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 arch/x86/events/intel/uncore_snbep.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 4a9a745c133f..f35cd89dee43 100644
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
-- 
2.20.1

