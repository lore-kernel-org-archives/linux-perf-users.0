Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D2851033
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 05:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709271416; cv=none; b=ATUjsUhx1938o120uq24bMGdb7neHrdnhJKii3JElhL6pyIHnRIY0QVcXiMtBmoQJQq0zfyy7HDzBO3PJKkQpm2XmmFjAW/2g4ZMqqjSfZhV44PAwpskTPgJZIB1UckMe4uAVGN36ORbaxuff01cBWBaEDi9fU6HM6VO7LkeeT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709271416; c=relaxed/simple;
	bh=5Vfpowhmbi0TZhAFP5b/eNfo07AUeLjsdG6M3wyq6EU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QoNiK+d1+90eZJypV609GQXUsVV4vcMv+d9M/zpLbxVb52wJOCeL4wYm+zJsxVnqIwMBPxGGMCd2Cb2J4L7VGXUsZL25euk4e3dOHVV1mxnMI9LnnAFOr2zmuLKZOOd6NmTbdXu2hghMLaJ5soKxpBidN3jGSNnGFauApaNBmak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ebeClS+Q; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ebeClS+Q"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64f63d768so3168774276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 21:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709271413; x=1709876213; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yQeIrRq9VG1C1m8G7JjY7O5qpsoUL6eU/Y9t6ioRzeU=;
        b=ebeClS+Q7qbXccRBIH/lVBhgQUMUM1JWewUf2qTGIW+MySiMN8eepnaKLsDWdLtH1l
         tV2Bs23lnR2I2ZVtVmlwmkGEIAN0lKATEZehsHSWOcn7xVEDfgUXRG9MRpgLhqUa839V
         6ocsYIll6VF4QZSuRVrZYmP1H7XkIutQOq+1dVKf2ScEReR04qiJo/PakNRa2/a2y9FU
         9lgnDjO+HkDlj4CFyagESdSIvRPdI8oAYiWt083bmC2j+wClvzY8jWsaocQOsUyssZQ7
         PKGCczOAW4KlbFEuIZv6TdKYeKSt4zOs1nJlKGvPpBtOVSls7+upyXcebo7h3O2Mg0lP
         +OYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709271413; x=1709876213;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQeIrRq9VG1C1m8G7JjY7O5qpsoUL6eU/Y9t6ioRzeU=;
        b=nZdaSYgdudItpUS6GSJt8mFxHRU7XrmiqaR4LOxwfqctbEdmmUBW8mVP9Y5o8YG2V6
         RixymDL0JXnoSXAWbWPB5g6HV4bE6Wl7WXbzAnCKg4Qx0fFwOh2a3Jvo6KnC7IHAoRWW
         iFOrd8+QWiMJw173Aizmga+PK1GTbS+QwDAY8u6CH6PG79my5aN44PdOfyy4bfaiOiOJ
         lAsdyBpovheF8MhWh7mq/1WtxAFRiBcJAms3/cBm4wnzRVSnsmOQudkpl0JxF0JpQQzt
         ZqgW/S8j0XU2WtK7d+nTg6i+mV+NOOT/zSgM24ZUGfgvB7jvKn9VXAWmPGCNHoFRmn69
         PCBw==
X-Forwarded-Encrypted: i=1; AJvYcCWjn2SQ68I6anvG/i4KFTBCMUzGpRMaB1Gb1PszglmXa4C1GWZC8JmOdHtdrYEJi0m33cCYg9LyVWPE1AUjAwq478MKJqNRx707DbaBvMLbRg==
X-Gm-Message-State: AOJu0YxJwi3TvT3kXOfEuNsYdPgpgDJhcoq0bHH0/MZTE5AO5jH7wEH4
	k6JmyNIdoHwo0EULJMNo4XLVod67+unV49+q/OZoUWW6UsJLj7jDbz9f6V7v96/soDiy7ztuQct
	utiv8sQ==
X-Google-Smtp-Source: AGHT+IHzY4vAeCAbNgLDBlMYcUGRB47pTsaxTuaJfsxTor6Gkb2Y+CWHZqehh8mBUqmH6OogzwB27cv1pYZ5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a5b:f05:0:b0:dca:33b8:38d7 with SMTP id
 x5-20020a5b0f05000000b00dca33b838d7mr141664ybr.11.1709271413380; Thu, 29 Feb
 2024 21:36:53 -0800 (PST)
