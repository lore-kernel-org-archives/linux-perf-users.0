Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590311;
	b=BUCzhjrnDKE9lEua6OeGvYFyBdKUgCXrbE1RIuLWakLSdwm384rLimgV5QNwlcL6RU5b
	 CuUgBLKwW7VYhXqQGX4Pra3T/Qp3c1t2TL956qJHfhd9GJD9lKDIT0DCxPzo4nhcZQ7Hy
	 OabGJUh7QWG9fDhmn9pn+3DCXjTxeNO3l0TjoOofXvteCv2eKtU/BtAJkRgQ5u5wEwb7t
	 Nn5i32NFVUxj4nKPrV1qiXK7W1XQ56Q1MdlW8YJNSxDivJN8Oi2oVSigH5w6rhZvGJN/6
	 f3S4ZE7NUXyM4zzWUVmEF0EB/d4IO7iV0ND3++9N9+aHVy7qgZmi0BFJlDkVudYxamw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=VEUw6mq+jrGr5dTOgnWaey+n+voAGDEvpFCzqxZW/TU=;
	b=wtmiQmbJTpuI5QBpJ++XGajdZmkUuqidPBMcALSBVNzLNPWUX7s//ZZ8HlQqEU6DfZqK
	 IRO1ffRXfSdB0gYRzO5p7gTqQXiy4AqRuUTyU+Pc7iJlKPQCq2TG06w8oXOEBIiDy8cGo
	 UFIczlnlo2nP6rH8R6+abLMmJtNWW7A6uysEpVkmDHonip+v+MV7ctJuVz9qTKG4nRwmL
	 PbxzoEtBm/USGh9uLgKWQxBoNu/XeDfQGYc56zbwtT5LhIUihpQlEZbclD5XWZMsMB6Es
	 j+JNkprQ4+4QnL7V3K4hxXFw2KtKLXUspzke/A2S9b2kC0AX7/aNeQVRGABF57JXzvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B8+lUDnT;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8634607D2CB
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8634607D2CB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B8+lUDnT
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1787663eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 09:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794590310; x=1795195110; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VEUw6mq+jrGr5dTOgnWaey+n+voAGDEvpFCzqxZW/TU=;
        b=B8+lUDnT+vHfcrqh3D4QZX18+ej8kyaiyc62TUToYdpxTilVZ+dDvxF1/thQuSHOph
         rOCEZdlizVWpd4ecJQb/bHYHbDq/xOUiqpZ+2IBFe2n6HlYXw5wUFlvPU2Lkd2/WhVi7
         VpDzTvGro38haHt/y2TTduSEK6BZxW0J8vBF0Me2OqQRMbuZpXiiG2OjLkOmqs2bjiWx
         1+kXHQG+HtWpZs03mDSNmlhkLCvQ5j2hQNZZTHeDSc/gMvL7sJBDX2YYOqAzbzQkcjSA
         XGIE53tXYmCoZn7Oq3NhGWP4wh7QY3+kiNSOsJrDylqP4tcwJptevLxpQSqTGKS7+MkU
         gdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590310; x=1795195110;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VEUw6mq+jrGr5dTOgnWaey+n+voAGDEvpFCzqxZW/TU=;
        b=LVFi85B53HOREIp/dQvqtdvOSxbmYFW1ATgUoGvMsy4SDgJdBwIyuDruB34PtKtcy7
         Cz8b7xaHpfB/NDbsXlEDa07ONQKfiSYm33tHpbS4k38u07v6p5SXWcgMuz5nUSCNMK+D
         7d+C2hiUxONX96E6s347j1GFY1uS7aDpc6mtRT4vdYEmyjiORJrvUnNx+01xLCUuE2CC
         Jf3qMGbUooq/J8CG3VjqmUuO4sG56FgI+x6kfkwhydX7Yz0xKfewO8FgXBzCSgtIecLA
         0zMCvvvad7QZQVSOdUiGUpzOw44lHjKYEwMC9zjGPCURWv7bZG5UHpWxXAEiEdB2E2LK
         C/Sw==
X-Forwarded-Encrypted: i=1; AL+hErFzjJFaKScqe1CXtVuLj3l0zz71/fML7vTUuTl38vVczbgB9mrQPNqF/Q+IAXbKqp7pZBpjgtUF/WpqKEIPDffh@vger.kernel.org
X-Gm-Message-State: APuU4Z+TCxy1pRKSIuqnUu+6IXSTc/dv3E1uH7d5W7sCqJuRp8Wj2Nra
	ohCF/l/4i/Nve34JqriuY4cUMxVqhzwtN9pq5BxshBDTfvEgDaRY/dEzlyZLwmOb1IkaAzQbDa+
	0R4HoIig42Q==
X-Received: from dycnn11.prod.google.com ([2002:a05:7301:140b:b0:36a:1c45:2f79])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:b06:b0:36a:1089:9836
 with SMTP id 5a478bee46e88-3796628ce32mr2229461eec.15.1794590309469; Fri, 13
 Nov 2026 09:18:29 -0800 (PST)
