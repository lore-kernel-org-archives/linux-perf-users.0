Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A9420721E;
	Tue, 12 Nov 2024 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435157; cv=none; b=XQhFYuGHud9eUQ70EmLIy2xaxVKaxHGitLspJg4M95eNhep7POskB0+C5//KYnFgEqCQHX8czAsUmBjedDPv/3Ut3ynRmzSPobEgTdb9W724M2vkLxbnDxjYgoETR9aVjdTrItjMSxZNgA/eC1dF1p06evvNkdh4qAhBT2qaN/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435157; c=relaxed/simple;
	bh=/KmrMm3dWkC1Bt/ZHxON491Bhxo4cGeRRS7wCJDfOC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+zUAWtXyEzIZE5gsCmmVRu87A5wgYih4uI4+8Z+rpRSIlt9v4e57M+Fv8n2NzDOhkD9PXyAetkCjLG3dg4nD0JoJdC3hUcY3LjyrRZ78Oh5uzo+wMK/A07c58gwY6sevDvFIjm+jajKdg1Z0tJngUG5S79bVPpnwcq9OAkIrDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xaf3PfNL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xaf3PfNL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516A8C4CECD;
	Tue, 12 Nov 2024 18:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731435156;
	bh=/KmrMm3dWkC1Bt/ZHxON491Bhxo4cGeRRS7wCJDfOC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xaf3PfNLgwoV2zsUsRY7GdnCgzII5a2bvpRcE5sfOSBtUh/U4Y/xyz5Ae1N/sXMQq
	 wm7kVEj0lmksX90uYRiBDWfg6kmDWO1Tu/A+KEBR6cP4ZUKLYYWjha4LrU/Hr+49BL
	 GChoUVNmQkcRgCHt6r6iA/wQUFZuSVaveXJU52zQg2S0H7NTOO0x2pEUaIm0nO4o+P
	 KP2Pll7eOGTnTCEm98+CkxgEDU+caGAVpOykNG3OGYZZ9x6RvS9uBPU0x3PeV9lSKU
	 FmRd7aA18Uu5WTwvBUoj0ybZTxxMzVFMU7DNgO9wNdogSGLnVOAF4wOKC4Es76bBcj
	 0V3sO8M6qw2RQ==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 2/4] perf ftrace latency: Introduce --bucket-range to ask for linear bucketing
Date: Tue, 12 Nov 2024 15:12:12 -0300
Message-ID: <20241112181214.1171244-3-acme@kernel.org>
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

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In addition to showing it exponentially, using log2() to figure out the
histogram index, allow for showing it linearly:

The preexisting more, the default:

  # perf ftrace latency --use-nsec --use-bpf \
  			-T switch_mm_irqs_off -a sleep 2
  #   DURATION     |      COUNT | GRAPH                                   |
       0 -    1 ns |          0 |                                         |
       1 -    2 ns |          0 |                                         |
       2 -    4 ns |          0 |                                         |
       4 -    8 ns |          0 |                                         |
       8 -   16 ns |          0 |                                         |
      16 -   32 ns |          0 |                                         |
      32 -   64 ns |          0 |                                         |
      64 -  128 ns |        238 | #                                       |
     128 -  256 ns |       1704 | ##########                              |
     256 -  512 ns |        672 | ###                                     |
     512 - 1024 ns |       4458 | ##########################              |
       1 -    2 us |        677 | ####                                    |
       2 -    4 us |          5 |                                         |
       4 -    8 us |          0 |                                         |
       8 -   16 us |          0 |                                         |
      16 -   32 us |          0 |                                         |
      32 -   64 us |          0 |                                         |
      64 -  128 us |          0 |                                         |
     128 -  256 us |          0 |                                         |
     256 -  512 us |          0 |                                         |
     512 - 1024 us |          0 |                                         |
       1 - ...  ms |          0 |                                         |
  #

