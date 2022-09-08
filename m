Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60754C6FA89
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Sep 2022 01:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiIHBhH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Sep 2022 21:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIHBhF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Sep 2022 21:37:05 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF38C6CF5;
        Wed,  7 Sep 2022 18:37:04 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MNMBM66fGzHncw;
        Thu,  8 Sep 2022 09:35:07 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 8 Sep 2022 09:37:03 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 8 Sep
 2022 09:37:02 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 3/4] perf timechart: Add create_pidcomm helper
Date:   Thu, 8 Sep 2022 10:11:40 +0800
Message-ID: <20220908021141.27134-4-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220908021141.27134-1-shangxiaojing@huawei.com>
References: <20220908021141.27134-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Wrap repeated code combined with alloc of per_pidcomm in helper function
create_pidcomm.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 tools/perf/builtin-timechart.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index e2e9ad929baf..667a94d45493 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -215,6 +215,19 @@ static struct per_pid *find_create_pid(struct timechart *tchart, int pid)
 	return cursor;
 }
 
+static struct per_pidcomm *create_pidcomm(struct per_pid *p)
+{
+	struct per_pidcomm *c;
+
+	c = zalloc(sizeof(*c));
+	if (!c)
+		return NULL;
+	p->current = c;
+	c->next = p->all;
+	p->all = c;
+	return c;
+}
+
 static void pid_set_comm(struct timechart *tchart, int pid, char *comm)
 {
 	struct per_pid *p;
@@ -233,12 +246,9 @@ static void pid_set_comm(struct timechart *tchart, int pid, char *comm)
 		}
 		c = c->next;
 	}
-	c = zalloc(sizeof(*c));
+	c = create_pidcomm(p);
 	assert(c != NULL);
 	c->comm = strdup(comm);
-	p->current = c;
-	c->next = p->all;
-	p->all = c;
 }
 
 static void pid_fork(struct timechart *tchart, int pid, int ppid, u64 timestamp)
@@ -277,11 +287,8 @@ static void pid_put_sample(struct timechart *tchart, int pid, int type,
 	p = find_create_pid(tchart, pid);
 	c = p->current;
 	if (!c) {
-		c = zalloc(sizeof(*c));
+		c = create_pidcomm(p);
 		assert(c != NULL);
-		p->current = c;
-		c->next = p->all;
-		p->all = c;
 	}
 
 	sample = zalloc(sizeof(*sample));
@@ -726,12 +733,9 @@ static int pid_begin_io_sample(struct timechart *tchart, int pid, int type,
 	struct io_sample *prev;
 
 	if (!c) {
-		c = zalloc(sizeof(*c));
+		c = create_pidcomm(p);
 		if (!c)
 			return -ENOMEM;
-		p->current = c;
-		c->next = p->all;
-		p->all = c;
 	}
 
 	prev = c->io_samples;
-- 
2.17.1

