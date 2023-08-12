Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7CBC04A94
	for <linux-perf-users@archiver.kernel.org>; Sat, 12 Aug 2023 08:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbjHLIwE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 12 Aug 2023 04:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbjHLIwD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 12 Aug 2023 04:52:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A270271E;
        Sat, 12 Aug 2023 01:52:06 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RNDrD54zlzTmHx;
        Sat, 12 Aug 2023 16:50:04 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 12 Aug 2023 16:52:03 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <sandipan.das@amd.com>, <ravi.bangoria@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC v1 05/16] perf kwork: Overwrite original atom in the list when a new atom is pushed.
Date:   Sat, 12 Aug 2023 08:49:06 +0000
Message-ID: <20230812084917.169338-6-yangjihong1@huawei.com>
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

work_push_atom() supports nesting. Currently, all supported kworks are not
nested. A `overwrite` parameter is added to overwrite the original atom in
the list.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 42ea59a957ae..f620911a26a2 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -392,9 +392,10 @@ static int work_push_atom(struct perf_kwork *kwork,
 			  struct evsel *evsel,
 			  struct perf_sample *sample,
 			  struct machine *machine,
-			  struct kwork_work **ret_work)
+			  struct kwork_work **ret_work,
+			  bool overwrite)
 {
-	struct kwork_atom *atom, *dst_atom;
+	struct kwork_atom *atom, *dst_atom, *last_atom;
 	struct kwork_work *work, key;
 
 	BUG_ON(class->work_init == NULL);
@@ -427,6 +428,17 @@ static int work_push_atom(struct perf_kwork *kwork,
 	if (ret_work != NULL)
 		*ret_work = work;
 
+	if (overwrite) {
+		last_atom = list_last_entry_or_null(&work->atom_list[src_type],
+						    struct kwork_atom, list);
+		if (last_atom) {
+			atom_del(last_atom);
+
+			kwork->nr_skipped_events[src_type]++;
+			kwork->nr_skipped_events[KWORK_TRACE_MAX]++;
+		}
+	}
+
 	list_add_tail(&atom->list, &work->atom_list[src_type]);
 
 	return 0;
@@ -502,7 +514,7 @@ static int report_entry_event(struct perf_kwork *kwork,
 {
 	return work_push_atom(kwork, class, KWORK_TRACE_ENTRY,
 			      KWORK_TRACE_MAX, evsel, sample,
-			      machine, NULL);
+			      machine, NULL, true);
 }
 
 static int report_exit_event(struct perf_kwork *kwork,
@@ -557,7 +569,7 @@ static int latency_raise_event(struct perf_kwork *kwork,
 {
 	return work_push_atom(kwork, class, KWORK_TRACE_RAISE,
 			      KWORK_TRACE_MAX, evsel, sample,
-			      machine, NULL);
+			      machine, NULL, true);
 }
 
 static int latency_entry_event(struct perf_kwork *kwork,
@@ -716,7 +728,7 @@ static int timehist_raise_event(struct perf_kwork *kwork,
 {
 	return work_push_atom(kwork, class, KWORK_TRACE_RAISE,
 			      KWORK_TRACE_MAX, evsel, sample,
-			      machine, NULL);
+			      machine, NULL, true);
 }
 
 static int timehist_entry_event(struct perf_kwork *kwork,
@@ -730,7 +742,7 @@ static int timehist_entry_event(struct perf_kwork *kwork,
 
 	ret = work_push_atom(kwork, class, KWORK_TRACE_ENTRY,
 			     KWORK_TRACE_RAISE, evsel, sample,
-			     machine, &work);
+			     machine, &work, true);
 	if (ret)
 		return ret;
 
-- 
2.30.GIT

