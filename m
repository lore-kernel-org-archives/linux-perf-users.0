Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBEE33AD8C;
	Thu, 21 May 2026 01:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325942; cv=none; b=YAgM5lsqc1LHLOIjnYJV9N4AbyNYs2zRGuajFUL77H/pj1I3snieSSAbPQYBRmiyiKRRT2GDTeSV5oftp+fg+/hNDQm0yNGXtHI/Ymrzref46k9yhPUaK6nrJAltUTC0WdiUH85Jzeb123DWY4RnacvNo6NqDPpmdTHircM64ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325942; c=relaxed/simple;
	bh=Q3v+AbeVq/fBP1sDqSyv9hFFDtXfsQhkpyhUlAA88HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4BO2LvZlOPTwtVtmf4s58b1b9IBEz6chJrQnNpIoFsgGjtBa4M0OA3e06eaHXnhyphKuEaAgYfVJAAmXwyXjbLFCL26A2qHWZfG35QUOmOJHCQeGNzCNmqTZaTAgHJgrusTZmJKZXUVmixFqOo1fYOeiBY6yW1LpUmM/cIcMnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lkr5a0HW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lkr5a0HW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00BE1F000E9;
	Thu, 21 May 2026 01:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779325941;
	bh=v4wXLn2GxE9k4/wrqT4DzbHNixMQqNiVQxJE9EHgn5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lkr5a0HWuvK/EIWodB2oskA8UA3pE0MtBQypmFZ+FOq9D8Wfi9U2zGx+NeFfSbbx3
	 /pu5b2EyKYY9cNzSvLuRpIaDKuv+yO47wjCbnkn0P/tyDvVag7CdxQC52u2M+cNRME
	 /q/rx0kqhbeb1sh9T6GNvw93/XveaQrBaijlvCcFYDp/axAJ39NGR9DxJBXs9xQE+Q
	 6PU9i48esUIYimawbbjSKL+mFXMwDH5gM0NqnBlGQzSkJCtWDXoSAqLuMeUbKXqr+6
	 jeOnkg98fSoUjza9qyngvCt0TqgrHHiME6bAhNNJ1xcl4vsMUtTtF8gb+6kB4kdmJC
	 e6fV1OXhV/TcQ==
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
Subject: [PATCH 26/27] perf kwork: Bounds check work->cpu before indexing cpus_runtime[]
Date: Wed, 20 May 2026 22:10:11 -0300
Message-ID: <20260521011027.622268-27-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521011027.622268-1-acme@kernel.org>
References: <20260521011027.622268-1-acme@kernel.org>
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
index 59a54d11f7fa63ad..f123230df283dacb 100644
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
@@ -1980,7 +1982,18 @@ static void top_calc_total_runtime(struct perf_kwork *kwork)
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
@@ -1992,7 +2005,8 @@ static void top_calc_idle_time(struct perf_kwork *kwork,
 {
 	struct kwork_top_stat *stat = &kwork->top_stat;
 
-	if (work->id == 0) {
+	/* See comment in top_calc_total_runtime() */
+	if (work->id == 0 && (unsigned int)work->cpu < MAX_NR_CPUS) {
 		stat->cpus_runtime[work->cpu].idle += work->total_runtime;
 		stat->cpus_runtime[MAX_NR_CPUS].idle += work->total_runtime;
 	}
@@ -2004,6 +2018,10 @@ static void top_calc_irq_runtime(struct perf_kwork *kwork,
 {
 	struct kwork_top_stat *stat = &kwork->top_stat;
 
+	/* See comment in top_calc_total_runtime() */
+	if ((unsigned int)work->cpu >= MAX_NR_CPUS)
+		return;
+
 	if (type == KWORK_CLASS_IRQ) {
 		stat->cpus_runtime[work->cpu].irq += work->total_runtime;
 		stat->cpus_runtime[MAX_NR_CPUS].irq += work->total_runtime;
@@ -2056,12 +2074,19 @@ static void top_calc_cpu_usage(struct perf_kwork *kwork)
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
@@ -2074,7 +2099,8 @@ static void top_calc_load_runtime(struct perf_kwork *kwork,
 {
 	struct kwork_top_stat *stat = &kwork->top_stat;
 
-	if (work->id != 0) {
+	/* See comment in top_calc_total_runtime() */
+	if (work->id != 0 && (unsigned int)work->cpu < MAX_NR_CPUS) {
 		stat->cpus_runtime[work->cpu].load += work->total_runtime;
 		stat->cpus_runtime[MAX_NR_CPUS].load += work->total_runtime;
 	}
@@ -2142,6 +2168,13 @@ static void perf_kwork__top_report(struct perf_kwork *kwork)
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
index abf637d447948f3a..65eb81acfbe38421 100644
--- a/tools/perf/util/kwork.h
+++ b/tools/perf/util/kwork.h
@@ -193,6 +193,7 @@ struct __top_cpus_runtime {
 struct kwork_top_stat {
 	DECLARE_BITMAP(all_cpus_bitmap, MAX_NR_CPUS);
 	struct __top_cpus_runtime *cpus_runtime;
+	unsigned int nr_skipped_cpu;
 };
 
 struct perf_kwork {
-- 
2.54.0

