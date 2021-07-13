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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32337C07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B7A6610D1
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbhGMMO1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 08:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbhGMMOZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 08:14:25 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10C0C0613DD;
        Tue, 13 Jul 2021 05:11:35 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id q18-20020a1ce9120000b02901f259f3a250so2180891wmc.2;
        Tue, 13 Jul 2021 05:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MEb7AcK2dhSUeUYWAppL9LVnTDMDUT/LyxDTtDZFJYU=;
        b=trhYvCu+ZR/3Pqq71sigenE9TJ1TyehIUHdXfkTSVwR5pic3q/g/dUUSg7NHiXdL/A
         JdhyFbExzgkfipi7aB3yD++64FcJBcX4Lt/S3Jiwdln8BrodrjAHWrAKKz9SfnMj2ZWM
         4JMlDKfYt/8pR/KJFUxA7lhbeHhyAOgLHCC5vWKChXUANnP/9Tcc60f6IPqQjZnbkfp1
         DgxgnGNVWt/8yfxcuE7s85fZUhIg2PeX3O3qfNuSOE30wq3/U1h13TJ8uU98BZ4xP58X
         WRDiHDJA3GKtYR/qVX5jUc5990lWvtT4JyDFLxavR6rnrh+tFpzjH6naY8QMrN7Pk8Rc
         TDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MEb7AcK2dhSUeUYWAppL9LVnTDMDUT/LyxDTtDZFJYU=;
        b=PtiQq7u/fHPIDrQm6u9njxWvAwYdWMBV1YfO6igJ5wmCIVDgMnn9I0C0iArmEg50gs
         Zw85DD28DAZ4UQY/MuUe2KqxHGzWW265w+BLxu1ulMg/+uMBkpk2g0ZKSBwZSB62K0Ir
         5+KLbEeCOHMdCw6GpePPs2/Ni5BtwsR4GLc7tgrBL1uqIFM4U8BN8I9MuxgXJ6vCFDG6
         S+iZxelImjHlF6aV+IaAIpPXO14WiW9Cb36tq83nCG28kY6ylvY+MMUSBWwK7AGylx+K
         QQIJq4qVk/WlVSDI4+tDKoly3X8tjrSc4lzNms9iPspGThuCQ//jWjDBwOG690LbC4LB
         61Rw==
X-Gm-Message-State: AOAM53298AaXx2i8lMDG+N6dnlYxqwOrvakMeDvP418i7CvfYaN7sapM
        KRBxn+J6qFx0kyeTgKudTgw=
X-Google-Smtp-Source: ABdhPJyKbBkETe3BmF6G7UsnTvg0JCmM0HC640hEhz0jAPAzGhHvMbjMXX0wTUOWZ/h2AM+anAubgw==
X-Received: by 2002:a05:600c:1992:: with SMTP id t18mr20461199wmq.165.1626178294287;
        Tue, 13 Jul 2021 05:11:34 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id o3sm17551425wrw.56.2021.07.13.05.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 05:11:33 -0700 (PDT)
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
Subject: [RFC PATCH 03/10] perf workqueue: add threadpool start and stop functions
Date:   Tue, 13 Jul 2021 14:11:14 +0200
Message-Id: <118c988358322b9daf69aeb98ff8986748b0dad2.1626177381.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626177381.git.rickyman7@gmail.com>
References: <cover.1626177381.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds the start and stop functions, alongside the thread
function.
Each thread will run until a stop signal is received.
Furthermore, start and stop are added to the test.

Thread management is based on the prototype from Alexey:
https://lore.kernel.org/lkml/cover.1625227739.git.alexey.v.bayduraev@linux.intel.com/

Suggested-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/tests/workqueue.c           |  13 ++
 tools/perf/util/workqueue/threadpool.c | 238 +++++++++++++++++++++++++
 tools/perf/util/workqueue/threadpool.h |   5 +
 3 files changed, 256 insertions(+)

diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
index 1bd4d78c13eb3b14..be377e9897bab4e9 100644
--- a/tools/perf/tests/workqueue.c
+++ b/tools/perf/tests/workqueue.c
@@ -10,16 +10,29 @@ struct threadpool_test_args_t {
 
 static int __threadpool__prepare(struct threadpool_struct **pool, int pool_size)
 {
+	int ret;
+
 	*pool = create_threadpool(pool_size);
 	TEST_ASSERT_VAL("threadpool creation failure", *pool != NULL);
 	TEST_ASSERT_VAL("threadpool size is wrong",
 			threadpool_size(*pool) == pool_size);
 
+	ret = start_threadpool(*pool);
+	TEST_ASSERT_VAL("threadpool start failure", ret == 0);
+	TEST_ASSERT_VAL("threadpool is not ready", threadpool_is_ready(*pool));
+
 	return 0;
 }
 
 static int __threadpool__teardown(struct threadpool_struct *pool)
 {
+	int ret;
+
+	ret = stop_threadpool(pool);
+	TEST_ASSERT_VAL("threadpool start failure", ret == 0);
+	TEST_ASSERT_VAL("stopped threadpool is ready",
+			!threadpool_is_ready(pool));
+
 	destroy_threadpool(pool);
 
 	return 0;
diff --git a/tools/perf/util/workqueue/threadpool.c b/tools/perf/util/workqueue/threadpool.c
index 70c67569f956a3e2..f4635ff782b9388e 100644
--- a/tools/perf/util/workqueue/threadpool.c
+++ b/tools/perf/util/workqueue/threadpool.c
@@ -4,12 +4,23 @@
 #include <unistd.h>
 #include <errno.h>
 #include <string.h>
+#include <pthread.h>
+#include <signal.h>
+#include <syscall.h>
 #include "debug.h"
 #include "asm/bug.h"
 #include "threadpool.h"
 
+#ifndef HAVE_GETTID
+static inline pid_t gettid(void)
+{
+	return (pid_t)syscall(__NR_gettid);
+}
+#endif
+
 enum threadpool_status {
 	THREADPOOL_STATUS__STOPPED,		/* no threads */
+	THREADPOOL_STATUS__READY,		/* threads are ready but idle */
 	THREADPOOL_STATUS__ERROR,		/* errors */
 	THREADPOOL_STATUS__MAX
 };
@@ -31,6 +42,21 @@ struct thread_struct {
 	} pipes;
 };
 
+enum thread_msg {
+	THREAD_MSG__UNDEFINED = 0,
+	THREAD_MSG__ACK,		/* from th: create and exit ack */
+	THREAD_MSG__WAKE,		/* to th: wake up */
+	THREAD_MSG__STOP,		/* to th: exit */
+	THREAD_MSG__MAX
+};
+
+static const char * const thread_msg_tags[] = {
+	"undefined",
+	"ack",
+	"wake",
+	"stop"
+};
+
 /**
  * init_pipes - initialize all pipes of @thread
  */
@@ -89,6 +115,113 @@ static void close_pipes(struct thread_struct *thread)
 	}
 }
 
+/**
+ * wait_thread - receive ack from thread
+ *
+ * NB: call only from main thread!
+ */
+static int wait_thread(struct thread_struct *thread)
+{
+	int res;
+	enum thread_msg msg = THREAD_MSG__UNDEFINED;
+
+	res = read(thread->pipes.from[0], &msg, sizeof(msg));
+	if (res < 0) {
+		pr_err("threadpool: failed to recv msg from tid=%d: %s\n",
+		       thread->tid, strerror(errno));
+		return -1;
+	}
+	if (msg != THREAD_MSG__ACK) {
+		pr_err("threadpool: received unexpected msg from tid=%d: %s\n",
+		       thread->tid, thread_msg_tags[msg]);
+		return -1;
+	}
+
+	pr_debug2("threadpool: received ack from tid=%d\n", thread->tid);
+
+	return 0;
+}
+
+/**
+ * terminate_thread - send stop signal to thread and wait for ack
+ *
+ * NB: call only from main thread!
+ */
+static int terminate_thread(struct thread_struct *thread)
+{
+	int res;
+	enum thread_msg msg = THREAD_MSG__STOP;
+
+	res = write(thread->pipes.to[1], &msg, sizeof(msg));
+	if (res < 0) {
+		pr_err("threadpool: error sending stop msg to tid=%d: %s\n",
+			thread->tid, strerror(errno));
+		return res;
+	}
+
+	res = wait_thread(thread);
+
+	return res;
+}
+
+/**
+ * threadpool_thread - function running on thread
+ *
+ * This function waits for a signal from main thread to start executing
+ * a task.
+ * On completion, it will go back to sleep, waiting for another signal.
+ * Signals are delivered through pipes.
+ */
+static void *threadpool_thread(void *args)
+{
+	struct thread_struct *thread = (struct thread_struct *) args;
+	enum thread_msg msg;
+	int err;
+
+	thread->tid = gettid();
+
+	pr_debug2("threadpool[%d]: started\n", thread->tid);
+
+	for (;;) {
+		msg = THREAD_MSG__ACK;
+		err = write(thread->pipes.from[1], &msg, sizeof(msg));
+		if (err == -1) {
+			pr_err("threadpool[%d]: failed to send ack: %s\n",
+				thread->tid, strerror(errno));
+			break;
+		}
+
+		msg = THREAD_MSG__UNDEFINED;
+		err = read(thread->pipes.to[0], &msg, sizeof(msg));
+		if (err < 0) {
+			pr_err("threadpool[%d]: error receiving msg: %s\n",
+				thread->tid, strerror(errno));
+			break;
+		}
+
+		if (msg != THREAD_MSG__WAKE && msg != THREAD_MSG__STOP) {
+			pr_err("threadpool[%d]: received unexpected msg: %s\n",
+				thread->tid, thread_msg_tags[msg]);
+			break;
+		}
+
+		if (msg == THREAD_MSG__STOP)
+			break;
+	}
+
+	pr_debug2("threadpool[%d]: exit\n", thread->tid);
+
+	msg = THREAD_MSG__ACK;
+	err = write(thread->pipes.from[1], &msg, sizeof(msg));
+	if (err == -1) {
+		pr_err("threadpool[%d]: failed to send ack: %s\n",
+			thread->tid, strerror(errno));
+		return NULL;
+	}
+
+	return NULL;
+}
+
 /**
  * create_threadpool - create a fixed threadpool with @n_threads threads
  */
