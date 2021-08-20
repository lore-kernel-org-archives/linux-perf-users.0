Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C898C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013A560FE8
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239861AbhHTKza (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239403AbhHTKzN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 06:55:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F9CC061575;
        Fri, 20 Aug 2021 03:54:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r19so13354484eds.13;
        Fri, 20 Aug 2021 03:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eCdBEtrU7CII7A1ikCE1/NS99NEQQoA1vVPvKWOOetQ=;
        b=DyKBEd7uEHaEajl3j0govc1fPM+ZZzjZ9ECdv839kuWWKl59aIEA9II40QzTl6WUOt
         /Y9u7132H1u4BhMocw6ICPk7aI2bv4jy5gjpvb+qpOEaM19oCHGvBcUajLEnB8ODkw0/
         ayeAinFI3MG1U19Crpv27A5daBCiEembwlcamKn3x23I3/Oz6TgOyTKNp1CQeaPsQXs+
         Lw1l4fHqSa1srryc6mCEJ0NJxeiLKzr40D/9AXdhNIqjR2VKwJa/29gB2jw3P+ySiExI
         yNPcrrxw82IYBhSyFfZLqqVtJn/ZlPRntya1qOQohyrxZXP8bXaqlHP8NBbQOvv9usOG
         zG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eCdBEtrU7CII7A1ikCE1/NS99NEQQoA1vVPvKWOOetQ=;
        b=ZIgMBy1/YPBL11wqj0BhT+cZDHd5epy3ab7a9jUsHFcZqejmIH74RZCIRcl+h9XM1x
         bcjcJLi/5LqJqeYNYy1MHWewhJtt4g+SCumbQQMP6oiAjK7kRmjEBK+KpG56THlNbNbj
         GvfzKf08vebLIxkyin43gFxUQB8PbQ0SBGMvndhsQHwKNC3WokmBofkSXFVHUVyaw5gw
         VQEqKB+tDV/j/n0/uEYpnkX5KI/GM9rwN68c4wdTIA1bLmo7+VE9ovS6ltVx5gurX4QW
         i4PXZZitG5tL5/IB14oMD/TtUY5xtN72QtI+p2lxOUWj/R4AUlTvYay6SjHWM8tdFgXW
         EyVw==
X-Gm-Message-State: AOAM531OUx1bLn28JTzaL8zOjqTyXVcu4cOsic5VnoTtq42sTGbIch9J
        9+S2oyKlwDkqsaOf4E8RtqzZi3pm1Ktb4QBHwzQ=
X-Google-Smtp-Source: ABdhPJyOFlOzq+ofA7dR/rJT+eEP/FImvsxoDVahkdb/cyhqQlXKDlGBUEKagIS79Yi1Xr0tYeDamQ==
X-Received: by 2002:a05:6402:8ce:: with SMTP id d14mr21700113edz.228.1629456866754;
        Fri, 20 Aug 2021 03:54:26 -0700 (PDT)
Received: from honeypot.epfl.ch (mob-176-243-199-7.net.vodafone.it. [176.243.199.7])
        by smtp.googlemail.com with ESMTPSA id g29sm3451459edf.31.2021.08.20.03.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 03:54:25 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v3 10/15] perf workqueue: create global workqueue
Date:   Fri, 20 Aug 2021 12:53:56 +0200
Message-Id: <f10597457f953d565515d6a885821b0ac445e89b.1629454773.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629454773.git.rickyman7@gmail.com>
References: <cover.1629454773.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds a global static workqueue, using the same API from the
kernel (schedule_work, flush_scheduled_work, and so on).

Before use, the global workqueue should be set up using
setup_global_workqueue and eventually destroyed using
teardown_global_workqueue.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/workqueue/workqueue.c |  2 ++
 tools/perf/util/workqueue/workqueue.h | 49 +++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/tools/perf/util/workqueue/workqueue.c b/tools/perf/util/workqueue/workqueue.c
index 305a9cda39810b84..a89370e68bd720c8 100644
--- a/tools/perf/util/workqueue/workqueue.c
+++ b/tools/perf/util/workqueue/workqueue.c
@@ -13,6 +13,8 @@
 #include <internal/lib.h>
 #include "workqueue.h"
 
+struct workqueue_struct *global_wq;
+
 enum worker_msg {
 	WORKER_MSG__UNDEFINED,
 	WORKER_MSG__READY,                          /* from worker: ack */
diff --git a/tools/perf/util/workqueue/workqueue.h b/tools/perf/util/workqueue/workqueue.h
index 37ef84fc9c6ed4b6..fc6166757f0e1d0d 100644
--- a/tools/perf/util/workqueue/workqueue.h
+++ b/tools/perf/util/workqueue/workqueue.h
@@ -5,6 +5,7 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <linux/list.h>
+#include <linux/err.h>
 #include "threadpool.h"
 
 struct work_struct;
@@ -29,6 +30,54 @@ extern int flush_workqueue(struct workqueue_struct *wq);
 
 extern void init_work(struct work_struct *work);
 
+/* Global workqueue */
+
+extern struct workqueue_struct *global_wq;
+
+/**
+ * setup_global_wq - create the global_wq
+ */
+static inline int setup_global_workqueue(int nr_threads)
+{
+	global_wq = create_workqueue(nr_threads);
+	return IS_ERR(global_wq) ? PTR_ERR(global_wq) : 0;
+}
+
+/**
+ * teardown_global_wq - destroy the global_wq
+ */
+static inline int teardown_global_workqueue(void)
+{
+	int ret = destroy_workqueue(global_wq);
+
+	global_wq = NULL;
+	return ret;
+}
+
+/**
+ * schedule_work - queue @work on the global_wq
+ */
+static inline int schedule_work(struct work_struct *work)
+{
+	return queue_work(global_wq, work);
+}
+
+/**
+ * schedule_work - queue @work on thread @tidx of global_wq
+ */
+static inline int schedule_work_on_worker(int tidx, struct work_struct *work)
+{
+	return queue_work_on_worker(tidx, global_wq, work);
+}
+
+/**
+ * flush_scheduled_work - ensure that any scheduled work in global_wq has run to completion
+ */
+static inline int flush_scheduled_work(void)
+{
+	return flush_workqueue(global_wq);
+}
+
 #define WORKQUEUE_STRERR_BUFSIZE (128+THREADPOOL_STRERR_BUFSIZE)
 #define WORKQUEUE_ERROR__OFFSET 512
 enum {
-- 
2.31.1

