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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61CBC4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D0A560C3E
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238356AbhHTKyw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238990AbhHTKyv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 06:54:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC37EC061575;
        Fri, 20 Aug 2021 03:54:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id n12so13373865edx.8;
        Fri, 20 Aug 2021 03:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2WCrWEngpypQuCrEAmm+bn82ltbiikiST3nYIeIplps=;
        b=DovOymUBKxML8yTaFuY/IpmGFNKiXMFBJVQJBsvjh6HbLeC8uESPF3cDnJ+BAcD2hh
         C4TVZ6l7x2dDSDgFYPCDKpJqGvU7CNyrry4Wfx5Lp9m9hChXzC2k0zURWy9U4SfgRzQL
         CFLWB4OuwqTNqtbHfUWo/IraWSrwsh47/alw5800vd9C//aOJ6QQpWo7eG7b5bCGiMEa
         MI4xFvTQT1UlbStvV71oYQFkBnW5uoKWr0TbQMEYgxaC89XMRPvnZ5RExXaKpL4ByZuf
         gcQW65CsDvGQ/eG2RP04s1KFqttUIvjqvXdXlpRJ9Yhv8yweu8CapBK3KnA6EzfBW3OP
         03CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2WCrWEngpypQuCrEAmm+bn82ltbiikiST3nYIeIplps=;
        b=WNJFnoIYd8RGKMQeXFB2Mj3OUxzj8T4qrF9KnFLZu48k2AwR2Gq1DKMEA9Zn78AIdb
         +hZG7Kx31VtfgrBYBQm4mPG7/UHoy635zUI/bP4q0b8DvOo26HZl7z7l9kQblHLzTYPZ
         x0v1JDI/logxDJXO4OcbRXtL27TMUPkO2BWHnV+Ugf/+ltSn0ELrBu2BqsYsKMHDyzmj
         dHa50hXo7aYvFuKNh7Q6Gh0zi/9kTnmttN/U/isCoziN5Epo3PVNhycsxyozt1GEuGH2
         bp4L6dxekJHd3U5gRXzmiUXCxrf0YZ2ges1bzyCeZcG6AcmODHUuUpeOHr7C6c6D/I6X
         930g==
X-Gm-Message-State: AOAM532wHdsxQeXUCyoaEykPmWhfOeS06n2o/4wrUN+1sDNjx7H+gZTE
        fWN64VkOrxC30CBdnrbNqCs=
X-Google-Smtp-Source: ABdhPJxhQBkt+s3bFx5r3Tdvq0AY7zC7Z1CfXGN4juJrwSW7+9NSULN2i7FkrIYbtsXqLAIDXaCddg==
X-Received: by 2002:aa7:c844:: with SMTP id g4mr8338285edt.37.1629456852168;
        Fri, 20 Aug 2021 03:54:12 -0700 (PDT)
Received: from honeypot.epfl.ch (mob-176-243-199-7.net.vodafone.it. [176.243.199.7])
        by smtp.googlemail.com with ESMTPSA id g29sm3451459edf.31.2021.08.20.03.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 03:54:11 -0700 (PDT)
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
Subject: [RFC PATCH v3 03/15] perf workqueue: add threadpool start and stop functions
Date:   Fri, 20 Aug 2021 12:53:49 +0200
Message-Id: <8225625a617596f4e28aedb9620503367f5d4450.1629454773.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629454773.git.rickyman7@gmail.com>
References: <cover.1629454773.git.rickyman7@gmail.com>
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
 tools/perf/tests/workqueue.c           |  12 +
 tools/perf/util/workqueue/threadpool.c | 324 ++++++++++++++++++++++++-
 tools/perf/util/workqueue/threadpool.h |  13 +
 3 files changed, 347 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
index 469b154d7522f132..01f05b066d9fbc70 100644
--- a/tools/perf/tests/workqueue.c
+++ b/tools/perf/tests/workqueue.c
@@ -12,16 +12,28 @@ struct threadpool_test_args_t {
 
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
+	TEST_ASSERT_VAL("threadpool is not ready", threadpool__is_running(*pool));
+
 	return TEST_OK;
 }
 
 static int __threadpool__teardown(struct threadpool *pool)
 {
+	int ret = threadpool__stop(pool);
+
+	TEST_ASSERT_VAL("threadpool stop failure", ret == 0);
+	TEST_ASSERT_VAL("stopped threadpool is ready",
+			!threadpool__is_running(pool));
+
 	threadpool__delete(pool);
 
 	return TEST_OK;
diff --git a/tools/perf/util/workqueue/threadpool.c b/tools/perf/util/workqueue/threadpool.c
index 17672cb089afcf1d..861a20231558e618 100644
--- a/tools/perf/util/workqueue/threadpool.c
+++ b/tools/perf/util/workqueue/threadpool.c
@@ -4,6 +4,8 @@
 #include <unistd.h>
 #include <errno.h>
 #include <string.h>
+#include <signal.h>
+#include <syscall.h>
 #include "debug.h"
 #include <asm/bug.h>
 #include <linux/zalloc.h>
@@ -11,8 +13,16 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <pthread.h>
+#include <internal/lib.h>
 #include "threadpool.h"
 
+#ifndef HAVE_GETTID
+static inline pid_t gettid(void)
+{
+	return (pid_t)syscall(__NR_gettid);
+}
+#endif
+
 struct threadpool {
 	int			nr_threads;	/* number of threads in the pool */
 	struct threadpool_entry	*threads;	/* array of threads in the pool */
@@ -31,6 +41,28 @@ struct threadpool_entry {
 	bool				running; /* has this thread been started? */
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
+	"Thread sent unexpected message"
+};
+
 /**
  * threadpool_entry__init_pipes - initialize all pipes of @thread
  */
@@ -89,6 +121,164 @@ static void threadpool_entry__close_pipes(struct threadpool_entry *thread)
 	}
 }
 
