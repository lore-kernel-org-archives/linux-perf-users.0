Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F18121502E;
	Tue, 12 Nov 2024 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435170; cv=none; b=icZAfrUhUIaD8WEfA+vNrP80ewKLp7duu6w5wqBZf0549TpYLhaLmXA26FJ4jkClPmMsi75/nFunL4tyl5Gqy8OyA8xWAGPOZeOhUBDTem09clM7bDvfq5WzZ7R+4UXBK+yivGuFabUv+yCizyzr/9PLFp5ymVYcJgWpV2DEGTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435170; c=relaxed/simple;
	bh=tOxPaO+RekpNDM4lI/J7zmLQsQQWqTc0faNKM820WJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXDTN89tHuttQdfpQWYvE131bxb7v8kSjZ+GztqVFc54jYt0UbuoX5byQGP4JgD9cSncQy7idZ5RVJgfowcTRoItnIieSvJCh76AIVBS+luYPTiNDVpEKRGThYUFRQWjDoUhwkEIOYmg/hIvyR37e6rUTIEKQaTLDWFwh4RusXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehbYvhxi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehbYvhxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3460C4CECD;
	Tue, 12 Nov 2024 18:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731435169;
	bh=tOxPaO+RekpNDM4lI/J7zmLQsQQWqTc0faNKM820WJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ehbYvhxid8Ram5+dnMF4aBJE2YmKogKy6Zj3gLZPfh9AJi45h8fX4k2/AEre2fXbO
	 lWANIe5v2G+TKAs+CXOwV3cIz7/LKnj3D+l/lSfJJ0w7a0N+e8ehXA2apvRbNNmyj5
	 XVO6n3MCCts2HXhvZOhZmIchDUboFGjSswWrG49wIcbbljdLQ0tNIWtZrc4/dXNoms
	 6g2SpCOzDVmZORv6N5M3M1mUCZoZ62pZ37jcIHF7QrfFi5smOEb8SavD67EIOpdn5F
	 y47CPtnfSOxdObeqFoAh5vME70g6q/Sz4EsWuzu3R2NcKkPJgvrE58+7/Zs4WuA40L
	 pb6UCvVd+uibA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/4] perf ftrace latency: Add --max-latency option
Date: Tue, 12 Nov 2024 15:12:14 -0300
Message-ID: <20241112181214.1171244-5-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112181214.1171244-1-acme@kernel.org>
References: <20241112181214.1171244-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriele Monaco <gmonaco@redhat.com>

This patch adds a max-latency option as discussed, in case the number of
buckets is more than 22, we don't observe the setting (for now, let's
say).

By default or if 0 is passed, the value is automatically determined
based on the number of buckets, range and minimum, so that we fill all
available buffers (equivalent to the behaviour before this patch).

We now get something like this:

  # perf ftrace latency --bucket-range=20 \
			--min-latency 10 \
			--max-latency=100 \
			-T switch_mm_irqs_off -a sleep 2
  #   DURATION     |      COUNT | GRAPH             |
       0 -   10 us |       1731 | ################  |
      10 -   30 us |          1 |                   |
      30 -   50 us |          0 |                   |
      50 -   70 us |          0 |                   |
      70 -   90 us |          0 |                   |
      90 -  100 us |          0 |                   |
     100 -  ... us |          0 |                   |

Note the maximum is observed also if it doesn't cover completely a full
range (the second to last range is 10us long to let the last start at
100 sharp), this looks to me more sensible and eases the computations,
since we don't need to account for the range while filling the buckets.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-ftrace.txt    |  4 +++
 tools/perf/builtin-ftrace.c                 | 28 ++++++++++++++++++---
 tools/perf/util/bpf_skel/func_latency.bpf.c |  4 ++-
 tools/perf/util/ftrace.h                    |  1 +
 4 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 82219e4262c73bc2..eccc0483f7faecad 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -155,6 +155,10 @@ OPTIONS for 'perf ftrace latency'
 	Minimum latency for the start of the first bucket, in ms or ns (according to
 	-n/--use-nsec).
 
