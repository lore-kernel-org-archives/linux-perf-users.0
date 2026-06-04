Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A923DA5AC;
	Thu,  4 Jun 2026 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780603905; cv=none; b=UKK9XSQf0IfzeHGPlsOoL2rFOVDDWmVqnvs01n6lSAKcejqxtiNK/LUfKkER9Q+IuQ+O5Y0vQ+KSpXmNzZC92eWxqxPtihkb8gVY46DO0ItXP225Yo9VvQyrwhmUlIr8AwceFxAtXpNOolLWZuD1ojJr0uu799Xh9nexbmhu/2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780603905; c=relaxed/simple;
	bh=UCQpoZtRZQix/YorHPv3+3WJF0dhBiq66RD+C0xocqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvlMsIncbSp6fDvWtDRcathcouKlKfHiA3v0ESOntgKw8/r8pXwzoQcPzcQuQCHFUPlcFDFl5+5UDYTUGjqGPXDk9l2lkfz5UORUp+o/BySqb8e7LYCPt5GczLM6UszDzyVMArl+GQDDCuYJ11QdNGZdjdyrsDh0s1KG+Yy90Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrWl1mLT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrWl1mLT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31EA1F00898;
	Thu,  4 Jun 2026 20:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780603902;
	bh=uDdZdq443dw1xqiU/tHBf+lc30Tzb+J6wcTr3uCO5ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GrWl1mLT6RNVYix2IL67065ZVbgoB8EEyersxhdMw8uONzmrsfmcHHgsRf5+lLggV
	 9Fhdrib1FQxKbvFg/gP3PHqA7A6DX8bMW07r4+zRDy4pCmJ+KIg94lGuOWi/8hf+pz
	 WqDL99o1EhEEbK3LBNHElZWIUvrex64eTWE9P3+WtsFwpC2I6vTMN65RhZh9C+hbpb
	 NqBoQ2rJi8Y3iPePx4d6/Dg76TVLb0AhWAV/2Ni6v6suz86eNTWTG6JWDERz8BTSfO
	 3qUK7j9UZ1nt+GI80R5KJ2SsKIfq2lA3YRY3KCezwNsgS133D69JFM91LCh6OOMgaG
	 4VAcLJ7sn2WnA==
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
Subject: [PATCH 3/4] perf sched: Fix NULL dereference in latency_runtime_event
Date: Thu,  4 Jun 2026 17:11:15 -0300
Message-ID: <20260604201119.1702338-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604201119.1702338-1-acme@kernel.org>
References: <20260604201119.1702338-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

latency_runtime_event() passes the return value of
machine__findnew_thread() directly to thread_atoms_search() at line
1216, before checking for NULL at line 1220.  thread_atoms_search()
calls pid_cmp() which dereferences the thread pointer via
thread__tid(), causing a NULL pointer dereference if the allocation
fails.

All other callers of thread_atoms_search() in this file
(latency_switch_event, latency_wakeup_event,
latency_migrate_task_event) correctly check for NULL first.

Move the atoms assignment after the NULL check to match the pattern
used by the other callers.

Fixes: b91fc39f4ad7 ("perf machine: Protect the machine->threads with a rwlock")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 13b801496a01271e..36da451447b5e59f 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1213,13 +1213,15 @@ static int latency_runtime_event(struct perf_sched *sched,
 	const u32 pid	   = perf_sample__intval(sample, "pid");
 	const u64 runtime  = perf_sample__intval(sample, "runtime");
 	struct thread *thread = machine__findnew_thread(machine, -1, pid);
-	struct work_atoms *atoms = thread_atoms_search(&sched->atom_root, thread, &sched->cmp_pid);
+	struct work_atoms *atoms;
 	u64 timestamp = sample->time;
 	int cpu = sample->cpu, err = -1;
 
 	if (thread == NULL)
 		return -1;
 
+	atoms = thread_atoms_search(&sched->atom_root, thread, &sched->cmp_pid);
+
 	/* perf.data is untrusted input — CPU may be absent or corrupted */
 	if (cpu >= MAX_CPUS || cpu < 0) {
 		pr_warning("WARNING: at offset %#" PRIx64 ": out-of-bound sample CPU %d, skipping sample\n",
-- 
2.54.0

