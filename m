Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9EFC6FA82
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Sep 2022 01:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiI0BmP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Sep 2022 21:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiI0BmN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Sep 2022 21:42:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26696A02D1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Sep 2022 18:42:12 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mc2LD0XBfzHthn;
        Tue, 27 Sep 2022 09:37:24 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 09:42:10 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH 5/5] perf lock: Remove unused struct lock_contention_key
Date:   Tue, 27 Sep 2022 01:39:31 +0000
Message-ID: <20220927013931.110475-6-yuancan@huawei.com>
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

The struct lock_contention_key is never used, remove it.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 tools/perf/util/bpf_lock_contention.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index c591a66733ef..462827c407c7 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -14,11 +14,6 @@
 
 static struct lock_contention_bpf *skel;
 
-/* should be same as bpf_skel/lock_contention.bpf.c */
-struct lock_contention_key {
-	s32 stack_id;
-};
-
 struct lock_contention_data {
 	u64 total_time;
 	u64 min_time;
-- 
2.17.1

