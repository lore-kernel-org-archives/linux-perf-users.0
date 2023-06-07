Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84DFC7EE2F
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jun 2023 01:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbjFGBoi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jun 2023 21:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240503AbjFGBoP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jun 2023 21:44:15 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C93619BF
        for <linux-perf-users@vger.kernel.org>; Tue,  6 Jun 2023 18:44:13 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565a33c35f6so85558897b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jun 2023 18:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686102253; x=1688694253;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dff62jpwMb0/r6p2B6URTiqfETOO43Hv2eYdW2jRSl0=;
        b=jE/KnNuh4nz7/QWE4tTJb+D0BsKFaT765WHBVXAZrnIWXxtBpOQMFn1ADjzNtxtYr/
         P9U17ZzWpk+5aBbZvRE0XGraJEkIV7QeyYR2Nsosl5fh+uJ1OklegPcoMMOsdNCWlCa2
         YUElndY4gbOB1buZxFGBI0KneE37gSGwOC6Y/R+Z7/GdDPMiebcbEtkdrBeq8ZcGhOms
         w/hk1FfAzKS3TZ7d46gsISSOFqGGns8Ck9PECz91Tu8V3960JfrvGsTo+k966nmVt/Zm
         1RDJwGXYCJDrY/IIWmW9wvyBSg3uKADhgjk2v4wqGKEVE7VhzwvqkkS9NtMDSVBdlkHm
         3p5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102253; x=1688694253;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dff62jpwMb0/r6p2B6URTiqfETOO43Hv2eYdW2jRSl0=;
        b=Qsb6WVQ5Nr0GMP3nFYfbkM0A0i3wwq+EmlC5N7xC0eqGf/XOHv1h8d89oPBAGDDWXo
         A9I+2leNnw96V4I9RHyUtcGs1cUFUmI2j4H59uE+s9xkpBAL/bVISg9XBEmqeDEc3vgv
         n6bc0itxiGrPwzva74+l5RUIuHZaGST5QogCr0dXm9/Vsxnb3qC0kLU1s96HFwfyHB42
         rJuZG7ey3MMFiaMHI+P2VixFRwyjHha9Hr7nJOkC86R2vt7C89gbEikD0ApPnb+b+YfD
         XBI8TZ206ARBzEpDviAZcsb+0WrIIzSN5rVq+A4Ql0L6sYnLEU7ZMvz14b4pqlUrqEO/
         +VTw==
X-Gm-Message-State: AC+VfDx3DxLHyZNPZ5F6pxWtGdYrqIlS2FFNsjcEW6Azdn48orpp/qq5
        9ZpOzzjCx29W6Dy/t1j5bXvdgyuPmKTN
X-Google-Smtp-Source: ACHHUZ4Iawx/59lS6bbLlvoBcs3swYi2Y2WoCtxQS8p7kFfz1YVG7/9jwRMIuZYpQoUsdbH42nygYLmm6frH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a25:e6d6:0:b0:ba7:5d7a:b50d with SMTP id
 d205-20020a25e6d6000000b00ba75d7ab50dmr2102946ybh.10.1686102252735; Tue, 06
 Jun 2023 18:44:12 -0700 (PDT)
Date:   Tue,  6 Jun 2023 18:43:34 -0700
In-Reply-To: <20230607014353.3172466-1-irogers@google.com>
Message-Id: <20230607014353.3172466-2-irogers@google.com>
Mime-Version: 1.0
References: <20230607014353.3172466-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 01/20] perf thread: Remove notion of dead threads
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        "Shawn M. Chapla" <schapla@codeweavers.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Raul Silvera <rsilvera@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The dead thread list is best effort. Threads live on it until the
reference count hits zero and they are removed. With correct reference
counting this should never happen. It is, however, part of the 'perf
sched' output that is now removed. If this is an issue we should
implement tracking of dead threads in a robust not best-effort way.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 23 +----------------------
 tools/perf/util/cs-etm.c   |  6 ------
 tools/perf/util/intel-pt.c |  8 --------
 tools/perf/util/machine.c  | 32 +-------------------------------
 tools/perf/util/thread.c   | 25 +------------------------
 tools/perf/util/thread.h   | 11 +----------
 6 files changed, 4 insertions(+), 101 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index cc4ba506e119..3a30c2ac5b47 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2760,7 +2760,7 @@ struct total_run_stats {
 	u64  total_run_time;
 };
 
-static int __show_thread_runtime(struct thread *t, void *priv)
+static int show_thread_runtime(struct thread *t, void *priv)
 {
 	struct total_run_stats *stats = priv;
 	struct thread_runtime *r;
@@ -2783,22 +2783,6 @@ static int __show_thread_runtime(struct thread *t, void *priv)
 	return 0;
 }
 
-static int show_thread_runtime(struct thread *t, void *priv)
-{
-	if (t->dead)
-		return 0;
-
-	return __show_thread_runtime(t, priv);
-}
-
-static int show_deadthread_runtime(struct thread *t, void *priv)
-{
-	if (!t->dead)
-		return 0;
-
-	return __show_thread_runtime(t, priv);
-}
-
 static size_t callchain__fprintf_folded(FILE *fp, struct callchain_node *node)
 {
 	const char *sep = " <- ";
@@ -2890,11 +2874,6 @@ static void timehist_print_summary(struct perf_sched *sched,
 	if (!task_count)
 		printf("<no still running tasks>\n");
 
-	printf("\nTerminated tasks:\n");
-	machine__for_each_thread(m, show_deadthread_runtime, &totals);
-	if (task_count == totals.task_count)
-		printf("<no terminated tasks>\n");
-
 	/* CPU idle stats not tracked when samples were skipped */
 	if (sched->skipped_samples && !sched->idle_hist)
 		return;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 91299cc56bf7..0f5be4ad24ba 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3292,12 +3292,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 		goto err_free_queues;
 	}
 
-	/*
-	 * Initialize list node so that at thread__zput() we can avoid
-	 * segmentation fault at list_del_init().
-	 */
-	INIT_LIST_HEAD(&etm->unknown_thread->node);
-
 	err = thread__set_comm(etm->unknown_thread, "unknown", 0);
 	if (err)
 		goto err_delete_thread;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index fe893c9bab3f..dde2ca77a005 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -4311,14 +4311,6 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 		goto err_free_queues;
 	}
 
