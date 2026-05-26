Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F813C09E6;
	Tue, 26 May 2026 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830388; cv=none; b=CfNFYP3UdcKp9L+a2+hl3jP/q4p8j0n66wEImvIQMknxKcCnjppPu9vp2thBBMu+aB/kk6xtRQLA4qnTVAFzsH3Skx3TrYr/n1bgJiALyR9YATdRX3RI/gqv4Qj98uszgO7vC4rgbiIYME+wLnpUvnepSZgqjL3qEwQxuFqMg9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830388; c=relaxed/simple;
	bh=cFbcd6tg4S4vTQ4OH5ZDXc6IUgIdEztjTvppO5X9nXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPhY6w6bj9F2NoIrDvMfKke0jwruydcaY5sT2dHA94rTmCSu8fIw9ge0BbC0CZp2b6Jvkho+bzqCpdxe+74PbpI308JFVl5hg2Y6rdKJyCOKFy8I8fnncIfjlz2cSEanH/+Zl7EjixKqBQKriMV7osqKsDXBvZjinRW12ITRhxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4EC+gbG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4EC+gbG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B021F00A3C;
	Tue, 26 May 2026 21:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779830387;
	bh=Gu5rtWBHTYXbvUrpZQHMBKoyRKvBtzO1Zg4Rx3KVL50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S4EC+gbG5T+tNTUyoiC8OxuZyucuIKWtATGuAgSnEBP6r0Th/TRjzxfpwvO7GiZpS
	 Cfods/zxMvMwGQdCVN9KfuEOFNaTg/s4H9KSBxaLo6/VwboPjiMFtIPgWHOqTkhITS
	 rTrnHeWMPSse3WU5Cy2p0+I3GAkHWsTlo2wwFS9VCttKPu0389Iuk3hNQyFdR2zxoT
	 dUizXXfVt7Hxzw5M1CWRGLrEZACfWSBwWh5tXhJbyI/h9BdSt/97cwAm9yVPKRFWmv
	 5gM5gp+TneTU3THUU+SLCGnfRo73flRAMoAjA+vD0D3CxkEVwV/ScGBD9k8eUyUA/z
	 jwcgAI2JHlY2w==
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
	sashiko-bot@kernel.org,
	Yang Jihong <yangjihong@bytedance.com>,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 27/29] perf kwork: Bounds check work->cpu before indexing cpus_runtime[]
Date: Tue, 26 May 2026 18:18:03 -0300
Message-ID: <20260526211806.1193848-28-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526211806.1193848-1-acme@kernel.org>
References: <20260526211806.1193848-1-acme@kernel.org>
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

Replace the BUG_ON in top_calc_total_runtime() with an unsigned
bounds check that skips entries with invalid CPU values, counting
them for a summary warning.

Guard the same index in profile_event_match() (bitmap OOB),
top_calc_idle_time(), top_calc_irq_runtime(), top_calc_cpu_usage(),
and top_calc_load_runtime().  Also guard against division by zero
in top_calc_cpu_usage() when no runtime was accumulated.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Yang Jihong <yangjihong@bytedance.com>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kwork.c | 45 +++++++++++++++++++++++++++++++++-----
 tools/perf/util/kwork.h    |  1 +
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index f793ea578515d08c..99dc293a0744726e 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -467,7 +467,9 @@ static bool profile_event_match(struct perf_kwork *kwork,
 	u64 time = sample->time;
 	struct perf_time_interval *ptime = &kwork->ptime;
 
-	if ((kwork->cpu_list != NULL) && !test_bit(cpu, kwork->cpu_bitmap))
+	/* Guard test_bit: cpu == -1 (absent PERF_SAMPLE_CPU) would index past the bitmap */
+	if ((kwork->cpu_list != NULL) &&
+	    ((unsigned int)cpu >= MAX_NR_CPUS || !test_bit(cpu, kwork->cpu_bitmap)))
 		return false;
 
 	if (((ptime->start != 0) && (ptime->start > time)) ||
@@ -2041,7 +2043,18 @@ static void top_calc_total_runtime(struct perf_kwork *kwork)
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
@@ -2053,7 +2066,8 @@ static void top_calc_idle_time(struct perf_kwork *kwork,
 {
 	struct kwork_top_stat *stat = &kwork->top_stat;
 
-	if (work->id == 0) {
+	/* See comment in top_calc_total_runtime() */
+	if (work->id == 0 && (unsigned int)work->cpu < MAX_NR_CPUS) {
 		stat->cpus_runtime[work->cpu].idle += work->total_runtime;
 		stat->cpus_runtime[MAX_NR_CPUS].idle += work->total_runtime;
 	}
@@ -2065,6 +2079,10 @@ static void top_calc_irq_runtime(struct perf_kwork *kwork,
 {
 	struct kwork_top_stat *stat = &kwork->top_stat;
 
+	/* See comment in top_calc_total_runtime() */
+	if ((unsigned int)work->cpu >= MAX_NR_CPUS)
+		return;
+
 	if (type == KWORK_CLASS_IRQ) {
 		stat->cpus_runtime[work->cpu].irq += work->total_runtime;
 		stat->cpus_runtime[MAX_NR_CPUS].irq += work->total_runtime;
@@ -2117,12 +2135,19 @@ static void top_calc_cpu_usage(struct perf_kwork *kwork)
 		if (work->total_runtime == 0)
 			goto next;
 
+		/* See comment in top_calc_total_runtime() */
+		if ((unsigned int)work->cpu >= MAX_NR_CPUS)
+			goto next;
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
@@ -2135,7 +2160,8 @@ static void top_calc_load_runtime(struct perf_kwork *kwork,
 {
 	struct kwork_top_stat *stat = &kwork->top_stat;
 
-	if (work->id != 0) {
+	/* See comment in top_calc_total_runtime() */
+	if (work->id != 0 && (unsigned int)work->cpu < MAX_NR_CPUS) {
 		stat->cpus_runtime[work->cpu].load += work->total_runtime;
 		stat->cpus_runtime[MAX_NR_CPUS].load += work->total_runtime;
 	}
@@ -2211,6 +2237,13 @@ static void perf_kwork__top_report(struct perf_kwork *kwork)
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
index 81d39a7f78c8b811..6ec70dcc4157a1f2 100644
--- a/tools/perf/util/kwork.h
+++ b/tools/perf/util/kwork.h
@@ -202,6 +202,7 @@ struct __top_cpus_runtime {
 struct kwork_top_stat {
 	DECLARE_BITMAP(all_cpus_bitmap, MAX_NR_CPUS);
 	struct __top_cpus_runtime *cpus_runtime;
+	unsigned int nr_skipped_cpu;
 };
 
 struct perf_kwork {
-- 
2.54.0

