Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A313C1F24;
	Fri,  5 Jun 2026 23:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780702775; cv=none; b=nQRSeJ29HDhvbfnPgiilhjE2y3FcAurGuWeM7qFL1zPu95m5XjaVIMyeRnU4zm3ugihA7kKkNbqSeZCC1cenVXAVynACGTvhdWCCZ+7B2IpPf5gKb2tgpxoChZt9UBAo44giOEiAxio5FKQ8VZIdbPlYLFM0Km2+bKCv3/3+xII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780702775; c=relaxed/simple;
	bh=7E+u88YjhqSFrOC8EAI6iyi24IFEPnQ79oxxisFcQrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYmIV1GoQjyDVQcrSw1qReg7BMcPnRWr8+J01QqGDOHr4IWYZJf46aqajfePJzb8g1dE3K7QLPQTcAKZ5+VlRrsJy2P8YLrCJgkG+ekEnf2aO0aRRcxn8Yj/WwruVSbbsZzn4IiF3RIFjcQh7ij35rfhaxCXJWaMDjcb/wrxhIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EO+wPeSd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EO+wPeSd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BB51F00898;
	Fri,  5 Jun 2026 23:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780702774;
	bh=Mf/zzc3NHCDU7+/AiwA0r3A/M8he1jXO0lPdQVV+t+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EO+wPeSdMZGPZ84N2SKJgIrpjvrXu2+KpWhVU/B8ssJ1vpH9GOHhWYjK6cZJpqUW5
	 6r0+zDXip2lDy/mrGUneE256hieX3JCUKuDQeet971Sz77VfX3yxrDs473TL9zdzW3
	 eUv9JK2XwSKrbYVgoQpUhh/0bLVMkgQfA8xtye1FdE/aPHFx4TxlaSAtBiqcsljLow
	 iBegfAbC2KeVtUo+vwZnh24SB8QqXiQGhbamDkn7bhReHR+SzXfeLRtKWH7BnJFTn2
	 d2nvLtCvG9f5lst5Lar1kINCUcCEIl0D32+jrrxtoDWVqZTpNsvf7n8Xq13DffBmr8
	 VhgTP2bffwrXQ==
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
Subject: [PATCH 9/9] perf sched: Replace BUG_ON and add NULL checks in replay event helpers
Date: Fri,  5 Jun 2026 20:38:37 -0300
Message-ID: <20260605233837.1773732-10-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605233837.1773732-1-acme@kernel.org>
References: <20260605233837.1773732-1-acme@kernel.org>
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
index 732c65008a8a5240..b7ccdc6a985d1c7b 100644
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

