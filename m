Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E741C0015E
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 05:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjFWFqx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 01:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjFWFqw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 01:46:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F047226B5;
        Thu, 22 Jun 2023 22:46:16 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QnR6t6tPvzqTpB;
        Fri, 23 Jun 2023 13:45:58 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 13:46:08 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <anshuman.khandual@arm.com>,
        <jesussanp@google.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v5 1/4] perf trace-event-info: Add tracepoint_id_to_name() helper
Date:   Fri, 23 Jun 2023 05:44:13 +0000
Message-ID: <20230623054416.160858-2-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20230623054416.160858-1-yangjihong1@huawei.com>
References: <20230623054416.160858-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add tracepoint_id_to_name() helper to search for the trace events directory
by given event id and return the corresponding tracepoint.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/trace-event-info.c | 12 ++++++++++++
 tools/perf/util/trace-event.h      |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index c24b3a15e319..319ccf09a435 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -466,6 +466,18 @@ static struct tracepoint_path *tracepoint_id_to_path(u64 config)
 	return NULL;
 }
 
+char *tracepoint_id_to_name(u64 config)
+{
+	struct tracepoint_path *path = tracepoint_id_to_path(config);
+	char *buf = NULL;
+
+	if (path && asprintf(&buf, "%s:%s", path->system, path->name) < 0)
+		buf = NULL;
+
+	put_tracepoints_path(path);
+	return buf;
+}
+
 static struct tracepoint_path *tracepoint_name_to_path(const char *name)
 {
 	struct tracepoint_path *path = zalloc(sizeof(*path));
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index a0cff184b1cd..a69ee29419f3 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -62,6 +62,12 @@ unsigned long long eval_flag(const char *flag);
 
 int read_tracing_data(int fd, struct list_head *pattrs);
 
+/*
+ * Return the tracepoint name in the format "subsystem:event_name",
+ * callers should free the returned string.
+ */
+char *tracepoint_id_to_name(u64 config);
+
 struct tracing_data {
 	/* size is only valid if temp is 'true' */
 	ssize_t size;
-- 
2.30.GIT

