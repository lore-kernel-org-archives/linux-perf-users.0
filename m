Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9411AEB64DB
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Jun 2023 15:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjFTP5N (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 20 Jun 2023 11:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjFTP5K (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Jun 2023 11:57:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4052AB4;
        Tue, 20 Jun 2023 08:57:08 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QlrqJ0mmXz1FDf8;
        Tue, 20 Jun 2023 23:57:00 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 20 Jun 2023 23:57:05 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 2/2] perf/core: deliver PERF_RECORD_COMM and PERF_RECORD_MMAP side-band events to all online cpus
Date:   Tue, 20 Jun 2023 15:55:15 +0000
Message-ID: <20230620155515.101222-3-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20230620155515.101222-1-yangjihong1@huawei.com>
References: <20230620155515.101222-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Tasks are migrated between cores due to scheduling.
If perf samples specified CPUs, PERF_RECORD_COMM and PERF_RECORD_MMAP
events need be deliver to all cores to avoids the problem that the comm
and symbols cannot be parsed due to task migration to the target core.

The specific scenarios are as follows:

         CPU0                                 CPU1
  perf record -C 0 start
                              taskA starts to be created and executed
                                -> PERF_RECORD_COMM and PERF_RECORD_MMAP
                                   events only deliver to CPU1
                              ......
                                |
                          migrate to CPU0
                                |
  Running on CPU0    <----------/
  ...

  perf record -C 0 stop

Now perf samples the PC of taskA. However, perf does not record the
PERF_RECORD_COMM and PERF_RECORD_COMM events of taskA.
Therefore, the comm and symbols of taskA cannot be parsed.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 66dbca1ba577..a014b2063af1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8276,7 +8276,7 @@ static void perf_event_comm_event(struct perf_comm_event *comm_event)
 	perf_iterate_sb(perf_event_comm_output,
 			comm_event,
 			NULL,
-			false);
+			true);
 }
 
 void perf_event_comm(struct task_struct *task, bool exec)
@@ -8755,7 +8755,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 	perf_iterate_sb(perf_event_mmap_output,
 			mmap_event,
 			NULL,
-			false);
+			true);
 
 	kfree(buf);
 }
-- 
2.30.GIT

