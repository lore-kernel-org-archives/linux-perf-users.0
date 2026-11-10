Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348523;
	b=vQo/ErrehWmKeM4ATgDPxEfj1NrLzXM76bltmO8AXL5N/wkPYQ6sqM3aMgsFzwkkXMpG
	 mzDSKPQiNi/m/bVDXuKLcPJTlvMhztZMxhuGxGm7fl+6szoS/LzB3p4igH4o3CGSeBLDU
	 zNpxoY4nh1l6x8tArST55831zSwirPbWQwaQ5U2a5VRxkZPIpus/3NeLIyBgiTytYCzSk
	 EDfg0jxQQ70tu1O0LVaHwOfGsnvHm7EnBUPunVnXXaj3Q4752Yq8mIxJX+YFqisq9lDgC
	 MSk8q5buhXbb5TzduIv3s8m8jdCzIXdHFzJxxq5cDsaDWwKjfUuqFTdc5coBrxYqCEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=an8m1XetOL3RVeRZhGNsr5tSmEtJ0j3tQX/ZpeqqAaA=;
	b=KSHOSeTbomu1TQ9cKbpVv/PeAGHss6ViOYbms63RF0vtlkWIoVY1xkg2g6XtGi/hrc7x
	 J+4HIpeG5AQsq/pp7TKoNueZxzP92anNirR8wEpFMU/TJXtAOxAHes8E0sZxyPJBvNxaR
	 cxcAFnNr0Cv7CffXTjf4oCT8hVBuP8jRwH4qjm4D6qZE1ElPX2b3Qnh+SbDpJJt/pnjyb
	 NY7EVH6nOWYfYMRU59JiXOFlRN3M2cjl6ubAD8podzuDVtjVwHalHUz3h55i+AKd5E+Nu
	 IoSAODVV5P4itMIkFNoN+mM2//RKtR9fjRlm+9SjXX5jKEdWwgbuzM5SZsCilatfBxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UpJrtx7n;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89359606D511
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89359606D511
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UpJrtx7n
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3425098ae4bso220495eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 14:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794348522; x=1794953322; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=an8m1XetOL3RVeRZhGNsr5tSmEtJ0j3tQX/ZpeqqAaA=;
        b=UpJrtx7nfV/5g+/ZQwxTuN93yvmRNmzo4CpuLTLwIBTnYCRJI+f/i4gUZzEp/xPouz
         sBAJb7/O0baN0XTi6e38D21HE7afAdsf9oWezqqoibl6HIyD0KEacdN7UrWpM7O+XqK5
         asv+LeC1FpAFRPGVBQTQMmRwZe+/6Xzl6a+DGDmVmLu91eZSNBHxRHOWdhXDwcNuR2Nd
         892w5ctbyOxz1TgWNhX0WpSYca4FqQiZ2X8Ndd95mkjTnTVC/0NlQBCM+eHitPhkaW5i
         wHiAOnaYwM/ls2/RwW6xvcV0Dio+xSe9LcNAZZOFfFdT92Ni1drGs0bzF412TR6G+bT9
         eC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794348522; x=1794953322;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=an8m1XetOL3RVeRZhGNsr5tSmEtJ0j3tQX/ZpeqqAaA=;
        b=Z6M5XKtw5Ey0fOQ82cZmi2/WiTSH2MgRCAjvKQIJMAZ1QH05rXFlVA1nf3H9vU4DsK
         w0Kd+lB10raKVBPMr8UlkX1bCUl7nKqh4FpGhuvh3gsKWohBQi6SANIyF/5eAIsdB6q8
         myHb5Np8QjQAL36sY0l4e9ZXpY0t7p3cj+d22sP1U7m1/fmyEtEyiTlErMygltpz+F9g
         uOB4+EoCLtJGcw27TECIt+ks1Yqpu5p6/Jb21GH/2V4ImT6ieRtsjqzVogkZg2f9iriB
         +anC/32osFtk5+jIG9+Bkvtl+bemJ+aaDsUQ3sUOGLK723oeXITFckdUWlxMOQtNQ8rr
         Ivxw==
X-Forwarded-Encrypted: i=1; AL+hErH+v/VsD1ykzs4mgSdhfUKaAEBpXnWGNhaiXdCa1kfShgadM7KV9NODCJ7Pcseb0pLnGAFv7C6p6gWelhV1Rg/6@vger.kernel.org
X-Gm-Message-State: APuU4Z/e6I+XYBY7jCg90FHY2VxyksMNfIXgvIe/XpfXeZz/Hu4edLuz
	piDN5u8qh/Ke658L+Gb+pxUBAQVMVPgq7z+TBymRSNEy588NFwi0at1vg5tbkBDzIUoqnga7Id3
	ywS+TajxBdw==
