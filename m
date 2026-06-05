Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365AD407CD7;
	Fri,  5 Jun 2026 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691647; cv=none; b=TtDHStyJt9Z4KpWt+JZmBL0EDXWMBBWY220SsO4PRIIDMMxdk64Mlu4hz149VARiZ9ZklxuglXLgicw6bCjU8uSIr27IEBO4AL99DKocWxeWyj2GGEy7r0tQ/cRE9ht/Xf5UVLcGrxLBCfp3Q5M9MOON1fIVCh1lQiIS612TfQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691647; c=relaxed/simple;
	bh=y/3Y1kzgtOtetBhhtbcQKNafHZfpVeknDKaJQi9vO78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHLZnSxLjYNvJ8PXHruoaSl5xCQ/zqcirP9x2BFPHSlP6l4L9B95iiGrwe/qPmzu2LKVX+rgTqs68PNkGoVDARW8dTYe4BD6qabbWpAhYJg1zxuP/A8HCNZsMvoy8vo8+NDDq1kKMMIDWAAL7+nV/vXC6bakR7X+OZU8er/qhHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyqBw2uR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyqBw2uR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895E31F00899;
	Fri,  5 Jun 2026 20:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780691645;
	bh=Kx49sQD2NgfXn7N4XpF6tp9WxmFwCEE3TA0rGGRUtuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eyqBw2uRj/dPCYiB9IJuAIK1s5X1dJUD25JjEDUPmujjW9B6GnRtYHSLSDrSgHZ8p
	 +smCmSskbKVjsEzxPLyyMbVJiNemAiFCWDnoKLt4nMW2+UAbk4lZSNjt4JK2jyomhD
	 i7fjPi7cfIYpOk6NftHmbciRdeTmV7UO31p4NwxcpRM49Rc9hxujmo17xWO6NJMbV1
	 ZGiylRkZeQJJnADd/bXby/VlZQVF3rdfoLHpfUdPRdS3EGFiCWZoEppD6mGeqARdIx
	 9jVaNPGsbsodIkd7gFqSu8u74rVIxHmvMkz515i11hN7oryNw1X1sdXJGfadkXencD
	 ygpa5REY8PghQ==
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
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 8/8] perf sched: Replace BUG_ON and add NULL checks in replay event helpers
Date: Fri,  5 Jun 2026 17:33:16 -0300
Message-ID: <20260605203316.1758661-9-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605203316.1758661-1-acme@kernel.org>
References: <20260605203316.1758661-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

get_new_event() has three issues:

1. The zalloc() result is dereferenced without a NULL check, crashing
   on allocation failure.

2. BUG_ON(!task->atoms) kills the process when realloc() fails.
   Since perf.data is untrusted input, this should be a graceful error.

3. The realloc pattern assigns directly to task->atoms, losing the old
   pointer on failure.  task->nr_events is also incremented before the
   realloc, leaving corrupted state on failure.

Fix get_new_event() to:
  - Check the zalloc() result before dereferencing
  - Use a temporary for realloc() to avoid losing the old pointer
  - Increment nr_events only after successful realloc
  - Return NULL instead of calling BUG_ON on failure

Also fix add_sched_event_wakeup() where zalloc() for wait_sem is
passed to sem_init() without a NULL check.

Update all callers (add_sched_event_run, add_sched_event_wakeup,
add_sched_event_sleep) to handle NULL returns by returning early.
The replay may produce incomplete output on OOM but will not crash.

Fixes: ec156764d424 ("perf sched: Import schedbench.c")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 3668048ca96cb71a..e7e55925532ff6f1 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -365,14 +365,25 @@ get_new_event(struct task_desc *task, u64 timestamp)
 	struct sched_atom *event = zalloc(sizeof(*event));
 	unsigned long idx = task->nr_events;
 	size_t size;
+	struct sched_atom **atoms_p;
+
+	if (event == NULL) {
+		pr_err("ERROR: sched: failed to allocate event\n");
+		return NULL;
+	}
 
 	event->timestamp = timestamp;
 	event->nr = idx;
 
+	size = sizeof(struct sched_atom *) * (task->nr_events + 1);
+	atoms_p = realloc(task->atoms, size);
+	if (!atoms_p) {
+		pr_err("ERROR: sched: failed to grow atoms array\n");
+		free(event);
+		return NULL;
+	}
+	task->atoms = atoms_p;
 	task->nr_events++;
-	size = sizeof(struct sched_atom *) * task->nr_events;
-	task->atoms = realloc(task->atoms, size);
-	BUG_ON(!task->atoms);
 
 	task->atoms[idx] = event;
 
@@ -403,6 +414,8 @@ static void add_sched_event_run(struct perf_sched *sched, struct task_desc *task
 	}
 
 	event = get_new_event(task, timestamp);
+	if (event == NULL)
+		return;
 
 	event->type = SCHED_EVENT_RUN;
 	event->duration = duration;
@@ -416,6 +429,8 @@ static void add_sched_event_wakeup(struct perf_sched *sched, struct task_desc *t
 	struct sched_atom *event, *wakee_event;
 
 	event = get_new_event(task, timestamp);
+	if (event == NULL)
+		return;
 	event->type = SCHED_EVENT_WAKEUP;
 	event->wakee = wakee;
 
@@ -430,6 +445,10 @@ static void add_sched_event_wakeup(struct perf_sched *sched, struct task_desc *t
 	}
 
 	wakee_event->wait_sem = zalloc(sizeof(*wakee_event->wait_sem));
+	if (!wakee_event->wait_sem) {
+		pr_err("ERROR: sched: failed to allocate semaphore\n");
+		return;
+	}
 	sem_init(wakee_event->wait_sem, 0, 0);
 	event->wait_sem = wakee_event->wait_sem;
 
@@ -441,6 +460,9 @@ static void add_sched_event_sleep(struct perf_sched *sched, struct task_desc *ta
 {
 	struct sched_atom *event = get_new_event(task, timestamp);
 
+	if (event == NULL)
+		return;
+
 	event->type = SCHED_EVENT_SLEEP;
 
 	sched->nr_sleep_events++;
-- 
2.54.0