Date: Fri, 13 Nov 2026 09:17:24 -0800
In-Reply-To: <20261113171734.2188066-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110220803.2503416-1-irogers@google.com> <20261113171734.2188066-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113171734.2188066-14-irogers@google.com>
Subject: [PATCH v4 13/23] perf bench internals: Add maps benchmark
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, haghdoost@uber.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add a 'perf bench internals maps' subcommand to measure map insertion,
sorting, and lookup operations directly:

1. Inserts non-overlapping maps in ascending address order (simulating
   /proc/<pid>/maps synthesis) and queries each map by address.
2. Incrementally appends maps at interior addresses (simulating runtime
   PERF_RECORD_MMAP2 / JIT events) and immediately queries each map by
   address and by name.

Example output:

  $ perf bench internals maps
  # Running 'internals/maps' benchmark:
    Average ascending insert + lookup: 145.870 usec (+- 14.628 usec)
    Average append + lookup: 17405.810 usec (+- 1773.195 usec)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-bench.txt |   3 +
 tools/perf/bench/Build                  |   1 +
 tools/perf/bench/bench.h                |   1 +
 tools/perf/bench/maps.c                 | 202 ++++++++++++++++++++++++
 tools/perf/builtin-bench.c              |   1 +
 5 files changed, 208 insertions(+)
 create mode 100644 tools/perf/bench/maps.c

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index 54eb809540c4..c65dd8f4131f 100644
--- a/tools/perf/Documentation/perf-bench.txt
+++ b/tools/perf/Documentation/perf-bench.txt
@@ -354,6 +354,9 @@ Suite for evaluating perf's event synthesis performance.
 *symbols*::
 Suite for evaluating ELF symbol loading, sorting, and lookup performance.
 
+*maps*::
+Suite for evaluating maps insertion, sorting, and lookup performance.
+
 SEE ALSO
 --------
 linkperf:perf[1]
diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index c3c0319696ae..d51e52d3742a 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -21,6 +21,7 @@ perf-bench-y += breakpoint.o
 perf-bench-y += pmu-scan.o
 perf-bench-y += uprobe.o
 perf-bench-y += symbols.o
+perf-bench-y += maps.o
 
 perf-bench-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
 perf-bench-$(CONFIG_X86_64) += mem-memset-x86-64-asm.o
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index e0b35d45559a..c988d236e0f0 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -53,6 +53,7 @@ int bench_uprobe_empty_ret(int argc, const char **argv);
 int bench_uprobe_trace_printk_ret(int argc, const char **argv);
 int bench_pmu_scan(int argc, const char **argv);
 int bench_symbols(int argc, const char **argv);
+int bench_maps(int argc, const char **argv);
 
 #define BENCH_FORMAT_DEFAULT_STR	"default"
 #define BENCH_FORMAT_DEFAULT		0
diff --git a/tools/perf/bench/maps.c b/tools/perf/bench/maps.c
new file mode 100644
index 000000000000..da05d39c5e0b
--- /dev/null
+++ b/tools/perf/bench/maps.c
@@ -0,0 +1,202 @@
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
+#include <unistd.h>
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/time64.h>
+#include <subcmd/parse-options.h>
+#include "bench.h"
+#include "../util/debug.h"
+#include "../util/dso.h"
+#include "../util/env.h"
+#include "../util/machine.h"
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
+	struct perf_env host_env;
+	struct machine *machine;
+	struct dso **dsos;
+	struct map **all_maps;
+	unsigned int i, j;
+	int err = 0;
+
+	if (total_dsos == 0)
+		return 0;
+
+	perf_env__init(&host_env);
+	machine = machine__new_live(&host_env, /*kernel_maps=*/false, getpid());
+	if (!machine) {
+		perf_env__exit(&host_env);
+		return -ENOMEM;
+	}
+
+	dsos = calloc(total_dsos, sizeof(*dsos));
+	all_maps = calloc(total_dsos, sizeof(*all_maps));
+	if (!dsos || !all_maps) {
+		free(dsos);
+		free(all_maps);
+		machine__delete(machine);
+		perf_env__exit(&host_env);
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
+		struct maps *maps = maps__new(machine);
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
+	machine__delete(machine);
+	perf_env__exit(&host_env);
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
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index f937c08f3900..57a4199a058c 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -98,6 +98,7 @@ static const struct bench internals_benchmarks[] = {
 	{ "evlist-open-close", "Benchmark evlist open and close",	bench_evlist_open_close	},
 	{ "pmu-scan", "Benchmark sysfs PMU info scanning",	bench_pmu_scan		},
 	{ "symbols", "Benchmark symbol loading, sorting and lookup",	bench_symbols	},
+	{ "maps", "Benchmark maps insertion, sorting and lookup",	bench_maps	},
 	{ NULL,		NULL,					NULL			}
 };
 
-- 
2.56.1.703.gf848ed807c-goog

