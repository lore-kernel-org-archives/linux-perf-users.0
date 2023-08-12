Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF08C001E0
	for <linux-perf-users@archiver.kernel.org>; Sat, 12 Aug 2023 08:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbjHLIwT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 12 Aug 2023 04:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbjHLIwD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 12 Aug 2023 04:52:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038072696;
        Sat, 12 Aug 2023 01:52:05 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RNDpP21LFztRQh;
        Sat, 12 Aug 2023 16:48:29 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 12 Aug 2023 16:52:00 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <sandipan.das@amd.com>, <ravi.bangoria@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC v1 01/16] perf kwork: Fix incorrect and missing free atom in work_push_atom()
Date:   Sat, 12 Aug 2023 08:49:02 +0000
Message-ID: <20230812084917.169338-2-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20230812084917.169338-1-yangjihong1@huawei.com>
References: <20230812084917.169338-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

1. Atoms are managed in page mode and should be released using atom_free()
   instead of free().
2. When the event does not match, the atom needs to free.

Fixes: f98919ec4fcc ("perf kwork: Implement 'report' subcommand")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 14bf7a8429e7..73b5dc099a8a 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -406,12 +406,14 @@ static int work_push_atom(struct perf_kwork *kwork,
 
 	work = work_findnew(&class->work_root, &key, &kwork->cmp_id);
 	if (work == NULL) {
-		free(atom);
+		atom_free(atom);
 		return -1;
 	}
 
-	if (!profile_event_match(kwork, work, sample))
+	if (!profile_event_match(kwork, work, sample)) {
+		atom_free(atom);
 		return 0;
+	}
 
 	if (dst_type < KWORK_TRACE_MAX) {
 		dst_atom = list_last_entry_or_null(&work->atom_list[dst_type],
-- 
2.30.GIT

