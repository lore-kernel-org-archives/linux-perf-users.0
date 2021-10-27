Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2929FC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Oct 2021 09:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B85760EDF
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Oct 2021 09:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbhJ0JzI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Oct 2021 05:55:08 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:26197 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbhJ0JzH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Oct 2021 05:55:07 -0400
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HfP8h6XbRz8tt7;
        Wed, 27 Oct 2021 17:51:16 +0800 (CST)
Received: from huawei.com (10.67.189.2) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Wed, 27
 Oct 2021 17:52:38 +0800
From:   Lexi Shao <shaolexi@huawei.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <mark.rutland@arm.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <shaolexi@huawei.com>,
        <qiuxi1@huawei.com>, <nixiaoming@huawei.com>,
        <wangbing6@huawei.com>
Subject: [PATCH] perf symbol: ignore $a/$d symbols for ARM modules
Date:   Wed, 27 Oct 2021 17:52:35 +0800
Message-ID: <20211027095235.123358-1-shaolexi@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On ARM machine, kernel symbols from modules can be resolved to $a
instead of printing the actual symbol name. Ignore symbols starting with
"$" when building kallsyms rbtree.

A sample stacktrace is shown as follows:

c0f2e39c schedule_hrtimeout+0x14 ([kernel.kallsyms])
bf4a66d8 $a+0x78 ([test_module])
c0a4f5f4 kthread+0x15c ([kernel.kallsyms])
c0a001f8 ret_from_fork+0x14 ([kernel.kallsyms])

On ARM machine, $a/$d symbols are used by the compiler to mark the
beginning of code/data part in code section. These symbols are filtered
out when linking vmlinux(see scripts/kallsyms.c ignored_prefixes), but
are left on modules. So there are $a symbols in /proc/kallsyms which
share the same addresses with the actual module symbols and confuses perf
when resolving symbols.

After this patch, the module symbol name is printed:

c0f2e39c schedule_hrtimeout+0x14 ([kernel.kallsyms])
bf4a66d8 test_func+0x78 ([test_module])
c0a4f5f4 kthread+0x15c ([kernel.kallsyms])
c0a001f8 ret_from_fork+0x14 ([kernel.kallsyms])

Signed-off-by: Lexi Shao <shaolexi@huawei.com>
---
 tools/perf/util/symbol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 0fc9a5410739..35116aed74eb 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -702,6 +702,10 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 	if (!symbol_type__filter(type))
 		return 0;
 
+	/* Ignore local symbols for ARM modules */
+	if (name[0] == '$')
+		return 0;
+
 	/*
 	 * module symbols are not sorted so we add all
 	 * symbols, setting length to 0, and rely on
-- 
2.12.3

