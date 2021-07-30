Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E8AC4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ECB760F26
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhG3Pg4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 11:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbhG3Pet (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jul 2021 11:34:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D9EC06179A;
        Fri, 30 Jul 2021 08:34:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j2so11801200wrx.9;
        Fri, 30 Jul 2021 08:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MQvcBgut5IUpq2mXbZlHqHmU6HhBKumRdvOIq0E0PgQ=;
        b=n6P0khVbHLed6WiY0tknhIXDe3UPfr0t6cGRIuOPu35w7bHdHRWG1logYcrwjex6IY
         uvduZnbfD33rauXF9DUqZh3jUDEYyAyIgKZgGPg6Aa3uKyh84TcBcOdCnZYUCHT8WggU
         kQ4mOudySQpAQvRJwKIN88TCr067GKRsG112sDvUJ/nPCo20Y+aODwMx7AveUe5fXYkz
         yUG1/HJFgykQJZuWfrvOKblxmPrKKsj0Y4UmRFryoblv8yFWq2Q5dOgMx5uFjLaePipu
         GSakTrUypBI2HFE1ALK9xg6tVKJT2QAVNYaKv4Jqi7pS/nWzMMtG9k+F/dYLxCUKDC3W
         +HfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MQvcBgut5IUpq2mXbZlHqHmU6HhBKumRdvOIq0E0PgQ=;
        b=gTdNzKLmtICMM0JY/CvVxJM6bjqk5TradRoF4u8bzlYyeM8qV08A9n2LQs2tAXyv9m
         ODKYCrABUygEvhMas/4tvOncqNv4MQdAayyabvWs2nJdy+qOYTsH7jGL805nnt7JPNI+
         2XYsT+m5wjValMF6a7ScFye3qm7qrmXLAM/+r/8UVqccbA1HEITYI97wuRir7eheghcr
         5X/iWlKWsyTReylnlo6QGd0hfTyj1MzCtVGOwzA0h9yMcHlYigJ3Rpg4KQahTxWLYjN7
         mBemGS2pbikVL80DsAwIhbqCLAcUZozbWX36xs5ncmQuSpGlO0fkCDLEb273NYZlu3RM
         s12A==
X-Gm-Message-State: AOAM531YPYpkiMKZYql9GZfDhmsghyw8iP5TNDgrMScPBceWFRsDZUfs
        ekVy2gmgqSz0hNXQSvdP3oY=
X-Google-Smtp-Source: ABdhPJxMiMulnvhJe23rxT8mqJthvwYqeRGgrZ9Md9fPCyNTGwkXA1UhrIC//wteNuF0Y0tpwvHgLg==
X-Received: by 2002:a05:6000:1841:: with SMTP id c1mr3506639wri.423.1627659265188;
        Fri, 30 Jul 2021 08:34:25 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id v15sm2354727wmj.39.2021.07.30.08.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:34:24 -0700 (PDT)
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
Subject: [RFC PATCH v2 03/10] perf workqueue: add threadpool start and stop functions
Date:   Fri, 30 Jul 2021 17:34:10 +0200
Message-Id: <6b18cd4441733f487b45bdf1e6f507b45be3bfbf.1627657061.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627657061.git.rickyman7@gmail.com>
References: <cover.1627657061.git.rickyman7@gmail.com>
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
 tools/perf/tests/workqueue.c           |  13 +
 tools/perf/util/workqueue/threadpool.c | 328 ++++++++++++++++++++++++-
 tools/perf/util/workqueue/threadpool.h |   9 +
 3 files changed, 347 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
index fb0e86390d466677..767e4fb60be4b190 100644
--- a/tools/perf/tests/workqueue.c
+++ b/tools/perf/tests/workqueue.c
@@ -11,16 +11,29 @@ struct threadpool_test_args_t {
 
 static int __threadpool__prepare(struct threadpool **pool, int pool_size)
 {
+	int ret;
+
 	*pool = threadpool__new(pool_size);
 	TEST_ASSERT_VAL("threadpool creation failure", !IS_ERR(*pool));
 	TEST_ASSERT_VAL("threadpool size is wrong",
 			threadpool__size(*pool) == pool_size);
 
+	ret = threadpool__start(*pool);
+	TEST_ASSERT_VAL("threadpool start failure", ret == 0);
+	TEST_ASSERT_VAL("threadpool is not ready", threadpool__is_ready(*pool));
+
 	return TEST_OK;
 }
 
 static int __threadpool__teardown(struct threadpool *pool)
 {
+	int ret;
+
+	ret = threadpool__stop(pool);
+	TEST_ASSERT_VAL("threadpool stop failure", ret == 0);
+	TEST_ASSERT_VAL("stopped threadpool is ready",
+			!threadpool__is_ready(pool));
+
 	threadpool__delete(pool);
 
 	return TEST_OK;
diff --git a/tools/perf/util/workqueue/threadpool.c b/tools/perf/util/workqueue/threadpool.c
index 0004ce606d5fa73d..850ef7e110566536 100644
--- a/tools/perf/util/workqueue/threadpool.c
+++ b/tools/perf/util/workqueue/threadpool.c
@@ -4,20 +4,38 @@
 #include <unistd.h>
 #include <errno.h>
 #include <string.h>
+#include <pthread.h>
+#include <signal.h>
+#include <syscall.h>
 #include "debug.h"
 #include <asm/bug.h>
 #include <linux/zalloc.h>
 #include <linux/string.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
+#include <internal/lib.h>
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
 
+static const char * const threadpool_status_tags[] = {
+	"stopped",
+	"ready",
+	"error"
+};
+
 struct threadpool {
 	int			nr_threads;	/* number of threads in the pool */
 	struct threadpool_entry	*threads;	/* array of threads in the pool */
@@ -35,6 +53,29 @@ struct threadpool_entry {
 	} pipes;
 };
 
+enum threadpool_msg {
+	THREADPOOL_MSG__UNDEFINED = 0,
+	THREADPOOL_MSG__ACK,		/* from th: create and exit ack */
+	THREADPOOL_MSG__WAKE,		/* to th: wake up */
+	THREADPOOL_MSG__STOP,		/* to th: exit */
+	THREADPOOL_MSG__MAX
+};
+
+static const char * const threadpool_msg_tags[] = {
+	"undefined",
+	"ack",
+	"wake",
+	"stop"
+};
+
+static const char * const threadpool_errno_str[] = {
+	"Error calling sigprocmask",
+	"Error receiving message from thread",
+	"Error sending message to thread",
+	"Thread sent unexpected message",
+	"This operation is not allowed in this state"
+};
+
 /**
  * threadpool_entry__init_pipes - initialize all pipes of @thread
  */
@@ -93,6 +134,130 @@ static void threadpool_entry__close_pipes(struct threadpool_entry *thread)
 	}
 }
 
+/**
+ * threadpool__wait_thread - receive ack from thread
+ *
+ * NB: call only from main thread!
+ */
+static int threadpool__wait_thread(struct threadpool_entry *thread)
+{
+	int res;
+	enum threadpool_msg msg = THREADPOOL_MSG__UNDEFINED;
+
+	res = readn(thread->pipes.ack[0], &msg, sizeof(msg));
+	if (res < 0) {
+		pr_debug2("threadpool: failed to recv msg from tid=%d: %s\n",
+		       thread->tid, strerror(errno));
+		return -THREADPOOL_ERROR__READPIPE;
+	}
+	if (msg != THREADPOOL_MSG__ACK) {
+		pr_debug2("threadpool: received unexpected msg from tid=%d: %s\n",
+		       thread->tid, threadpool_msg_tags[msg]);
+		return -THREADPOOL_ERROR__INVALIDMSG;
+	}
+
+	pr_debug2("threadpool: received ack from tid=%d\n", thread->tid);
+
+	return 0;
+}
+
+/**
+ * threadpool__terminate_thread - send stop signal to thread and wait for ack
+ *
+ * NB: call only from main thread!
+ */
+static int threadpool__terminate_thread(struct threadpool_entry *thread)
+{
+	int res;
+	enum threadpool_msg msg = THREADPOOL_MSG__STOP;
+
+	res = writen(thread->pipes.cmd[1], &msg, sizeof(msg));
+	if (res < 0) {
+		pr_debug2("threadpool: error sending stop msg to tid=%d: %s\n",
+			thread->tid, strerror(errno));
+		return -THREADPOOL_ERROR__WRITEPIPE;
+	}
+
+	return threadpool__wait_thread(thread);
+}
+
+/**
+ * threadpool_entry__function - send ack to main thread
+ */
+static int threadpool_entry__send_ack(struct threadpool_entry *thread)
+{
+	enum threadpool_msg msg = THREADPOOL_MSG__ACK;
+	int ret = writen(thread->pipes.ack[1], &msg, sizeof(msg));
+
+	if (ret < 0) {
+		pr_debug("threadpool[%d]: failed to send ack: %s\n",
+			thread->tid, strerror(errno));
+		return -THREADPOOL_ERROR__WRITEPIPE;
+	}
+
+	return 0;
+}
+
+/**
+ * threadpool_entry__recv_cmd - receive command from main thread
+ */
+static int threadpool_entry__recv_cmd(struct threadpool_entry *thread,
+					enum threadpool_msg *cmd)
+{
+	int ret;
+
+	*cmd = THREADPOOL_MSG__UNDEFINED;
+	ret = readn(thread->pipes.cmd[0], cmd, sizeof(*cmd));
+	if (ret < 0) {
+		pr_debug("threadpool[%d]: error receiving command: %s\n",
+			thread->tid, strerror(errno));
+		return -THREADPOOL_ERROR__READPIPE;
+	}
+
+	if (*cmd != THREADPOOL_MSG__WAKE && *cmd != THREADPOOL_MSG__STOP) {
+		pr_debug("threadpool[%d]: received unexpected command: %s\n",
+			thread->tid, threadpool_msg_tags[*cmd]);
+		return -THREADPOOL_ERROR__INVALIDMSG;
+	}
+
+	return 0;
+}
+
+/**
+ * threadpool_entry__function - function running on thread
+ *
+ * This function waits for a signal from main thread to start executing
+ * a task.
+ * On completion, it will go back to sleep, waiting for another signal.
+ * Signals are delivered through pipes.
+ */
+static void *threadpool_entry__function(void *args)
+{
+	struct threadpool_entry *thread = (struct threadpool_entry *) args;
+	enum threadpool_msg cmd;
+
+	thread->tid = gettid();
+
+	pr_debug2("threadpool[%d]: started\n", thread->tid);
+
+	for (;;) {
+		if (threadpool_entry__send_ack(thread))
+			break;
+
+		if (threadpool_entry__recv_cmd(thread, &cmd))
+			break;
+
+		if (cmd == THREADPOOL_MSG__STOP)
+			break;
+	}
+
+	pr_debug2("threadpool[%d]: exit\n", thread->tid);
+
+	threadpool_entry__send_ack(thread);
+
+	return NULL;
+}
+
 /**
  * threadpool__new - create a fixed threadpool with @n_threads threads
  */
@@ -161,12 +326,30 @@ struct threadpool *threadpool__new(int n_threads)
  *
  * Buffer size should be at least THREADPOOL_STRERR_BUFSIZE bytes.
  */
-int threadpool__strerror(struct threadpool *pool __maybe_unused, int err, char *buf, size_t size)
+int threadpool__strerror(struct threadpool *pool, int err, char *buf, size_t size)
 {
 	char sbuf[STRERR_BUFSIZE], *emsg;
+	const char *status_str, *errno_str;
 
-	emsg = str_error_r(err, sbuf, sizeof(sbuf));
-	return scnprintf(buf, size, "Error: %s.\n", emsg);
+	status_str = IS_ERR_OR_NULL(pool) ? "error" : threadpool_status_tags[pool->status];
+
+	switch (err) {
+	case -THREADPOOL_ERROR__SIGPROCMASK:
+	case -THREADPOOL_ERROR__READPIPE:
+	case -THREADPOOL_ERROR__WRITEPIPE:
+		emsg = str_error_r(errno, sbuf, sizeof(sbuf));
+		errno_str = threadpool_errno_str[-err-THREADPOOL_ERROR__OFFSET];
+		return scnprintf(buf, size, "%s: %s.\n", errno_str, emsg);
+	case -THREADPOOL_ERROR__INVALIDMSG:
+		errno_str = threadpool_errno_str[-err-THREADPOOL_ERROR__OFFSET];
+		return scnprintf(buf, size, "%s.\n", errno_str);
+	case -THREADPOOL_ERROR__NOTALLOWED:
+		return scnprintf(buf, size, "%s (%s).\n",
+			threadpool_errno_str[-err], status_str);
+	default:
+		emsg = str_error_r(err, sbuf, sizeof(sbuf));
+		return scnprintf(buf, size, "Error: %s", emsg);
+	}
 }
 
 /**
@@ -206,3 +389,142 @@ int threadpool__size(struct threadpool *pool)
 {
 	return pool->nr_threads;
 }
+
+/**
+ * __threadpool__start - start all threads in the pool.
+ *
+ * NB: use threadpool_start. This function does not change @pool->status.
+ */
+static int __threadpool__start(struct threadpool *pool)
+{
+	int t, tt, ret, err = 0, nr_threads = pool->nr_threads;
+	sigset_t full, mask;
+	pthread_t handle;
+	pthread_attr_t attrs;
+
+	sigfillset(&full);
+	if (sigprocmask(SIG_SETMASK, &full, &mask)) {
+		pr_debug2("Failed to block signals on threads start: %s\n", strerror(errno));
+		return -THREADPOOL_ERROR__SIGPROCMASK;
+	}
+
+	pthread_attr_init(&attrs);
+	pthread_attr_setdetachstate(&attrs, PTHREAD_CREATE_DETACHED);
+
+	for (t = 0; t < nr_threads; t++) {
+		struct threadpool_entry *thread = &pool->threads[t];
+
+		ret = pthread_create(&handle, &attrs, threadpool_entry__function, thread);
+		if (ret) {
+			err = ret;
+			pr_debug2("Failed to start threads: %s\n", strerror(errno));
+			break;
+		}
+	}
+
+	/**
+	 * Wait for all threads that we managed to run.
+	 * In case of further errors, continue to terminate possibly not
+	 * failing threads.
+	 */
+	for (tt = 0; tt < t; tt++) {
+		struct threadpool_entry *thread = &pool->threads[tt];
+
+		ret = threadpool__wait_thread(thread);
+		if (ret)
+			err = ret;
+	}
+
+	/**
+	 * In case of errors, terminate all threads that we managed to run.
+	 */
+	if (err) {
+		for (tt = 0; tt < t; tt++)
+			threadpool__terminate_thread(&pool->threads[tt]);
+	}
+
+	pthread_attr_destroy(&attrs);
+
+	if (sigprocmask(SIG_SETMASK, &mask, NULL)) {
+		pr_debug2("Failed to unblock signals on threads start: %s\n", strerror(errno));
+		err = -THREADPOOL_ERROR__SIGPROCMASK;
+	}
+
+	return err;
+}
+
+/**
+ * threadpool__start - start all threads in the pool.
+ *
+ * The function blocks until all threads are up and running.
+ */
+int threadpool__start(struct threadpool *pool)
+{
+	int ret;
+
+	if (pool->status != THREADPOOL_STATUS__STOPPED) {
+		pr_debug2("threadpool: starting not stopped pool\n");
+		return -THREADPOOL_ERROR__NOTALLOWED;
+	}
+
+	ret = __threadpool__start(pool);
+	if (ret) {
+		pool->status = THREADPOOL_STATUS__ERROR;
+		return ret;
+	}
+	pool->status = THREADPOOL_STATUS__READY;
+	return 0;
+}
+
+/**
+ * __threadpool__stop - stop all threads in the pool.
+ *
+ * NB: use threadpool_stop. This function does not change @pool->status.
+ */
+static int __threadpool__stop(struct threadpool *pool)
+{
+	int t, ret, err = 0;
+
+	for (t = 0; t < pool->nr_threads; t++) {
+		/**
+		 * Even if a termination fails, we should continue to terminate
+		 * all other threads.
+		 */
+		ret = threadpool__terminate_thread(&pool->threads[t]);
+		if (ret)
+			err = ret;
+	}
+
+	return err;
+}
+
+/**
+ * threadpool__stop - stop all threads in the pool.
+ *
+ * This function blocks waiting for ack from all threads.
+ */
+int threadpool__stop(struct threadpool *pool)
+{
+	int ret;
+
+	if (pool->status != THREADPOOL_STATUS__READY) {
+		pr_debug2("threadpool: stopping not ready pool\n");
+		return -THREADPOOL_ERROR__NOTALLOWED;
+	}
+
+	ret = __threadpool__stop(pool);
+	if (ret) {
+		pool->status = THREADPOOL_STATUS__ERROR;
+		return ret;
+	}
+	pool->status = THREADPOOL_STATUS__STOPPED;
+	return 0;
+}
+
+/**
+ * threadpool__is_ready - check if the threads are running
+ */
+bool threadpool__is_ready(struct threadpool *pool)
+{
+	return pool->status == THREADPOOL_STATUS__READY;
+}
diff --git a/tools/perf/util/workqueue/threadpool.h b/tools/perf/util/workqueue/threadpool.h
index fb18aa32fb64f671..7d56e5450fac605b 100644
--- a/tools/perf/util/workqueue/threadpool.h
+++ b/tools/perf/util/workqueue/threadpool.h
@@ -21,9 +21,18 @@ extern int threadpool__execute(struct threadpool *pool, struct task_struct *task
 extern int threadpool__wait(struct threadpool *pool);
 
 extern int threadpool__size(struct threadpool *pool);
+extern bool threadpool__is_ready(struct threadpool *pool);
 
 /* Error management */
 #define THREADPOOL_STRERR_BUFSIZE (128+STRERR_BUFSIZE)
+#define THREADPOOL_ERROR__OFFSET 512
+enum {
+	THREADPOOL_ERROR__SIGPROCMASK = THREADPOOL_ERROR__OFFSET,
+	THREADPOOL_ERROR__READPIPE,
+	THREADPOOL_ERROR__WRITEPIPE,
+	THREADPOOL_ERROR__INVALIDMSG,
+	THREADPOOL_ERROR__NOTALLOWED
+};
 extern int threadpool__strerror(struct threadpool *pool, int err, char *buf, size_t size);
 extern int threadpool__new_strerror(struct threadpool *err_ptr, char *buf, size_t size);
 
-- 
2.31.1

