Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0BCC4320E
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D11060F4B
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239585AbhG3Pg7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 11:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbhG3Per (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jul 2021 11:34:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41F0C061798;
        Fri, 30 Jul 2021 08:34:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r2so11863987wrl.1;
        Fri, 30 Jul 2021 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SxRw8//oUZ0sX5jicGZ4KE5X0e/lFiwA1Ow1dfU174o=;
        b=Ke8+7TLPjOHM2LXWYyuFidAT870D87OYKldkAnit/81TNctjy/D3ducL/icg5Xc1dy
         RwJ03Bq+uDFCHCcYVdtdYYDGgE0tnidgNutfdWsf5U8VkppMU//y3ofHlv8VBVczDMbx
         YgGZ8kj9h8Vyd2jW02qZ4GbidfmOmSqxmA4UdpX+dSCznLLxpGQOF+kIxDpDaBnUAQYI
         FJlEpuPmOiGcLFBK8/p3xLRaGJMCh3TmykjP232hakZDT4qk3RX+qnlG14xIeBrJa9Vb
         XZX5EL3lNuj2RAIrLjy1xGK3yBPEZJjs3r0Sw7Yd3h/T1yUETvyziEzaS4dE9m51XYkJ
         KkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SxRw8//oUZ0sX5jicGZ4KE5X0e/lFiwA1Ow1dfU174o=;
        b=s3CGfAY6+EjEc99tMNswj+KWBDkdZxyyO2iHRSHNad8ue90zDr/h43Ww1N+LaH2Wic
         pWPD7K3CFwkjokzbdAUxx+YeQugaLgOynOO4UfeZQ9O32fuOXsyj5Yws1ZMHuc0orTYO
         gxZd8ST2vakFSu+RjvPp043HZmEVOQX9vUtGG2Ccd3QJPUyWMP5t61FrpdLFqBjpru/L
         jLiD0i9Fujer9VjAa7CNBiGgMV7z5AVb1zqJnWvIl/bGoxQabGDweOiiQpVCqEGQ7F8X
         jJygmMz0lACNnOpoH6hR+3A3liZLCm4nPfJuD+DI/SMd8zt0GWtUh416d9Id1usax9Dr
         W3tg==
X-Gm-Message-State: AOAM533Hm8k4VTD5xro/0m6hPuXKKUwGZYt2LUTc2Ourzpe6zNwcCTyW
        v/yEiPJm26gGfzspEGfvPXg=
X-Google-Smtp-Source: ABdhPJy053v+DPHhmxFJw1v5vcpe+Kzo1bPpywfCUzToXGtVxpFDyry5ESHzcZwOoXvcgKiG1VTdcg==
X-Received: by 2002:adf:f4c5:: with SMTP id h5mr1952817wrp.292.1627659263438;
        Fri, 30 Jul 2021 08:34:23 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id v15sm2354727wmj.39.2021.07.30.08.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:34:23 -0700 (PDT)
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
Subject: [RFC PATCH v2 01/10] perf workqueue: threadpool creation and destruction
Date:   Fri, 30 Jul 2021 17:34:08 +0200
Message-Id: <4f0cd6c8e77c0b4f4d4b8d553a7032757b976e61.1627657061.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627657061.git.rickyman7@gmail.com>
References: <cover.1627657061.git.rickyman7@gmail.com>
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
 tools/perf/util/workqueue/threadpool.c | 208 +++++++++++++++++++++++++
 tools/perf/util/workqueue/threadpool.h |  30 ++++
 4 files changed, 240 insertions(+)
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
index 0000000000000000..0004ce606d5fa73d
--- /dev/null
+++ b/tools/perf/util/workqueue/threadpool.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include <string.h>
+#include "debug.h"
+#include <asm/bug.h>
+#include <linux/zalloc.h>
+#include <linux/string.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include "threadpool.h"
+
+enum threadpool_status {
+	THREADPOOL_STATUS__STOPPED,		/* no threads */
+	THREADPOOL_STATUS__ERROR,		/* errors */
+	THREADPOOL_STATUS__MAX
+};
+
+struct threadpool {
+	int			nr_threads;	/* number of threads in the pool */
+	struct threadpool_entry	*threads;	/* array of threads in the pool */
+	struct task_struct	*current_task;	/* current executing function */
+	enum threadpool_status	status;		/* current status of the pool */
+};
+
+struct threadpool_entry {
+	int				idx;	/* idx of thread in pool->threads */
+	pid_t				tid;	/* tid of thread */
+	struct threadpool		*pool;	/* parent threadpool */
+	struct {
+		int ack[2];			/* messages from thread (acks) */
+		int cmd[2];			/* messages to thread (commands) */
+	} pipes;
+};
+
+/**
+ * threadpool_entry__init_pipes - initialize all pipes of @thread
+ */
+static void threadpool_entry__init_pipes(struct threadpool_entry *thread)
+{
+	thread->pipes.ack[0] = -1;
+	thread->pipes.ack[1] = -1;
+	thread->pipes.cmd[0] = -1;
+	thread->pipes.cmd[1] = -1;
+}
+
+/**
+ * threadpool_entry__open_pipes - open all pipes of @thread
+ */
+static int threadpool_entry__open_pipes(struct threadpool_entry *thread)
+{
+	if (pipe(thread->pipes.ack)) {
+		pr_debug2("threadpool: failed to create comm pipe 'from': %s\n",
+			strerror(errno));
+		return -ENOMEM;
+	}
+
+	if (pipe(thread->pipes.cmd)) {
+		pr_debug2("threadpool: failed to create comm pipe 'to': %s\n",
+			strerror(errno));
+		close(thread->pipes.ack[0]);
+		thread->pipes.ack[0] = -1;
+		close(thread->pipes.ack[1]);
+		thread->pipes.ack[1] = -1;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/**
+ * threadpool_entry__close_pipes - close all communication pipes of @thread
+ */
+static void threadpool_entry__close_pipes(struct threadpool_entry *thread)
+{
+	if (thread->pipes.ack[0] != -1) {
+		close(thread->pipes.ack[0]);
+		thread->pipes.ack[0] = -1;
+	}
+	if (thread->pipes.ack[1] != -1) {
+		close(thread->pipes.ack[1]);
+		thread->pipes.ack[1] = -1;
+	}
+	if (thread->pipes.cmd[0] != -1) {
+		close(thread->pipes.cmd[0]);
+		thread->pipes.cmd[0] = -1;
+	}
+	if (thread->pipes.cmd[1] != -1) {
+		close(thread->pipes.cmd[1]);
+		thread->pipes.cmd[1] = -1;
+	}
+}
+
+/**
+ * threadpool__new - create a fixed threadpool with @n_threads threads
+ */
+struct threadpool *threadpool__new(int n_threads)
+{
+	int ret, err, t;
+	struct threadpool *pool = malloc(sizeof(*pool));
+
+	if (!pool) {
+		pr_debug2("threadpool: cannot allocate pool: %s\n",
+			strerror(errno));
+		err = -ENOMEM;
+		goto out_return;
+	}
+
+	if (n_threads <= 0) {
+		pr_debug2("threadpool: invalid number of threads: %d\n",
+			n_threads);
+		err = -EINVAL;
+		goto out_free_pool;
+	}
+
+	pool->nr_threads = n_threads;
+	pool->current_task = NULL;
+
+	pool->threads = calloc(n_threads, sizeof(*pool->threads));
+	if (!pool->threads) {
+		pr_debug2("threadpool: cannot allocate threads: %s\n",
+			strerror(errno));
+		err = -ENOMEM;
+		goto out_free_pool;
+	}
+
+	for (t = 0; t < n_threads; t++) {
+		pool->threads[t].idx = t;
+		pool->threads[t].tid = -1;
+		pool->threads[t].pool = pool;
+		threadpool_entry__init_pipes(&pool->threads[t]);
+	}
+
+	for (t = 0; t < n_threads; t++) {
+		ret = threadpool_entry__open_pipes(&pool->threads[t]);
+		if (ret) {
+			err = -ret;
+			goto out_close_pipes;
+		}
+	}
+
+	pool->status = THREADPOOL_STATUS__STOPPED;
+
+	return pool;
+
+out_close_pipes:
+	for (t = 0; t < n_threads; t++)
+		threadpool_entry__close_pipes(&pool->threads[t]);
+
+	zfree(&pool->threads);
+out_free_pool:
+	free(pool);
+out_return:
+	return ERR_PTR(err);
+}
+
+/**
+ * threadpool__strerror - print message regarding given @err in @pool
+ *
+ * Buffer size should be at least THREADPOOL_STRERR_BUFSIZE bytes.
+ */
+int threadpool__strerror(struct threadpool *pool __maybe_unused, int err, char *buf, size_t size)
+{
+	char sbuf[STRERR_BUFSIZE], *emsg;
+
+	emsg = str_error_r(err, sbuf, sizeof(sbuf));
+	return scnprintf(buf, size, "Error: %s.\n", emsg);
+}
+
+/**
+ * threadpool__new_strerror - print message regarding @err_ptr
+ *
+ * Buffer size should be at least THREADPOOL_STRERR_BUFSIZE bytes.
+ */
+int threadpool__new_strerror(struct threadpool *err_ptr, char *buf, size_t size)
+{
+	return threadpool__strerror(err_ptr, PTR_ERR(err_ptr), buf, size);
+}
+
+/**
+ * threadpool__delete - free the @pool and all its resources
+ */
+void threadpool__delete(struct threadpool *pool)
+{
+	int t;
+
+	if (IS_ERR_OR_NULL(pool))
+		return;
+
+	WARN_ON(pool->status != THREADPOOL_STATUS__STOPPED
+		&& pool->status != THREADPOOL_STATUS__ERROR);
+
+	for (t = 0; t < pool->nr_threads; t++)
+		threadpool_entry__close_pipes(&pool->threads[t]);
+
+	zfree(&pool->threads);
+	free(pool);
+}
+
+/**
+ * threadpool__size - get number of threads in the threadpool
+ */
+int threadpool__size(struct threadpool *pool)
+{
+	return pool->nr_threads;
+}
diff --git a/tools/perf/util/workqueue/threadpool.h b/tools/perf/util/workqueue/threadpool.h
new file mode 100644
index 0000000000000000..fb18aa32fb64f671
--- /dev/null
+++ b/tools/perf/util/workqueue/threadpool.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __WORKQUEUE_THREADPOOL_H
+#define __WORKQUEUE_THREADPOOL_H
+
+struct threadpool;
+struct task_struct;
+
+typedef void (*task_func_t)(int tidx, struct task_struct *task);
+
+struct task_struct {
+	task_func_t fn;
+};
+
+extern struct threadpool *threadpool__new(int n_threads);
+extern void threadpool__delete(struct threadpool *pool);
+
+extern int threadpool__start(struct threadpool *pool);
+extern int threadpool__stop(struct threadpool *pool);
+
+extern int threadpool__execute(struct threadpool *pool, struct task_struct *task);
+extern int threadpool__wait(struct threadpool *pool);
+
+extern int threadpool__size(struct threadpool *pool);
+
+/* Error management */
+#define THREADPOOL_STRERR_BUFSIZE (128+STRERR_BUFSIZE)
+extern int threadpool__strerror(struct threadpool *pool, int err, char *buf, size_t size);
+extern int threadpool__new_strerror(struct threadpool *err_ptr, char *buf, size_t size);
+
+#endif /* __WORKQUEUE_THREADPOOL_H */
-- 
2.31.1

