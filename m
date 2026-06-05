Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E5C29C325;
	Fri,  5 Jun 2026 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661744; cv=none; b=gX6YxJm98k0WnN/iIio5SFM+XUH8rois30hTojQnk/Cn1hSN3SsWqDCiOwSMzLio99eJMU5WVoNmB97Kp9jsPgymLEQfN2mft/B1XXZs0wBZVtWcB6GgYxlUJWiiYFOg6NZnE/w2UnEThwXZkCWZDcRkaq/5zudLLFPDbD6M1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661744; c=relaxed/simple;
	bh=HOKHGRfUJcS6pTTmAVNE9L8dC7jTySlVCO3W5BsVoRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oT26Rp9GJmzii58kw+9IK1h3b306IrouUtzzFktu4DMU3yBBpkLSq7uadkPjnQezF9IfdP0ulRRFVtBsdKkDl5GXhqgjToanCycrSIBML35jGoFLGa6pXhJCz4PvpGeCt8GZ/M1UeUNm9TdH+dZ5h5S5zN7H+r5Y8XVYy73Txxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6lWm+vZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6lWm+vZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00841F00893;
	Fri,  5 Jun 2026 12:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780661743;
	bh=PBIeMlQer6SU09WeehCC4HX+Dlyd2D3hPoy/580i8ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U6lWm+vZtBJknMv292XXONF59EKLqwKIMk+F84VjwWMjXJgZyt5snTfTOXVIqr37I
	 wJaRKIvB8+BjxrnlJXP7YDQu8fPbkz2HP7YDew2eFAd7o+Lt0GrHr6pb6lRB8RdphX
	 nzyOaJOES5AleGCGTwRUbj+oWEAcoI2uPftPEFr4NneCH2v81HDMZZHr/mrdsXtFbe
	 IloJrh7GxJVR3lMQt9LzmaX208JPz+Wwn4CFvNHE4GEDhz8Xb6w7bUkVv9fZMbkRn2
	 Js99YzutqtSfDc4L5e85OCDVPVR/B9Li2N56yBJzddHCsGFTZgLTUvwB5vWVMdMg2L
	 7HW0vuSLz7F5Q==
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
	David Ahern <dsahern@gmail.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 4/5] perf sched: Cap max_cpu at MAX_CPUS in timehist sample processing
Date: Fri,  5 Jun 2026 09:15:13 -0300
Message-ID: <20260605121515.1725549-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605121515.1725549-1-acme@kernel.org>
References: <20260605121515.1725549-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

perf_timehist__process_sample() updates sched->max_cpu from the
sample CPU without bounds checking.  Later code uses max_cpu + 1 as
an iteration count over arrays allocated with MAX_CPUS entries
(curr_thread, cpu_last_switched).  A recording with CPU IDs >= MAX_CPUS
causes out-of-bounds array accesses.

Also cap the env->nr_cpus_online initialization of max_cpu in
perf_sched__timehist(), which could exceed MAX_CPUS on very large
systems.

Add bounds checks before both max_cpu updates, matching the pattern
already used in map_switch_event().

Fixes: 49394a2a24c7 ("perf sched timehist: Introduce timehist command")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 7bd61028327b39db..87a1f4cf8760e1e9 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3215,7 +3215,9 @@ static int perf_timehist__process_sample(const struct perf_tool *tool,
 		.cpu = sample->cpu,
 	};
 
-	if (this_cpu.cpu > sched->max_cpu.cpu)
+	/* max_cpu indexes arrays allocated with MAX_CPUS entries */
+	if (this_cpu.cpu >= 0 && this_cpu.cpu < MAX_CPUS &&
+	    this_cpu.cpu > sched->max_cpu.cpu)
 		sched->max_cpu = this_cpu;
 
 	if (evsel->handler != NULL) {
@@ -3385,8 +3387,8 @@ static int perf_sched__timehist(struct perf_sched *sched)
 		perf_session__set_tracepoints_handlers(session, migrate_handlers))
 		goto out;
 
-	/* pre-allocate struct for per-CPU idle stats */
-	sched->max_cpu.cpu = env->nr_cpus_online;
+	/* pre-allocate struct for per-CPU idle stats; cap to array bounds */
+	sched->max_cpu.cpu = min(env->nr_cpus_online, MAX_CPUS);
 	if (sched->max_cpu.cpu == 0)
 		sched->max_cpu.cpu = 4;
 	if (init_idle_threads(sched->max_cpu.cpu))
-- 
2.54.0

