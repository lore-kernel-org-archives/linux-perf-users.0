Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CB9C432BE
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 14:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6326E61077
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 14:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbhG2OJT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:09:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3525 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238077AbhG2OCk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jul 2021 10:02:40 -0400
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GbBnV5qKjz6FG0F;
        Thu, 29 Jul 2021 21:53:18 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 16:02:35 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 15:02:32 +0100
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <yao.jin@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <irogers@google.com>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 02/11] perf jevents: Relocate test events to cpu folder
Date:   Thu, 29 Jul 2021 21:56:17 +0800
Message-ID: <1627566986-30605-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1627566986-30605-1-git-send-email-john.garry@huawei.com>
References: <1627566986-30605-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In future to add support for sys events, relocate the core and uncore
events to a cpu folder.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../pmu-events/arch/test/{test_cpu => test_soc/cpu}/branch.json | 0
 .../pmu-events/arch/test/{test_cpu => test_soc/cpu}/cache.json  | 0
 .../pmu-events/arch/test/{test_cpu => test_soc/cpu}/other.json  | 0
 .../pmu-events/arch/test/{test_cpu => test_soc/cpu}/uncore.json | 0
 tools/perf/pmu-events/jevents.c                                 | 2 +-
 5 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/perf/pmu-events/arch/test/{test_cpu => test_soc/cpu}/branch.json (100%)
 rename tools/perf/pmu-events/arch/test/{test_cpu => test_soc/cpu}/cache.json (100%)
 rename tools/perf/pmu-events/arch/test/{test_cpu => test_soc/cpu}/other.json (100%)
 rename tools/perf/pmu-events/arch/test/{test_cpu => test_soc/cpu}/uncore.json (100%)

diff --git a/tools/perf/pmu-events/arch/test/test_cpu/branch.json b/tools/perf/pmu-events/arch/test/test_soc/cpu/branch.json
similarity index 100%
rename from tools/perf/pmu-events/arch/test/test_cpu/branch.json
rename to tools/perf/pmu-events/arch/test/test_soc/cpu/branch.json
diff --git a/tools/perf/pmu-events/arch/test/test_cpu/cache.json b/tools/perf/pmu-events/arch/test/test_soc/cpu/cache.json
similarity index 100%
rename from tools/perf/pmu-events/arch/test/test_cpu/cache.json
rename to tools/perf/pmu-events/arch/test/test_soc/cpu/cache.json
diff --git a/tools/perf/pmu-events/arch/test/test_cpu/other.json b/tools/perf/pmu-events/arch/test/test_soc/cpu/other.json
similarity index 100%
rename from tools/perf/pmu-events/arch/test/test_cpu/other.json
rename to tools/perf/pmu-events/arch/test/test_soc/cpu/other.json
diff --git a/tools/perf/pmu-events/arch/test/test_cpu/uncore.json b/tools/perf/pmu-events/arch/test/test_soc/cpu/uncore.json
similarity index 100%
rename from tools/perf/pmu-events/arch/test/test_cpu/uncore.json
rename to tools/perf/pmu-events/arch/test/test_soc/cpu/uncore.json
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 9604446f8360..405bdd36b9b9 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -814,7 +814,7 @@ static void print_mapping_test_table(FILE *outfp)
 	fprintf(outfp, "\t.cpuid = \"testcpu\",\n");
 	fprintf(outfp, "\t.version = \"v1\",\n");
 	fprintf(outfp, "\t.type = \"core\",\n");
-	fprintf(outfp, "\t.table = pme_test_cpu,\n");
+	fprintf(outfp, "\t.table = pme_test_soc_cpu,\n");
 	fprintf(outfp, "},\n");
 }
 
-- 
2.26.2

