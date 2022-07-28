Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C5EC04A68
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Jul 2022 12:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbiG1MBv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Jul 2022 08:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237217AbiG1MBq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Jul 2022 08:01:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BF5491F1;
        Thu, 28 Jul 2022 05:01:41 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ltq1j2ww4zlVhf;
        Thu, 28 Jul 2022 19:59:05 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 20:01:39 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 20:01:38 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <colin.i.king@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <pc@us.ibm.com>, <yhs@fb.com>, <andrii.nakryiko@gmail.com>,
        <songliubraving@fb.com>, <yangjihong1@huawei.com>
Subject: [PATCH 1/5] perf kwork: Add '--synth task' option for record
Date:   Thu, 28 Jul 2022 19:58:50 +0800
Message-ID: <20220728115854.80399-2-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20220728115854.80399-1-yangjihong1@huawei.com>
References: <20220728115854.80399-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since we don't need user space symbols, add '--synth task' option to skip
costly synthesis.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index fb8c63656ad8..ff17711a554a 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -1631,6 +1631,10 @@ static int perf_kwork__record(struct perf_kwork *kwork,
 		"-R",
 		"-m", "1024",
 		"-c", "1",
+		/*
+		 * Skip synthesis as we do not need user space symbols.
+		 */
+		"--synth", "task",
 	};
 
 	rec_argc = ARRAY_SIZE(record_args) + argc - 1;
-- 
2.30.GIT

