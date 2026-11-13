Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604298;
	b=va4rou8Cy9w8RwWx1CvCgIqcikLughkoPCEqLIm96CquyVKCL945Ej6zL9Du57q7eFmp
	 ez6MNlWHp6id1lytDyzSjlHPTSCj7NZ8zhh73U401ZmGbXnhQA7pdTT6rHKU2L/GA7Dgr
	 Q67k02t6BAaHs/aw3Se5U0nN9f4M34gPBZlFykQI153AlyJL8QPF+O/qCbF+g4nDoooyC
	 6aRRI/npXxSyGtiR616UVOfCOVRWQQQJrWmXimmWtl+We7toUBasR0Mm0mmrPEJ/iq/yL
	 RXk8bR8/k2w2rtL0He7/UYJwjOHa+/A2wTODOfQRUJYu2xKg3iyAWdXrMQgB9JPtDMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=m80AGQbPS/DmXnuoMYtiEjibdInNcaEY/vjnI36ebWE=;
	b=ryLdZuFwwUccywfGvd2D48+UIe+BcqAjtu7FoYUzy1XYsM8YwBcUZ3GGVjOT7lTKea+B
	 6GYMeGqT97bonuVNDgWMlYhW16ywM+FYuPtNoaYodKakWkZBVr/4gDRYpTr5fafcV5R68
	 eH9i6I9o357jOwry3GDvJaXwmff3590ZbmKsz295iC0xXqVX0VYNkY+PaRL+0mXjYx83d
	 0Vx6WchfjSBRRYSDNMKf+Zc5vwocsVJX5ar9QjdtFT72lwezaJFbg9FcYaH6jP2UGWAtd
	 YKqSUb7mxUayzkx4OdonB2uXw7xNcpgOtXZNWosRgvw51gUtmfhLa3NrvmcyJRKqhvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TUG4BYFL;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EEE606A88C
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75EEE606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TUG4BYFL
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36efb506f29so1560580eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794604297; x=1795209097; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m80AGQbPS/DmXnuoMYtiEjibdInNcaEY/vjnI36ebWE=;
        b=TUG4BYFLlBYWV6j8T3ITIdYU8B4tHltNNG6FLRXpE2OPp0drZ0Snd1z5J14yxkJn+n
         7xWeruGKlV81/oBx36XehOSruO9JffFR7QX3GqeRdAODKcnw0PHXSUmHpVYijAP7UedZ
         AHFu0oXtlN3sUKWAW6z2yjb3/fJ3MF6ZsgoVes+Z/s9qmetg9Ibt2F6ipnhf76oqy5BL
         6wfxBPGE+9hh6eqOQycspJTe+Rr2bPYYLVtUrsXP11ep6IAGxv9u5ckBwCUI87C2liND
         7HZaw/z5yhQ+ofh3DJSQkKHr6MpCfgQRIrYMLaVwMpSocOEOMG6qJCOchIX1c8tNk6xG
         nNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604297; x=1795209097;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m80AGQbPS/DmXnuoMYtiEjibdInNcaEY/vjnI36ebWE=;
        b=Z32CdVC5QhuQ4c2T08h0IXnGkF88KYyWIqXpyUSSb++N1KDSidSasmTp4t3Yd5FgPS
         Z+OU0wDGHJrbsXvaBoSX+FMFWOt3X1cxxsAVRB42U/8yXgJHdwOq28p6VEoQc+SeSe9a
         xCary8ebKbmDhHZPjW+PIQgXIqW5oVMXnA3uUR0tnThCn7LT9UfJbSGKwiP7gIyOliXJ
         fw+F150zr3/HM9SkmsYrWQYL/H54mSr72raWCraXfMWqIyPWfm1kb4Eh786pKZQeaIrg
         nw2msU3xtEuzmncEcB+/RlskFxqY46F5ZhnDmfrEz2fUGOtvtIo6cgwiqmdo2poArgKF
         NVAA==
X-Forwarded-Encrypted: i=1; AL+hErFjMWhcqSvr6h8PAPOpXt2g02quro0rudAM1BA2aU3qEwCHi+8z2cEGB3xhh52KSwqHwdrefaMDl6xc6KqovNN0@vger.kernel.org
X-Gm-Message-State: APuU4Z/sTZVhZoK9O8EAEv9TeLWmuUcpRBnHCqU4wtCKFBeAglpsiZUT
	1shzCfqIxABrVUCJ5PtjXCcbFOTBB6vUhe5VSOwG9nCA8FEs9vsKLV45/y0c/BiwS9ZmlP2u3lY
	6RUnWXnxzEA==
