Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142922;
	b=bHgy9GclH/+KPVBiaYciu9PBR2+vbpKG698BXoDEhIIekz0v/el0jv0O2seA30HKIT7T
	 0HpgIO1jdZY/REhjVddPb4v+ZC3oBIKmstxmx+uvSk3+iieO5pwl8CZD7A527j7noqSsk
	 KMK9OYr6JsgTxWnmmgXXoTyawBevU2MuR50f8fmi2RPjgMcyEteRbthjUH5hvEjAM13Mw
	 BhDPbhi/1WeHe/B5aBB/GAvyoO9BUuaAA41hqld219zSms5hhFEH3n6fhymor0f+U1sTv
	 1DgnVuqUMm76LBjUrYm4GhtnDfBz3kY5cER2mFtRjv78xBhB4w6qDJys7q+Epc4xf2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=z2jE4gTmuf/r38PjaXid8z7o0E5PHGG0DTEOyceOV1A=;
	b=Dvwk0f4/QCQNk9PgDFXHcjFCDlVxLBxkhMey9WW//JORyfG9D2hv99u9/BScGl7wYvns
	 XUcVrw28xhgQqT8+i9JIVloI3TDzp9rvnf9GxY2/w0f01FnMS2GavS6KTynOAhshrvTrU
	 t1TYR8GcxBDJxpV6H9gIwKzb3n3b4Sdb3IFe+sMDyAq2hfgqv7V35lQSxgGpKRxyeF5D+
	 NuDQQaa3gXeehldBNDR6ddRd6CiUxcZx0gXXl6CpZHTZWAqEqR28IPc6aHGh48uXOV5zO
	 gTK/BIWkJn4iyymmuDVNTlyEhG2zI2GHGoIfa9no1ZK/Ae8aYhgeRL1KY8c/LISDe/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j252JKDp;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EABE606A32D
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 23:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EABE606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j252JKDp
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-89fb6a45c48so487548b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 16:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793142921; x=1793747721; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z2jE4gTmuf/r38PjaXid8z7o0E5PHGG0DTEOyceOV1A=;
        b=j252JKDpkMZxeddUumxvZlojV0Q+zsd9SQeIEyIYb2Zxhz1mF3SA69DloDjHPTiK04
         6FWJhhVvK+Ll139DcaMF+pMMN5xOLfZ0SvLDL8paFAMAXz/1ES+s6oXde9o7irHZnFuU
         JvlgxUEhL/Bb0DNLMIQXndllDuOrZFUaEKiMBLGKU9jXcXRkcPm8NOfJZvjLwLQw6GpU
         jF9wXM7Krfm1Ym4q/KY1SFeu0nMY10FLKuidaw77ZS2MwxlZBJBU0t1XptvVA30Cri4u
         pbvMewtxPyLUgIRjbcw0mwsKE9LLZOLZhxFDAd5RCrAGfkK224UKOsF/eLIDQC8DK38e
         mhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793142921; x=1793747721;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z2jE4gTmuf/r38PjaXid8z7o0E5PHGG0DTEOyceOV1A=;
        b=RTdhPWmxKRhV63zAndDX6gCc84GrzPUKE5DpZE9fNDbiu4YwsInu6rYbasZME2BX/a
         6Dgq2+yxYhrArJVsa70vq247yJjjFbLaehAb0ZTKTdje4mWW7vUKX9U6eSTEDdV2o8Wm
         JeygM1vzahQ9MgOSmn7T90f0sboi+t7de2358My9n0j7/Ycqnq1j5fmmFVid1kGsaLiT
         4VsN+oZLKjqu3k8XSHXCTqVDnrEW6gjsXkoNghZTaXPaaCqoTBs96iMdvQ+N0P46D0Q+
         0fyc2N2rfCtSK1jRH+Pfv0CR7JxOxeXe4Qd1FrRWbpQEk3L9g/FlAf+yhcVUMmteWLwh
         CKRg==
X-Forwarded-Encrypted: i=1; AKwUvByCMJoSvix140daYxRiCeLMZHPsc3ecUbXEgHU2guNjrRqlcJRlAkMcKp53jaMyHhfMY0zaDSe1a/jCHKouN7zD@vger.kernel.org
X-Gm-Message-State: AFq9FYK3iDa6dKjaz1TDJCGSAeiphDVkvXwPIQPR7Gov1tThO+MmgNTk
	LEQHg0sxy+BfZWelSENYBSaI85upxWy0aLD/SK3IczAMbUo0oRiVBpJZjjzDFlNaaj2Rua2Q10N
	9URyr/KnueQ==
