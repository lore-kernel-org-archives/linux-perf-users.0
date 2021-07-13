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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA16C07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12149610D1
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbhGMMOY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 08:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbhGMMOY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 08:14:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED564C0613E9;
        Tue, 13 Jul 2021 05:11:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f17so30177405wrt.6;
        Tue, 13 Jul 2021 05:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zbu3xed4FVceBb1sRv3k/hOdnw405/iMg8ZcmcQ4j3c=;
        b=hwMbFft4JUQI4rQNZtIBq9c7gFRSEoJFX4b4v4Wi6StcvjeA634ybZno9+Uv+IEWbc
         s29m+uHuM7eLe/80WwEvFSTS13ID4rScEgsk/l8EgQCp4hIGqijKdKQrw0kyO11xQRap
         3G07HS/eVX07V6J+5pGyP8sv8onpb5M6STAAB60sq6DPkReFspyKZxa0oBSX1W7/gHPQ
         oqW4l8A2cZHh3YNx2fdXwrRaRhN/NynXIvUPWR8KNUAPapw8DsGM52kJkFLboOUj3EXJ
         KtRmOUz3Pq7ImDDC3czmqxH0TxymQC/K530O8oJ4hxZBUo1vyO7ve1s82NxTY5sfZLkP
         4mfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zbu3xed4FVceBb1sRv3k/hOdnw405/iMg8ZcmcQ4j3c=;
        b=mLRd5ztX6bLtZ5/sik3VzoOed1bKNYmK3B6n+VZeRJ002c9/21XtsEOmqmhXMjjoXQ
         F3QGnglsKVab7GtWcYqqFybvw8JdHxPC3drMe9QwffsVdURp7p5XaSrFH0mVllMHLL0e
         SBEm47EDzDUAUE4O/WBssoCVyBgJWUfRftYKbdWUg4cdH6XvFdQpZwxmA1XTAekjcUJt
         /OVqAVhu8I4wPWGVQ61QLOZjKiNUZVZJW1qhoBNzCpHC2jomieq02Xvx6k4LoCbdvaby
         cb7+2eosLoMRRKf4by0Nt2wXYphsSBM/LkhRplZg8QrVq4tdhvI48QN5qEMmJjhmxVmo
         g9dQ==
X-Gm-Message-State: AOAM5306attXjntj85sORi2nb7KMKSJ0iisGXZV6szpNHtUqBaKO7EvJ
        Bq6ZYWccsDMPR+HBUFOWT1o=
X-Google-Smtp-Source: ABdhPJwzbwEzYHtTtbDlqd6gQARgCUBM6qqykXxE1U54cJbBSMdJMUgs3KjwcKj2t4Ia26fYfjAd+Q==
X-Received: by 2002:a05:6000:1d1:: with SMTP id t17mr5155623wrx.267.1626178292398;
        Tue, 13 Jul 2021 05:11:32 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id o3sm17551425wrw.56.2021.07.13.05.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 05:11:31 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Subject: [RFC PATCH 01/10] perf workqueue: threadpool creation and destruction
Date:   Tue, 13 Jul 2021 14:11:12 +0200
Message-Id: <46f9e291af3d87c212d279717d56eeab4cbfde68.1626177381.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626177381.git.rickyman7@gmail.com>
References: <cover.1626177381.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The workqueue library is made up by two components:
 - threadpool: handles the lifetime of the threads
 - workqueue: handles work distribution among the threads

This first patch introduces the threadpool, starting from its creation
and destruction functions.
Thread management is based on the prototype from Alexey:
https://lore.kernel.org/lkml/cover.1625227739.git.alexey.v.bayduraev@linux.intel.com/

Each thread in the threadpool executes the same function (aka task)
with a different argument tidx.
Threads use a pair of pipes to communicate with the main process.
The threadpool is static (all threads will be spawned at the same time).
Future work could include making it resizable and adding affinity support
(as in Alexey prototype).

Suggested-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/Build                  |   1 +
 tools/perf/util/workqueue/Build        |   1 +
 tools/perf/util/workqueue/threadpool.c | 175 +++++++++++++++++++++++++
 tools/perf/util/workqueue/threadpool.h |  19 +++
 4 files changed, 196 insertions(+)
 create mode 100644 tools/perf/util/workqueue/Build
 create mode 100644 tools/perf/util/workqueue/threadpool.c
 create mode 100644 tools/perf/util/workqueue/threadpool.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 2d4fa13041789cd6..c7b09701661c869d 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -180,6 +180,7 @@ perf-$(CONFIG_LIBBABELTRACE) += data-convert-bt.o
 perf-y += data-convert-json.o
 
 perf-y += scripting-engines/
+perf-y += workqueue/
 
 perf-$(CONFIG_ZLIB) += zlib.o
 perf-$(CONFIG_LZMA) += lzma.o
