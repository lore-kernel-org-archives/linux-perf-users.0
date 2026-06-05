Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFF5296BCD;
	Fri,  5 Jun 2026 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661749; cv=none; b=gJp2+8oOZX5/viHFxmkWE+oIQ17GqRsOCSh9DmeETtBzJcHQYtBljmg3n+cn15lgd/apAWw/oHuysNuV3FJ7lg+I8VSS9xfE1cN/g6f2wYmfGMlu9HSKTGBZ1sokaOOVV6eG5tk99xeQiV8PrWrNuWQp7rpeI1Psu+A5muULwsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661749; c=relaxed/simple;
	bh=E/X5t8VSuLeT43XVwJ4SLY/T8z0TgVNOuzEQHKxUA/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USNWaNJyUYJqtgoaJgtW+Ugq/kXbjxIt62NK7iXtGJwYDUQlJc5hBgydLYCkS06TcPsJhNFa4djGg5VRFGgCR7wbiiVwHGoShdWjVBdhwViSp5tPDZ1WR3tCc+caPZmi2ULeUD1F1d9VqMexma5dOTOeugnoXS0YpPZ3NPKy8J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUATDCJm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUATDCJm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38C61F00898;
	Fri,  5 Jun 2026 12:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780661747;
	bh=rVYHvTrmv3hexu3nlZplAr1TqsD9rzUEXCOoHGNhTmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nUATDCJmbNdoi/EftTg7ojAD1ErDkjKVOpU6R4cMgQS/W2InOWZrC1Rq9zd63D79R
	 l410XxU/KbLNWqY3x87ka9rVWbWB2fUc6JN7Ee9o1kS4Tn31x3I8LZwHLcpJrsmfEI
	 ZnbRZsnHhdK9EgHRHj8t8y8IZkLmhcsSzQEEYthhKOB4zcGRAl2XqUnNhCRQmz45w/
	 9psvdvMHZJaRD/fQ+WghcXPmJjEgtQ87c1BsWK1bJQJTo5/gnG3jMUGTjxkpoBsa3e
	 benTgLPaCNCHN630Ch6CmOF0lZdaWQO5xFxSlNIyuO913UNqwbAsWoevB9zv3PR4Oq
	 qmCysBqpuByow==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 5/5] perf sched: Fix register_pid() overflow, strcpy, and BUG_ON
Date: Fri,  5 Jun 2026 09:15:14 -0300
Message-ID: <20260605121515.1725549-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605121515.1725549-1-acme@kernel.org>
References: <20260605121515.1725549-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

register_pid() has several issues when processing untrusted perf.data:

1. Integer overflow: (pid + 1) * sizeof(struct task_desc *) can wrap
   to a small value on 32-bit systems when pid is large (e.g.
   0x40000000), causing realloc to return a tiny buffer followed by
   out-of-bounds writes in the initialization loop.

2. Heap buffer overflow: strcpy(task->comm, comm) copies the
   untrusted comm string into a fixed 20-byte COMM_LEN buffer with
   no length check.

3. BUG_ON on allocation failure: perf.data is untrusted input, so
   allocation failures should be handled gracefully rather than
   killing the process.

4. Realloc of sched->tasks assigned directly back, leaking the old
   pointer on failure; nr_tasks incremented before the realloc,
   leaving corrupted state on failure.

Cap pid at PID_MAX_LIMIT (4194304, matching the kernel's maximum
on 64-bit), replace strcpy with strlcpy, guard against NULL comm,
replace BUG_ON with NULL returns using safe realloc patterns, and
add NULL checks in callers that dereference the result.

Fixes: ec156764d424 ("perf sched: Import schedbench.c")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 40 ++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 87a1f4cf8760e1e9..21fb820b625b43e1 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -55,6 +55,7 @@
 #define COMM_LEN		20
 #define SYM_LEN			129
 #define MAX_PID			1024000