X-Received: from dybrt9.prod.google.com ([2002:a05:7301:4709:b0:369:f2bd:5ab6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4d10:b0:377:58c0:22a7
 with SMTP id 5a478bee46e88-379655d4493mr2800075eec.6.1794604296206; Fri, 13
 Nov 2026 13:11:36 -0800 (PST)
Date: Fri, 13 Nov 2026 13:11:01 -0800
In-Reply-To: <20261113211105.3118281-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113211105.3118281-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113211105.3118281-11-irogers@google.com>
Subject: [PATCH 10/11] perf list: Add --export-cpuid to export compiled-in CPU models
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently 'perf list --export-dir <dir>' only exports the active PMUs on
the running system into host-direct '<dir>/<pmu>/' directories, while
exporting other CPU models or architectures requires running
'jevents.py --output-dir' against an unbuilt kernel JSON source tree.
With JEVENTS_ARCH=all and block-indexed string compression, the 'perf'
binary already carries all compiled-in architectures and CPU models.

Add '--export-cpuid <cpuid|arch[/model]|all>' to 'perf list' (for use
with '--export-dir <dir>') so compiled-in event, metric, and metricgroup
tables for any CPUID, model, or architecture can be materialized
directly from the 'perf' binary without needing 'jevents.py' or kernel
sources:

- Implement pmu_layer__export_cpuid() in pmu-layer.c, supporting:
  - Exact or stepping CPUIDs (e.g. 'GenuineIntel-6-8F-8' ->
    'GenuineIntel-6-8F', '0x00000000411fd493' -> '0x00000000410fd490',
    '0x00800200' -> '0x00800000', 'IBM,8561,703' -> 'IBM,8561', and
    '0x489-0x8000000000000007-0x1' -> '0x489-0x8000000000000007') as
    well as literal system PMU Compat identifiers.
  - Architecture names ('x86', 'arm64', 'riscv', 'powerpc', 's390',
    'common') and '<arch>/<model>' or '<model>' globs ('x86/skylake',
    'arm64/arm/neoverse-n2-v2', 'amdzen*').
  - 'all' to materialize all compiled-in architectures and models under
    '<dir>/models/<arch>/<model>/' with expanded relative POSIX symlinks
    under '<dir>/cpus/<cpuid>' and '<dir>/sys/<id>'.
- Preserve all 'perf list' filters (--unit, --cputype, --deprecated, and
  hw/sw/cache/pmu/metric/metricgroup/event_glob positional arguments).

For example, to inspect or migrate metrics from ARM64 Neoverse-N2 onto
another machine:

  $ perf list --export-dir /tmp/n2 \
        --export-cpuid arm64/arm/neoverse-n2-v2 metric metricgroup

produces:

  /tmp/n2/
  |-- cpus/
  |   |-- 0x00000000410fd490 -> ../models/arm64/arm/neoverse-n2-v2
  |   `-- 0x00000000410fd4f0 -> ../models/arm64/arm/neoverse-n2-v2
  |-- models/arm64/arm/neoverse-n2-v2/
  |   |-- default_core/metrics/...
  |   `-- metricgroups/...
  `-- metricgroups/...

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-config.txt |    6 +-
 tools/perf/Documentation/perf-list.txt   |   23 +-
 tools/perf/builtin-list.c                |  152 +++
 tools/perf/util/pmu-layer.c              | 1199 ++++++++++++++++++++--
 tools/perf/util/pmu-layer.h              |   12 +
 5 files changed, 1300 insertions(+), 92 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 95181ebfca23..d9afecde6019 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -302,10 +302,12 @@ For example, to layer local overrides ahead of a shared directory in
 		$ perf stat -M my_ipc true
 +
 Overlay directories can also be populated from the current system using
-`perf list --export-dir` (see linkperf:perf-list[1]) or from JSON event trees
-using `jevents.py --output-dir`:
+`perf list --export-dir`, from compiled-in cross-architecture tables using
+`perf list --export-dir ... --export-cpuid` (see linkperf:perf-list[1]), or
+from JSON event trees using `jevents.py --output-dir`:
 
 		$ perf list --export-dir ~/.perf-events/local metric metricgroup
+		$ perf list --export-dir /opt/pmu-events --export-cpuid all
 		$ python3 tools/perf/pmu-events/jevents.py --output-dir /opt/pmu-events x86 all
 		$ perf config pmu-events.dir=~/.perf-events/local:/opt/pmu-events
 
diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index dbad98da3899..e2f7d8407a4c 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -57,8 +57,18 @@ Output in JSON format.
 	(`<dir>/<pmu>/metrics/`), and metricgroup descriptions
 	(`<dir>/metricgroups/`) into a sysfs-style directory tree suitable for
 	layering via `pmu-events.dir` in linkperf:perf-config[1], for example
-	`perf list --export-dir ~/.perf-events metric metricgroup`. See
-	<<EXPORTING_EVENTS, EXPORTING AND OVERLAYING EVENTS>>.
+	`perf list --export-dir ~/.perf-events metric metricgroup`. By default
+	only the current system's active PMUs are exported; combine with
+	`--export-cpuid` to export compiled-in tables for other CPUs or
+	architectures. See <<EXPORTING_EVENTS, EXPORTING AND OVERLAYING EVENTS>>.
+
+--export-cpuid=::
+	When combined with `--export-dir`, export compiled-in PMU event and
+	metric tables matching a CPUID (for example `GenuineIntel-6-8F-8` or
+	`0x00000000410fd490`), architecture (`x86`, `arm64`, `riscv`), model
+	path or glob (`x86/skylake`, `arm64/arm/neoverse-n2-v2`, `amdzen*`), or
+	`all` into `<dir>/models/<arch>/<model>/` with relative POSIX symlinks
+	under `<dir>/cpus/<cpuid>` and `<dir>/sys/<id>`.
 
 --tui::
 Rather than printing the events, interactively browse the PMUs, events and
@@ -386,10 +396,13 @@ extended in place, and layered back over the inbuilt tables and sysfs via
   perf config pmu-events.dir=~/.perf-events
   perf list sw
 
-Architecture JSON definitions from the kernel source tree can also be exported
-directly into a self-contained directory tree (with literal 'cpus/<cpuid>' and
-'sys/<id>' symlinks and no 'mapfile.csv') using 'jevents.py --output-dir':
+Compiled-in tables for other CPUIDs, models, or architectures can also be
+exported directly from the 'perf' binary using '--export-cpuid' (for example,
+to inspect or migrate a metric from one architecture or model to another), or
+exported from unbuilt kernel source JSON trees using 'jevents.py --output-dir':
 
+  perf list --export-dir /tmp/skl --export-cpuid x86/skylake metric
+  perf list --export-dir /opt/pmu-events --export-cpuid all
   python3 tools/perf/pmu-events/jevents.py --output-dir /opt/pmu-events x86 all
   perf config pmu-events.dir=~/.perf-events:/opt/pmu-events
 
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 85de0bd73e32..f87a8b2147d4 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -703,6 +703,140 @@ static int list__tui(int argc, const char **argv)
 	return ret;
 }
 
+static int run_export_cpuid_pass(const char *export_dir,
+				 const char *export_cpuid,
+				 const struct pmu_layer_export_opts *opts)
+{
+	int ret = pmu_layer__export_cpuid(export_dir, export_cpuid, opts);
+
+	if (ret == -ENOENT) {
+		pr_err("ERROR: No compiled-in PMU tables matched --export-cpuid '%s'\n",
+		       export_cpuid);
+		return -1;
+	}
+	if (ret < 0) {
+		pr_err("Failed to export PMU tables to '%s': %s\n",
+		       export_dir, strerror(-ret));
+		return -1;
+	}
+	return 0;
+}
+
+static int cmd_list__export_cpuid(const char *export_dir,
+				  const char *export_cpuid,
+				  const char *unit_name,
+				  const char *cputype,
+				  bool deprecated,
+				  int argc, const char **argv)
+{
+	const char *base_pmu_glob = NULL;
+	bool ran_pass = false;
+
+	if (unit_name) {
+		base_pmu_glob = unit_name;
+	} else if (cputype) {
+		const struct perf_pmu *pmu = perf_pmus__pmu_for_pmu_filter(cputype);
+
+		if (pmu)
+			base_pmu_glob = pmu->name;
+		else if (!strcasecmp(cputype, "core"))
+			base_pmu_glob = "cpu_core";
+		else if (!strcasecmp(cputype, "atom"))
+			base_pmu_glob = "cpu_atom";
+		else
+			base_pmu_glob = cputype;
+	}
+
+	if (argc == 0) {
+		struct pmu_layer_export_opts opts = {
+			.pmu_glob = base_pmu_glob,
+			.events = true,
+			.metrics = true,
+			.metricgroups = true,
+			.deprecated = deprecated,
+		};
+
+		return run_export_cpuid_pass(export_dir, export_cpuid, &opts);
+	}
+
+	for (int i = 0; i < argc; i++) {
+		struct pmu_layer_export_opts opts = {
+			.pmu_glob = base_pmu_glob,
+			.deprecated = deprecated,
+		};
+		int ret;
+
+		if (!strcmp(argv[i], "tracepoint") || !strcmp(argv[i], "sdt") ||
+		    !strcmp(argv[i], "pfm")) {
+			continue;
+		} else if (!strcmp(argv[i], "hw") || !strcmp(argv[i], "hardware")) {
+			opts.events = true;
+			opts.event_glob = "legacy hardware";
+			ret = run_export_cpuid_pass(export_dir, export_cpuid, &opts);
+		} else if (!strcmp(argv[i], "sw") || !strcmp(argv[i], "software")) {
+			static const char * const sw_globs[] = { "software", "tool" };
+
+			ret = 0;
+			for (size_t j = 0; j < ARRAY_SIZE(sw_globs) && !ret; j++) {
+				if (base_pmu_glob &&
+				    !strglobmatch(sw_globs[j], base_pmu_glob))
+					continue;
+				opts.pmu_glob = sw_globs[j];
+				opts.events = true;
+				ret = run_export_cpuid_pass(export_dir, export_cpuid, &opts);
+				ran_pass = true;
+			}
+			if (ret)
+				return ret;
+			continue;
+		} else if (!strcmp(argv[i], "cache") || !strcmp(argv[i], "hwcache")) {
+			opts.events = true;
+			opts.event_glob = "legacy cache";
+			ret = run_export_cpuid_pass(export_dir, export_cpuid, &opts);
+		} else if (!strcmp(argv[i], "pmu")) {
+			opts.events = true;
+			opts.exclude_abi = true;
+			ret = run_export_cpuid_pass(export_dir, export_cpuid, &opts);
+		} else if (!strcmp(argv[i], "metric") || !strcmp(argv[i], "metrics")) {
+			opts.metrics = true;
+			ret = run_export_cpuid_pass(export_dir, export_cpuid, &opts);
+		} else if (!strcmp(argv[i], "metricgroup") ||
+			   !strcmp(argv[i], "metricgroups")) {
+			opts.metricgroups = true;
+			ret = run_export_cpuid_pass(export_dir, export_cpuid, &opts);
+		} else if (strchr(argv[i], ':') != NULL) {
+			opts.event_glob = argv[i];
+			opts.metrics = true;
+			opts.metricgroups = true;
+			ret = run_export_cpuid_pass(export_dir, export_cpuid, &opts);
+		} else {
+			char *s = NULL;
+
+			if (asprintf(&s, "*%s*", argv[i]) < 0)
+				return -1;
+			opts.event_glob = s;
+			opts.events = true;
+			opts.metrics = true;
+			opts.metricgroups = true;
+			ret = run_export_cpuid_pass(export_dir, export_cpuid, &opts);
+			free(s);
+		}
+		if (ret)
+			return ret;
+		ran_pass = true;
+	}
+
+	if (!ran_pass) {
+		struct pmu_layer_export_opts opts = {
+			.pmu_glob = base_pmu_glob,
+			.deprecated = deprecated,
+		};
+
+		return run_export_cpuid_pass(export_dir, export_cpuid, &opts);
+	}
+	return 0;
+}
+
 int cmd_list(int argc, const char **argv)
 {
 	int i, ret = 0;
@@ -732,6 +866,7 @@ int cmd_list(int argc, const char **argv)
 	const char *unit_name = NULL;
 	const char *output_path = NULL;
 	const char *export_dir = NULL;
+	const char *export_cpuid = NULL;
 	bool json = false;
 	bool use_tui = false;
 	struct option list_options[] = {
@@ -746,6 +881,8 @@ int cmd_list(int argc, const char **argv)
 		OPT_STRING('o', "output", &output_path, "file", "output file name"),
 		OPT_STRING(0, "export-dir", &export_dir, "dir",
 			   "Export events, metrics, and metricgroups to a sysfs-style directory"),
+		OPT_STRING(0, "export-cpuid", &export_cpuid, "cpuid|arch[/model]|all",
+			   "Export compiled-in PMU tables for CPUID, arch[/model], or 'all'"),
 		OPT_BOOLEAN(0, "deprecated", &default_ps.deprecated,
 			    "Print deprecated events."),
 		OPT_STRING(0, "cputype", &cputype, "cpu type",
@@ -779,10 +916,25 @@ int cmd_list(int argc, const char **argv)
 		pr_err("ERROR: --export-dir cannot be combined with --tui, --json, or --output\n");
 		return -1;
 	}
+	if (export_cpuid && !export_dir) {
+		pr_err("ERROR: --export-cpuid requires --export-dir\n");
+		return -1;
+	}
+	if (export_cpuid && !export_cpuid[0]) {
+		pr_err("ERROR: --export-cpuid requires a CPUID, arch, arch/model, or 'all'\n");
+		return -1;
+	}
 
 	if (use_tui)
 		return list__tui(argc, argv);
 
+	if (export_cpuid) {
+		return cmd_list__export_cpuid(export_dir, export_cpuid,
+					      unit_name, cputype,
+					      default_ps.deprecated,
+					      argc, argv);
+	}
+
 	if (export_dir) {
 		export_ps.root_dir = export_dir;
 		export_ps.common.long_desc = default_ps.long_desc;
diff --git a/tools/perf/util/pmu-layer.c b/tools/perf/util/pmu-layer.c
index 35a816db3f4f..74c07ffc8495 100644
--- a/tools/perf/util/pmu-layer.c
+++ b/tools/perf/util/pmu-layer.c
@@ -29,6 +29,7 @@
 #include "pmu.h"
 #include "pmus.h"
 #include "pmu-layer.h"
+#include "string2.h"
 #include "pmu-events/pmu-events.h"
 
 static struct pmu_layer *pmu_layers;
@@ -2594,36 +2595,11 @@ static struct perf_pmu_alias *export_find_pmu_and_alias(const char *pmu_name,
 	return NULL;
 }
 
-int pmu_layer__export_event(const char *root_dir, const char *pmu_name,
-			    const char *event_name)
+static int export_write_alias_files(int events_fd, const char *enc_name,
+				    const struct perf_pmu_alias *alias)
 {
-	struct perf_pmu *pmu = NULL;
-	struct perf_pmu_alias *alias;
-	const char *target_pmu;
-	char dir_path[PATH_MAX];
-	char enc_name[NAME_MAX];
 	char num_buf[64];
-	int events_fd, n, ret = 0;
-
-	alias = export_find_pmu_and_alias(pmu_name, event_name, &pmu);
-	if (!alias)
-		return 0;
-
-	if (pmu_layer__encode_filename(alias->name, enc_name, sizeof(enc_name)) != 0)
-		return 0;
-
-	target_pmu = (alias->pmu_name && alias->pmu_name[0]) ? alias->pmu_name : pmu->name;
-	n = snprintf(dir_path, sizeof(dir_path), "%s/%s/events", root_dir, target_pmu);
-	if (n < 0 || (size_t)n >= sizeof(dir_path))
-		return -ENAMETOOLONG;
-
-	ret = pmu_layer__mkdir_p(dir_path);
-	if (ret < 0)
-		return ret;
-
-	events_fd = open(dir_path, O_RDONLY | O_DIRECTORY);
-	if (events_fd < 0)
-		return -errno;
+	int ret;
 
 	if (!strncmp(alias->terms, "legacy-hardware-config=", 23) ||
 	    !strncmp(alias->terms, "legacy-cache-config=", 20)) {
@@ -2636,7 +2612,7 @@ int pmu_layer__export_event(const char *root_dir, const char *pmu_name,
 						   ".legacy-terms",
 						   alias->legacy_terms);
 	}
-	if (!ret && (alias->has_unit || alias->unit[0] != '\0'))
+	if (!ret && alias->unit[0] != '\0')
 		ret = export_write_sidecar(events_fd, enc_name, ".unit", alias->unit);
 	if (!ret && (alias->has_scale || alias->scale != 1.0)) {
 		snprintf(num_buf, sizeof(num_buf), "%.17g", alias->scale);
@@ -2678,7 +2654,40 @@ int pmu_layer__export_event(const char *root_dir, const char *pmu_name,
 		ret = export_write_sidecar(events_fd, enc_name, ".retire-lat-max",
 					   num_buf);
 	}
+	return ret;
+}
+
+int pmu_layer__export_event(const char *root_dir, const char *pmu_name,
+			    const char *event_name)
+{
+	struct perf_pmu *pmu = NULL;
+	struct perf_pmu_alias *alias;
+	const char *target_pmu;
+	char dir_path[PATH_MAX];
+	char enc_name[NAME_MAX];
+	int events_fd, n, ret;
+
+	alias = export_find_pmu_and_alias(pmu_name, event_name, &pmu);
+	if (!alias)
+		return 0;
+
+	if (pmu_layer__encode_filename(alias->name, enc_name, sizeof(enc_name)) != 0)
+		return 0;
+
+	target_pmu = (alias->pmu_name && alias->pmu_name[0]) ? alias->pmu_name : pmu->name;
+	n = snprintf(dir_path, sizeof(dir_path), "%s/%s/events", root_dir, target_pmu);
+	if (n < 0 || (size_t)n >= sizeof(dir_path))
+		return -ENAMETOOLONG;
+
+	ret = pmu_layer__mkdir_p(dir_path);
+	if (ret < 0)
+		return ret;
+
+	events_fd = open(dir_path, O_RDONLY | O_DIRECTORY);
+	if (events_fd < 0)
+		return -errno;
 
+	ret = export_write_alias_files(events_fd, enc_name, alias);
 	close(events_fd);
 	return ret;
 }
@@ -2772,6 +2781,50 @@ int pmu_layer__export_metricgroup(const char *root_dir, const char *group,
 	return ret;
 }
 
+static int export_write_pm_files(int fd, const char *enc_name,
+				 const struct pmu_metric *pm,
+				 bool has_aggr, bool has_grouping,
+				 bool has_show, bool show_val)
+{
+	int ret = export_write_sidecar(fd, enc_name, "", pm->metric_expr);
+
+	if (!ret && pm->unit && pm->unit[0])
+		ret = export_write_sidecar(fd, enc_name, ".scale-unit", pm->unit);
+	if (!ret && pm->desc && pm->desc[0])
+		ret = export_write_sidecar(fd, enc_name, ".desc", pm->desc);
+	if (!ret && pm->long_desc && pm->long_desc[0])
+		ret = export_write_sidecar(fd, enc_name, ".long-desc", pm->long_desc);
+	if (!ret && pm->metric_group && pm->metric_group[0])
+		ret = export_write_sidecar(fd, enc_name, ".group", pm->metric_group);
+	if (!ret && pm->metricgroup_no_group && pm->metricgroup_no_group[0])
+		ret = export_write_sidecar(fd, enc_name, ".no-group",
+					   pm->metricgroup_no_group);
+	if (!ret && pm->default_metricgroup_name && pm->default_metricgroup_name[0])
+		ret = export_write_sidecar(fd, enc_name, ".default-group",
+					   pm->default_metricgroup_name);
+	if (!ret && pm->metric_threshold && pm->metric_threshold[0])
+		ret = export_write_sidecar(fd, enc_name, ".threshold",
+					   pm->metric_threshold);
+	if (!ret && pm->compat && pm->compat[0])
+		ret = export_write_sidecar(fd, enc_name, ".compat", pm->compat);
+	if (!ret && has_aggr) {
+		const char *aggr = export_aggr_mode_str(pm->aggr_mode);
+
+		if (aggr)
+			ret = export_write_sidecar(fd, enc_name, ".aggr-mode", aggr);
+	}
+	if (!ret && has_grouping) {
+		const char *cstr = export_constraint_str(pm->event_grouping);
+
+		if (cstr)
+			ret = export_write_sidecar(fd, enc_name, ".constraint", cstr);
+	}
+	if (!ret && has_show)
+		ret = export_write_sidecar(fd, enc_name, ".show-events",
+					   show_val ? "1" : "0");
+	return ret;
+}
+
 int pmu_layer__export_metric(const char *root_dir, const char *eff_pmu,
 			     const char *group, const char *name,
 			     const char *desc, const char *long_desc,
@@ -2779,6 +2832,7 @@ int pmu_layer__export_metric(const char *root_dir, const char *eff_pmu,
 			     const char *unit)
 {
 	const struct perf_pmu_metric *m;
+	struct pmu_metric pm = {};
 	char dir_path[PATH_MAX];
 	char enc_name[NAME_MAX];
 	int fd, n, ret;
@@ -2801,65 +2855,1040 @@ int pmu_layer__export_metric(const char *root_dir, const char *eff_pmu,
 		return -errno;
 
 	if (m) {
-		ret = export_write_sidecar(fd, enc_name, "",
-					   m->metric_expr ?: expr);
-		if (!ret && m->unit && m->unit[0])
-			ret = export_write_sidecar(fd, enc_name, ".scale-unit",
-						   m->unit);
-		if (!ret && m->desc && m->desc[0])
-			ret = export_write_sidecar(fd, enc_name, ".desc", m->desc);
-		if (!ret && m->long_desc && m->long_desc[0])
-			ret = export_write_sidecar(fd, enc_name, ".long-desc",
-						   m->long_desc);
-		if (!ret && m->metric_group && m->metric_group[0])
-			ret = export_write_sidecar(fd, enc_name, ".group",
-						   m->metric_group);
-		if (!ret && m->metricgroup_no_group && m->metricgroup_no_group[0])
-			ret = export_write_sidecar(fd, enc_name, ".no-group",
-						   m->metricgroup_no_group);
-		if (!ret && m->default_metricgroup_name &&
-		    m->default_metricgroup_name[0])
-			ret = export_write_sidecar(fd, enc_name, ".default-group",
-						   m->default_metricgroup_name);
-		if (!ret && m->metric_threshold && m->metric_threshold[0])
-			ret = export_write_sidecar(fd, enc_name, ".threshold",
-						   m->metric_threshold);
-		if (!ret && m->compat && m->compat[0])
-			ret = export_write_sidecar(fd, enc_name, ".compat",
-						   m->compat);
-		if (!ret && m->has_aggr_mode) {
-			const char *aggr = export_aggr_mode_str(m->aggr_mode);
-
-			if (aggr)
-				ret = export_write_sidecar(fd, enc_name,
-							   ".aggr-mode", aggr);
-		}
-		if (!ret && m->has_event_grouping) {
-			const char *cstr = export_constraint_str(m->event_grouping);
-
-			if (cstr)
-				ret = export_write_sidecar(fd, enc_name,
-							   ".constraint", cstr);
-		}
-		if (!ret && m->has_default_show_events)
-			ret = export_write_sidecar(fd, enc_name, ".show-events",
-						   m->default_show_events ? "1" : "0");
+		perf_pmu_metric__to_pmu_metric(m, &pm);
+		if (!pm.metric_expr)
+			pm.metric_expr = expr;
+		ret = export_write_pm_files(fd, enc_name, &pm,
+					    m->has_aggr_mode,
+					    m->has_event_grouping,
+					    m->has_default_show_events,
+					    m->default_show_events);
 	} else {
-		ret = export_write_sidecar(fd, enc_name, "", expr);
-		if (!ret && unit && unit[0])
-			ret = export_write_sidecar(fd, enc_name, ".scale-unit", unit);
-		if (!ret && desc && desc[0])
-			ret = export_write_sidecar(fd, enc_name, ".desc", desc);
-		if (!ret && long_desc && long_desc[0])
-			ret = export_write_sidecar(fd, enc_name, ".long-desc",
-						   long_desc);
-		if (!ret && group && group[0])
-			ret = export_write_sidecar(fd, enc_name, ".group", group);
-		if (!ret && threshold && threshold[0])
-			ret = export_write_sidecar(fd, enc_name, ".threshold",
-						   threshold);
+		pm.metric_expr = expr;
+		pm.unit = unit;
+		pm.desc = desc;
+		pm.long_desc = long_desc;
+		pm.metric_group = group;
+		pm.metric_threshold = threshold;
+		ret = export_write_pm_files(fd, enc_name, &pm,
+					    false, false, false, false);
+	}
+
+	close(fd);
+	return ret;
+}
+
+struct export_str_vec {
+	char **items;
+	size_t nr;
+	size_t cap;
+};
+
+static void export_str_vec__clear(struct export_str_vec *v)
+{
+	for (size_t i = 0; i < v->nr; i++)
+		free(v->items[i]);
+	zfree(&v->items);
+	v->nr = 0;
+	v->cap = 0;
+}
+
+static bool export_str_vec__contains(const struct export_str_vec *v, const char *s)
+{
+	for (size_t i = 0; i < v->nr; i++) {
+		if (!strcmp(v->items[i], s))
+			return true;
+	}
+	return false;
+}
+
+static int export_str_vec__add(struct export_str_vec *v, const char *s)
+{
+	char *dup_s;
+
+	if (v->nr == v->cap) {
+		size_t new_cap = v->cap ? v->cap * 2 : 16;
+		char **new_items = realloc(v->items, new_cap * sizeof(*new_items));
+
+		if (!new_items)
+			return -ENOMEM;
+		v->items = new_items;
+		v->cap = new_cap;
+	}
+	dup_s = strdup(s);
+	if (!dup_s)
+		return -ENOMEM;
+	v->items[v->nr++] = dup_s;
+	return 0;
+}
+
+static int export_str_vec__add_concat3(struct export_str_vec *v,
+				       const char *p1, size_t l1,
+				       const char *p2, size_t l2,
+				       const char *p3, size_t l3)
+{
+	char buf[256];
+
+	if (l1 + l2 + l3 >= sizeof(buf))
+		return 0;
+	memcpy(buf, p1, l1);
+	memcpy(buf + l1, p2, l2);
+	memcpy(buf + l1 + l2, p3, l3);
+	buf[l1 + l2 + l3] = '\0';
+	return export_str_vec__add(v, buf);
+}
+
+static int expand_regex_fragment(const char *pat, struct export_str_vec *out);
+
+static int expand_alt_slice(const char *prefix, size_t plen,
+			    const char *slice, size_t slen,
+			    const struct export_str_vec *suf_vec,
+			    struct export_str_vec *out)
+{
+	struct export_str_vec alt_vec = {};
+	char alt_buf[256];
+	int ret;
+
+	if (slen >= sizeof(alt_buf))
+		return 0;
+	memcpy(alt_buf, slice, slen);
+	alt_buf[slen] = '\0';
+
+	ret = expand_regex_fragment(alt_buf, &alt_vec);
+	for (size_t a = 0; !ret && a < alt_vec.nr; a++) {
+		const char *as = alt_vec.items[a];
+		size_t al = strlen(as);
+
+		for (size_t s = 0; !ret && s < suf_vec->nr; s++) {
+			const char *ss = suf_vec->items[s];
+
+			ret = export_str_vec__add_concat3(out, prefix, plen,
+							  as, al,
+							  ss, strlen(ss));
+		}
 	}
+	export_str_vec__clear(&alt_vec);
+	return ret;
+}
+
+static int expand_paren_group(const char *pat, size_t idx, size_t close_idx,
+			      struct export_str_vec *out)
+{
+	struct export_str_vec suf_vec = {};
+	size_t start = idx + 1, depth = 0;
+	int ret;
+
+	ret = expand_regex_fragment(pat + close_idx + 1, &suf_vec);
+	if (ret)
+		goto out;
+
+	for (size_t j = idx + 1; j <= close_idx; j++) {
+		if (j < close_idx && pat[j] == '(') {
+			depth++;
+		} else if (j < close_idx && pat[j] == ')') {
+			depth--;
+		} else if (j == close_idx || (pat[j] == '|' && depth == 0)) {
+			ret = expand_alt_slice(pat, idx, pat + start, j - start,
+					       &suf_vec, out);
+			if (ret)
+				goto out;
+			start = j + 1;
+		}
+	}
+
+out:
+	export_str_vec__clear(&suf_vec);
+	return ret;
+}
+
+static int expand_bracket_group(const char *pat, size_t idx,
+				const char *close_p, struct export_str_vec *out)
+{
+	struct export_str_vec suf_vec = {};
+	const char *p = pat + idx + 1;
+	int ret;
+
+	ret = expand_regex_fragment(close_p + 1, &suf_vec);
+	if (ret)
+		goto out;
+
+	while (p < close_p) {
+		unsigned int c_lo, c_hi;
+
+		if (p + 2 < close_p && p[1] == '-' &&
+		    (unsigned char)p[0] <= (unsigned char)p[2]) {
+			c_lo = (unsigned char)p[0];
+			c_hi = (unsigned char)p[2];
+			p += 3;
+		} else {
+			c_lo = (unsigned char)p[0];
+			c_hi = c_lo;
+			p += 1;
+		}
+		for (unsigned int ch = c_lo; ch <= c_hi; ch++) {
+			char one = (char)ch;
+
+			for (size_t s = 0; s < suf_vec.nr; s++) {
+				const char *ss = suf_vec.items[s];
+
+				ret = export_str_vec__add_concat3(out, pat, idx,
+								  &one, 1,
+								  ss, strlen(ss));
+				if (ret)
+					goto out;
+			}
+		}
+	}
+
+out:
+	export_str_vec__clear(&suf_vec);
+	return ret;
+}
+
+static int expand_regex_fragment(const char *pat, struct export_str_vec *out)
+{
+	for (size_t idx = 0; pat[idx]; idx++) {
+		if (pat[idx] == '(') {
+			size_t depth = 0;
+
+			for (size_t j = idx; pat[j]; j++) {
+				if (pat[j] == '(') {
+					depth++;
+				} else if (pat[j] == ')') {
+					depth--;
+					if (depth == 0)
+						return expand_paren_group(pat, idx,
+									  j, out);
+				}
+			}
+		} else if (pat[idx] == '[') {
+			const char *close_p = strchr(pat + idx + 1, ']');
+
+			if (close_p)
+				return expand_bracket_group(pat, idx, close_p, out);
+		}
+	}
+	return export_str_vec__add(out, pat);
+}
+
+static bool replace_substr_all(const char *src, const char *needle,
+			       const char *repl, char *dst, size_t dst_size)
+{
+	size_t nlen = strlen(needle), rlen = strlen(repl), out_pos = 0;
+	const char *p = src;
+
+	while (*p) {
+		const char *hit = strstr(p, needle);
+
+		if (!hit) {
+			size_t tail = strlen(p);
+
+			if (out_pos + tail >= dst_size)
+				return false;
+			memcpy(dst + out_pos, p, tail + 1);
+			return true;
+		}
+		if (out_pos + (size_t)(hit - p) + rlen >= dst_size)
+			return false;
+		memcpy(dst + out_pos, p, (size_t)(hit - p));
+		out_pos += (size_t)(hit - p);
+		memcpy(dst + out_pos, repl, rlen);
+		out_pos += rlen;
+		p = hit + nlen;
+	}
+	if (out_pos >= dst_size)
+		return false;
+	dst[out_pos] = '\0';
+	return true;
+}
+
+static int expand_cpuid_pattern(const char *arch, const char *pattern,
+				struct export_str_vec *out)
+{
+	struct export_str_vec tmp = {};
+	char work[256], pat_buf[256];
+	int ret = 0;
+
+	if (!arch || !pattern || !pattern[0])
+		return 0;
+
+	if (!strcmp(arch, "s390")) {
+		size_t flen = 0;
+
+		if (strncmp(pattern, "^IBM.", 5) != 0)
+			return 0;
+		while (pattern[5 + flen] && pattern[5 + flen] != '.' &&
+		       pattern[5 + flen] != '*')
+			flen++;
+		if (flen == 0 || flen >= sizeof(work))
+			return 0;
+		memcpy(work, pattern + 5, flen);
+		work[flen] = '\0';
+		ret = expand_regex_fragment(work, &tmp);
+		for (size_t i = 0; !ret && i < tmp.nr; i++) {
+			if (!strchr(tmp.items[i], '/'))
+				ret = export_str_vec__add_concat3(
+					out, "IBM,", 4,
+					tmp.items[i], strlen(tmp.items[i]),
+					"", 0);
+		}
+		export_str_vec__clear(&tmp);
+		return ret;
+	}
+
+	if (!strcmp(arch, "powerpc")) {
+		if (!replace_substr_all(pattern, "[[:xdigit:]]{4}", "0000",
+					pat_buf, sizeof(pat_buf)))
+			return 0;
+		ret = expand_regex_fragment(pat_buf, &tmp);
+	} else {
+		const char *xdigit_cls = !strcmp(arch, "x86") ? "[0-9A-F]" : "[0-9a-f]";
+		const char *opt_xdigit = !strcmp(arch, "x86") ? "([0-9A-F]|)" : "([0-9a-f]|)";
+		size_t plen = strlen(pattern);
+
+		if (plen >= sizeof(work))
+			return 0;
+		memcpy(work, pattern, plen + 1);
+
+		if (plen >= 14 && !strcmp(work + plen - 14, "-[[:xdigit:]]+")) {
+			work[plen - 14] = '\0';
+		} else if (plen >= 16 && !strcmp(work + plen - 16, "-0x[[:xdigit:]]+")) {
+			work[plen - 16] = '\0';
+		} else if (plen >= 13 && !strcmp(work + plen - 13, "[[:xdigit:]]+")) {
+			if (plen - 13 + strlen(opt_xdigit) >= sizeof(work))
+				return 0;
+			strcpy(work + plen - 13, opt_xdigit);
+		}
+
+		if (!replace_substr_all(work, "[[:xdigit:]]", xdigit_cls,
+					pat_buf, sizeof(pat_buf)))
+			return 0;
+		ret = expand_regex_fragment(pat_buf, &tmp);
+	}
+
+	for (size_t i = 0; !ret && i < tmp.nr; i++) {
+		if (!strchr(tmp.items[i], '/'))
+			ret = export_str_vec__add(out, tmp.items[i]);
+	}
+	export_str_vec__clear(&tmp);
+	return ret;
+}
+
+static bool is_literal_compat(const char *compat)
+{
+	if (!compat || !compat[0] || strchr(compat, '/'))
+		return false;
+	return strpbrk(compat, "*+?[]()|^$\\") == NULL;
+}
+
+static bool is_known_core_pmu_glob(const char *glob)
+{
+	return !strcmp(glob, "cpu") || !strcmp(glob, "cpum_cf") ||
+	       !strcmp(glob, "default_core") || !strncmp(glob, "armv8_pmuv3", 11);
+}
+
+static bool export_cpuid_pmu_matches(const char *eff_pmu, const char *pmu_glob)
+{
+	if (!pmu_glob)
+		return true;
+	if (strglobmatch(eff_pmu, pmu_glob))
+		return true;
+	if (!strcmp(eff_pmu, "default_core") && is_known_core_pmu_glob(pmu_glob))
+		return true;
+	return false;
+}
+
+static int ensure_rel_symlink(const char *root_dir, const char *subdir,
+			      const char *link_name, const char *arch,
+			      const char *model)
+{
+	char target_dir[PATH_MAX], sub_path[PATH_MAX], link_path[PATH_MAX];
+	char rel_target[PATH_MAX];
+	struct stat st;
+	int n, ret;
+
+	if (!link_name || !link_name[0] || strchr(link_name, '/'))
+		return 0;
+
+	n = snprintf(target_dir, sizeof(target_dir), "%s/models/%s/%s",
+		     root_dir, arch, model);
+	if (n < 0 || (size_t)n >= sizeof(target_dir))
+		return -ENAMETOOLONG;
+	if (stat(target_dir, &st) < 0 || !S_ISDIR(st.st_mode))
+		return 0;
+
+	n = snprintf(sub_path, sizeof(sub_path), "%s/%s", root_dir, subdir);
+	if (n < 0 || (size_t)n >= sizeof(sub_path))
+		return -ENAMETOOLONG;
+
+	n = snprintf(link_path, sizeof(link_path), "%s/%s", sub_path, link_name);
+	if (n < 0 || (size_t)n >= sizeof(link_path))
+		return -ENAMETOOLONG;
+	if (lstat(link_path, &st) == 0)
+		return 0;
+
+	ret = pmu_layer__mkdir_p(sub_path);
+	if (ret < 0)
+		return ret;
+
+	n = snprintf(rel_target, sizeof(rel_target), "../models/%s/%s", arch, model);
+	if (n < 0 || (size_t)n >= sizeof(rel_target))
+		return -ENAMETOOLONG;
+
+	if (symlink(rel_target, link_path) < 0 && errno != EEXIST)
+		return -errno;
+	return 0;
+}
+
+static int export_builtin_pe_to_dir(const char *target_root,
+				    const struct pmu_event *pe)
+{
+	const char *eff_pmu = (pe->pmu && pe->pmu[0]) ? pe->pmu : "default_core";
+	struct perf_pmu_alias *alias;
+	char dir_path[PATH_MAX];
+	char enc_name[NAME_MAX];
+	int fd, n, ret;
+
+	if (!pe->name || !pe->event)
+		return 0;
+	if (pmu_layer__encode_filename(pe->name, enc_name, sizeof(enc_name)) != 0)
+		return 0;
+
+	alias = pmu_layer_alloc_alias(pe->name);
+	if (!alias)
+		return -ENOMEM;
+
+	ret = pmu_layer_merge_pe(alias, pe, /*is_common=*/false);
+	if (ret) {
+		perf_pmu_free_alias(alias);
+		return ret;
+	}
+
+	n = snprintf(dir_path, sizeof(dir_path), "%s/%s/events", target_root, eff_pmu);
+	if (n < 0 || (size_t)n >= sizeof(dir_path)) {
+		perf_pmu_free_alias(alias);
+		return -ENAMETOOLONG;
+	}
+
+	ret = pmu_layer__mkdir_p(dir_path);
+	if (ret == 0) {
+		fd = open(dir_path, O_RDONLY | O_DIRECTORY);
+		if (fd < 0) {
+			ret = -errno;
+		} else {
+			ret = export_write_alias_files(fd, enc_name, alias);
+			close(fd);
+		}
+	}
+	perf_pmu_free_alias(alias);
+	return ret;
+}
+
+static int export_builtin_pm_to_dir(const char *target_root,
+				    const struct pmu_metric *pm)
+{
+	const char *eff_pmu = (pm->pmu && pm->pmu[0]) ? pm->pmu : "default_core";
+	char dir_path[PATH_MAX];
+	char enc_name[NAME_MAX];
+	int fd, n, ret;
+
+	if (!pm->metric_name || !pm->metric_expr)
+		return 0;
+	if (pmu_layer__encode_filename(pm->metric_name, enc_name, sizeof(enc_name)) != 0)
+		return 0;
+
+	n = snprintf(dir_path, sizeof(dir_path), "%s/%s/metrics", target_root, eff_pmu);
+	if (n < 0 || (size_t)n >= sizeof(dir_path))
+		return -ENAMETOOLONG;
+
+	ret = pmu_layer__mkdir_p(dir_path);
+	if (ret < 0)
+		return ret;
+
+	fd = open(dir_path, O_RDONLY | O_DIRECTORY);
+	if (fd < 0)
+		return -errno;
 
+	ret = export_write_pm_files(fd, enc_name, pm, true, true,
+				    pm->default_show_events, true);
 	close(fd);
 	return ret;
 }
+
+struct export_compat_entry {
+	char *compat;
+	const char *arch;
+	const char *model;
+	bool ambiguous;
+};
+
+struct export_table_walk_ctx {
+	const char *root_dir;
+	const char *target_root;
+	const char *arch;
+	const char *model;
+	const struct pmu_layer_export_opts *opts;
+	bool is_sys;
+	struct export_compat_entry **compats;
+	size_t *nr_compats;
+	size_t *cap_compats;
+};
+
+static int record_sys_compat(struct export_table_walk_ctx *ctx, const char *compat)
+{
+	struct export_compat_entry *arr;
+
+	if (!ctx->is_sys || !is_literal_compat(compat))
+		return 0;
+
+	arr = *ctx->compats;
+	for (size_t i = 0; i < *ctx->nr_compats; i++) {
+		if (!strcmp(arr[i].compat, compat)) {
+			if (strcmp(arr[i].arch, ctx->arch) != 0 ||
+			    strcmp(arr[i].model, ctx->model) != 0)
+				arr[i].ambiguous = true;
+			return 0;
+		}
+	}
+	if (*ctx->nr_compats == *ctx->cap_compats) {
+		size_t new_cap = *ctx->cap_compats ? *ctx->cap_compats * 2 : 16;
+		struct export_compat_entry *new_arr =
+			realloc(arr, new_cap * sizeof(*new_arr));
+
+		if (!new_arr)
+			return -ENOMEM;
+		*ctx->compats = new_arr;
+		*ctx->cap_compats = new_cap;
+		arr = new_arr;
+	}
+	arr[*ctx->nr_compats].compat = strdup(compat);
+	if (!arr[*ctx->nr_compats].compat)
+		return -ENOMEM;
+	arr[*ctx->nr_compats].arch = ctx->arch;
+	arr[*ctx->nr_compats].model = ctx->model;
+	arr[*ctx->nr_compats].ambiguous = false;
+	(*ctx->nr_compats)++;
+	return 0;
+}
+
+static int export_cpuid_event_cb(const struct pmu_event *pe,
+				 const struct pmu_events_table *table __maybe_unused,
+				 void *vdata)
+{
+	struct export_table_walk_ctx *ctx = vdata;
+	const char *eff_pmu = (pe->pmu && pe->pmu[0]) ? pe->pmu : "default_core";
+	int ret;
+
+	if (!pe->name || !pe->event)
+		return 0;
+	if (pe->deprecated && !ctx->opts->deprecated)
+		return 0;
+	if (ctx->opts->exclude_abi && !strcmp(eff_pmu, "software"))
+		return 0;
+	if (!export_cpuid_pmu_matches(eff_pmu, ctx->opts->pmu_glob))
+		return 0;
+	if (ctx->opts->event_glob &&
+	    !strglobmatch(pe->name, ctx->opts->event_glob) &&
+	    (!pe->topic || !strglobmatch_nocase(pe->topic, ctx->opts->event_glob)))
+		return 0;
+
+	ret = export_builtin_pe_to_dir(ctx->target_root, pe);
+	if (ret)
+		return ret;
+	return record_sys_compat(ctx, pe->compat);
+}
+
+static bool metric_groups_match_glob(const char *groups, const char *glob)
+{
+	const char *p = groups;
+
+	if (!groups || !glob)
+		return false;
+
+	while (*p) {
+		const char *semi = strchr(p, ';');
+		size_t len = semi ? (size_t)(semi - p) : strlen(p);
+		char gbuf[NAME_MAX];
+
+		while (len > 0 && isspace((unsigned char)*p)) {
+			p++;
+			len--;
+		}
+		while (len > 0 && isspace((unsigned char)p[len - 1]))
+			len--;
+
+		if (len > 0 && len < sizeof(gbuf)) {
+			memcpy(gbuf, p, len);
+			gbuf[len] = '\0';
+			if (strglobmatch(gbuf, glob))
+				return true;
+		}
+		if (!semi)
+			break;
+		p = semi + 1;
+	}
+	return false;
+}
+
+static int export_metric_groups_for_pm(struct export_table_walk_ctx *ctx,
+				       const struct pmu_metric *pm)
+{
+	const char *p = pm->metric_group;
+
+	if (!p || !p[0])
+		return 0;
+
+	while (*p) {
+		const char *semi = strchr(p, ';');
+		size_t len = semi ? (size_t)(semi - p) : strlen(p);
+		char gbuf[NAME_MAX];
+
+		while (len > 0 && isspace((unsigned char)*p)) {
+			p++;
+			len--;
+		}
+		while (len > 0 && isspace((unsigned char)p[len - 1]))
+			len--;
+
+		if (len > 0 && len < sizeof(gbuf)) {
+			const char *gdesc;
+			int ret;
+
+			memcpy(gbuf, p, len);
+			gbuf[len] = '\0';
+			if (!ctx->opts->event_glob ||
+			    (ctx->opts->metrics && pm->metric_name &&
+			     strglobmatch(pm->metric_name, ctx->opts->event_glob)) ||
+			    strglobmatch(gbuf, ctx->opts->event_glob)) {
+				gdesc = describe_metricgroup(gbuf);
+				ret = pmu_layer__export_metricgroup(ctx->target_root,
+								    gbuf, gdesc);
+				if (ret)
+					return ret;
+				if (strcmp(ctx->target_root, ctx->root_dir) != 0) {
+					ret = pmu_layer__export_metricgroup(
+						ctx->root_dir, gbuf, gdesc);
+					if (ret)
+						return ret;
+				}
+			}
+		}
+		if (!semi)
+			break;
+		p = semi + 1;
+	}
+	return 0;
+}
+
+static int export_cpuid_metric_cb(const struct pmu_metric *pm,
+				  const struct pmu_metrics_table *table __maybe_unused,
+				  void *vdata)
+{
+	struct export_table_walk_ctx *ctx = vdata;
+	const char *eff_pmu = (pm->pmu && pm->pmu[0]) ? pm->pmu : "default_core";
+	int ret;
+
+	if (!pm->metric_name || !pm->metric_expr)
+		return 0;
+	if (!export_cpuid_pmu_matches(eff_pmu, ctx->opts->pmu_glob))
+		return 0;
+	if (ctx->opts->event_glob &&
+	    (!ctx->opts->metrics || !strglobmatch(pm->metric_name, ctx->opts->event_glob)) &&
+	    (!ctx->opts->metricgroups || !metric_groups_match_glob(pm->metric_group,
+								   ctx->opts->event_glob)))
+		return 0;
+
+	if (ctx->opts->metricgroups) {
+		ret = export_metric_groups_for_pm(ctx, pm);
+		if (ret)
+			return ret;
+	}
+	if (!ctx->opts->metrics)
+		return 0;
+
+	ret = export_builtin_pm_to_dir(ctx->target_root, pm);
+	if (ret)
+		return ret;
+	return record_sys_compat(ctx, pm->compat);
+}
+
+struct export_map_row {
+	const char *arch;
+	const char *cpuid;
+	const char *model;
+	const struct pmu_events_table *events_table;
+	const struct pmu_metrics_table *metrics_table;
+	struct export_str_vec cpuids;
+	bool selected;
+};
+
+struct export_sys_row {
+	const char *arch;
+	const char *model;
+	const struct pmu_events_table *events_table;
+	const struct pmu_metrics_table *metrics_table;
+	bool selected;
+};
+
+struct collect_rows_ctx {
+	struct export_map_row *map_rows;
+	size_t nr_map_rows;
+	size_t cap_map_rows;
+	struct export_sys_row *sys_rows;
+	size_t nr_sys_rows;
+	size_t cap_sys_rows;
+};
+
+static int collect_map_row_cb(const char *arch, const char *cpuid,
+			      const char *model,
+			      const struct pmu_events_table *events_table,
+			      const struct pmu_metrics_table *metrics_table,
+			      void *vdata)
+{
+	struct collect_rows_ctx *ctx = vdata;
+
+	if (ctx->nr_map_rows == ctx->cap_map_rows) {
+		size_t new_cap = ctx->cap_map_rows ? ctx->cap_map_rows * 2 : 32;
+		struct export_map_row *new_arr =
+			realloc(ctx->map_rows, new_cap * sizeof(*new_arr));
+
+		if (!new_arr)
+			return -ENOMEM;
+		ctx->map_rows = new_arr;
+		ctx->cap_map_rows = new_cap;
+	}
+	ctx->map_rows[ctx->nr_map_rows++] = (struct export_map_row){
+		.arch = arch,
+		.cpuid = cpuid,
+		.model = model,
+		.events_table = events_table,
+		.metrics_table = metrics_table,
+	};
+	return 0;
+}
+
+static int collect_sys_row_cb(const char *arch, const char *model,
+			      const struct pmu_events_table *events_table,
+			      const struct pmu_metrics_table *metrics_table,
+			      void *vdata)
+{
+	struct collect_rows_ctx *ctx = vdata;
+
+	if (ctx->nr_sys_rows == ctx->cap_sys_rows) {
+		size_t new_cap = ctx->cap_sys_rows ? ctx->cap_sys_rows * 2 : 16;
+		struct export_sys_row *new_arr =
+			realloc(ctx->sys_rows, new_cap * sizeof(*new_arr));
+
+		if (!new_arr)
+			return -ENOMEM;
+		ctx->sys_rows = new_arr;
+		ctx->cap_sys_rows = new_cap;
+	}
+	ctx->sys_rows[ctx->nr_sys_rows++] = (struct export_sys_row){
+		.arch = arch,
+		.model = model,
+		.events_table = events_table,
+		.metrics_table = metrics_table,
+	};
+	return 0;
+}
+
+struct sys_compat_match_ctx {
+	const char *selector;
+	bool matched;
+};
+
+static int check_sys_event_compat_cb(const struct pmu_event *pe,
+				     const struct pmu_events_table *table __maybe_unused,
+				     void *vdata)
+{
+	struct sys_compat_match_ctx *ctx = vdata;
+
+	if (pe->compat && is_literal_compat(pe->compat) &&
+	    strglobmatch(pe->compat, ctx->selector)) {
+		ctx->matched = true;
+		return 1;
+	}
+	return 0;
+}
+
+static int check_sys_metric_compat_cb(const struct pmu_metric *pm,
+				      const struct pmu_metrics_table *table __maybe_unused,
+				      void *vdata)
+{
+	struct sys_compat_match_ctx *ctx = vdata;
+
+	if (pm->compat && is_literal_compat(pm->compat) &&
+	    strglobmatch(pm->compat, ctx->selector)) {
+		ctx->matched = true;
+		return 1;
+	}
+	return 0;
+}
+
+static bool arch_or_model_matches(const char *arch, const char *model,
+				  const char *selector)
+{
+	char full_model[256];
+
+	if (!arch || !model)
+		return false;
+	if (!strcmp(arch, selector) ||
+	    (!strcmp(selector, "test") && !strcmp(arch, "testarch")))
+		return true;
+	if (!strcmp(arch, "common"))
+		return !strcmp(selector, "common/common");
+
+	snprintf(full_model, sizeof(full_model), "%s/%s", arch, model);
+	return strglobmatch(full_model, selector) || strglobmatch(model, selector);
+}
+
+static bool row_cpuids_match_cand(const struct export_str_vec *cpuids,
+				  const char *cand)
+{
+	for (size_t j = 0; j < cpuids->nr; j++) {
+		if (strglobmatch(cpuids->items[j], cand))
+			return true;
+	}
+	return false;
+}
+
+int pmu_layer__export_cpuid(const char *root_dir, const char *selector,
+			    const struct pmu_layer_export_opts *opts)
+{
+	struct collect_rows_ctx rows = {};
+	struct export_str_vec exported_models = {};
+	struct export_compat_entry *compats = NULL;
+	size_t nr_compats = 0, cap_compats = 0;
+	bool any_selected = false;
+	int ret;
+
+	if (!root_dir || !root_dir[0] || !selector || !selector[0] || !opts)
+		return -EINVAL;
+
+	ret = pmu_events_map__for_each(collect_map_row_cb, &rows);
+	if (ret)
+		goto out;
+	ret = pmu_sys_events__for_each(collect_sys_row_cb, &rows);
+	if (ret)
+		goto out;
+
+	for (size_t i = 0; i < rows.nr_map_rows; i++) {
+		struct export_map_row *r = &rows.map_rows[i];
+
+		if (r->arch && strcmp(r->arch, "common") != 0) {
+			ret = expand_cpuid_pattern(r->arch, r->cpuid, &r->cpuids);
+			if (ret)
+				goto out;
+		}
+	}
+
+	if (!strcmp(selector, "all")) {
+		for (size_t i = 0; i < rows.nr_map_rows; i++)
+			rows.map_rows[i].selected = true;
+		for (size_t i = 0; i < rows.nr_sys_rows; i++)
+			rows.sys_rows[i].selected = true;
+		any_selected = rows.nr_map_rows > 0 || rows.nr_sys_rows > 0;
+	} else {
+		for (size_t i = 0; i < rows.nr_map_rows; i++) {
+			struct export_map_row *r = &rows.map_rows[i];
+
+			if (arch_or_model_matches(r->arch, r->model, selector)) {
+				r->selected = true;
+				any_selected = true;
+			}
+		}
+		for (size_t i = 0; i < rows.nr_sys_rows; i++) {
+			struct export_sys_row *r = &rows.sys_rows[i];
+
+			if (arch_or_model_matches(r->arch, r->model, selector)) {
+				r->selected = true;
+				any_selected = true;
+			}
+		}
+
+		if (!any_selected) {
+			char cands[6][128];
+			size_t nr_cands = build_cpuid_candidates(selector, cands,
+								 ARRAY_SIZE(cands));
+
+			for (size_t c = 0; c < nr_cands && !any_selected; c++) {
+				for (size_t i = 0; i < rows.nr_map_rows; i++) {
+					struct export_map_row *r = &rows.map_rows[i];
+
+					if (row_cpuids_match_cand(&r->cpuids, cands[c])) {
+						r->selected = true;
+						any_selected = true;
+					}
+				}
+			}
+
+			for (size_t i = 0; i < rows.nr_sys_rows; i++) {
+				struct export_sys_row *r = &rows.sys_rows[i];
+				struct sys_compat_match_ctx mctx = {
+					.selector = selector,
+				};
+
+				if (r->events_table)
+					pmu_events_table__for_each_event(
+						r->events_table, NULL,
+						check_sys_event_compat_cb, &mctx);
+				if (!mctx.matched && r->metrics_table)
+					pmu_metrics_table__for_each_metric(
+						r->metrics_table,
+						check_sys_metric_compat_cb, &mctx);
+				if (mctx.matched) {
+					r->selected = true;
+					any_selected = true;
+				}
+			}
+		}
+	}
+
+	if (!any_selected) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	ret = pmu_layer__mkdir_p(root_dir);
+	if (ret)
+		goto out;
+
+	for (size_t i = 0; i < rows.nr_map_rows; i++) {
+		struct export_map_row *r = &rows.map_rows[i];
+		char target_root[PATH_MAX];
+		char model_key[256];
+
+		if (!r->selected)
+			continue;
+
+		if (!strcmp(r->arch, "common")) {
+			snprintf(target_root, sizeof(target_root), "%s", root_dir);
+			snprintf(model_key, sizeof(model_key), "common");
+		} else {
+			int n = snprintf(target_root, sizeof(target_root),
+					 "%s/models/%s/%s",
+					 root_dir, r->arch, r->model);
+
+			if (n < 0 || (size_t)n >= sizeof(target_root)) {
+				ret = -ENAMETOOLONG;
+				goto out;
+			}
+			snprintf(model_key, sizeof(model_key), "%s/%s",
+				 r->arch, r->model);
+		}
+
+		if (!export_str_vec__contains(&exported_models, model_key)) {
+			struct export_table_walk_ctx wctx = {
+				.root_dir = root_dir,
+				.target_root = target_root,
+				.arch = r->arch,
+				.model = r->model,
+				.opts = opts,
+				.is_sys = false,
+				.compats = &compats,
+				.nr_compats = &nr_compats,
+				.cap_compats = &cap_compats,
+			};
+
+			ret = export_str_vec__add(&exported_models, model_key);
+			if (ret)
+				goto out;
+			if (opts->events && r->events_table) {
+				ret = pmu_events_table__for_each_event(
+					r->events_table, NULL,
+					export_cpuid_event_cb, &wctx);
+				if (ret)
+					goto out;
+			}
+			if ((opts->metrics || opts->metricgroups) && r->metrics_table) {
+				ret = pmu_metrics_table__for_each_metric(
+					r->metrics_table,
+					export_cpuid_metric_cb, &wctx);
+				if (ret)
+					goto out;
+			}
+		}
+
+		if (strcmp(r->arch, "common") != 0) {
+			for (size_t j = 0; j < r->cpuids.nr; j++) {
+				ret = ensure_rel_symlink(root_dir, "cpus",
+							 r->cpuids.items[j],
+							 r->arch, r->model);
+				if (ret)
+					goto out;
+			}
+		}
+	}
+
+	for (size_t i = 0; i < rows.nr_sys_rows; i++) {
+		struct export_sys_row *r = &rows.sys_rows[i];
+		char target_root[PATH_MAX];
+		char model_key[256];
+		struct export_table_walk_ctx wctx;
+		int n;
+
+		if (!r->selected)
+			continue;
+
+		n = snprintf(target_root, sizeof(target_root), "%s/models/%s/%s",
+			     root_dir, r->arch, r->model);
+		if (n < 0 || (size_t)n >= sizeof(target_root)) {
+			ret = -ENAMETOOLONG;
+			goto out;
+		}
+		snprintf(model_key, sizeof(model_key), "sys:%s/%s", r->arch, r->model);
+		if (export_str_vec__contains(&exported_models, model_key))
+			continue;
+
+		ret = export_str_vec__add(&exported_models, model_key);
+		if (ret)
+			goto out;
+
+		wctx = (struct export_table_walk_ctx){
+			.root_dir = root_dir,
+			.target_root = target_root,
+			.arch = r->arch,
+			.model = r->model,
+			.opts = opts,
+			.is_sys = true,
+			.compats = &compats,
+			.nr_compats = &nr_compats,
+			.cap_compats = &cap_compats,
+		};
+		if (opts->events && r->events_table) {
+			ret = pmu_events_table__for_each_event(
+				r->events_table, NULL,
+				export_cpuid_event_cb, &wctx);
+			if (ret)
+				goto out;
+		}
+		if ((opts->metrics || opts->metricgroups) && r->metrics_table) {
+			ret = pmu_metrics_table__for_each_metric(
+				r->metrics_table,
+				export_cpuid_metric_cb, &wctx);
+			if (ret)
+				goto out;
+		}
+	}
+
+	for (size_t i = 0; i < nr_compats; i++) {
+		if (compats[i].ambiguous)
+			continue;
+		ret = ensure_rel_symlink(root_dir, "sys", compats[i].compat,
+					 compats[i].arch, compats[i].model);
+		if (ret)
+			goto out;
+	}
+
+out:
+	for (size_t i = 0; i < rows.nr_map_rows; i++)
+		export_str_vec__clear(&rows.map_rows[i].cpuids);
+	free(rows.map_rows);
+	free(rows.sys_rows);
+	export_str_vec__clear(&exported_models);
+	for (size_t i = 0; i < nr_compats; i++)
+		free(compats[i].compat);
+	free(compats);
+	return ret;
+}
diff --git a/tools/perf/util/pmu-layer.h b/tools/perf/util/pmu-layer.h
index 183bed9cc10e..df32acdb1b63 100644
--- a/tools/perf/util/pmu-layer.h
+++ b/tools/perf/util/pmu-layer.h
@@ -173,6 +173,16 @@ int pmu_layer__load_metrics(struct perf_pmu *pmu);
 const char *pmu_layer__describe_metricgroup(struct perf_pmu *pmu,
 					    const char *group);
 
+struct pmu_layer_export_opts {
+	const char *pmu_glob;
+	const char *event_glob;
+	bool events;
+	bool metrics;
+	bool metricgroups;
+	bool deprecated;
+	bool exclude_abi;
+};
+
 int pmu_layer__mkdir_p(const char *path);
 int pmu_layer__export_event(const char *root_dir, const char *pmu_name,
 			    const char *event_name);
@@ -183,5 +193,7 @@ int pmu_layer__export_metric(const char *root_dir, const char *eff_pmu,
 			     const char *desc, const char *long_desc,
 			     const char *expr, const char *threshold,
 			     const char *unit);
+int pmu_layer__export_cpuid(const char *root_dir, const char *selector,
+			    const struct pmu_layer_export_opts *opts);
 
 #endif /* __PMU_LAYER_H */
-- 
2.56.1.703.gf848ed807c-goog

