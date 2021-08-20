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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62EFC432BE
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9158B60FDA
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239746AbhHTKzW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239485AbhHTKzG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 06:55:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EFDC06129E;
        Fri, 20 Aug 2021 03:54:25 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cn28so13393132edb.6;
        Fri, 20 Aug 2021 03:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lc2Zt/+CS0R575XVe79GSf+OTrq7xb/P6V3j1NCEBTY=;
        b=hyOlzRlTsXRl1mYjSqJsRLOEhve2TLqYJcX/uB6fbFqpuZbYNvRhfAz8sRyAq76ei5
         QR5nKClHtYx4bg3UjbXMREcLkt+XB03TQHDJtWS0PbQ68LHTZxiuFMo0UEfIDc03EQZr
         X7oeG1t1wDs/AIP+5bT/AuIY8lsT1mxwDVtuelan9bEMRfKgF9d9uA3O1DzdknU8t7LS
         wuIHqtHWPHob3op9bnvMheJfpoUvuuQIRC+kZNUZV3ETPmklosWvJP0JdyV9TbSIil9A
         PkUhhrac8STHuMu71weWJ1uxqJxzOEPFynVELHe4Bkt3tC7aGZlsc/L9NW68OhtF0VJR
         OZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lc2Zt/+CS0R575XVe79GSf+OTrq7xb/P6V3j1NCEBTY=;
        b=rk0M4u5E4Z1jexvV7D4w6zbaSKDY3fuaFHuh2h1oGw1IisXIPkCxI0rH5gXYBZBUdm
         QOKP2cEUOgdyZUQUHgXThOsnGGNprDm3gQHBwgYSiKXIYnmgo/JYmeguDqLjhZBwbK7X
         iq3pt4TY/43xJlZnHmmTjhsHxj/7q/jn3fZUkySeNMm5KniA/T9W5mjop3g+AtiGc4Lf
         yAZRIKw9VjYdcYJ8+81Ps2wTRd/IqMyxSHVsrF4mS7Kl08mywoQFd0ctoPgxHdkLKdKj
         S2dprg29FE2OEaP/l9JHCxND8DX0KLPdqRQJ+92+hI19he2gg1nZPNunstwn5RcqKR78
         3OtA==
X-Gm-Message-State: AOAM533BfaT96uy4uPQqpKQw1n6cjCB+TUw1RverX3PpLbf2KS8ZKHYA
        vkYecDVzTopJn+IwvUOwoF0=
X-Google-Smtp-Source: ABdhPJyPVvi2FevBcNeRZm1psvv9GDKSX8L6ivH0T82vVs6aqkh90FnG9vcj33tlEN8NpmlTeaD2AA==
X-Received: by 2002:a05:6402:34c7:: with SMTP id w7mr22764587edc.175.1629456864178;
        Fri, 20 Aug 2021 03:54:24 -0700 (PDT)
Received: from honeypot.epfl.ch (mob-176-243-199-7.net.vodafone.it. [176.243.199.7])
        by smtp.googlemail.com with ESMTPSA id g29sm3451459edf.31.2021.08.20.03.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 03:54:23 -0700 (PDT)
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
Subject: [RFC PATCH v3 09/15] perf workqueue: spinup threads when needed
Date:   Fri, 20 Aug 2021 12:53:55 +0200
Message-Id: <c50a4628b86c445391014fb16709c11f72082454.1629454773.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629454773.git.rickyman7@gmail.com>
References: <cover.1629454773.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds lazy thread creation in the workqueue.
When a new work is submitted, first an idle worker is searched. If one
is found, it will be selected for execution. Otherwise, a not already
spawned thread is searched. If found, it will be spun up and selected.
If none of the latter is found, one of the busy threads is chosen using
a round-robin policy.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/workqueue/workqueue.c | 54 +++++++++++++++++++--------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/workqueue/workqueue.c b/tools/perf/util/workqueue/workqueue.c
index 1092ece9ad39d6d2..305a9cda39810b84 100644
--- a/tools/perf/util/workqueue/workqueue.c
+++ b/tools/perf/util/workqueue/workqueue.c
@@ -39,6 +39,7 @@ struct workqueue_struct {
 	int			msg_pipe[2];	/* main thread comm pipes */
 	struct worker		**workers;	/* array of all workers */
 	struct worker		*next_worker;	/* next worker to choose (round robin) */
+	int			first_stopped_worker; /* next worker to start if needed */
 };
 
 static const char * const workqueue_errno_str[] = {
@@ -423,8 +424,7 @@ static void worker_thread(int tidx, struct task_struct *task)
  */
 struct workqueue_struct *create_workqueue(int nr_threads)
 {
-	int ret, err = 0, t;
-	struct worker *worker;
+	int ret, err = 0;
 	struct workqueue_struct *wq = zalloc(sizeof(struct workqueue_struct));
 
 	if (!wq) {
@@ -474,24 +474,11 @@ struct workqueue_struct *create_workqueue(int nr_threads)
 		goto out_close_pipe;
 	}
 
-	for (t = 0; t < nr_threads; t++) {
-		err = spinup_worker(wq, t);
-		if (err)
-			goto out_stop_pool;
-	}
-
 	wq->next_worker = NULL;
+	wq->first_stopped_worker = 0;
 
 	return wq;
 
-out_stop_pool:
-	lock_workqueue(wq);
-	for_each_idle_worker(wq, worker) {
-		ret = stop_worker(worker);
-		if (ret)
-			err = ret;
-	}
-	unlock_workqueue(wq);
 out_close_pipe:
 	close(wq->msg_pipe[0]);
 	wq->msg_pipe[0] = -1;
@@ -686,10 +673,28 @@ __releases(&worker->lock)
  */
 int queue_work(struct workqueue_struct *wq, struct work_struct *work)
 {
+	int ret;
 	struct worker *worker;
 
+repeat:
 	lock_workqueue(wq);
 	if (list_empty(&wq->idle_list)) {
+		// find a worker to spin up
+		while (wq->first_stopped_worker < threadpool__size(wq->pool)
+				&& wq->workers[wq->first_stopped_worker])
+			wq->first_stopped_worker++;
+
+		// found one
+		if (wq->first_stopped_worker < threadpool__size(wq->pool)) {
+			// spinup does not hold the lock to make the thread register itself
+			unlock_workqueue(wq);
+			ret = spinup_worker(wq, wq->first_stopped_worker);
+			if (ret)
+				return ret;
+			// worker is now in idle_list
+			goto repeat;
+		}
+
 		worker = wq->next_worker;
 		advance_next_worker(wq);
 	} else {
@@ -705,7 +710,24 @@ int queue_work(struct workqueue_struct *wq, struct work_struct *work)
  */
 int queue_work_on_worker(int tidx, struct workqueue_struct *wq, struct work_struct *work)
 {
+	int ret;
+
 	lock_workqueue(wq);
+	if (!wq->workers[tidx]) {
+		// spinup does not hold the lock to make the thread register itself
+		unlock_workqueue(wq);
+		ret = spinup_worker(wq, tidx);
+		if (ret)
+			return ret;
+
+		// now recheck if worker is available
+		lock_workqueue(wq);
+		if (!wq->workers[tidx]) {
+			unlock_workqueue(wq);
+			return -WORKQUEUE_ERROR__NOTREADY;
+		}
+	}
+
 	lock_worker(wq->workers[tidx]);
 	return __queue_work_on_worker(wq, wq->workers[tidx], work);
 }
-- 
2.31.1

