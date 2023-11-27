Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bZyJN1sZ"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529482D69
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:38 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db3ef4c7094so5513471276.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123037; x=1701727837; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FQr150ScOb/lbmGkQrGttGTuSJdOwS+GnCjhxbgSEVc=;
        b=bZyJN1sZF/Zm6vA5ddG3bNStjQ3cCTiYTaIVoKTHwees3lAo63QG/fMlJi4m3zky+L
         GQlNQ1wLeVvJsCYPCWEjZp0dOgmOhCun+852HzTD6Rf4cNkpWOZb6Go/bhsUXiOGlnkh
         aAor42mJr6Sgc9U80jhlAy/cJFOQH/4lXBAr9wY1Dhvpb3zXAVZAUsMie1eSyJkjuw5t
         IJQT/mHw5J4T/PaONFTz8Nz8TByKSKaxBelxy4et1Nvyeu6pBEXfkcywWI2oyfTbM0nA
         elhJQnK5gwK92Gi1Pc4XWjRQxiL7+2KmQj/Ft/d8IppMTNW0tU0yIQe8AoCnKaFyVKgZ
         jaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123037; x=1701727837;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQr150ScOb/lbmGkQrGttGTuSJdOwS+GnCjhxbgSEVc=;
        b=KrmtJYZi9UGgqFHB5S/nTJJzo4BsZrlDkHq1xbkoK1TrZzAQoR65kNfeH9t1HFComB
         QhFSr+G0tCF7yusudVG1MghYjdQK8sc6bE3SVAMsJu4OKAjfX2j3QZbQngeJGrTDNGQy
         Pq9pCrTKwdHLQZmmBgcc+VTAGGH3+7zLFJJCoOteWoHZBHn+IEvYasW/Oe6eBDcXFENj
         eMz7qIMn4ZZv3RnvR02cE8oxKKIenj4CGnaUXqYQrsmH/1OixVNrchZl9kwyz2YQLOb/
         qxoy/UF2n4Y9plO3wxValaPOubpnUSZKrduO5znXzTq9Zi//oQdcl8DYlFiGCAsx4sQP
         1MoQ==
X-Gm-Message-State: AOJu0Yyk9aFBNbdb4uCGkYlZ79uN+8lY6D4yz6eGCgcHrus1e2dnkrRV
	IISHEMNeb2eDcs6rmWyutqFTEBiZR0fx
X-Google-Smtp-Source: AGHT+IExtR2pdCcyaQBNptluUzL8OErI9UZpcunqQynNOJ2BLbzrG9bJgqNJRJQmBc6vM4zmMn2NnsW+SRIu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a05:6902:e91:b0:db4:5e66:98fe with SMTP id
 dg17-20020a0569020e9100b00db45e6698femr358495ybb.11.1701123037192; Mon, 27
 Nov 2023 14:10:37 -0800 (PST)
Date: Mon, 27 Nov 2023 14:08:44 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-33-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 32/50] perf report: Sort child tasks by tid
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
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
 tools/perf/builtin-report.c | 203 ++++++++++++++++++++----------------
 tools/perf/util/machine.c   |  30 ++++++
 tools/perf/util/machine.h   |  10 ++
 3 files changed, 155 insertions(+), 88 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index a5d7bc5b843f..f5b95d45f6da 100644
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
@@ -830,35 +831,6 @@ static void tasks_setup(struct report *rep)
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
@@ -902,89 +874,144 @@ static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
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
+static int task_list_cmp(void *priv, const struct list_head *la, const struct list_head *lb)
+{
+	struct machine *machine = priv;
+	struct thread_list *task_a = list_entry(la, struct thread_list, list);
+	struct thread_list *task_b = list_entry(lb, struct thread_list, list);
+	struct thread *a = task_a->thread;
+	struct thread *b = task_b->thread;
+	int level_a, level_b, res;
+
+	/* Compare a and b to root. */
+	if (thread__tid(a) == thread__tid(b))
+		return 0;
 
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads *threads = &machine->threads[i];
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
+	/* If parents match sort by tid. */
+	if (thread__ppid(a) == thread__ppid(b)) {
+		return thread__tid(a) < thread__tid(b)
+			? -1
+			: (thread__tid(a) > thread__tid(b) ? 1 : 0);
 	}
 
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
+		if (!a || !b)
+			return !a && !b ? 0 : (!a ? -1 : 1);
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
+
+static int tasks_print(struct report *rep, FILE *fp)
+{
+	struct machine *machine = &rep->session->machines.host;
+	LIST_HEAD(tasks);
+	int ret;
 
-	fprintf(fp, "# %8s %8s %8s  %s\n", "pid", "tid", "ppid", "comm");
+	ret = machine__thread_list(machine, &tasks);
+	if (!ret) {
+		struct thread_list *task;
 
-	list_for_each_entry(task, &list, list)
-		task__print_level(task, fp, 0);
+		list_sort(machine, &tasks, task_list_cmp);
 
-	free(tasks);
-	return 0;
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
index f9c77119af22..6d7a505850c8 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3258,6 +3258,36 @@ int machines__for_each_thread(struct machines *machines,
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
2.43.0.rc1.413.gea7ed67945-goog