diff --git a/tools/perf/util/workqueue/Build b/tools/perf/util/workqueue/Build
new file mode 100644
index 0000000000000000..8b72a6cd4e2cba0d
--- /dev/null
+++ b/tools/perf/util/workqueue/Build
@@ -0,0 +1 @@
+perf-y += threadpool.o
diff --git a/tools/perf/util/workqueue/threadpool.c b/tools/perf/util/workqueue/threadpool.c
new file mode 100644
index 0000000000000000..70c67569f956a3e2
--- /dev/null
+++ b/tools/perf/util/workqueue/threadpool.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include <string.h>
+#include "debug.h"
+#include "asm/bug.h"
+#include "threadpool.h"
+
+enum threadpool_status {
+	THREADPOOL_STATUS__STOPPED,		/* no threads */
+	THREADPOOL_STATUS__ERROR,		/* errors */
+	THREADPOOL_STATUS__MAX
+};
+
+struct threadpool_struct {
+	int			nr_threads;	/* number of threads in the pool */
+	struct thread_struct	*threads;	/* array of threads in the pool */
+	struct task_struct	*current_task;	/* current executing function */
+	enum threadpool_status	status;		/* current status of the pool */
+};
+
+struct thread_struct {
+	int				idx;	/* idx of thread in pool->threads */
+	pid_t				tid;	/* tid of thread */
+	struct threadpool_struct	*pool;	/* parent threadpool */
+	struct {
+		int from[2];			/* messages from thread (acks) */
+		int to[2];			/* messages to thread (commands) */
+	} pipes;
+};
+
+/**
+ * init_pipes - initialize all pipes of @thread
+ */
+static void init_pipes(struct thread_struct *thread)
+{
+	thread->pipes.from[0] = -1;
+	thread->pipes.from[1] = -1;
+	thread->pipes.to[0] = -1;
+	thread->pipes.to[1] = -1;
+}
+
+/**
+ * open_pipes - open all pipes of @thread
+ */
+static int open_pipes(struct thread_struct *thread)
+{
+	if (pipe(thread->pipes.from)) {
+		pr_err("threadpool: failed to create comm pipe 'from': %s\n",
+			strerror(errno));
+		return -ENOMEM;
+	}
+
+	if (pipe(thread->pipes.to)) {
+		pr_err("threadpool: failed to create comm pipe 'to': %s\n",
+			strerror(errno));
+		close(thread->pipes.from[0]);
+		thread->pipes.from[0] = -1;
+		close(thread->pipes.from[1]);
+		thread->pipes.from[1] = -1;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/**
+ * close_pipes - close all communication pipes of @thread
+ */
+static void close_pipes(struct thread_struct *thread)
+{
+	if (thread->pipes.from[0] != -1) {
+		close(thread->pipes.from[0]);
+		thread->pipes.from[0] = -1;
+	}
+	if (thread->pipes.from[1] != -1) {
+		close(thread->pipes.from[1]);
+		thread->pipes.from[1] = -1;
+	}
+	if (thread->pipes.to[0] != -1) {
+		close(thread->pipes.to[0]);
+		thread->pipes.to[0] = -1;
+	}
+	if (thread->pipes.to[1] != -1) {
+		close(thread->pipes.to[1]);
+		thread->pipes.to[1] = -1;
+	}
+}
+
+/**
+ * create_threadpool - create a fixed threadpool with @n_threads threads
+ */
+struct threadpool_struct *create_threadpool(int n_threads)
+{
+	int ret, t;
+	struct threadpool_struct *pool = malloc(sizeof(*pool));
+
+	if (!pool) {
+		pr_err("threadpool: cannot allocate pool: %s\n",
+			strerror(errno));
+		return NULL;
+	}
+
+	if (n_threads <= 0) {
+		pr_err("threadpool: invalid number of threads: %d\n",
+			n_threads);
+		goto out_free_pool;
+	}
+
+	pool->nr_threads = n_threads;
+	pool->current_task = NULL;
+
+	pool->threads = malloc(n_threads * sizeof(*pool->threads));
+	if (!pool->threads) {
+		pr_err("threadpool: cannot allocate threads: %s\n",
+			strerror(errno));
+		goto out_free_pool;
+	}
+
+	for (t = 0; t < n_threads; t++) {
+		pool->threads[t].idx = t;
+		pool->threads[t].tid = -1;
+		pool->threads[t].pool = pool;
+		init_pipes(&pool->threads[t]);
+	}
+
+	for (t = 0; t < n_threads; t++) {
+		ret = open_pipes(&pool->threads[t]);
+		if (ret)
+			goto out_close_pipes;
+	}
+
+	pool->status = THREADPOOL_STATUS__STOPPED;
+
+	return pool;
+
+out_close_pipes:
+	for (t = 0; t < n_threads; t++)
+		close_pipes(&pool->threads[t]);
+
+	free(pool->threads);
+out_free_pool:
+	free(pool);
+	return NULL;
+}
+
+/**
+ * destroy_threadpool - free the @pool and all its resources
+ */
+void destroy_threadpool(struct threadpool_struct *pool)
+{
+	int t;
+
+	if (!pool)
+		return;
+
+	WARN_ON(pool->status != THREADPOOL_STATUS__STOPPED
+		&& pool->status != THREADPOOL_STATUS__ERROR);
+
+	for (t = 0; t < pool->nr_threads; t++)
+		close_pipes(&pool->threads[t]);
+
+	free(pool->threads);
+	free(pool);
+}
+
+/**
+ * threadpool_size - get number of threads in the threadpool
+ */
+int threadpool_size(struct threadpool_struct *pool)
+{
+	return pool->nr_threads;
+}
diff --git a/tools/perf/util/workqueue/threadpool.h b/tools/perf/util/workqueue/threadpool.h
new file mode 100644
index 0000000000000000..2b9388c768a0b588
--- /dev/null
+++ b/tools/perf/util/workqueue/threadpool.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __WORKQUEUE_THREADPOOL_H
+#define __WORKQUEUE_THREADPOOL_H
+
+struct threadpool_struct;
+struct task_struct;
+
+typedef void (*task_func_t)(int tidx, struct task_struct *task);
+
+struct task_struct {
+	task_func_t fn;
+};
+
+extern struct threadpool_struct *create_threadpool(int n_threads);
+extern void destroy_threadpool(struct threadpool_struct *pool);
+
+extern int threadpool_size(struct threadpool_struct *pool);
+
+#endif /* __WORKQUEUE_THREADPOOL_H */
-- 
2.31.1

