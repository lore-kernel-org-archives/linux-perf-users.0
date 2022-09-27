Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824D5C6FA86
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Sep 2022 01:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiI0BmM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Sep 2022 21:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiI0BmL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Sep 2022 21:42:11 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F99098C8C
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Sep 2022 18:42:10 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mc2Lp5VYBz1P6sW;
        Tue, 27 Sep 2022 09:37:54 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 09:42:08 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH 2/5] perf annotate: Remove unused struct disasm_line_samples
Date:   Tue, 27 Sep 2022 01:39:28 +0000
Message-ID: <20220927013931.110475-3-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220927013931.110475-1-yuancan@huawei.com>
References: <20220927013931.110475-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

After commit 3ab6db8d0f3b("perf annotate browser: Use samples data from struct
annotation_line"), no one use struct disasm_line_samples, so remove it.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 tools/perf/ui/browsers/annotate.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 9bc1076374ff..b4293c9df346 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -19,11 +19,6 @@
 #include <sys/ttydefaults.h>
 #include <asm/bug.h>
 
-struct disasm_line_samples {
-	double		      percent;
-	struct sym_hist_entry he;
-};
-
 struct arch;
 
 struct annotate_browser {
-- 
2.17.1