The new histogram mode:

  # perf ftrace latency --bucket-range=150 --use-nsec --use-bpf \
  			-T switch_mm_irqs_off -a sleep 2
  #   DURATION     |      COUNT | GRAPH                                   |
       0 -    1 ns |          0 |                                         |
       1 -  151 ns |        265 | #                                       |
     151 -  301 ns |       1797 | ###########                             |
     301 -  451 ns |        258 | #                                       |
     451 -  601 ns |        289 | #                                       |
     601 -  751 ns |       2049 | #############                           |
     751 -  901 ns |        967 | ######                                  |
     901 - 1051 ns |        513 | ###                                     |
    1.05 - 1.20 us |        114 |                                         |
    1.20 - 1.35 us |        559 | ###                                     |
    1.35 - 1.50 us |        189 | #                                       |
    1.50 - 1.65 us |        137 |                                         |
    1.65 - 1.80 us |         32 |                                         |
    1.80 - 1.95 us |          2 |                                         |
    1.95 - 2.10 us |          0 |                                         |
    2.10 - 2.25 us |          1 |                                         |
    2.25 - 2.40 us |          1 |                                         |
    2.40 - 2.55 us |          0 |                                         |
    2.55 - 2.70 us |          0 |                                         |
    2.70 - 2.85 us |          0 |                                         |
    2.85 - 3.00 us |          1 |                                         |
    3.00 - ...  us |          4 |                                         |
  #

Co-developed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-ftrace.txt    |  3 +
 tools/perf/builtin-ftrace.c                 | 66 +++++++++++++++++----
 tools/perf/util/bpf_ftrace.c                |  2 +
 tools/perf/util/bpf_skel/func_latency.bpf.c | 14 +++++
 tools/perf/util/ftrace.h                    |  1 +
 5 files changed, 73 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index eaec8253be681a0e..e8cc8208e29fca7e 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -148,6 +148,9 @@ OPTIONS for 'perf ftrace latency'
 --use-nsec::
 	Use nano-second instead of micro-second as a base unit of the histogram.
 
+--bucket-range=::
+	Bucket range in ms or ns (according to -n/--use-nsec), default is log2() mode.
+
 
 OPTIONS for 'perf ftrace profile'
 ---------------------------------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 88b9f0597b925c69..e047e5dcda2656df 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -777,9 +777,17 @@ static void make_histogram(struct perf_ftrace *ftrace, int buckets[],
 		if (ftrace->use_nsec)
 			num *= 1000;
 
-		i = log2(num);
-		if (i < 0)
+		if (!ftrace->bucket_range) {
+			i = log2(num);
+			if (i < 0)
+				i = 0;
+		} else {
+			// Less than 1 unit (ms or ns), or, in the future,
+			// than the min latency desired.
 			i = 0;
+			if (num > 0) // 1st entry: [ 1 unit .. bucket_range units ]
+				i = num / ftrace->bucket_range + 1;
+		}
 		if (i >= NUM_BUCKET)
 			i = NUM_BUCKET - 1;
 
@@ -815,28 +823,58 @@ static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
 	       "  DURATION    ", "COUNT", bar_total, "GRAPH");
 
 	bar_len = buckets[0] * bar_total / total;
