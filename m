Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B937E105;
	Fri, 12 Jun 2026 00:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224526; cv=none; b=tBKBfSFWXs+Fc83emwzLs+GEyZbjL2Y7JWw9cKgLx3zV6bp1xqMS60Ch7cHUaqFheWTLetL0a3f+ZK6RhBG2edOTVZQlFCh+J1ZMlya5aRhZWKNCWhdIb+FGEs4K5ZtwAJ3YlurCIa9Xi9y85Koc+6lIpRWiizA58VdBOOxR+B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224526; c=relaxed/simple;
	bh=Xk64OA4KDKmLmY7RkepDIPXt0Q1+N//eyczTKXDaBLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNtzO45JH+WWSIhJJQKiK1FgIGnDwGhO5LzrCwfjJbDqrkE/qVMudvthtq+p2Hmn9VeWjOnVERXedt9jOpS2fZnU4hGx3p8KIABDKpV4I+Hen9aCofExoAjNiQC9icealbo0fxTDmxMYNFq2KFnfBI9UJC3s0JjU5JJYSNQPAU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr4HGa4Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr4HGa4Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D132B1F00A3A;
	Fri, 12 Jun 2026 00:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781224525;
	bh=zSAbmXWEkohvATa8TtK9IXZcsOZ7CamkMak1gPsvgSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cr4HGa4Yl7tfuboOXuUEBHhg4CKQ1L9MBUOuXZDAx4K5zXlIsdamKXNMK+wqoKHmG
	 l/b7RRQP1KtYtbRpWJ2Zx+Rjzb9e9y3Mp/4bqYBbwLxIM7ogpB8PERpG1FAp5ilG83
	 dR8R5DVQ7GEpDzdBiGnSZo/8y2zoRFujja6ky45xXy0Hlxl/TkPRrGG/ca+fm7sL1R
	 a7gHR02gUGVxXcCwJOjenXsIIPx3qvhww9fW6oc6K0GNJVxJD4FS8rqPFckrqit4XL
	 9jRxsMHKMz6AU7kHpiV987sBVaHfTICuNonufBgF3xILfR5FUo9LUm3AJfHzBi+Nxj
	 /SICQn/yIHwwg==
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
Subject: [PATCH 09/15] perf sched: Replace (void*)1 sentinel with proper runtime allocation
Date: Thu, 11 Jun 2026 21:34:37 -0300
Message-ID: <20260612003444.50723-10-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612003444.50723-1-acme@kernel.org>
References: <20260612003444.50723-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

map__findnew_thread() marks color-pid threads by storing (void*)1 as
the thread private data via thread__set_priv().  This sentinel value
causes two problems:

1. thread__get_runtime() returns (void*)1 as a struct thread_runtime
   pointer.  Any field access (e.g. tr->shortname) dereferences address
   1, which is an unmapped page — immediate segfault.

2. cmd_sched() registers free() as the thread priv destructor, so thread
   cleanup calls free((void*)1) — undefined behavior that corrupts the
   heap on many allocators.

Fix by adding a 'color' flag to struct thread_runtime and allocating a
real runtime struct for color-pid threads.  thread__has_color() now
checks the flag instead of relying on priv being non-NULL.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: 58a606149c60d5da ("perf sched: Avoid union type punning undefined behavior")
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 5f16caebd9645da0..7fd63a9db4574fbf 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -274,6 +274,7 @@ struct thread_runtime {
 	u64 migrations;
 
 	int prio;
+	bool color;
 };
 
 /* per event run time data */
@@ -1589,22 +1590,32 @@ static int process_sched_wakeup_ignore(const struct perf_tool *tool __maybe_unus
 
 static bool thread__has_color(struct thread *thread)
 {
-	return thread__priv(thread) != NULL;
+	struct thread_runtime *tr = thread__priv(thread);
+
+	return tr != NULL && tr->color;
 }
 
 static struct thread*
 map__findnew_thread(struct perf_sched *sched, struct machine *machine, pid_t pid, pid_t tid)
 {
 	struct thread *thread = machine__findnew_thread(machine, pid, tid);
-	bool color = false;
 
-	if (!sched->map.color_pids || !thread || thread__priv(thread))
+	if (!sched->map.color_pids || !thread)
 		return thread;
 
-	if (thread_map__has(sched->map.color_pids, tid))
-		color = true;
+	/*
+	 * Always check the color-pids map, even if thread__priv() is
+	 * already set.  COMM events processed before the first sched_switch
+	 * allocate a thread_runtime via thread__get_runtime(), so priv is
+	 * non-NULL before we ever get here.  Skipping the check on non-NULL
+	 * priv would prevent those threads from being colored.
+	 */
+	if (thread_map__has(sched->map.color_pids, tid)) {
+		struct thread_runtime *tr = thread__get_runtime(thread);
 
-	thread__set_priv(thread, color ? ((void*)1) : NULL);
+		if (tr)
+			tr->color = true;
+	}
 	return thread;
 }
 
-- 
2.54.0