-	/*
-	 * Since this thread will not be kept in any rbtree not in a
-	 * list, initialize its list node so that at thread__put() the
-	 * current thread lifetime assumption is kept and we don't segfault
-	 * at list_del_init().
-	 */
-	INIT_LIST_HEAD(&pt->unknown_thread->node);
-
 	err = thread__set_comm(pt->unknown_thread, "unknown", 0);
 	if (err)
 		goto err_delete_thread;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 9e02e19c1b7a..a1954ac85f59 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -241,17 +241,6 @@ void machine__exit(struct machine *machine)
 
 	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads *threads = &machine->threads[i];
-		struct thread *thread, *n;
-		/*
-		 * Forget about the dead, at this point whatever threads were
-		 * left in the dead lists better have a reference count taken
-		 * by who is using them, and then, when they drop those references
-		 * and it finally hits zero, thread__put() will check and see that
-		 * its not in the dead threads list and will not try to remove it
-		 * from there, just calling thread__delete() straight away.
-		 */
-		list_for_each_entry_safe(thread, n, &threads->dead, node)
-			list_del_init(&thread->node);
 
 		exit_rwsem(&threads->lock);
 	}
@@ -2046,18 +2035,7 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
 	rb_erase_cached(&th->rb_node, &threads->entries);
 	RB_CLEAR_NODE(&th->rb_node);
 	--threads->nr;
-	/*
-	 * Move it first to the dead_threads list, then drop the reference,
-	 * if this is the last reference, then the thread__delete destructor
-	 * will be called and we will remove it from the dead_threads list.
-	 */
-	list_add_tail(&th->node, &threads->dead);
 
-	/*
-	 * We need to do the put here because if this is the last refcount,
-	 * then we will be touching the threads->dead head when removing the
-	 * thread.
-	 */
 	thread__put(th);
 
 	if (lock)
@@ -2145,10 +2123,8 @@ int machine__process_exit_event(struct machine *machine, union perf_event *event
 	if (dump_trace)
 		perf_event__fprintf_task(event, stdout);
 
-	if (thread != NULL) {
-		thread__exited(thread);
+	if (thread != NULL)
 		thread__put(thread);
-	}
 
 	return 0;
 }
@@ -3204,12 +3180,6 @@ int machine__for_each_thread(struct machine *machine,
 			if (rc != 0)
 				return rc;
 		}
-
-		list_for_each_entry(thread, &threads->dead, node) {
-			rc = fn(thread, priv);
-			if (rc != 0)
-				return rc;
-		}
 	}
 	return rc;
 }
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 4b5bdc277baa..d949bffc0ed6 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -125,31 +125,8 @@ struct thread *thread__get(struct thread *thread)
 
 void thread__put(struct thread *thread)
 {
-	if (thread && refcount_dec_and_test(&thread->refcnt)) {
-		/*
-		 * Remove it from the dead threads list, as last reference is
-		 * gone, if it is in a dead threads list.
-		 *
-		 * We may not be there anymore if say, the machine where it was
-		 * stored was already deleted, so we already removed it from
-		 * the dead threads and some other piece of code still keeps a
-		 * reference.
-		 *
-		 * This is what 'perf sched' does and finally drops it in
-		 * perf_sched__lat(), where it calls perf_sched__read_events(),
-		 * that processes the events by creating a session and deleting
-		 * it, which ends up destroying the list heads for the dead
-		 * threads, but before it does that it removes all threads from
-		 * it using list_del_init().
-		 *
-		 * So we need to check here if it is in a dead threads list and
-		 * if so, remove it before finally deleting the thread, to avoid
-		 * an use after free situation.
-		 */
-		if (!list_empty(&thread->node))
-			list_del_init(&thread->node);
+	if (thread && refcount_dec_and_test(&thread->refcnt))
 		thread__delete(thread);
-	}
 }
 
 static struct namespaces *__thread__namespaces(const struct thread *thread)
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 395c626699a9..86737812e06b 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -30,10 +30,7 @@ struct lbr_stitch {
 };
 
 struct thread {
-	union {
-		struct rb_node	 rb_node;
-		struct list_head node;
-	};
+	struct rb_node		rb_node;
 	struct maps		*maps;
 	pid_t			pid_; /* Not all tools update this */
 	pid_t			tid;
@@ -43,7 +40,6 @@ struct thread {
 	refcount_t		refcnt;
 	bool			comm_set;
 	int			comm_len;
-	bool			dead; /* if set thread has exited */
 	struct list_head	namespaces_list;
 	struct rw_semaphore	namespaces_lock;
 	struct list_head	comm_list;
@@ -81,11 +77,6 @@ static inline void __thread__zput(struct thread **thread)
 
 #define thread__zput(thread) __thread__zput(&thread)
 
-static inline void thread__exited(struct thread *thread)
-{
-	thread->dead = true;
-}
-
 struct namespaces *thread__namespaces(struct thread *thread);
 int thread__set_namespaces(struct thread *thread, u64 timestamp,
 			   struct perf_record_namespaces *event);
-- 
2.41.0.rc0.172.g3f132b7071-goog

