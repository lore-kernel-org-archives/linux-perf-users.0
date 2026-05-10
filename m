Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D10A282F29;
	Sun, 10 May 2026 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384227; cv=none; b=WXEHoJabzKeJdkVfqsUFUeHzkuXzGAZnG1CV3aOrStFHAjzbCwZG+6iM317DL3cDadoHhrlAPaKLJ+TvjxLXbXFwlKhh8a7By81S98FmjBSKAtOVAVPEdmtWKmYj59IdRfVD94rA7NgUCkQ7FEO4/SqKqZNQuu4RVYOseykCG9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384227; c=relaxed/simple;
	bh=fGAeaWAb2ooLx8uf/+yJehDkdNBeLyPVlm6gPOuh/2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1o52BfTZGtrzTXPbe8gb+sUag/dngrkrDX04hhMOu/eL0TezHBG0T8Y3tXUIJn69ztFR2b1bYWqzRaQBbYljE/jWgkZCAfiUxG6SNhI2BFJCG0oQORXcvczTg05UtSxQ5LmOinRuUvHXDwYy0ji+aUissOnSwCCqnvJfL+GNys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSQKLWy1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSQKLWy1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920F0C2BCF6;
	Sun, 10 May 2026 03:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384227;
	bh=fGAeaWAb2ooLx8uf/+yJehDkdNBeLyPVlm6gPOuh/2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kSQKLWy1uiz1JT766aIn+zklWejhUUCWEIDQnb8SuCjQbt3fns16KTbeJ3E9CWM0W
	 rjNrgUL8JbiFONmMgJH7nULNQqd7AwCmi4BPxLRhwvnSFKmEoPsM5BxOLY7T8wHw00
	 7seuJ8ZlN1o1xhbLuEboASpFqXHKTypEE7Z9n0oGS0twTMAr9Ghl3HbqJ1mC9FoeCU
	 UioNMBQGu6tcjyVi+If7pgQM+5arsrVvOSzCtVfwm70A4m60F87UrK4on8Ng7GDFRP
	 qn2GYly6q+K+mAbv62ybasdAPl32jpfIKWLdXjj5Q1fX0UeStgO4UDJEvyDuLpn3Bd
	 0vWC2TdOC2TrA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot@kernel.org,
	Yang Jihong <yangjihong@bytedance.com>,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 27/28] perf kwork: Bounds check work->cpu before indexing cpus_runtime[]
Date: Sun, 10 May 2026 00:34:18 -0300
Message-ID: <20260510033424.255812-28-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510033424.255812-1-acme@kernel.org>
References: <20260510033424.255812-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

work->cpu comes from sample->cpu which is (u32)-1 when
PERF_SAMPLE_CPU is absent.  Stored as int, this becomes -1
which passes the signed BUG_ON(work->cpu >= MAX_NR_CPUS) but
causes an out-of-bounds access on cpus_runtime[-1].

