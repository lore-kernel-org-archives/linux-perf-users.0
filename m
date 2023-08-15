Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A43CC0015E
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Aug 2023 13:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjHONLD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Aug 2023 09:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237363AbjHONKg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Aug 2023 09:10:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54D310C0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Aug 2023 06:10:35 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQBPC1QHTztQr4;
        Tue, 15 Aug 2023 21:06:55 +0800 (CST)
Received: from localhost.localdomain (10.175.103.91) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 21:10:30 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
CC:     <linux-perf-users@vger.kernel.org>, <huawei.libin@huawei.com>
Subject: [PATCH] perf header: Fix missing PMU caps recording in write_pmu_caps
Date:   Tue, 15 Aug 2023 21:07:22 +0800
Message-ID: <20230815130722.1223744-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

An error occurred when executing "perf script syscall-counts" on arm64:
    Press control+C to stop and show the summary
    0x6a7c [0x14]: failed to process type: 80

After debugging i found that it failed to process HEADER_PMU_CAPS, looking
back on write_pmu_caps(), it get all pmus with caps except "cpu" first,
then handle the hybrid core pmus, and the uncore pmus finally.

But on arm64 platforms, the core pmu is named "armv8_pmuv3" etc, not "cpu".
So it's counted but no caps recorded here, this is broken since commit
178ddf3bad98 ("perf header: Avoid hybrid PMU list in write_pmu_caps"),
as the logic for determining hybrid is changed from name matching to "core"
attribute judging.

To fix this, change the logic of recording pmu caps to be consistent with
the preceding counting, also make the code clear. The compatibility with
old perf tool is ignored since it has been already broken.

Fixes: 178ddf3bad98 ("perf header: Avoid hybrid PMU list in write_pmu_caps")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/util/header.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 52fbf526fe74..7d2bd1fb8ef2 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1618,22 +1618,10 @@ static int write_pmu_caps(struct feat_fd *ff,
 	if (!nr_pmu)
 		return 0;
 
-	/*
-	 * Write hybrid pmu caps first to maintain compatibility with
-	 * older perf tool.
-	 */
-	if (perf_pmus__num_core_pmus() > 1) {
-		pmu = NULL;
-		while ((pmu = perf_pmus__scan_core(pmu))) {
-			ret = __write_pmu_caps(ff, pmu, true);
-			if (ret < 0)
-				return ret;
-		}
-	}
-
 	pmu = NULL;
 	while ((pmu = perf_pmus__scan(pmu))) {
-		if (pmu->is_core || !pmu->nr_caps)
+		if (!pmu->name || !strcmp(pmu->name, "cpu") ||
+		    !pmu->nr_caps)
 			continue;
 
 		ret = __write_pmu_caps(ff, pmu, true);
-- 
2.25.1

