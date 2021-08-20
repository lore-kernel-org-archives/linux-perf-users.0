Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE5AC4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F9AF6109D
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbhHTKyu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbhHTKyr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 06:54:47 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC7BC061756;
        Fri, 20 Aug 2021 03:54:09 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r19so13353383eds.13;
        Fri, 20 Aug 2021 03:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uU2IQ1ngRJIjJIHc2FG0E9/4hhnO6UqWl7czhXuy3S4=;
        b=sP/DaB7+CvbKalyyfdTvW3dTPZneMMuc/WJDqLpslApmUWva/1oQqo9Y55ZypJFMqO
         IOXtcKfUi8WRljWzEJleJKw4QbznGgOKdnZWkHrLLfo5dm5rza8VSm4A4Vko/6VMtBP3
         mHt1o/b5FWpt3m8SESuQHWDqP78uj1vu2LZHnjjwerYd9QIvqydE8sAhjHU4CPaGM6mu
         xDALJ1+UHGefvmUOdZ0wH2VftCOVKnYaGjRcJSLFuBQOswJxCqW1yx0uvbrn7/m/+2L/
         tgSfFlFoCdRB4oa7YeGIWXsM7N8ixJFAv6jnPQQ4JY5qeQLApJOIceyfBfxOZG9Z7Td5
         4Itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uU2IQ1ngRJIjJIHc2FG0E9/4hhnO6UqWl7czhXuy3S4=;
        b=AnMVbMra/Pb8dWdzxyN3Llhu8Rr/dvwf8vEpYLwgCuvSNYU5TIOD4LNUOGLhOgwsKs
         aXhrr5A2cGHM3c9XyisgEVtIkGyTOaEYYnFit8o4EDptIXqyuuG/n+BOgwYAENk4MSXF
         8TjCFXK6Rz1fiUrA3kE7RVBmWt/YmdDPI+Cau7QMXoHJUw39xjaKzwy/3uy1bafviOnG
         uWiHwwJcd/WoAWAJa+e3TLUqp/S3OJ8f31UHSIHAb1p5fwkwcLnWUn4v/Q7xA6c4Oi9w
         bdPVHrjHIgSB+5njENvyxyuVz74U38Yg3ZKWEJl51jXqmcJ0OOdp+gX2H1CldG1WEnDc
         vlhA==
X-Gm-Message-State: AOAM530LOtJJjMaY65vNAeDHvcgjc2gyhAuMvfbrX+Pa3BX6/NTnbm/K
        lTdw5wbCoRAf6mFvcI5TNYE=
X-Google-Smtp-Source: ABdhPJy2QPERh7AHBQFQbUYFSH3sJQM2gdLu/mCxI5yzYlcw/F9Q4AzDpb8ffGqhW+Qb7WMKC4baAw==
X-Received: by 2002:a05:6402:70c:: with SMTP id w12mr21035047edx.288.1629456848437;
        Fri, 20 Aug 2021 03:54:08 -0700 (PDT)
Received: from honeypot.epfl.ch (mob-176-243-199-7.net.vodafone.it. [176.243.199.7])
        by smtp.googlemail.com with ESMTPSA id g29sm3451459edf.31.2021.08.20.03.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 03:54:07 -0700 (PDT)
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
Subject: [RFC PATCH v3 01/15] perf workqueue: threadpool creation and destruction
Date:   Fri, 20 Aug 2021 12:53:47 +0200
Message-Id: <542abfa6cafdc28e5001495cf8b45b0b394e8b66.1629454773.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629454773.git.rickyman7@gmail.com>
References: <cover.1629454773.git.rickyman7@gmail.com>
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
 tools/perf/util/workqueue/threadpool.c | 205 +++++++++++++++++++++++++
 tools/perf/util/workqueue/threadpool.h |  24 +++
 4 files changed, 231 insertions(+)
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
index 0000000000000000..17672cb089afcf1d
--- /dev/null
+++ b/tools/perf/util/workqueue/threadpool.c
@@ -0,0 +1,205 @@
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
+#include <pthread.h>
+#include "threadpool.h"
+
+struct threadpool {
+	int			nr_threads;	/* number of threads in the pool */
+	struct threadpool_entry	*threads;	/* array of threads in the pool */
+	struct task_struct	*current_task;	/* current executing function */
+};
+
+struct threadpool_entry {
+	int				idx;	/* idx of thread in pool->threads */
+	pid_t				tid;	/* tid of thread */
+	pthread_t			ptid;   /* pthread id */
+	struct threadpool		*pool;	/* parent threadpool */
+	struct {
+		int ack[2];			/* messages from thread (acks) */
+		int cmd[2];			/* messages to thread (commands) */
+	} pipes;
+	bool				running; /* has this thread been started? */
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
+ *
+ * Caller should perform cleanup on error.
+ */
+static int threadpool_entry__open_pipes(struct threadpool_entry *thread)
+{
+	char sbuf[STRERR_BUFSIZE];
+
+	if (pipe(thread->pipes.ack)) {
+		pr_debug2("threadpool: failed to create comm pipe 'from': %s\n",
+			str_error_r(errno, sbuf, sizeof(sbuf)));
+		return -ENOMEM;
+	}
+
+	if (pipe(thread->pipes.cmd)) {
+		pr_debug2("threadpool: failed to create comm pipe 'to': %s\n",
+			str_error_r(errno, sbuf, sizeof(sbuf)));
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
+	char sbuf[STRERR_BUFSIZE];
+	struct threadpool *pool = malloc(sizeof(*pool));
+
+	if (!pool) {
+		pr_debug2("threadpool: cannot allocate pool: %s\n",
+			str_error_r(errno, sbuf, sizeof(sbuf)));
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
+			str_error_r(errno, sbuf, sizeof(sbuf)));
+		err = -ENOMEM;
+		goto out_free_pool;
+	}
+
+	for (t = 0; t < n_threads; t++) {
+		pool->threads[t].idx = t;
+		pool->threads[t].tid = -1;
+		pool->threads[t].ptid = 0;
+		pool->threads[t].pool = pool;
+		pool->threads[t].running = false;
+		threadpool_entry__init_pipes(&pool->threads[t]);
+	}
+
+	for (t = 0; t < n_threads; t++) {
+		ret = threadpool_entry__open_pipes(&pool->threads[t]);
+		if (ret) {
+			err = ret;
+			goto out_close_pipes;
+		}
+	}
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
+	struct threadpool_entry *thread;
+	int t;
+
+	if (IS_ERR_OR_NULL(pool))
+		return;
+
+	for (t = 0; t < pool->nr_threads; t++) {
+		thread = &pool->threads[t];
+		threadpool_entry__close_pipes(thread);
+	}
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
index 0000000000000000..55146eb141d4c380
--- /dev/null
+++ b/tools/perf/util/workqueue/threadpool.h
@@ -0,0 +1,24 @@
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