Replace the BUG_ON with an unsigned bounds check that skips
entries with invalid CPU values, and guard the idle and irq
runtime accumulators the same way.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Yang Jihong <yangjihong@bytedance.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kwork.c | 49 +++++++++++++++++++++++++++++++++-----
 tools/perf/util/kwork.h    |  1 +
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 9d3a4c779a41e383..6e124a0f277c8294 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -424,7 +424,9 @@ static bool profile_event_match(struct perf_kwork *kwork,
 	u64 time = sample->time;
 	struct perf_time_interval *ptime = &kwork->ptime;
 
-	if ((kwork->cpu_list != NULL) && !test_bit(cpu, kwork->cpu_bitmap))
+	/* Guard test_bit: cpu == -1 (absent PERF_SAMPLE_CPU) would index past the bitmap */
+	if ((kwork->cpu_list != NULL) &&
+	    ((unsigned int)cpu >= MAX_NR_CPUS || !test_bit(cpu, kwork->cpu_bitmap)))
 		return false;
 
 	if (((ptime->start != 0) && (ptime->start > time)) ||
@@ -2008,7 +2010,18 @@ static void top_calc_total_runtime(struct perf_kwork *kwork)
 	next = rb_first_cached(&class->work_root);
 	while (next) {
 		work = rb_entry(next, struct kwork_work, node);
-		BUG_ON(work->cpu >= MAX_NR_CPUS);
+		/*
+		 * work->cpu comes from sample->cpu which is -1 when
+		 * PERF_SAMPLE_CPU is absent.  As int that's -1, but as
+		 * unsigned it exceeds MAX_NR_CPUS — skip to avoid OOB
+		 * on cpus_runtime[].
+		 */
+		/* Counted and reported in perf_kwork__top_report() */
+		if ((unsigned int)work->cpu >= MAX_NR_CPUS) {
+			stat->nr_skipped_cpu++;
+			next = rb_next(next);
+			continue;
+		}
 		stat->cpus_runtime[work->cpu].total += work->total_runtime;
 		stat->cpus_runtime[MAX_NR_CPUS].total += work->total_runtime;
 		next = rb_next(next);
@@ -2020,7 +2033,8 @@ static void top_calc_idle_time(struct perf_kwork *kwork,
 {
 	struct kwork_top_stat *stat = &kwork->top_stat;
 
-	if (work->id == 0) {
+	/* See comment in top_calc_total_runtime() */
+	if (work->id == 0 && (unsigned int)work->cpu < MAX_NR_CPUS) {
 		stat->cpus_runtime[work->cpu].idle += work->total_runtime;
 		stat->cpus_runtime[MAX_NR_CPUS].idle += work->total_runtime;
 	}
@@ -2032,6 +2046,12 @@ static void top_calc_irq_runtime(struct perf_kwork *kwork,
 {
 	struct kwork_top_stat *stat = &kwork->top_stat;
 
+	/* See comment in top_calc_total_runtime() */
+	if ((unsigned int)work->cpu >= MAX_NR_CPUS) {
+		stat->nr_skipped_cpu++;
+		return;
+	}
+
 	if (type == KWORK_CLASS_IRQ) {
 		stat->cpus_runtime[work->cpu].irq += work->total_runtime;
 		stat->cpus_runtime[MAX_NR_CPUS].irq += work->total_runtime;
@@ -2084,12 +2104,21 @@ static void top_calc_cpu_usage(struct perf_kwork *kwork)
 		if (work->total_runtime == 0)
 			goto next;
 
+		/* See comment in top_calc_total_runtime() */
+		if ((unsigned int)work->cpu >= MAX_NR_CPUS) {
+			stat->nr_skipped_cpu++;
+			goto next;
+		}
+
 		__set_bit(work->cpu, stat->all_cpus_bitmap);
 
 		top_subtract_irq_runtime(kwork, work);
 
-		work->cpu_usage = work->total_runtime * 10000 /
-			stat->cpus_runtime[work->cpu].total;
+		/* Guard against division by zero if no runtime was accumulated */
+		if (stat->cpus_runtime[work->cpu].total) {
+			work->cpu_usage = work->total_runtime * 10000 /
+				stat->cpus_runtime[work->cpu].total;
+		}
 
 		top_calc_idle_time(kwork, work);
 next:
@@ -2102,7 +2131,8 @@ static void top_calc_load_runtime(struct perf_kwork *kwork,
 {
 	struct kwork_top_stat *stat = &kwork->top_stat;
 
-	if (work->id != 0) {
+	/* See comment in top_calc_total_runtime() */
+	if (work->id != 0 && (unsigned int)work->cpu < MAX_NR_CPUS) {
 		stat->cpus_runtime[work->cpu].load += work->total_runtime;
 		stat->cpus_runtime[MAX_NR_CPUS].load += work->total_runtime;
 	}
@@ -2170,6 +2200,13 @@ static void perf_kwork__top_report(struct perf_kwork *kwork)
 		next = rb_next(next);
 	}
 
+	if (kwork->top_stat.nr_skipped_cpu) {
+		printf("  Warning: %u work entries with invalid CPU were excluded from totals.\n"
+		       "  Task runtimes may appear inflated (IRQ time not subtracted).\n"
+		       "  Consider re-recording with PERF_SAMPLE_CPU enabled.\n",
+		       kwork->top_stat.nr_skipped_cpu);
+	}
+
 	printf("\n");
 }
 
diff --git a/tools/perf/util/kwork.h b/tools/perf/util/kwork.h
index db00269b73f24c66..10290cd779402f9d 100644
--- a/tools/perf/util/kwork.h
+++ b/tools/perf/util/kwork.h
@@ -194,6 +194,7 @@ struct __top_cpus_runtime {
 struct kwork_top_stat {
 	DECLARE_BITMAP(all_cpus_bitmap, MAX_NR_CPUS);
 	struct __top_cpus_runtime *cpus_runtime;
+	unsigned int nr_skipped_cpu;
 };
 
 struct perf_kwork {
-- 
2.54.0

