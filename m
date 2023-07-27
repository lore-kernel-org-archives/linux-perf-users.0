Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FAFC001DC
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 Jul 2023 10:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjG0Kvh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 Jul 2023 06:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjG0Kvd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 Jul 2023 06:51:33 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77F726BA
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jul 2023 03:51:26 -0700 (PDT)
Received: from dggpeml100024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RBSGZ303rz1GDGx;
        Thu, 27 Jul 2023 18:50:30 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml100024.china.huawei.com (7.185.36.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 18:51:24 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>
CC:     <linux-perf-users@vger.kernel.org>, <xiujianfeng@huawei.com>
Subject: [PATCH -next] perf doc: Fix typo in perf.data-file-format.txt
Date:   Thu, 27 Jul 2023 10:50:01 +0000
Message-ID: <20230727105001.261420-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.26]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100024.china.huawei.com (7.185.36.115)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The 'it' should be 'is' here, fix it.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 635ba043fd7d..010a4edcd384 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -43,7 +43,7 @@ struct perf_file_section {
 
 Flags section:
 
-For each of the optional features a perf_file_section it placed after the data
+For each of the optional features a perf_file_section is placed after the data
 section if the feature bit is set in the perf_header flags bitset. The
 respective perf_file_section points to the data of the additional header and
 defines its size.
-- 
2.34.1

