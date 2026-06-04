Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323673D9051;
	Thu,  4 Jun 2026 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780603897; cv=none; b=DPURR2At7+vC1TILR9xtiRKYXXGqzGC5NcVU8xj5beeHQFQC/PzftNv3gG3usSrSwzBB95UB18/uR2DcGs0qI4eSJNypG/bqZx8tutVw7GPiDD02veTjEGI/qywTLYJ6d7TQBKOyfHloLUYmCVd+2xzvZukfvR6bhD5Uo4z82Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780603897; c=relaxed/simple;
	bh=bF3F/8IC1UxGrGeYse+PT06B9e/07oxtF7xcjd6N3Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuOqvakjtlE7aXdOJf4xAhZTS3i7y3DerPxVudh3+wdr8m5pQGRD1HxCvQ8ofmzT3BZkURLL1RW+uiXlm9i2NMoiX5K4V3cE9UD77o3uP7uvLBRTvBq7nBtbDUdDKq/J5Tdlyeww+x0TcjIaA/1wQ16oOmAk17wGxg9Bs5U7x5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUUuKpCK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUUuKpCK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9B81F00898;
	Thu,  4 Jun 2026 20:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780603894;
	bh=hUnG8kXEc8BYSs8ofmQrVbf2/csNKG2fsdfuTn8+ex4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oUUuKpCKJCL78EyEnrcUGrpr1JPOfcdjOHinhmBjKAsfG7Pj6Si7f+WNbs5d+Cp/t
	 BJ9cgEqFHlFv8xCdp8HtI9rVV8LPG0J9c6g7eOkcgBpdkvKcDte5DJFzzGTL2UjBn/
	 5NlkUz3yPfWQgCDpXBr31K8r+6tJ00Rt2z9xy/PfypZXVzq09DVRzX0FE8K6ZiUFYJ
	 Zd4ULOezq2VZBSzlgoRZnsvpJiL8hbReWk7gBy/y3fmb1wIq58fhmvHeUaQNyiyAfk
	 hubnJL8BdttfEBEoiAU5KIqZ8cV2SQV8quuSbUiYABGIVmMQI8fdb8nknsiDZLZJdQ
	 FdrX8tX8VmD7Q==
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
	Anton Blanchard <anton@samba.org>,
	sashiko-bot <sashiko-bot@kernel.org>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 1/4] perf tools: Guard test_bit from out-of-bounds sample CPU
Date: Thu,  4 Jun 2026 17:11:13 -0300
Message-ID: <20260604201119.1702338-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604201119.1702338-1-acme@kernel.org>
References: <20260604201119.1702338-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When PERF_SAMPLE_CPU is absent from a perf.data file, sample->cpu is
initialized to (u32)-1 by evsel__parse_sample().  Five call sites pass
this value directly to test_bit(sample->cpu, cpu_bitmap), reading
massively out of bounds past the DECLARE_BITMAP(..., MAX_NR_CPUS)
allocation of 4096 bits.

Add a sample->cpu >= MAX_NR_CPUS guard before each test_bit() call,
matching the existing safe pattern in builtin-kwork.c.  This catches
both the (u32)-1 sentinel and any corrupted CPU value exceeding the
bitmap size.

Fixes: 5d67be97f890 ("perf report/annotate/script: Add option to specify a CPU range")
Cc: Anton Blanchard <anton@samba.org>
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c | 3 ++-
 tools/perf/builtin-diff.c     | 3 ++-
 tools/perf/builtin-report.c   | 3 ++-
 tools/perf/builtin-sched.c    | 6 ++++--
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index b918f9eed5fd2441..8a0eb30eac24fdbc 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -295,7 +295,8 @@ static int process_sample_event(const struct perf_tool *tool,
 		goto out_put;
 	}
 
-	if (ann->cpu_list && !test_bit(sample->cpu, ann->cpu_bitmap))
+	if (ann->cpu_list && (sample->cpu >= MAX_NR_CPUS ||
+			     !test_bit(sample->cpu, ann->cpu_bitmap)))
 		goto out_put;
 
 	if (!al.filtered &&
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 9592f44b6545bab6..9fa8e900637b0d71 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -416,7 +416,8 @@ static int diff__process_sample_event(const struct perf_tool *tool,
 		goto out;
 	}
 
-	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap)) {
+	if (cpu_list && (sample->cpu >= MAX_NR_CPUS ||
+			!test_bit(sample->cpu, cpu_bitmap))) {
 		ret = 0;
 		goto out;
 	}
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 6f044c3df8937dc5..dd1309c320943ea4 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -298,7 +298,8 @@ static int process_sample_event(const struct perf_tool *tool,
 	if (symbol_conf.hide_unresolved && al.sym == NULL)
 		goto out_put;
 
-	if (rep->cpu_list && !test_bit(sample->cpu, rep->cpu_bitmap))
+	if (rep->cpu_list && (sample->cpu >= MAX_NR_CPUS ||
+			     !test_bit(sample->cpu, rep->cpu_bitmap)))
 		goto out_put;
 
 	if (sort__mode == SORT_MODE__BRANCH) {
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 4de2baf03c5036dc..e7bd3f331cb8e889 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2192,7 +2192,8 @@ static void timehist_print_sample(struct perf_sched *sched,
 	char nstr[30];
 	u64 wait_time;
 
-	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
+	if (cpu_list && (sample->cpu >= MAX_NR_CPUS ||
+			!test_bit(sample->cpu, cpu_bitmap)))
 		return;
 
 	timestamp__scnprintf_usec(t, tstr, sizeof(tstr));
@@ -2871,7 +2872,8 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 	}
 
 	if (!sched->idle_hist || thread__tid(thread) == 0) {
-		if (!cpu_list || test_bit(sample->cpu, cpu_bitmap))
+		if (!cpu_list || (sample->cpu < MAX_NR_CPUS &&
+				 test_bit(sample->cpu, cpu_bitmap)))
 			timehist_update_runtime_stats(tr, t, tprev);
 
 		if (sched->idle_hist) {
-- 
2.54.0

