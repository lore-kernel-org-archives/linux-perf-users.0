Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33283B38BE;
	Tue,  2 Jun 2026 23:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444660; cv=none; b=Ih+k+hUCLPmGsiknFIVMazWtLdpSPZBqum4NKrehJBOXkSf69jfkkjTwrQSELDQqxXvXVJcqISFFw3AGvqOR0lLcexpvu6VaYIqnsYX/YcDvcC5dZ9JKAUmLuSlO9eK6XDoSEOY5eo8DFgYgmuhg8ASZreyROps9DqPEPYXEJzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444660; c=relaxed/simple;
	bh=7DHsLM7XidbkkjIOsgAiF7oDdpCGOyzhpG3B7CYMD4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F93NNnFGS2rsBakpucICiQ75cqZCqs5Xx/tzgn/U8qHtYbhXbzAXS/b7DXk8qL4jDoWtCMFFplrN0Y4DO5WuS+wp3T1ExGVf6CEv09aVNQqtxCLSuX0paUA4uHdV/Or6Tw6USg1LdDyPJ4gGLIy9UClyK3zwrKhbVcM/zf/TGJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b34wN5qb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b34wN5qb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF761F00893;
	Tue,  2 Jun 2026 23:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780444659;
	bh=GKDHO0PxxBqgohG98+Cq1neCIrILOrnO2K6UBft8lAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b34wN5qbzUyAk4EhABnL6BUY9ZI5LuMR0LtzdxiL+fgrlv2na847VbzIR58u6lj19
	 DYeVit7Ago1elHx7rRYQQ7myLva2Q3lXISX+vOaAI6TM2qQm0vJnGtJ8qQk6lTDHbH
	 mZHMn6Eavvr8FQM/TbQENOzA1tXLHZNMDDq81jf6rMHKJAr0WbDIw0zxI5yKMRVyIX
	 4EfOZdxj5A0mCEktYaYmyB8iptOP5UbTNjQXW4im4RQjEuBvukzUJJx2QcgDoVccpI
	 nwrVxvLq0anlFX63XZLCZguh3WOPipH5ZzZ/BX4heP4+qSrbjHWKhMSv+KUc78MZYg
	 qqQj1mWYLfFIg==
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
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 4/8] perf timechart: Include file offset in CPU bounds check messages
Date: Tue,  2 Jun 2026 20:57:03 -0300
Message-ID: <20260602235709.1541603-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602235709.1541603-1-acme@kernel.org>
References: <20260602235709.1541603-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add the perf.data file offset to the out-of-bounds CPU debug messages
in process_sample_cpu_idle(), process_sample_cpu_frequency(),
process_sample_sched_wakeup(), and process_sample_sched_switch().

Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-timechart.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 630756bebe3242dc..071987241a528ba4 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -605,8 +605,10 @@ process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
 	u32 state  = perf_sample__intval(sample, "state");
 	u32 cpu_id = perf_sample__intval(sample, "cpu_id");
 
+	/* perf.data is untrusted input — cpu_id may be corrupted */
 	if (cpu_id >= MAX_CPUS) {
-		pr_debug("Out-of-bounds cpu_id %u\n", cpu_id);
+		pr_debug("at offset %#" PRIx64 ": out-of-bounds cpu_id %u\n",
+			 sample->file_offset, cpu_id);
 		return -1;
 	}
 	if (state == (u32)PWR_EVENT_EXIT)
@@ -624,8 +626,10 @@ process_sample_cpu_frequency(struct timechart *tchart,
 	u32 state  = perf_sample__intval(sample, "state");
 	u32 cpu_id = perf_sample__intval(sample, "cpu_id");
 
+	/* perf.data is untrusted input — cpu_id may be corrupted */
 	if (cpu_id >= MAX_CPUS) {
-		pr_debug("Out-of-bounds cpu_id %u\n", cpu_id);
+		pr_debug("at offset %#" PRIx64 ": out-of-bounds cpu_id %u\n",
+			 sample->file_offset, cpu_id);
 		return -1;
 	}
 	p_state_change(tchart, cpu_id, sample->time, state);
@@ -641,8 +645,10 @@ process_sample_sched_wakeup(struct timechart *tchart,
 	int waker = perf_sample__intval(sample, "common_pid");
 	int wakee = perf_sample__intval(sample, "pid");
 
+	/* perf.data is untrusted input — CPU may be absent or corrupted */
 	if (sample->cpu >= MAX_CPUS) {
-		pr_debug("Out-of-bounds cpu %u\n", sample->cpu);
+		pr_debug("at offset %#" PRIx64 ": out-of-bounds cpu %u\n",
+			 sample->file_offset, sample->cpu);
 		return -1;
 	}
 	sched_wakeup(tchart, sample->cpu, sample->time, waker, wakee, flags, backtrace);
@@ -658,8 +664,10 @@ process_sample_sched_switch(struct timechart *tchart,
 	int next_pid   = perf_sample__intval(sample, "next_pid");
 	u64 prev_state = perf_sample__intval(sample, "prev_state");
 
+	/* perf.data is untrusted input — CPU may be absent or corrupted */
 	if (sample->cpu >= MAX_CPUS) {
-		pr_debug("Out-of-bounds cpu %u\n", sample->cpu);
+		pr_debug("at offset %#" PRIx64 ": out-of-bounds cpu %u\n",
+			 sample->file_offset, sample->cpu);
 		return -1;
 	}
 	sched_switch(tchart, sample->cpu, sample->time, prev_pid, next_pid,
@@ -676,6 +684,7 @@ process_sample_power_start(struct timechart *tchart __maybe_unused,
 	u64 cpu_id = perf_sample__intval(sample, "cpu_id");
 	u64 value  = perf_sample__intval(sample, "value");
 
+	/* perf.data is untrusted input — cpu_id may be corrupted */
 	if (cpu_id >= MAX_CPUS) {
 		pr_debug("Out-of-bounds cpu_id %llu\n", (unsigned long long)cpu_id);
 		return -1;
@@ -689,6 +698,7 @@ process_sample_power_end(struct timechart *tchart,
 			 struct perf_sample *sample,
 			 const char *backtrace __maybe_unused)
 {
+	/* perf.data is untrusted input — CPU may be absent or corrupted */
 	if (sample->cpu >= MAX_CPUS) {
 		pr_debug("Out-of-bounds cpu %u\n", sample->cpu);
 		return -1;
@@ -705,6 +715,7 @@ process_sample_power_frequency(struct timechart *tchart,
 	u64 cpu_id = perf_sample__intval(sample, "cpu_id");
 	u64 value  = perf_sample__intval(sample, "value");
 
+	/* perf.data is untrusted input — cpu_id may be corrupted */
 	if (cpu_id >= MAX_CPUS) {
 		pr_debug("Out-of-bounds cpu_id %llu\n", (unsigned long long)cpu_id);
 		return -1;
-- 
2.54.0