@@ -173,3 +306,108 @@ int threadpool_size(struct threadpool_struct *pool)
 {
 	return pool->nr_threads;
 }
+
+/**
+ * __start_threadpool - start all threads in the pool.
+ *
+ * This function does not change @pool->status.
+ */
+static int __start_threadpool(struct threadpool_struct *pool)
+{
+	int t, tt, ret = 0, nr_threads = pool->nr_threads;
+	sigset_t full, mask;
+	pthread_t handle;
+	pthread_attr_t attrs;
+
+	sigfillset(&full);
+	if (sigprocmask(SIG_SETMASK, &full, &mask)) {
+		pr_err("Failed to block signals on threads start: %s\n",
+			strerror(errno));
+		return -1;
+	}
+
+	pthread_attr_init(&attrs);
+	pthread_attr_setdetachstate(&attrs, PTHREAD_CREATE_DETACHED);
+
+	for (t = 0; t < nr_threads; t++) {
+		struct thread_struct *thread = &pool->threads[t];
+
+		if (pthread_create(&handle, &attrs, threadpool_thread, thread)) {
+			for (tt = 1; tt < t; tt++)
+				terminate_thread(thread);
+			pr_err("Failed to start threads: %s\n", strerror(errno));
+			ret = -1;
+			goto out_free_attr;
+		}
+
+		if (wait_thread(thread)) {
+			for (tt = 1; tt <= t; tt++)
+				terminate_thread(thread);
+			ret = -1;
+			goto out_free_attr;
+		}
+	}
+
+out_free_attr:
+	pthread_attr_destroy(&attrs);
+
+	if (sigprocmask(SIG_SETMASK, &mask, NULL)) {
+		pr_err("Failed to unblock signals on threads start: %s\n",
+			strerror(errno));
+		ret = -1;
+	}
+
+	return ret;
+}
+
+/**
+ * start_threadpool - start all threads in the pool.
+ *
+ * The function blocks until all threads are up and running.
+ */
+int start_threadpool(struct threadpool_struct *pool)
+{
+	int err;
+
+	if (pool->status != THREADPOOL_STATUS__STOPPED) {
+		pr_err("threadpool: starting not stopped pool\n");
+		return -1;
+	}
+
+	err = __start_threadpool(pool);
+	pool->status = err ? THREADPOOL_STATUS__ERROR : THREADPOOL_STATUS__READY;
+	return err;
+}
+
+/**
+ * stop_threadpool - stop all threads in the pool.
+ *
+ * This function blocks waiting for ack from all threads.
+ */
+int stop_threadpool(struct threadpool_struct *pool)
+{
+	int t, ret, err = 0;
+
+	if (pool->status != THREADPOOL_STATUS__READY) {
+		pr_err("threadpool: stopping not ready pool\n");
+		return -1;
+	}
+
+	for (t = 0; t < pool->nr_threads; t++) {
+		ret = terminate_thread(&pool->threads[t]);
+		if (ret && !err)
+			err = -1;
+	}
+
+	pool->status = err ? THREADPOOL_STATUS__ERROR : THREADPOOL_STATUS__STOPPED;
+
+	return err;
+}
+
+/**
+ * threadpool_is_ready - check if the threads are running
+ */
+bool threadpool_is_ready(struct threadpool_struct *pool)
+{
+	return pool->status == THREADPOOL_STATUS__READY;
+}
diff --git a/tools/perf/util/workqueue/threadpool.h b/tools/perf/util/workqueue/threadpool.h
index 2b9388c768a0b588..b62cad2b2c5dd331 100644
--- a/tools/perf/util/workqueue/threadpool.h
+++ b/tools/perf/util/workqueue/threadpool.h
@@ -14,6 +14,11 @@ struct task_struct {
 extern struct threadpool_struct *create_threadpool(int n_threads);
 extern void destroy_threadpool(struct threadpool_struct *pool);
 
+extern int start_threadpool(struct threadpool_struct *pool);
+extern int stop_threadpool(struct threadpool_struct *pool);
+
 extern int threadpool_size(struct threadpool_struct *pool);
 
+extern bool threadpool_is_ready(struct threadpool_struct *pool);
+
 #endif /* __WORKQUEUE_THREADPOOL_H */
-- 
2.31.1