X-Received: from dldz8-n1.prod.google.com ([2002:a05:701b:4188:10b0:191:592e:bf3b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701a:8148:10b0:1b3:b322:a42c
 with SMTP id a92af1059eb24-1b3c0354ec9mr275842c88.13.1794348521326; Tue, 10
 Nov 2026 14:08:41 -0800 (PST)
Date: Tue, 10 Nov 2026 14:07:52 -0800
In-Reply-To: <20261110220803.2503416-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027231513.816148-1-irogers@google.com> <20261110220803.2503416-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261110220803.2503416-10-irogers@google.com>
Subject: [PATCH v3 09/20] perf bench internals: Add symbols benchmark
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, haghdoost@uber.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add a 'perf bench internals symbols' subcommand to measure symbol
loading, sorting, and lookup operations directly:

1. Loads symbols from an ELF binary (defaulting to the running perf
   executable, or specified via -b/--binary) without sorting by name,
   reporting average load runtime and maximum RSS via getrusage().
2. Sorts the loaded DSO symbols by name (dso__sort_by_name()),
   reporting average sort runtime and maximum RSS separately so
   address-only/lazy symbol loading can be evaluated independently of
   symbol name sorting.
3. Inserts synthetic symbols in two ascending runs (simulating .symtab
   and .dynsym), fixes up symbol ends and duplicates, and queries each
   symbol by address.
4. Incrementally appends symbols at interior addresses and immediately
   queries each appended symbol by address.

Example output:

  $ perf bench internals symbols
  # Running 'internals/symbols' benchmark:
    Average DSO load: 9.174 msec (+- 0.220 msec)
    Max RSS (DSO load): 75640 KB
    Average DSO sort by name: 2.787 msec (+- 0.019 msec)
    Max RSS (with sort by name): 75640 KB
    Average bulk insert + lookup: 2030.050 usec (+- 13.376 usec)
    Average append + lookup: 54.650 usec (+- 1.466 usec)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-bench.txt |   3 +
 tools/perf/bench/Build                  |   1 +
 tools/perf/bench/bench.h                |   1 +
 tools/perf/bench/symbols.c              | 273 ++++++++++++++++++++++++
 tools/perf/builtin-bench.c              |   1 +
 5 files changed, 279 insertions(+)
 create mode 100644 tools/perf/bench/symbols.c

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index 7f820f69740f..54eb809540c4 100644
--- a/tools/perf/Documentation/perf-bench.txt
+++ b/tools/perf/Documentation/perf-bench.txt
@@ -351,6 +351,9 @@ SUITES FOR 'internals'
 *synthesize*::
 Suite for evaluating perf's event synthesis performance.
 
+*symbols*::
+Suite for evaluating ELF symbol loading, sorting, and lookup performance.
+
 SEE ALSO
 --------
 linkperf:perf[1]
diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index c64c52468d3d..c3c0319696ae 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -20,6 +20,7 @@ perf-bench-y += evlist-open-close.o
 perf-bench-y += breakpoint.o
 perf-bench-y += pmu-scan.o
 perf-bench-y += uprobe.o
+perf-bench-y += symbols.o
 
 perf-bench-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
 perf-bench-$(CONFIG_X86_64) += mem-memset-x86-64-asm.o
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 85e3ac471875..e0b35d45559a 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -52,6 +52,7 @@ int bench_uprobe_trace_printk(int argc, const char **argv);
 int bench_uprobe_empty_ret(int argc, const char **argv);
 int bench_uprobe_trace_printk_ret(int argc, const char **argv);
 int bench_pmu_scan(int argc, const char **argv);
+int bench_symbols(int argc, const char **argv);
 
 #define BENCH_FORMAT_DEFAULT_STR	"default"
 #define BENCH_FORMAT_DEFAULT		0
diff --git a/tools/perf/bench/symbols.c b/tools/perf/bench/symbols.c
new file mode 100644
index 000000000000..c5043fc08198
--- /dev/null
+++ b/tools/perf/bench/symbols.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Benchmark symbol loading, sorting, and address/name lookup.
+ */
+#include <elf.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/resource.h>
+#include <sys/time.h>
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/time64.h>
+#include <subcmd/parse-options.h>
+#include "bench.h"
+#include "../util/debug.h"
+#include "../util/dso.h"
+#include "../util/map.h"
+#include "../util/stat.h"
+#include "../util/symbol.h"
+#include "../util/util.h"
+
+static unsigned int iterations = 20;
+static unsigned int nr_symbols = 10000;
+static unsigned int nr_appends = 200;
+static const char *binary_path;
+static bool no_demangle;
+
+static const struct option options[] = {
+	OPT_UINTEGER('i', "iterations", &iterations,
+		     "Number of iterations used to compute average (default: 20)"),
+	OPT_STRING('b', "binary", &binary_path, "path",
+		   "Binary path for ELF symbol load benchmark (default: perf binary)"),
+	OPT_UINTEGER('n', "nr-symbols", &nr_symbols,
+		     "Number of synthetic symbols for bulk benchmark (default: 10000)"),
+	OPT_UINTEGER('a', "nr-appends", &nr_appends,
+		     "Number of incremental symbol appends per iteration (default: 200)"),
+	OPT_BOOLEAN(0, "no-demangle", &no_demangle,
+		    "Disable symbol demangling during ELF load"),
+	OPT_END()
+};
+
+static const char *const bench_usage[] = {
+	"perf bench internals symbols <options>",
+	NULL
+};
+
+static int do_dso_load_bench(const char *path, bool *skipped)
+{
+	struct stats time_stats;
+	struct rusage rusage;
+	unsigned int i;
+
+	*skipped = false;
+	init_stats(&time_stats);
+
+	for (i = 0; i < iterations; i++) {
+		struct timeval start, end, diff;
+		struct map *map;
+		struct dso *dso;
+		u64 runtime_us;
+		int nr;
+
+		gettimeofday(&start, NULL);
+		map = dso__new_map(path);
+		if (!map) {
+			pr_err("Failed to create map for %s\n", path);
+			return -ENOMEM;
+		}
+		dso = map__dso(map);
+		nr = dso__load(dso, map);
+		if (nr < 0) {
+			pr_err("Failed to load symbols from %s\n", path);
+			map__put(map);
+			return -EINVAL;
+		}
+		if (nr == 0) {
+			printf("  Skipping DSO load benchmark (%s has no symbols)\n", path);
+			map__put(map);
+			*skipped = true;
+			return 0;
+		}
+		gettimeofday(&end, NULL);
+
+		map__put(map);
+
+		timersub(&end, &start, &diff);
+		runtime_us = (u64)diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
+		update_stats(&time_stats, runtime_us);
+	}
+
+	printf("  Average DSO load: %.3f msec (+- %.3f msec)\n",
+	       avg_stats(&time_stats) / USEC_PER_MSEC,
+	       stddev_stats(&time_stats) / USEC_PER_MSEC);
+	if (getrusage(RUSAGE_SELF, &rusage) == 0)
+		printf("  Max RSS (DSO load): %ld KB\n", rusage.ru_maxrss);
+	return 0;
+}
+
+static int do_dso_sort_by_name_bench(const char *path)
+{
+	struct stats time_stats;
+	struct rusage rusage;
+	unsigned int i;
+
+	init_stats(&time_stats);
+
+	for (i = 0; i < iterations; i++) {
+		struct timeval start, end, diff;
+		struct map *map;
+		struct dso *dso;
+		u64 runtime_us;
+
+		map = dso__new_map(path);
+		if (!map) {
+			pr_err("Failed to create map for %s\n", path);
+			return -ENOMEM;
+		}
+		dso = map__dso(map);
+		if (dso__load(dso, map) <= 0) {
+			map__put(map);
+			return -EINVAL;
+		}
+
+		gettimeofday(&start, NULL);
+		dso__sort_by_name(dso);
+		gettimeofday(&end, NULL);
+
+		map__put(map);
+
+		timersub(&end, &start, &diff);
+		runtime_us = (u64)diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
+		update_stats(&time_stats, runtime_us);
+	}
+
+	printf("  Average DSO sort by name: %.3f msec (+- %.3f msec)\n",
+	       avg_stats(&time_stats) / USEC_PER_MSEC,
+	       stddev_stats(&time_stats) / USEC_PER_MSEC);
+	if (getrusage(RUSAGE_SELF, &rusage) == 0)
+		printf("  Max RSS (with sort by name): %ld KB\n", rusage.ru_maxrss);
+	return 0;
+}
+
+static int do_synthetic_symbols_bench(void)
+{
+	struct stats bulk_stats, append_stats;
+	unsigned int i, j, half = nr_symbols / 2;
+
+	if (half == 0)
+		return 0;
+
+	init_stats(&bulk_stats);
+	init_stats(&append_stats);
+
+	for (i = 0; i < iterations; i++) {
+		struct timeval start, end, diff;
+		struct dso *dso = dso__new("[bench_symbols]");
+		u64 runtime_us;
+		char name[32];
+
+		if (!dso)
+			return -ENOMEM;
+
+		/*
+		 * Phase 1: Insert symbols in two ascending runs (simulating
+		 * .symtab + .dynsym), fixup ends and duplicates, and look up
+		 * all symbols by address.
+		 */
+		gettimeofday(&start, NULL);
+		for (j = 0; j < nr_symbols; j++) {
+			u64 addr = (j < half) ?
+				(0x100000ULL + (u64)j * 0x40ULL) :
+				(0x100020ULL + (u64)(j - half) * 0x40ULL);
+			struct symbol *sym;
+
+			scnprintf(name, sizeof(name), "bench_sym_%06u", j);
+			sym = symbol__new(addr, 0x18, STB_GLOBAL, STT_FUNC, name);
+			if (!sym) {
+				dso__put(dso);
+				return -ENOMEM;
+			}
+			symbols__insert(dso__symbols(dso), sym);
+		}
+		symbols__fixup_end(dso__symbols(dso), false);
+		symbols__fixup_duplicate(dso__symbols(dso));
+
+		for (j = 0; j < nr_symbols; j++) {
+			u64 addr = (j < half) ?
+				(0x100000ULL + (u64)j * 0x40ULL + 4) :
+				(0x100020ULL + (u64)(j - half) * 0x40ULL + 4);
+
+			(void)dso__find_symbol_nocache(dso, addr);
+		}
+		gettimeofday(&end, NULL);
+		timersub(&end, &start, &diff);
+		runtime_us = (u64)diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
+		update_stats(&bulk_stats, runtime_us);
+
+		/*
+		 * Phase 2: Incrementally append one symbol at a time at an
+		 * interior address and immediately query by address.
+		 */
+		gettimeofday(&start, NULL);
+		for (j = 0; j < nr_appends; j++) {
+			u64 addr = 0x100010ULL + ((u64)(j * 197 % half)) * 0x40ULL;
+			struct symbol *sym;
+
+			scnprintf(name, sizeof(name), "jit_sym_%06u", j);
+			sym = symbol__new(addr, 0x08, STB_GLOBAL, STT_FUNC, name);
+			if (!sym) {
+				dso__put(dso);
+				return -ENOMEM;
+			}
+			dso__insert_symbol(dso, sym);
+			(void)dso__find_symbol_nocache(dso, addr + 2);
+		}
+		gettimeofday(&end, NULL);
+		timersub(&end, &start, &diff);
+		runtime_us = (u64)diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
+		update_stats(&append_stats, runtime_us);
+
+		dso__put(dso);
+	}
+
+	printf("  Average bulk insert + lookup: %.3f usec (+- %.3f usec)\n",
+	       avg_stats(&bulk_stats), stddev_stats(&bulk_stats));
+	printf("  Average append + lookup: %.3f usec (+- %.3f usec)\n",
+	       avg_stats(&append_stats), stddev_stats(&append_stats));
+	return 0;
+}
+
+int bench_symbols(int argc, const char **argv)
+{
+	char exe_buf[PATH_MAX];
+	const char *path;
+	bool orig_demangle;
+	bool skipped = false;
+	int err;
+
+	argc = parse_options(argc, argv, options, bench_usage, 0);
+	if (argc) {
+		usage_with_options(bench_usage, options);
+		exit(EXIT_FAILURE);
+	}
+
+	if (symbol__init(NULL) < 0)
+		return -1;
+
+	orig_demangle = symbol_conf.demangle;
+	if (no_demangle)
+		symbol_conf.demangle = false;
+
+	if (binary_path) {
+		path = binary_path;
+	} else {
+		perf_exe(exe_buf, sizeof(exe_buf));
+		path = exe_buf;
+	}
+
+	err = do_dso_load_bench(path, &skipped);
+	if (!err && !skipped)
+		err = do_dso_sort_by_name_bench(path);
+	if (!err)
+		err = do_synthetic_symbols_bench();
+
+	symbol_conf.demangle = orig_demangle;
+	symbol__exit();
+	return err;
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 62bebdedd3b8..f937c08f3900 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -97,6 +97,7 @@ static const struct bench internals_benchmarks[] = {
 	{ "inject-build-id", "Benchmark build-id injection",	bench_inject_build_id	},
 	{ "evlist-open-close", "Benchmark evlist open and close",	bench_evlist_open_close	},
 	{ "pmu-scan", "Benchmark sysfs PMU info scanning",	bench_pmu_scan		},
+	{ "symbols", "Benchmark symbol loading, sorting and lookup",	bench_symbols	},
 	{ NULL,		NULL,					NULL			}
 };
 
-- 
2.56.0.542.g3ef89b7020-goog

