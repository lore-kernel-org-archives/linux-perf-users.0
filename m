Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32E7C6FA83
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Sep 2022 03:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiIZDSi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 25 Sep 2022 23:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbiIZDSd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 25 Sep 2022 23:18:33 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498742656E;
        Sun, 25 Sep 2022 20:18:32 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MbSXT5QFhz1P72r;
        Mon, 26 Sep 2022 11:14:17 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 11:18:30 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 11:18:30 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <john.garry@huawei.com>, <adrian.hunter@intel.com>,
        <ak@linux.intel.com>, <florian.fischer@muhq.space>,
        <chenzhongjin@huawei.com>
Subject: [PATCH -next 2/5] perf: Fix incorrectly parsed flags in filter
Date:   Mon, 26 Sep 2022 11:14:37 +0800
Message-ID: <20220926031440.28275-3-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926031440.28275-1-chenzhongjin@huawei.com>
References: <20220926031440.28275-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When parsing flags in filter, the strtoul function uses wrong parsing
condition (tok[1] = 'x'), which can make the flags be corrupted and
treat all numbers start with 0 as hex.

In fact strtoul() will auto test hex format when base == 0 (See
_parse_integer_fixup_radix). So there is no need to test this again.

Remove the unnessesary is_hexa test.

Fixes: 154c978d484c ("libbeauty: Introduce strarray__strtoul_flags()")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 tools/perf/builtin-trace.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c7bb7a8222a6..7ecd76428440 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -615,11 +615,8 @@ bool strarray__strtoul_flags(struct strarray *sa, char *bf, size_t size, u64 *re
 		if (isalpha(*tok) || *tok == '_') {
 			if (!strarray__strtoul(sa, tok, toklen, &val))
 				return false;
-		} else {
-			bool is_hexa = tok[0] == 0 && (tok[1] = 'x' || tok[1] == 'X');
-
-			val = strtoul(tok, NULL, is_hexa ? 16 : 0);
-		}
+		} else
+			val = strtoul(tok, NULL, 0);
 
 		*ret |= (1 << (val - 1));
 
-- 
2.17.1