+#define PID_MAX_LIMIT		4194304 /* kernel limit on 64-bit */
 #define MAX_PRIO		140
 #define SEP_LEN			100
 
@@ -448,17 +449,28 @@ static void add_sched_event_sleep(struct perf_sched *sched, struct task_desc *ta
 static struct task_desc *register_pid(struct perf_sched *sched,
 				      unsigned long pid, const char *comm)
 {
-	struct task_desc *task;
+	struct task_desc *task, **tasks_p;
 	static int pid_max;
 
+	/* perf.data is untrusted — cap pid to prevent overflow in size calculations */
+	if (pid >= PID_MAX_LIMIT) {
+		pr_err("pid %lu exceeds limit %d, skipping\n", pid, PID_MAX_LIMIT);
+		return NULL;
+	}
+
 	if (sched->pid_to_task == NULL) {
 		if (sysctl__read_int("kernel/pid_max", &pid_max) < 0)
 			pid_max = MAX_PID;
-		BUG_ON((sched->pid_to_task = calloc(pid_max, sizeof(struct task_desc *))) == NULL);
+		sched->pid_to_task = calloc(pid_max, sizeof(struct task_desc *));
+		if (sched->pid_to_task == NULL)
+			return NULL;
 	}
 	if (pid >= (unsigned long)pid_max) {
-		BUG_ON((sched->pid_to_task = realloc(sched->pid_to_task, (pid + 1) *
-			sizeof(struct task_desc *))) == NULL);
+		void *p = realloc(sched->pid_to_task, (pid + 1) * sizeof(struct task_desc *));
+
+		if (p == NULL)
+			return NULL;
+		sched->pid_to_task = p;
 		while (pid >= (unsigned long)pid_max)
 			sched->pid_to_task[pid_max++] = NULL;
 	}
@@ -469,9 +481,11 @@ static struct task_desc *register_pid(struct perf_sched *sched,
 		return task;
 
 	task = zalloc(sizeof(*task));
+	if (task == NULL)
+		return NULL;
 	task->pid = pid;
-	task->nr = sched->nr_tasks;
-	strcpy(task->comm, comm);
+	if (comm)
+		strlcpy(task->comm, comm, sizeof(task->comm));
 	/*
 	 * every task starts in sleeping state - this gets ignored
 	 * if there's no wakeup pointing to this sleep state:
@@ -479,10 +493,12 @@ static struct task_desc *register_pid(struct perf_sched *sched,
 	add_sched_event_sleep(sched, task, 0);
 
 	sched->pid_to_task[pid] = task;
-	sched->nr_tasks++;
-	sched->tasks = realloc(sched->tasks, sched->nr_tasks * sizeof(struct task_desc *));
-	BUG_ON(!sched->tasks);
-	sched->tasks[task->nr] = task;
+	tasks_p = realloc(sched->tasks, (sched->nr_tasks + 1) * sizeof(struct task_desc *));
+	if (!tasks_p)
+		return NULL;
+	sched->tasks = tasks_p;
+	sched->tasks[sched->nr_tasks] = task;
+	task->nr = sched->nr_tasks++;
 
 	if (verbose > 0)
 		printf("registered task #%ld, PID %ld (%s)\n", sched->nr_tasks, pid, comm);
@@ -841,6 +857,8 @@ replay_wakeup_event(struct perf_sched *sched,
 
 	waker = register_pid(sched, sample->tid, "<unknown>");
 	wakee = register_pid(sched, pid, comm);
+	if (waker == NULL || wakee == NULL)
+		return -1;
 
 	add_sched_event_wakeup(sched, waker, sample->time, wakee);
 	return 0;
@@ -881,6 +899,8 @@ static int replay_switch_event(struct perf_sched *sched,
 
 	prev = register_pid(sched, prev_pid, prev_comm);
 	next = register_pid(sched, next_pid, next_comm);
+	if (prev == NULL || next == NULL)
+		return -1;
 
 	sched->cpu_last_switched[cpu] = timestamp;
 
-- 
2.54.0

