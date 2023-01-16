Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F5EC3DA78
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 Jan 2023 01:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjAPBPr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 15 Jan 2023 20:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjAPBPn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 15 Jan 2023 20:15:43 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C24CC3F
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Jan 2023 17:15:39 -0800 (PST)
Received: from dggpeml500004.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NwDVz57JGzJq9c;
        Mon, 16 Jan 2023 09:11:23 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500004.china.huawei.com
 (7.185.36.140) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 09:15:35 +0800
From:   qinyu <qinyu32@huawei.com>
To:     <peterz@infradead.org>, <acme@kernel.org>, <mingo@redhat.com>
CC:     <linux-perf-users@vger.kernel.org>, <hewenliang4@huawei.com>,
        <linfeilong@huawei.com>
Subject: [PATCH] perf docs: fix a typo in perf probe doc
Date:   Mon, 16 Jan 2023 09:21:43 +0800
Message-ID: <20230116012143.432435-1-qinyu32@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500004.china.huawei.com (7.185.36.140)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

fix a minor typo in perf probe doc.

Fixes: 631c9def804b ("perf probe: Support --line option to show probable source-code lines")
Signed-off-by: qinyu <qinyu32@huawei.com>
---
 tools/perf/Documentation/perf-probe.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-probe.txt b/tools/perf/Documentation/perf-probe.txt
index 7f8e8ba3a..5c43a6edc 100644
--- a/tools/perf/Documentation/perf-probe.txt
+++ b/tools/perf/Documentation/perf-probe.txt
@@ -222,7 +222,7 @@ probe syntax, 'SRC' means the source file path, 'ALN' is start line number,
 and 'ALN2' is end line number in the file. It is also possible to specify how
 many lines to show by using 'NUM'. Moreover, 'FUNC@SRC' combination is good
 for searching a specific function when several functions share same name.
-So, "source.c:100-120" shows lines between 100th to l20th in source.c file. And "func:10+20" shows 20 lines from 10th line of func function.
+So, "source.c:100-120" shows lines between 100th to 120th in source.c file. And "func:10+20" shows 20 lines from 10th line of func function.
 
 LAZY MATCHING
 -------------
-- 
2.33.0

