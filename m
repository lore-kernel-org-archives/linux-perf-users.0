Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D81BC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 12:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1642B61090
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 12:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbhJOMhx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 08:37:53 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13743 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbhJOMh0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Oct 2021 08:37:26 -0400
Received: from dggeml751-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HW5KT2YJSzW9wV;
        Fri, 15 Oct 2021 20:33:33 +0800 (CST)
Received: from huawei.com (10.67.189.167) by dggeml751-chm.china.huawei.com
 (10.1.199.150) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Fri, 15
 Oct 2021 20:35:13 +0800
From:   Jiangfeng Xiao <xiaojiangfeng@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <rickyman7@gmail.com>, <namhyung@kernel.org>,
        <kan.liang@linux.intel.com>, <yao.jin@linux.intel.com>,
        <song@kernel.org>, <amurray@thegoodpenguin.co.uk>,
        <xiaojiangfeng@huawei.com>
CC:     <andrew.murray@arm.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shaolexi@huawei.com>,
        <nixiaoming@huawei.com>, <qiuxi1@huawei.com>
Subject: [PATCH] perf evsel: fix armv7_a9 failed to resolve symbols with JIT
Date:   Fri, 15 Oct 2021 20:34:57 +0800
Message-ID: <1634301297-125143-1-git-send-email-xiaojiangfeng@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.167]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeml751-chm.china.huawei.com (10.1.199.150)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The PMU of armv7_a9 machine does not have the capability to exclude
counting events that occur in specific contexts such as guest, so
sys_perf_event_open() syscall returned with -EINVAL.

See following code:

static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
{
	...
	if (pmu->capabilities & PERF_PMU_CAP_NO_EXCLUDE &&
	    event_has_any_exclude_flag(event))
		ret = -EINVAL;
	...
}

Then evsel__open_cpu will use perf_missing_features.mmap2 to fallback to
not using .mmap2 and fail to re-execute sys_perf_event_open. Next,
evsel__open_cpu use perf_missing_features.exclude_guest to fallback to
not using .exclude_guest and finally success to re-execute
sys_perf_event_open.

When .mmap2 is not used, the input parameter flag of map__new is 0,
perf will not find the perf-%d.map to resolve.

Therefore, in this submission, the disabling order of .mmap2 and
exclude_guest is reversed to fix the failure to resolve symbols with JIT.

Fixes: cc6795aeffe ("perf/core: Add PERF_PMU_CAP_NO_EXCLUDE for exclusion incapable PMUs")

Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
---
 tools/perf/util/evsel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbfeceb..d6bf15b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1896,15 +1896,15 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 		perf_missing_features.cloexec = true;
 		pr_debug2_peo("switching off cloexec flag\n");
 		return true;
-	} else if (!perf_missing_features.mmap2 && evsel->core.attr.mmap2) {
-		perf_missing_features.mmap2 = true;
-		pr_debug2_peo("switching off mmap2\n");
-		return true;
 	} else if (!perf_missing_features.exclude_guest &&
 		   (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host)) {
 		perf_missing_features.exclude_guest = true;
 		pr_debug2_peo("switching off exclude_guest, exclude_host\n");
 		return true;
+	} else if (!perf_missing_features.mmap2 && evsel->core.attr.mmap2) {
+		perf_missing_features.mmap2 = true;
+		pr_debug2_peo("switching off mmap2\n");
+		return true;
 	} else if (!perf_missing_features.sample_id_all) {
 		perf_missing_features.sample_id_all = true;
 		pr_debug2_peo("switching off sample_id_all\n");
-- 
1.8.5.6