+/**
+ * threadpool__send_cmd - send @cmd to @thread
+ */
+static int threadpool__send_cmd(struct threadpool *pool, int tidx, enum threadpool_msg cmd)
+{
+	struct threadpool_entry *thread = &pool->threads[tidx];
+	char sbuf[STRERR_BUFSIZE];
+	int res = writen(thread->pipes.cmd[1], &cmd, sizeof(cmd));
+
+	if (res < 0) {
+		pr_debug2("threadpool: error sending %s msg to tid=%d: %s\n",
+			threadpool_msg_tags[cmd], thread->tid,
+			str_error_r(errno, sbuf, sizeof(sbuf)));
+		return -THREADPOOL_ERROR__WRITEPIPE;
+	}
+
+	pr_debug2("threadpool: sent %s msg to tid=%d\n", threadpool_msg_tags[cmd], thread->tid);
+	return 0;
+}
+
+/**
+ * threadpool__wait_thread - receive ack from thread
+ *
+ * NB: call only from main thread!
+ */
+static int threadpool__wait_thread(struct threadpool *pool, int tidx)
+{
+	int res;
+	char sbuf[STRERR_BUFSIZE];
+	struct threadpool_entry *thread = &pool->threads[tidx];
+	enum threadpool_msg msg = THREADPOOL_MSG__UNDEFINED;
+
+	res = readn(thread->pipes.ack[0], &msg, sizeof(msg));
+	if (res < 0) {
+		pr_debug2("threadpool: failed to recv msg from tid=%d: %s\n",
+		       thread->tid, str_error_r(errno, sbuf, sizeof(sbuf)));
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
+static int threadpool__terminate_thread(struct threadpool *pool, int tidx)
+{
+	struct threadpool_entry *thread = &pool->threads[tidx];
+	int err;
+
+	if (!thread->running)
+		return 0;
+
+	err = threadpool__send_cmd(pool, tidx, THREADPOOL_MSG__STOP);
+	if (err)
+		goto out_cancel;
+
+	err = threadpool__wait_thread(pool, tidx);
+	if (err)
+		goto out_cancel;
+
+	thread->running = false;
+out:
+	return err;
+
+out_cancel:
+	pthread_cancel(thread->ptid);
+	goto out;
+}
+
+/**
+ * threadpool_entry__send_ack - send ack to main thread
+ */
+static int threadpool_entry__send_ack(struct threadpool_entry *thread)
+{
+	enum threadpool_msg msg = THREADPOOL_MSG__ACK;
+	char sbuf[STRERR_BUFSIZE];
+	int ret = writen(thread->pipes.ack[1], &msg, sizeof(msg));
+
+	if (ret < 0) {
+		pr_debug("threadpool[%d]: failed to send ack: %s\n",
+			thread->tid, str_error_r(errno, sbuf, sizeof(sbuf)));
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
+	char sbuf[STRERR_BUFSIZE];
+	int ret;
+
+	*cmd = THREADPOOL_MSG__UNDEFINED;
+	ret = readn(thread->pipes.cmd[0], cmd, sizeof(*cmd));
+	if (ret < 0) {
+		pr_debug("threadpool[%d]: error receiving command: %s\n",
+			thread->tid, str_error_r(errno, sbuf, sizeof(sbuf)));
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
@@ -161,9 +351,23 @@ struct threadpool *threadpool__new(int n_threads)
 int threadpool__strerror(struct threadpool *pool __maybe_unused, int err, char *buf, size_t size)
 {
 	char sbuf[STRERR_BUFSIZE], *emsg;
+	const char *errno_str;
+	int err_idx = -err-THREADPOOL_ERROR__OFFSET;
 
-	emsg = str_error_r(err, sbuf, sizeof(sbuf));
-	return scnprintf(buf, size, "Error: %s.\n", emsg);
+	switch (err) {
+	case -THREADPOOL_ERROR__SIGPROCMASK:
+	case -THREADPOOL_ERROR__READPIPE:
+	case -THREADPOOL_ERROR__WRITEPIPE:
+		emsg = str_error_r(errno, sbuf, sizeof(sbuf));
+		errno_str = threadpool_errno_str[err_idx];
+		return scnprintf(buf, size, "%s: %s.\n", errno_str, emsg);
+	case -THREADPOOL_ERROR__INVALIDMSG:
+		errno_str = threadpool_errno_str[err_idx];
+		return scnprintf(buf, size, "%s.\n", errno_str);
+	default:
+		emsg = str_error_r(err, sbuf, sizeof(sbuf));
+		return scnprintf(buf, size, "Error: %s", emsg);
+	}
 }
 
 /**
@@ -203,3 +407,119 @@ int threadpool__size(struct threadpool *pool)
 {
 	return pool->nr_threads;
 }
+
+/**
+ * threadpool__start_thread - start thread @tidx of the pool
+ *
+ * The function blocks until the thread is up and running.
+ * This function can also be called if the threadpool is already executing.
+ */
+int threadpool__start_thread(struct threadpool *pool, int tidx)
+{
+	char sbuf[STRERR_BUFSIZE];
+	int ret, err = 0;
+	sigset_t full, mask;
+	pthread_attr_t attrs;
+	struct threadpool_entry *thread = &pool->threads[tidx];
+
+	if (thread->running)
+		return -EBUSY;
+
+	sigfillset(&full);
+	if (sigprocmask(SIG_SETMASK, &full, &mask)) {
+		pr_debug2("Failed to block signals on threads start: %s\n",
+			str_error_r(errno, sbuf, sizeof(sbuf)));
+		return -THREADPOOL_ERROR__SIGPROCMASK;
+	}
+
+	pthread_attr_init(&attrs);
+	pthread_attr_setdetachstate(&attrs, PTHREAD_CREATE_DETACHED);
+
+	ret = pthread_create(&thread->ptid, &attrs, threadpool_entry__function, thread);
+	if (ret) {
+		err = -ret;
+		pr_debug2("Failed to start threads: %s\n", str_error_r(ret, sbuf, sizeof(sbuf)));
+		goto out;
+	}
+
+	err = threadpool__wait_thread(pool, tidx);
+	if (err)
+		goto out_cancel;
+
+	thread->running = true;
+
+out:
+	pthread_attr_destroy(&attrs);
+
+	if (sigprocmask(SIG_SETMASK, &mask, NULL)) {
+		pr_debug2("Failed to unblock signals on threads start: %s\n",
+			str_error_r(errno, sbuf, sizeof(sbuf)));
+		err = -THREADPOOL_ERROR__SIGPROCMASK;
+	}
+
+	return err;
+
+out_cancel:
+	pthread_cancel(thread->ptid);
+	goto out;
+}
+
+/**
+ * threadpool__start - start all threads in the pool.
+ *
+ * The function blocks until all threads are up and running.
+ */
+int threadpool__start(struct threadpool *pool)
+{
+	int t, tt, err = 0, nr_threads = pool->nr_threads;
+
+	for (t = 0; t < nr_threads; t++) {
+		err = threadpool__start_thread(pool, t);
+		if (err)
+			goto out_terminate;
+	}
+
+out:
+	return err;
+
+out_terminate:
+	for (tt = 0; tt < t; tt++)
+		threadpool__terminate_thread(pool, tt);
+	goto out;
+}
+
+
+/**
+ * threadpool__stop - stop all threads in the pool.
+ *
+ * This function blocks waiting for ack from all threads.
+ */
+int threadpool__stop(struct threadpool *pool)
+{
+	int t, ret, err = 0;
+
+	for (t = 0; t < pool->nr_threads; t++) {
+		/**
+		 * Even if a termination fails, we should continue to terminate
+		 * all other threads.
+		 */
+		ret = threadpool__terminate_thread(pool, t);
+		if (ret)
+			err = ret;
+	}
+
+	return err;
+}
+
+/**
+ * threadpool__is_running - return true if any of the threads is running
+ */
+bool threadpool__is_running(struct threadpool *pool)
+{
+	int t;
+
+	for (t = 0; t < pool->nr_threads; t++)
+		if (pool->threads[t].running)
+			return true;
+	return false;
+}
diff --git a/tools/perf/util/workqueue/threadpool.h b/tools/perf/util/workqueue/threadpool.h
index 55146eb141d4c380..0e03fdd377627e79 100644
--- a/tools/perf/util/workqueue/threadpool.h
+++ b/tools/perf/util/workqueue/threadpool.h
@@ -14,10 +14,23 @@ struct task_struct {
 extern struct threadpool *threadpool__new(int n_threads);
 extern void threadpool__delete(struct threadpool *pool);
 
+extern int threadpool__start_thread(struct threadpool *pool, int tidx);
+extern int threadpool__start(struct threadpool *pool);
+extern int threadpool__stop(struct threadpool *pool);
+
 extern int threadpool__size(struct threadpool *pool);
+extern bool threadpool__is_running(struct threadpool *pool);
 
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