Date: Thu, 29 Feb 2024 21:36:39 -0800
In-Reply-To: <20240301053646.1449657-1-irogers@google.com>
Message-Id: <20240301053646.1449657-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301053646.1449657-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v4 1/7] perf report: Sort child tasks by tid
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 91e467bc568f ("perf machine: Use hashtable for machine
threads") made the iteration of thread tids unordered. The perf report
--tasks output now shows child threads in an order determined by the
hashing. For example, in this snippet tid 3 appears after tid 256 even
though they have the same ppid 2:

```
$ perf report --tasks
%      pid      tid     ppid  comm
         0        0       -1 |swapper
         2        2        0 | kthreadd
       256      256        2 |  kworker/12:1H-k
    693761   693761        2 |  kworker/10:1-mm
   1301762  1301762        2 |  kworker/1:1-mm_
   1302530  1302530        2 |  kworker/u32:0-k
         3        3        2 |  rcu_gp
...
```

The output is easier to read if threads appear numerically
increasing. To allow for this, read all threads into a list then sort
with a comparator that orders by the child task's of the first common
parent. The list creation and deletion are created as utilities on
machine.  The indentation is possible by counting the number of
parents a child has.

With this change the output for the same data file is now like:
```
$ perf report --tasks
%      pid      tid     ppid  comm
         0        0       -1 |swapper
         1        1        0 | systemd
       823      823        1 |  systemd-journal
       853      853        1 |  systemd-udevd
      3230     3230        1 |  systemd-timesyn
      3236     3236        1 |  auditd
      3239     3239     3236 |   audisp-syslog
      3321     3321        1 |  accounts-daemon
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 217 +++++++++++++++++++++---------------
 tools/perf/util/machine.c   |  30 +++++
 tools/perf/util/machine.h   |  10 ++
 3 files changed, 168 insertions(+), 89 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 8e16fa261e6f..dcd93ee5fc24 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -59,6 +59,7 @@
 #include <linux/ctype.h>
 #include <signal.h>
 #include <linux/bitmap.h>
+#include <linux/list_sort.h>
 #include <linux/string.h>
 #include <linux/stringify.h>
 #include <linux/time64.h>
@@ -828,35 +829,6 @@ static void tasks_setup(struct report *rep)
 	rep->tool.no_warn = true;
 }
 
-struct task {
-	struct thread		*thread;
-	struct list_head	 list;
-	struct list_head	 children;
-};
-
-static struct task *tasks_list(struct task *task, struct machine *machine)
-{
-	struct thread *parent_thread, *thread = task->thread;
-	struct task   *parent_task;
-
-	/* Already listed. */
-	if (!list_empty(&task->list))
-		return NULL;
-
-	/* Last one in the chain. */
-	if (thread__ppid(thread) == -1)
-		return task;
-
-	parent_thread = machine__find_thread(machine, -1, thread__ppid(thread));
-	if (!parent_thread)
-		return ERR_PTR(-ENOENT);
-
-	parent_task = thread__priv(parent_thread);
-	thread__put(parent_thread);
-	list_add_tail(&task->list, &parent_task->children);
-	return tasks_list(parent_task, machine);
-}
-
 struct maps__fprintf_task_args {
 	int indent;
 	FILE *fp;
@@ -900,89 +872,156 @@ static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
 	return args.printed;
 }
 
-static void task__print_level(struct task *task, FILE *fp, int level)
+static int thread_level(struct machine *machine, const struct thread *thread)
 {
-	struct thread *thread = task->thread;
-	struct task *child;
-	int comm_indent = fprintf(fp, "  %8d %8d %8d |%*s",
-				  thread__pid(thread), thread__tid(thread),
-				  thread__ppid(thread), level, "");
+	struct thread *parent_thread;
+	int res;
 
-	fprintf(fp, "%s\n", thread__comm_str(thread));
+	if (thread__tid(thread) <= 0)
+		return 0;
 
-	maps__fprintf_task(thread__maps(thread), comm_indent, fp);
+	if (thread__ppid(thread) <= 0)
+		return 1;
 
-	if (!list_empty(&task->children)) {
-		list_for_each_entry(child, &task->children, list)
-			task__print_level(child, fp, level + 1);
+	parent_thread = machine__find_thread(machine, -1, thread__ppid(thread));
+	if (!parent_thread) {
+		pr_err("Missing parent thread of %d\n", thread__tid(thread));
+		return 0;
 	}
+	res = 1 + thread_level(machine, parent_thread);
+	thread__put(parent_thread);
+	return res;
 }
 
-static int tasks_print(struct report *rep, FILE *fp)
+static void task__print_level(struct machine *machine, struct thread *thread, FILE *fp)
 {
-	struct perf_session *session = rep->session;
-	struct machine      *machine = &session->machines.host;
-	struct task *tasks, *task;
-	unsigned int nr = 0, itask = 0, i;
-	struct rb_node *nd;
-	LIST_HEAD(list);
+	int level = thread_level(machine, thread);
+	int comm_indent = fprintf(fp, "  %8d %8d %8d |%*s",
+				  thread__pid(thread), thread__tid(thread),
+				  thread__ppid(thread), level, "");
 
-	/*
-	 * No locking needed while accessing machine->threads,
-	 * because --tasks is single threaded command.
-	 */
+	fprintf(fp, "%s\n", thread__comm_str(thread));
 
-	/* Count all the threads. */
-	for (i = 0; i < THREADS__TABLE_SIZE; i++)
-		nr += machine->threads[i].nr;
+	maps__fprintf_task(thread__maps(thread), comm_indent, fp);
+}
 
-	tasks = malloc(sizeof(*tasks) * nr);
-	if (!tasks)
-		return -ENOMEM;
+/*
+ * Sort two thread list nodes such that they form a tree. The first node is the
+ * root of the tree, its children are ordered numerically after it. If a child
+ * has children itself then they appear immediately after their parent. For
+ * example, the 4 threads in the order they'd appear in the list:
+ * - init with a TID 1 and a parent of 0
+ * - systemd with a TID 3000 and a parent of init/1
+ * - systemd child thread with TID 4000, the parent is 3000
+ * - NetworkManager is a child of init with a TID of 3500.
+ */
+static int task_list_cmp(void *priv, const struct list_head *la, const struct list_head *lb)
+{
+	struct machine *machine = priv;
+	struct thread_list *task_a = list_entry(la, struct thread_list, list);
+	struct thread_list *task_b = list_entry(lb, struct thread_list, list);
+	struct thread *a = task_a->thread;
+	struct thread *b = task_b->thread;
+	int level_a, level_b, res;
+
+	/* Same thread? */
+	if (thread__tid(a) == thread__tid(b))
+		return 0;
 
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads *threads = &machine->threads[i];
+	/* Compare a and b to root. */
+	if (thread__tid(a) == 0)
+		return -1;
 
-		for (nd = rb_first_cached(&threads->entries); nd;
-		     nd = rb_next(nd)) {
-			task = tasks + itask++;
+	if (thread__tid(b) == 0)
+		return 1;
 
-			task->thread = rb_entry(nd, struct thread_rb_node, rb_node)->thread;
-			INIT_LIST_HEAD(&task->children);
-			INIT_LIST_HEAD(&task->list);
-			thread__set_priv(task->thread, task);
-		}
-	}
+	/* If parents match sort by tid. */
+	if (thread__ppid(a) == thread__ppid(b))
+		return thread__tid(a) < thread__tid(b) ? -1 : 1;
 
 	/*
-	 * Iterate every task down to the unprocessed parent
-	 * and link all in task children list. Task with no
-	 * parent is added into 'list'.
+	 * Find a and b such that if they are a child of each other a and b's
+	 * tid's match, otherwise a and b have a common parent and distinct
+	 * tid's to sort by. First make the depths of the threads match.
 	 */
-	for (itask = 0; itask < nr; itask++) {
-		task = tasks + itask;
-
-		if (!list_empty(&task->list))
-			continue;
-
-		task = tasks_list(task, machine);
-		if (IS_ERR(task)) {
-			pr_err("Error: failed to process tasks\n");
-			free(tasks);
-			return PTR_ERR(task);
+	level_a = thread_level(machine, a);
+	level_b = thread_level(machine, b);
+	a = thread__get(a);
+	b = thread__get(b);
+	for (int i = level_a; i > level_b; i--) {
+		struct thread *parent = machine__find_thread(machine, -1, thread__ppid(a));
+
+		thread__put(a);
+		if (!parent) {
+			pr_err("Missing parent thread of %d\n", thread__tid(a));
+			thread__put(b);
+			return -1;
 		}
+		a = parent;
+	}
+	for (int i = level_b; i > level_a; i--) {
+		struct thread *parent = machine__find_thread(machine, -1, thread__ppid(b));
 
-		if (task)
-			list_add_tail(&task->list, &list);
+		thread__put(b);
+		if (!parent) {
+			pr_err("Missing parent thread of %d\n", thread__tid(b));
+			thread__put(a);
+			return 1;
+		}
+		b = parent;
+	}
+	/* Search up to a common parent. */
+	while (thread__ppid(a) != thread__ppid(b)) {
+		struct thread *parent;
+
+		parent = machine__find_thread(machine, -1, thread__ppid(a));
+		thread__put(a);
+		if (!parent)
+			pr_err("Missing parent thread of %d\n", thread__tid(a));
+		a = parent;
+		parent = machine__find_thread(machine, -1, thread__ppid(b));
+		thread__put(b);
+		if (!parent)
+			pr_err("Missing parent thread of %d\n", thread__tid(b));
+		b = parent;
+		if (!a || !b) {
+			/* Handle missing parent (unexpected) with some sanity. */
+			thread__put(a);
+			thread__put(b);
+			return !a && !b ? 0 : (!a ? -1 : 1);
+		}
+	}
+	if (thread__tid(a) == thread__tid(b)) {
+		/* a is a child of b or vice-versa, deeper levels appear later. */
+		res = level_a < level_b ? -1 : (level_a > level_b ? 1 : 0);
+	} else {
+		/* Sort by tid now the parent is the same. */
+		res = thread__tid(a) < thread__tid(b) ? -1 : 1;
 	}
+	thread__put(a);
+	thread__put(b);
+	return res;
+}
 
-	fprintf(fp, "# %8s %8s %8s  %s\n", "pid", "tid", "ppid", "comm");
+static int tasks_print(struct report *rep, FILE *fp)
+{
+	struct machine *machine = &rep->session->machines.host;
+	LIST_HEAD(tasks);
+	int ret;
 
-	list_for_each_entry(task, &list, list)
-		task__print_level(task, fp, 0);
+	ret = machine__thread_list(machine, &tasks);
+	if (!ret) {
+		struct thread_list *task;
 
-	free(tasks);
-	return 0;
+		list_sort(machine, &tasks, task_list_cmp);
+
+		fprintf(fp, "# %8s %8s %8s  %s\n", "pid", "tid", "ppid", "comm");
+
+		list_for_each_entry(task, &tasks, list)
+			task__print_level(machine, task->thread, fp);
+	}
+	thread_list__delete(&tasks);
+	return ret;
 }
 
 static int __cmd_report(struct report *rep)
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3da92f18814a..7872ce92c9fc 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3261,6 +3261,36 @@ int machines__for_each_thread(struct machines *machines,
 	return rc;
 }
 
+
+static int thread_list_cb(struct thread *thread, void *data)
+{
+	struct list_head *list = data;
+	struct thread_list *entry = malloc(sizeof(*entry));
+
+	if (!entry)
+		return -ENOMEM;
+
+	entry->thread = thread__get(thread);
+	list_add_tail(&entry->list, list);
+	return 0;
+}
+
+int machine__thread_list(struct machine *machine, struct list_head *list)
+{
+	return machine__for_each_thread(machine, thread_list_cb, list);
+}
+
+void thread_list__delete(struct list_head *list)
+{
+	struct thread_list *pos, *next;
+
+	list_for_each_entry_safe(pos, next, list, list) {
+		thread__zput(pos->thread);
+		list_del(&pos->list);
+		free(pos);
+	}
+}
+
 pid_t machine__get_current_tid(struct machine *machine, int cpu)
 {
 	if (cpu < 0 || (size_t)cpu >= machine->current_tid_sz)
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 1279acda6a8a..b738ce84817b 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -280,6 +280,16 @@ int machines__for_each_thread(struct machines *machines,
 			      int (*fn)(struct thread *thread, void *p),
 			      void *priv);
 
+struct thread_list {
+	struct list_head	 list;
+	struct thread		*thread;
+};
+
+/* Make a list of struct thread_list based on threads in the machine. */
+int machine__thread_list(struct machine *machine, struct list_head *list);
+/* Free up the nodes within the thread_list list. */
+void thread_list__delete(struct list_head *list);
+
 pid_t machine__get_current_tid(struct machine *machine, int cpu);
 int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
 			     pid_t tid);
-- 
2.44.0.278.ge034bb2e1d-goog

