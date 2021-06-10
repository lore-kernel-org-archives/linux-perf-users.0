Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FE3C48BD1
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 14:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9915613F1
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 14:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhFJOjj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 10 Jun 2021 10:39:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3201 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhFJOji (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Jun 2021 10:39:38 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G15tV42XHz6H6gv;
        Thu, 10 Jun 2021 22:28:18 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 16:37:40 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 15:37:37 +0100
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <irogers@google.com>,
        <kjain@linux.ibm.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 2/2] perf metricgroup: Return error code from metricgroup__add_metric_sys_event_iter()
Date:   Thu, 10 Jun 2021 22:33:00 +0800
Message-ID: <1623335580-187317-3-git-send-email-john.garry@huawei.com>
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

The error code is not set at all in the sys event iter function.

This may lead to an uninitialized value of "ret" in
metricgroup__add_metric() when no CPU metric is added.

Fix by properly setting the error code.

It is not necessary to init "ret" to 0 in metricgroup__add_metric(), as
if we have no CPU or sys event metric matching, then "has_match" should
be 0 and "ret" is set to -EINVAL.

However gcc cannot detect that it may not have been set after the
map_for_each_metric() loop for CPU metrics, which is strange.

Fixes: be335ec28efa8 ("perf metricgroup: Support adding metrics for system PMUs")
Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/metricgroup.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index c456fdeae06a..d3cf2dee36c8 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1073,16 +1073,18 @@ static int metricgroup__add_metric_sys_event_iter(struct pmu_event *pe,
 
 	ret = add_metric(d->metric_list, pe, d->metric_no_group, &m, NULL, d->ids);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = resolve_metric(d->metric_no_group,
 				     d->metric_list, NULL, d->ids);
 	if (ret)
-		return ret;
+		goto out;
 
 	*(d->has_match) = true;
 
-	return *d->ret;
+out:
+	*(d->ret) = ret;
+	return ret;
 }
 
 static int metricgroup__add_metric(const char *metric, bool metric_no_group,
-- 
2.26.2

