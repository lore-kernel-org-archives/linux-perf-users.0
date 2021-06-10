Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A640CC48BDF
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 14:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86653613F1
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 14:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhFJOjf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 10 Jun 2021 10:39:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3200 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhFJOjf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Jun 2021 10:39:35 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G15xV3dB4z6G7Hq;
        Thu, 10 Jun 2021 22:30:54 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 16:37:37 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 15:37:33 +0100
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <irogers@google.com>,
        <kjain@linux.ibm.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 1/2] perf metricgroup: Fix find_evsel_group() event selector
Date:   Thu, 10 Jun 2021 22:32:59 +0800
Message-ID: <1623335580-187317-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1623335580-187317-1-git-send-email-john.garry@huawei.com>
References: <1623335580-187317-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The following command segfaults on my x86 broadwell:

$ ./perf stat  -M frontend_bound,retiring,backend_bound,bad_speculation sleep 1
WARNING: grouped events cpus do not match, disabling group:
  anon group { raw 0x10e }
  anon group { raw 0x10e }
perf: util/evsel.c:1596: get_group_fd: Assertion `!(!leader->core.fd)' failed.
Aborted (core dumped)

The issue shows itself as a use-after-free in evlist__check_cpu_maps(),
whereby the leader of an event selector (evsel) has been deleted (yet we
still attempt to verify for an evsel).

Fundamentally the problem comes from metricgroup__setup_events() ->
find_evsel_group(), and has developed from the previous fix attempt in
commit 9c880c24cb0d ("perf metricgroup: Fix for metrics containing
duration_time").

The problem now is that the logic in checking if an evsel is in the same
group is subtely broken for "cycles" event. For "cycles" event, the
pmu_name is NULL; however the logic in find_evsel_group() may set an event
matched against "cycles" as used, when it should not be.

This leads to a condition where an evsel is set, yet its leader is not.

Fix the check for evsel pmu_name by not matching evsels when either has a
NULL pmu_name.

There is still a pre-existing metric issue whereby the ordering of the
metrics may break the 'stat' function, as discussed at:
https://lore.kernel.org/lkml/49c6fccb-b716-1bf0-18a6-cace1cdb66b9@huawei.com/

Fixes: 9c880c24cb0d ("perf metricgroup: Fix for metrics containing duration_time")
Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/metricgroup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8336dd8e8098..c456fdeae06a 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -162,10 +162,10 @@ static bool contains_event(struct evsel **metric_events, int num_events,
 	return false;
 }
 
-static bool evsel_same_pmu(struct evsel *ev1, struct evsel *ev2)
+static bool evsel_same_pmu_or_none(struct evsel *ev1, struct evsel *ev2)
 {
 	if (!ev1->pmu_name || !ev2->pmu_name)
-		return false;
+		return true;
 
 	return !strcmp(ev1->pmu_name, ev2->pmu_name);
 }
@@ -288,7 +288,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			 */
 			if (!has_constraint &&
 			    ev->leader != metric_events[i]->leader &&
-			    evsel_same_pmu(ev->leader, metric_events[i]->leader))
+			    evsel_same_pmu_or_none(ev->leader, metric_events[i]->leader))
 				break;
 			if (!strcmp(metric_events[i]->name, ev->name)) {
 				set_bit(ev->idx, evlist_used);
-- 
2.26.2

