Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CA0C41513
	for <linux-perf-users@archiver.kernel.org>; Mon, 31 Jul 2023 13:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjGaNdT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 31 Jul 2023 09:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjGaNdS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 31 Jul 2023 09:33:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D13F1709
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jul 2023 06:33:17 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RDzcf6HtQztRYj;
        Mon, 31 Jul 2023 21:29:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 21:33:14 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <ravi.bangoria@amd.com>
CC:     <lizetao1@huawei.com>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH -next] perf tool x86: Remove redundant bool conversion
Date:   Mon, 31 Jul 2023 21:32:42 +0800
Message-ID: <20230731133242.2684483-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

There is a warning reported by coccinelle:

./tools/perf/arch/x86/util/env.c:18:29-34: WARNING:
		conversion to bool not needed here

Remove the redundant bool conversion to silence the warning.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 tools/perf/arch/x86/util/env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/env.c b/tools/perf/arch/x86/util/env.c
index 3e537ffb1353..5b0db77f8e0f 100644
--- a/tools/perf/arch/x86/util/env.c
+++ b/tools/perf/arch/x86/util/env.c
@@ -15,5 +15,5 @@ bool x86__is_amd_cpu(void)
 	is_amd = env.cpuid && strstarts(env.cpuid, "AuthenticAMD") ? 1 : -1;
 	perf_env__exit(&env);
 ret:
-	return is_amd >= 1 ? true : false;
+	return is_amd >= 1;
 }
-- 
2.34.1