+--max-latency=::
+	Maximum latency for the start of the last bucket, in ms or ns (according to
+	-n/--use-nsec). The setting is ignored if the value results in more than
+	22 buckets.
 
 OPTIONS for 'perf ftrace profile'
 ---------------------------------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index d9fbe7a329268572..cea7bc284f2f9077 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -730,6 +730,7 @@ static void make_histogram(struct perf_ftrace *ftrace, int buckets[],
 			   char *buf, size_t len, char *linebuf)
 {
 	int min_latency = ftrace->min_latency;
+	int max_latency = ftrace->max_latency;
 	char *p, *q;
 	char *unit;
 	double num;
@@ -794,7 +795,7 @@ static void make_histogram(struct perf_ftrace *ftrace, int buckets[],
 			if (num > 0) // 1st entry: [ 1 unit .. bucket_range units ]
 				i = num / ftrace->bucket_range + 1;
 		}
-		if (i >= NUM_BUCKET)
+		if (i >= NUM_BUCKET || num >= max_latency - min_latency)
 			i = NUM_BUCKET - 1;
 
 do_inc:
@@ -837,7 +838,7 @@ static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
 	       buckets[0], bar_len, bar, bar_total - bar_len, "");
 
 	for (i = 1; i < NUM_BUCKET - 1; i++) {
-		int start, stop;
+		unsigned int start, stop;
 		const char *unit = use_nsec ? "ns" : "us";
 
 		if (!ftrace->bucket_range) {
@@ -853,6 +854,11 @@ static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
 			start = (i - 1) * ftrace->bucket_range + min_latency;
 			stop  = i * ftrace->bucket_range + min_latency;
 
+			if (start >= ftrace->max_latency)
+				break;
+			if (stop > ftrace->max_latency)
+				stop = ftrace->max_latency;
+
 			if (start >= 1000) {
 				double dstart = start / 1000.0,
 				       dstop  = stop / 1000.0;
@@ -873,7 +879,9 @@ static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
 	if (!ftrace->bucket_range) {
 		printf("  %4d - %-4s %s", 1, "...", use_nsec ? "ms" : "s ");
 	} else {
-		int upper_outlier = (NUM_BUCKET - 2) * ftrace->bucket_range + min_latency;
+		unsigned int upper_outlier = (NUM_BUCKET - 2) * ftrace->bucket_range + min_latency;
+		if (upper_outlier > ftrace->max_latency)
+			upper_outlier = ftrace->max_latency;
 
 		if (upper_outlier >= 1000) {
 			double dstart = upper_outlier / 1000.0;
@@ -1609,6 +1617,8 @@ int cmd_ftrace(int argc, const char **argv)
 		    "Bucket range in ms or ns (-n/--use-nsec), default is log2() mode"),
 	OPT_UINTEGER(0, "min-latency", &ftrace.min_latency,
 		    "Minimum latency (1st bucket). Works only with --bucket-range."),
+	OPT_UINTEGER(0, "max-latency", &ftrace.max_latency,
+		    "Maximum latency (last bucket). Works only with --bucket-range and total buckets less than 22."),
 	OPT_PARENT(common_options),
 	};
 	const struct option profile_options[] = {
@@ -1715,6 +1725,18 @@ int cmd_ftrace(int argc, const char **argv)
 			/* default min latency should be the bucket range */
 			ftrace.min_latency = ftrace.bucket_range;
 		}
+		if (!ftrace.bucket_range && ftrace.max_latency) {
+			pr_err("--max-latency works only with --bucket-range\n");
+			parse_options_usage(ftrace_usage, options,
+					    "max-latency", /*short_opt=*/false);
+			ret = -EINVAL;
+			goto out_delete_filters;
+		}
+		if (!ftrace.max_latency) {
+			/* default max latency should depend on bucket range and num_buckets */
+			ftrace.max_latency = (NUM_BUCKET - 2) * ftrace.bucket_range +
+						ftrace.min_latency;
+		}
 		cmd_func = __cmd_latency;
 		break;
 	case PERF_FTRACE_PROFILE:
diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c b/tools/perf/util/bpf_skel/func_latency.bpf.c
index a89d2b4c38174c03..50ae153bf26e7a13 100644
--- a/tools/perf/util/bpf_skel/func_latency.bpf.c
+++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
@@ -43,6 +43,7 @@ const volatile int has_task = 0;
 const volatile int use_nsec = 0;
 const volatile unsigned int bucket_range;
 const volatile unsigned int min_latency;
+const volatile unsigned int max_latency;
 
 SEC("kprobe/func")
 int BPF_PROG(func_begin)
@@ -116,7 +117,8 @@ int BPF_PROG(func_end)
 			// than the min latency desired.
 			if (delta > 0) { // 1st entry: [ 1 unit .. bucket_range units )
 				key = delta / bucket_range + 1;
-				if (key >= NUM_BUCKET)
+				if (key >= NUM_BUCKET ||
+					delta >= max_latency - min_latency)
 					key = NUM_BUCKET - 1;
 			}
 			goto do_lookup;
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index 78d7745d497a8988..f218703063f74786 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -22,6 +22,7 @@ struct perf_ftrace {
 	bool			use_nsec;
 	unsigned int		bucket_range;
 	unsigned int		min_latency;
+	unsigned int		max_latency;
 	int			graph_depth;
 	int			func_stack_trace;
 	int			func_irq_info;
-- 
2.47.0