X-Received: from pfwp40.prod.google.com ([2002:a05:6a00:26e8:b0:8a0:70d8:a2ef])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ab05:b0:88e:a50a:b260
 with SMTP id d2e1a72fcca58-8a6e898e9f0mr554486b3a.54.1793142920177; Tue, 27
 Oct 2026 16:15:20 -0700 (PDT)
Date: Tue, 27 Oct 2026 16:14:55 -0700
In-Reply-To: <20261027231513.816148-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <20261027231513.816148-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027231513.816148-2-irogers@google.com>
Subject: [PATCH v2 01/18] perf bench internals: Add symbols and maps benchmarks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, haghdoost@uber.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add two new 'perf bench internals' subcommands to measure symbol and map
operations directly:

- 'perf bench internals symbols':
  1. Loads symbols from an ELF binary (defaulting to the running perf
     executable, or specified via -b/--binary) and sorts them by name,
     reporting both average runtime and heap memory consumption.
  2. Inserts synthetic symbols in two ascending runs (simulating .symtab
     and .dynsym), fixes up symbol ends and duplicates, and queries each
     symbol by address.
  3. Incrementally appends symbols at interior addresses and immediately
     queries each appended symbol by address.

- 'perf bench internals maps':
  1. Inserts non-overlapping maps in ascending address order (simulating
     /proc/<pid>/maps synthesis) and queries each map by address.
  2. Incrementally appends maps at interior addresses (simulating runtime
     PERF_RECORD_MMAP2 / JIT events) and immediately queries each map by
     address and by name.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-bench.txt |   6 +
 tools/perf/bench/Build                  |   2 +
 tools/perf/bench/bench.h                |   2 +
 tools/perf/bench/maps.c                 | 186 +++++++++++++++++++
 tools/perf/bench/symbols.c              | 236 ++++++++++++++++++++++++
 tools/perf/builtin-bench.c              |   2 +
 6 files changed, 434 insertions(+)
 create mode 100644 tools/perf/bench/maps.c
 create mode 100644 tools/perf/bench/symbols.c

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index 7f820f69740f..c65dd8f4131f 100644
--- a/tools/perf/Documentation/perf-bench.txt
+++ b/tools/perf/Documentation/perf-bench.txt
@@ -351,6 +351,12 @@ SUITES FOR 'internals'
 *synthesize*::
 Suite for evaluating perf's event synthesis performance.
 
+*symbols*::
+Suite for evaluating ELF symbol loading, sorting, and lookup performance.
+
+*maps*::
+Suite for evaluating maps insertion, sorting, and lookup performance.
+
 SEE ALSO
 --------
 linkperf:perf[1]
diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index c64c52468d3d..d51e52d3742a 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -20,6 +20,8 @@ perf-bench-y += evlist-open-close.o
 perf-bench-y += breakpoint.o
 perf-bench-y += pmu-scan.o
 perf-bench-y += uprobe.o
+perf-bench-y += symbols.o
+perf-bench-y += maps.o
 
 perf-bench-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
 perf-bench-$(CONFIG_X86_64) += mem-memset-x86-64-asm.o
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 85e3ac471875..c988d236e0f0 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -52,6 +52,8 @@ int bench_uprobe_trace_printk(int argc, const char **argv);
 int bench_uprobe_empty_ret(int argc, const char **argv);
 int bench_uprobe_trace_printk_ret(int argc, const char **argv);
 int bench_pmu_scan(int argc, const char **argv);
+int bench_symbols(int argc, const char **argv);
+int bench_maps(int argc, const char **argv);
 
 #define BENCH_FORMAT_DEFAULT_STR	"default"
 #define BENCH_FORMAT_DEFAULT		0
