Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF829C19F29
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Aug 2022 00:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbiHDAwU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Aug 2022 20:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiHDAwT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 Aug 2022 20:52:19 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB2C5D0C7;
        Wed,  3 Aug 2022 17:52:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VLJpZHJ_1659574334;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VLJpZHJ_1659574334)
          by smtp.aliyun-inc.com;
          Thu, 04 Aug 2022 08:52:15 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] perf stat: Remove duplicated include in builtin-stat.c
Date:   Thu,  4 Aug 2022 08:52:13 +0800
Message-Id: <20220804005213.71990-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

util/topdown.h is included twice in builtin-stat.c,
remove one of them.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1818
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 tools/perf/builtin-stat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3d22543fc305..e326226656e4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -71,7 +71,6 @@
 #include "util/bpf_counter.h"
 #include "util/iostat.h"
 #include "util/pmu-hybrid.h"
- #include "util/topdown.h"
 #include "asm/bug.h"
 
 #include <linux/time64.h>
-- 
2.20.1.7.g153144c

