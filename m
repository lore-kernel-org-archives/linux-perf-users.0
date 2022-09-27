Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BE6C6FA82
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Sep 2022 01:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiI0BmL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Sep 2022 21:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiI0BmL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Sep 2022 21:42:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6458051F
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Sep 2022 18:42:10 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mc2L96tjLzHtgt;
        Tue, 27 Sep 2022 09:37:21 +0800 (CST)
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
Subject: [PATCH 1/5] perf machine: Remove unused struct process_args
Date:   Tue, 27 Sep 2022 01:39:27 +0000
Message-ID: <20220927013931.110475-2-yuancan@huawei.com>
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

After commit a93f0e551af9("perf symbols: Get kernel start address by symbol
name"), no one uses struct process_args any more, so remove it.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 tools/perf/util/machine.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2a16cae28407..76316e459c3d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1128,10 +1128,6 @@ static struct dso *machine__get_kernel(struct machine *machine)
 	return kernel;
 }
 
-struct process_args {
-	u64 start;
-};
-
 void machine__get_kallsyms_filename(struct machine *machine, char *buf,
 				    size_t bufsz)
 {
-- 
2.17.1