-	printf("  %4d - %-4d %s | %10d | %.*s%*s |\n",
+
+	printf("  %4d - %4d %s | %10d | %.*s%*s |\n",
 	       0, 1, use_nsec ? "ns" : "us", buckets[0], bar_len, bar, bar_total - bar_len, "");
 
 	for (i = 1; i < NUM_BUCKET - 1; i++) {
-		int start = (1 << (i - 1));
-		int stop = 1 << i;
+		int start, stop;
 		const char *unit = use_nsec ? "ns" : "us";
 
-		if (start >= 1024) {
-			start >>= 10;
-			stop >>= 10;
-			unit = use_nsec ? "us" : "ms";
+		if (!ftrace->bucket_range) {
+			start = (1 << (i - 1));
+			stop  = 1 << i;
+
+			if (start >= 1024) {
+				start >>= 10;
+				stop >>= 10;
+				unit = use_nsec ? "us" : "ms";
+			}
+		} else {
+			start = (i - 1) * ftrace->bucket_range + 1;
+			stop  = i * ftrace->bucket_range + 1;
+
+			if (start >= 1000) {
+				double dstart = start / 1000.0,
+				       dstop  = stop / 1000.0;
+				printf("  %4.2f - %-4.2f", dstart, dstop);
+				unit = use_nsec ? "us" : "ms";
+				goto print_bucket_info;
+			}
 		}
+
+		printf("  %4d - %4d", start, stop);
+print_bucket_info:
 		bar_len = buckets[i] * bar_total / total;
-		printf("  %4d - %-4d %s | %10d | %.*s%*s |\n",
-		       start, stop, unit, buckets[i], bar_len, bar,
+		printf(" %s | %10d | %.*s%*s |\n", unit, buckets[i], bar_len, bar,
 		       bar_total - bar_len, "");
 	}
 
 	bar_len = buckets[NUM_BUCKET - 1] * bar_total / total;
-	printf("  %4d - %-4s %s | %10d | %.*s%*s |\n",
-	       1, "...", use_nsec ? "ms" : " s", buckets[NUM_BUCKET - 1],
+	if (!ftrace->bucket_range) {
+		printf("  %4d - %-4s %s", 1, "...", use_nsec ? "ms" : "s ");
+	} else {
+		int upper_outlier = (NUM_BUCKET - 2) * ftrace->bucket_range;
+
+		if (upper_outlier >= 1000) {
+			double dstart = upper_outlier / 1000.0;
+
+			printf("  %4.2f - %-4s %s", dstart, "...", use_nsec ? "us" : "ms");
+		} else {
+			printf("  %4d - %4s %s", upper_outlier, "...", use_nsec ? "ns" : "us");
+		}
+	}
+	printf(" | %10d | %.*s%*s |\n", buckets[NUM_BUCKET - 1],
 	       bar_len, bar, bar_total - bar_len, "");
 
 }
@@ -1558,6 +1596,8 @@ int cmd_ftrace(int argc, const char **argv)
 #endif
 	OPT_BOOLEAN('n', "use-nsec", &ftrace.use_nsec,
 		    "Use nano-second histogram"),
+	OPT_UINTEGER(0, "bucket-range", &ftrace.bucket_range,
+		    "Bucket range in ms or ns (-n/--use-nsec), default is log2() mode"),
 	OPT_PARENT(common_options),
 	};
 	const struct option profile_options[] = {
diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
index 06d1c4018407a265..b3cb68295e56631c 100644
--- a/tools/perf/util/bpf_ftrace.c
+++ b/tools/perf/util/bpf_ftrace.c
@@ -36,6 +36,8 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
 		return -1;
 	}
 
+	skel->rodata->bucket_range = ftrace->bucket_range;
+
 	/* don't need to set cpu filter for system-wide mode */
 	if (ftrace->target.cpu_list) {
 		ncpus = perf_cpu_map__nr(ftrace->evlist->core.user_requested_cpus);
diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c b/tools/perf/util/bpf_skel/func_latency.bpf.c
index f613dc9cb123480c..00a340ca1543dff0 100644
--- a/tools/perf/util/bpf_skel/func_latency.bpf.c
+++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
@@ -41,6 +41,7 @@ int enabled = 0;
 const volatile int has_cpu = 0;
 const volatile int has_task = 0;
 const volatile int use_nsec = 0;
+const volatile unsigned int bucket_range;
 
 SEC("kprobe/func")
 int BPF_PROG(func_begin)
@@ -100,12 +101,25 @@ int BPF_PROG(func_end)
 		if (delta < 0)
 			return 0;
 
+		if (bucket_range != 0) {
+			delta /= cmp_base;
+			// Less than 1 unit (ms or ns), or, in the future,
+			// than the min latency desired.
+			key = 0;
+			if (delta > 0) { // 1st entry: [ 1 unit .. bucket_range units )
+				key = delta / bucket_range + 1;
+				if (key >= NUM_BUCKET)
+					key = NUM_BUCKET - 1;
+			}
+			goto do_lookup;
+		}
 		// calculate index using delta
 		for (key = 0; key < (NUM_BUCKET - 1); key++) {
 			if (delta < (cmp_base << key))
 				break;
 		}
 
+do_lookup:
 		hist = bpf_map_lookup_elem(&latency, &key);
 		if (!hist)
 			return 0;
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index bae649ef50e8447a..6ac136484349a9a5 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -20,6 +20,7 @@ struct perf_ftrace {
 	unsigned long		percpu_buffer_size;
 	bool			inherit;
 	bool			use_nsec;
+	unsigned int		bucket_range;
 	int			graph_depth;
 	int			func_stack_trace;
 	int			func_irq_info;
-- 
2.47.0