diff --git a/tools/perf/bench/maps.c b/tools/perf/bench/maps.c
new file mode 100644
index 000000000000..ed5a5be3cbf0
--- /dev/null
+++ b/tools/perf/bench/maps.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Benchmark maps insertion, sorting, and address/name lookup.
+ */
+#include <errno.h>
+#include <inttypes.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/time.h>
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/time64.h>
+#include <subcmd/parse-options.h>
+#include "bench.h"
+#include "../util/debug.h"
+#include "../util/dso.h"
+#include "../util/map.h"
+#include "../util/maps.h"
+#include "../util/stat.h"
+
+static unsigned int iterations = 100;
+static unsigned int nr_maps = 1000;
+static unsigned int nr_appends = 200;
+
+static const struct option options[] = {
+	OPT_UINTEGER('i', "iterations", &iterations,
+		     "Number of iterations used to compute average (default: 100)"),
+	OPT_UINTEGER('m', "nr-maps", &nr_maps,
+		     "Number of ascending maps per iteration (default: 1000)"),
+	OPT_UINTEGER('a', "nr-appends", &nr_appends,
+		     "Number of incremental map appends per iteration (default: 200)"),
+	OPT_END()
+};
+
+static const char *const bench_usage[] = {
+	"perf bench internals maps <options>",
+	NULL
+};
+
+static int do_maps_bench(void)
+{
+	struct stats asc_stats, append_stats;
+	unsigned int total_dsos = nr_maps + nr_appends;
+	struct dso **dsos;
+	struct map **all_maps;
+	unsigned int i, j;
+	int err = 0;
+
+	if (total_dsos == 0)
+		return 0;
+
+	dsos = calloc(total_dsos, sizeof(*dsos));
+	all_maps = calloc(total_dsos, sizeof(*all_maps));
+	if (!dsos || !all_maps) {
+		free(dsos);
+		free(all_maps);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < total_dsos; i++) {
+		char name[32];
+		u64 addr;
+
+		scnprintf(name, sizeof(name), "/tmp/bench_dso_%06u.so", i);
+		dsos[i] = dso__new(name);
+		if (!dsos[i]) {
+			err = -ENOMEM;
+			goto out_free;
+		}
+		if (i < nr_maps) {
+			addr = 0x100000ULL + (u64)i * 0x2000ULL;
+			all_maps[i] = map__new2(addr, dsos[i]);
+			if (!all_maps[i]) {
+				err = -ENOMEM;
+				goto out_free;
+			}
+			map__set_end(all_maps[i], addr + 0x1000ULL);
+		} else {
+			u64 k = i - nr_maps;
+			u64 slot = nr_maps ? (k * 197ULL) % nr_maps : k;
+
+			addr = 0x101000ULL + slot * 0x2000ULL +
+			       (nr_maps ? (k / nr_maps) * 0x100ULL : 0);
+			all_maps[i] = map__new2(addr, dsos[i]);
+			if (!all_maps[i]) {
+				err = -ENOMEM;
+				goto out_free;
+			}
+			map__set_end(all_maps[i], addr + 0x80ULL);
+		}
+	}
+
+	init_stats(&asc_stats);
+	init_stats(&append_stats);
+
+	for (i = 0; i < iterations; i++) {
+		struct timeval start, end, diff;
+		struct maps *maps = maps__new(NULL);
+		u64 runtime_us;
+
+		if (!maps) {
+			err = -ENOMEM;
+			goto out_free;
+		}
+
+		/*
+		 * Phase 1: Insert maps in ascending address order (simulating
+		 * /proc/<pid>/maps synthesis) and look up each map by address.
+		 */
+		gettimeofday(&start, NULL);
+		for (j = 0; j < nr_maps; j++) {
+			err = maps__fixup_overlap_and_insert(maps, all_maps[j]);
+			if (err) {
+				maps__zput(maps);
+				goto out_free;
+			}
+		}
+		for (j = 0; j < nr_maps; j++) {
+			u64 addr = 0x100000ULL + (u64)j * 0x2000ULL + 0x100ULL;
+			struct map *found = maps__find(maps, addr);
+
+			map__put(found);
+		}
+		gettimeofday(&end, NULL);
+		timersub(&end, &start, &diff);
+		runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
+		update_stats(&asc_stats, runtime_us);
+
+		/*
+		 * Phase 2: Incrementally insert maps at interior addresses
+		 * (simulating runtime MMAP2 / JIT code events) and immediately
+		 * query by address and by name.
+		 */
+		gettimeofday(&start, NULL);
+		for (j = 0; j < nr_appends; j++) {
+			struct map *map = all_maps[nr_maps + j];
+			struct dso *dso = dsos[nr_maps + j];
+			u64 addr = map__start(map);
+			struct map *found;
+
+			err = maps__fixup_overlap_and_insert(maps, map);
+			if (err) {
+				maps__zput(maps);
+				goto out_free;
+			}
+
+			found = maps__find(maps, addr + 0x10ULL);
+			map__put(found);
+
+			found = maps__find_by_name(maps, dso__short_name(dso));
+			map__put(found);
+		}
+		gettimeofday(&end, NULL);
+		timersub(&end, &start, &diff);
+		runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
+		update_stats(&append_stats, runtime_us);
+
+		maps__zput(maps);
+	}
+
+	printf("  Average ascending insert + lookup: %.3f usec (+- %.3f usec)\n",
+	       avg_stats(&asc_stats), stddev_stats(&asc_stats));
+	printf("  Average append + lookup: %.3f usec (+- %.3f usec)\n",
+	       avg_stats(&append_stats), stddev_stats(&append_stats));
+
+out_free:
+	for (i = 0; i < total_dsos; i++) {
+		map__put(all_maps[i]);
+		dso__put(dsos[i]);
+	}
+	free(all_maps);
+	free(dsos);
+	return err;
+}
+
+int bench_maps(int argc, const char **argv)
+{
+	argc = parse_options(argc, argv, options, bench_usage, 0);
+	if (argc) {
+		usage_with_options(bench_usage, options);
+		exit(EXIT_FAILURE);
+	}
+
+	return do_maps_bench();
+}
diff --git a/tools/perf/bench/symbols.c b/tools/perf/bench/symbols.c
new file mode 100644
index 000000000000..5ab71d440e67
--- /dev/null
+++ b/tools/perf/bench/symbols.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Benchmark symbol loading, sorting, and address/name lookup.
+ */
+#include <elf.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <limits.h>
+#include <malloc.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
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
+static int do_dso_load_bench(const char *path)
+{
+	struct stats time_stats;
+#if defined(__GLIBC__) && __GLIBC_PREREQ(2, 33)
+	struct stats mem_stats;
+#endif
+	double time_average, time_stddev;
+	unsigned int i;
+
+	init_stats(&time_stats);
+#if defined(__GLIBC__) && __GLIBC_PREREQ(2, 33)
+	init_stats(&mem_stats);
+#endif
+
+	for (i = 0; i < iterations; i++) {
+		struct timeval start, end, diff;
+		struct map *map;
+		struct dso *dso;
+		u64 runtime_us;
+#if defined(__GLIBC__) && __GLIBC_PREREQ(2, 33)
+		size_t mem_before = mallinfo2().uordblks;
+		size_t mem_after;
+#endif
+
+		gettimeofday(&start, NULL);
+		map = dso__new_map(path);
+		if (!map) {
+			pr_err("Failed to create map for %s\n", path);
+			return -ENOMEM;
+		}
+		if (map__load(map) < 0) {
+			pr_err("Failed to load symbols from %s\n", path);
+			map__put(map);
+			return -EINVAL;
+		}
+		dso = map__dso(map);
+		dso__sort_by_name(dso);
+		gettimeofday(&end, NULL);
+
+#if defined(__GLIBC__) && __GLIBC_PREREQ(2, 33)
+		mem_after = mallinfo2().uordblks;
+		if (mem_after > mem_before)
+			update_stats(&mem_stats, (mem_after - mem_before) / 1024);
+#endif
+		map__put(map);
+
+		timersub(&end, &start, &diff);
+		runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
+		update_stats(&time_stats, runtime_us);
+	}
+
+	time_average = avg_stats(&time_stats) / USEC_PER_MSEC;
+	time_stddev = stddev_stats(&time_stats) / USEC_PER_MSEC;
+	printf("  Average DSO load + sort: %.3f msec (+- %.3f msec)\n",
+	       time_average, time_stddev);
+
+#if defined(__GLIBC__) && __GLIBC_PREREQ(2, 33)
+	printf("  Average DSO memory usage: %.0f KB (+- %.0f KB)\n",
+	       avg_stats(&mem_stats), stddev_stats(&mem_stats));
+#endif
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
+		runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
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
+		runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
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
+	err = do_dso_load_bench(path);
+	if (!err)
+		err = do_synthetic_symbols_bench();
+
+	symbol_conf.demangle = orig_demangle;
+	return err;
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 62bebdedd3b8..57a4199a058c 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -97,6 +97,8 @@ static const struct bench internals_benchmarks[] = {
 	{ "inject-build-id", "Benchmark build-id injection",	bench_inject_build_id	},
 	{ "evlist-open-close", "Benchmark evlist open and close",	bench_evlist_open_close	},
 	{ "pmu-scan", "Benchmark sysfs PMU info scanning",	bench_pmu_scan		},
+	{ "symbols", "Benchmark symbol loading, sorting and lookup",	bench_symbols	},
+	{ "maps", "Benchmark maps insertion, sorting and lookup",	bench_maps	},
 	{ NULL,		NULL,					NULL			}
 };
 
-- 
2.56.0.313.g2479322e68-goog

