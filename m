Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212877;
	b=E2+dh1q0WfIE8NYS2ZsAc+zIYWr1g15XQHnu5Y1iC2fhKoFg4dML7R8n+UK5ntSD51bv
	 60CmOghCysX80sctZZ4A8aDhy4cpfe6GXs77kTpTzMCfyZLJHEVcd07heIFEBvTNokxu3
	 Q8ley59/TTlYXpOkhBTo0ydK052p01abOAq7rhkHZWnCDtY/nDWC/vai/5eOAHVbzZ6H4
	 YoJGM4ajtBzk3VnrGQz4yE1a/a74KMlf2Flo9RQJY24eYojbNCoRqXjfoEbvmPxRA2lL4
	 5ShAK3Vz1zy/ITNyy857FH4T6L+i+u0HFYodL/ePQ7FX6YI/BvWMxJLzIq8YWAd5e2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=id0a/mzGN50ic2k00/n8hpihWo/9QDdq+HMV733fdTc=;
	b=IKVR6mzCC+NkBgXs8W9X+2FkzN6wNVTsj4co6bFXgbqe95sy9AXXuEILdbBaWhztkToz
	 uBxirUnnDLbuelNlQknM+6BmIQsCeBxxIZfaXIstpmUPp40Fv78sKfwKYbo7ZrIu0UwCw
	 3CBWCwtxcdEO8Se3hYJ0ebRHDqvbIOf/iWBA9jw8ecknt0rJEHhoKssw4WKGJf1umfD+2
	 zzhSky8IMqjfYIYpREA0oRhkXyqdwYFWQgJQRgSSX18J7RFgDtHN1lB0xsZY+8gMkFFLM
	 wnp7d2uL2k0ZDWsE3SBoi8olh7ORj9FeRiiSI96IVA9m45aNgkyeU6I9pbRpJVRMXdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NCE5mPUm;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD04606A6AC
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BD04606A6AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NCE5mPUm
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-383ec96a7deso1544200eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795212872; x=1795817672; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=id0a/mzGN50ic2k00/n8hpihWo/9QDdq+HMV733fdTc=;
        b=NCE5mPUmYAlTk2Y3M+ju45dppk9LrZGfIbDJG3J0yTc+ZoXV15FqdhLChIOTGI3Cqa
         86v1Wbaj8EVTsjkFkzcQ1/ax3cLaCUJUcWyP6vbhPjouTEnArXGXYB4oTH34sIx5HkNq
         77vC9+ephkh3cdZkdtNYYP/R6a2O1+aQbA445p9dVRVYhInTvZbcW8Zps53BE8YIlmOD
         MNHxwzFVcPTjzuSqSQSMJKM4mZAM/CDMBd1dF6Y30Mp6f6459ybabB2cG2LQaoNYeB+w
         buLaZHMMarE6hSCDbVwxUN09CL7GWEnRbFvxUHPWo/10Vop4ZopJIkhQQwSxkr4L6keH
         919Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212872; x=1795817672;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=id0a/mzGN50ic2k00/n8hpihWo/9QDdq+HMV733fdTc=;
        b=jhXw7dVaLWhzkes7TuE5qMaqerRkpeQuayujkRyXniWxlDxG+zcX1doWax27D1bSjV
         nbYflhuR9YNhBClTFXkHfYlokqegpu1aZnWFv78FYjmmtceVgOATwtPFn5P4H9ZtvDWJ
         z0vmMkpBsDUpenh+wMb8GTwbCh2db5SWRvpG7OwWT7WobNT2ezbZD1p3yQXIXwAIk0C/
         9+a8VirLSwuWk3rv3aXSSKXNpTUWaLQU18f574dIGuIs+ZYv98K07abHRQWF8kiV4R6J
         /bzdfuJ0Pl16BDJ13gBLWsfvFquWcwsmKHWbjLqGEhPL5XSHrbA+QkfWggFFK6CHX3FU
         CLPA==
X-Gm-Message-State: APuU4Z9R2ILpJGhareWcDg9jJK4BJpcpzRdxERtGGHVIaZJ29ubb6EFz
	Zm+vX8l02wy+0x0XHTYhh344EqHyuFx1WoRRJ2tPv7Lmbju41sdmZ2PLX921zqk9lp6AlIaiZcA
	cWe6VeylcQw==
X-Received: from dyee6.prod.google.com ([2002:a05:693c:6286:b0:386:6850:930a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:50fa:b0:384:6487:b155
 with SMTP id 5a478bee46e88-38570c359d3mr4897009eec.29.1795212872032; Fri, 20
 Nov 2026 14:14:32 -0800 (PST)
Date: Fri, 20 Nov 2026 14:13:12 -0800
In-Reply-To: <20261120221332.2245191-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120221332.2245191-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120221332.2245191-12-irogers@google.com>
Subject: [PATCH v3 11/30] perf pmu-events: Add e_machine to struct pmu_events_map
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The CPUID strings in the pmu-events mapfile.csv files have an
architecture specific format, such as "GenuineIntel-6-55-[56789ABCDEF]"
on x86 or a MIDR value like "0x00000000410fd0c0" on arm64. When perf is
built with JEVENTS_ARCH=all the tables of every architecture are
present and map_for_cpu() compared the host's CPUID against all of
them, even though only the host architecture's tables can match.

Record the ELF machine of each architecture's CPUIDs in struct
pmu_events_map, EM_NONE for the test and common tables, and have
map_for_cpu() only consider tables for the host's ELF machine. The 32
and 64-bit variants of x86 and PowerPC share tables.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 24 +++++++++++++++-
 tools/perf/pmu-events/jevents.py         | 35 +++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 7df1552403e7..7428ffd4d70c 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -4,6 +4,8 @@
 #include <pmu-events/pmu-events.h>
 #include "util/header.h"
 #include "util/pmu.h"
+#include <dwarf-regs.h>
+#include <elf.h>
 #include <string.h>
 #include <stddef.h>
 
@@ -5419,6 +5421,8 @@ struct pmu_metrics_table {
 struct pmu_events_map {
 	const char *arch;
 	const char *cpuid;
+	/* The ELF machine of the architecture's CPUIDs, EM_NONE for test and common. */
+	uint16_t e_machine;
 	struct pmu_events_table event_table;
 	struct pmu_metrics_table metric_table;
 };
@@ -5431,6 +5435,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 {
 	.arch = "common",
 	.cpuid = "common",
+	.e_machine = EM_NONE,
 	.event_table = {
 		.pmus = pmu_events__common,
 		.num_pmus = ARRAY_SIZE(pmu_events__common),
@@ -5444,6 +5449,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 {
 	.arch = "testarch",
 	.cpuid = "testcpu",
+	.e_machine = EM_NONE,
 	.event_table = {
 		.pmus = pmu_events__test_soc_cpu,
 		.num_pmus = ARRAY_SIZE(pmu_events__test_soc_cpu),
@@ -5457,6 +5463,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 {
 	.arch = 0,
 	.cpuid = 0,
+	.e_machine = EM_NONE,
 	.event_table = { 0, 0 },
 	.metric_table = { 0 },
 }
@@ -5769,6 +5776,20 @@ int pmu_metrics_table__find_metric(const struct pmu_metrics_table *table,
 	return PMU_METRICS__NOT_FOUND;
 }
 
+/*
+ * Is the map for the architecture of @e_machine? The 32 and 64-bit variants of
+ * an architecture share tables.
+ */
+static bool pmu_events_map__e_machine_matches(const struct pmu_events_map *map,
+					      uint16_t e_machine)
+{
+	if (e_machine == EM_386)
+		e_machine = EM_X86_64;
+	else if (e_machine == EM_PPC)
+		e_machine = EM_PPC64;
+	return map->e_machine == e_machine;
+}
+
 static const struct pmu_events_map *map_for_cpu(struct perf_cpu cpu)
 {
 	static struct {
@@ -5809,7 +5830,8 @@ static const struct pmu_events_map *map_for_cpu(struct perf_cpu cpu)
 				break;
 			}
 
-			if (!strcmp_cpuid_str(map->cpuid, cpuid))
+			if (pmu_events_map__e_machine_matches(map, EM_HOST) &&
+			    !strcmp_cpuid_str(map->cpuid, cpuid))
 				break;
 		}
 		free(last_map_search.cpuid);
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 080e04b51b8c..db1b4749aec3 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -26,6 +26,15 @@ _sys_event_table_to_metric_table_mapping: Dict[str, str] = {}
 # JsonEvent. Architecture standard events are in json files in the top
 # f'{_args.starting_dir}/{_args.arch}' directory.
 _arch_std_events: Dict[str, "JsonEvent"] = {}
+# The ELF machine of the CPUIDs in each architecture's mapfile.csv.
+_arch_e_machine: Dict[str, str] = {
+    'arm64': 'EM_AARCH64',
+    'nds32': 'EM_NDS32',
+    'powerpc': 'EM_PPC64',
+    'riscv': 'EM_RISCV',
+    's390': 'EM_S390',
+    'x86': 'EM_X86_64',
+}
 # Events to write out when the table is closed
 _pending_events: list["JsonEvent"] = []
 # Name of events table to be written out
@@ -730,6 +739,8 @@ struct pmu_metrics_table {
 struct pmu_events_map {
 \tconst char *arch;
 \tconst char *cpuid;
+\t/* The ELF machine of the architecture's CPUIDs, EM_NONE for test and common. */
+\tuint16_t e_machine;
 \tstruct pmu_events_table event_table;
 \tstruct pmu_metrics_table metric_table;
 };
@@ -745,6 +756,7 @@ static const struct pmu_events_map pmu_events_map[] = {
       _args.output_file.write("""{
 \t.arch = "testarch",
 \t.cpuid = "testcpu",
+\t.e_machine = EM_NONE,
 \t.event_table = {
 \t\t.pmus = pmu_events__test_soc_cpu,
 \t\t.num_pmus = ARRAY_SIZE(pmu_events__test_soc_cpu),
@@ -760,6 +772,7 @@ static const struct pmu_events_map pmu_events_map[] = {
       _args.output_file.write("""{
 \t.arch = "common",
 \t.cpuid = "common",
+\t.e_machine = EM_NONE,
 \t.event_table = {
 \t\t.pmus = pmu_events__common,
 \t\t.num_pmus = ARRAY_SIZE(pmu_events__common),
@@ -772,6 +785,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 },
 """)
     else:
+      e_machine = _arch_e_machine[arch]
       with open(f'{_args.starting_dir}/{arch}/mapfile.csv', encoding='utf-8') as csvfile:
         table = csv.reader(csvfile)
         first = True
@@ -798,6 +812,7 @@ static const struct pmu_events_map pmu_events_map[] = {
             _args.output_file.write(f"""{{
 \t.arch = "{arch}",
 \t.cpuid = "{cpuid}",
+\t.e_machine = {e_machine},
 \t.event_table = {{
 \t\t.pmus = {event_tblname},
 \t\t.num_pmus = {event_size}
@@ -814,6 +829,7 @@ static const struct pmu_events_map pmu_events_map[] = {
   _args.output_file.write("""{
 \t.arch = 0,
 \t.cpuid = 0,
+\t.e_machine = EM_NONE,
 \t.event_table = { 0, 0 },
 \t.metric_table = { 0 },
 }
@@ -1178,6 +1194,20 @@ int pmu_metrics_table__find_metric(const struct pmu_metrics_table *table,
 \treturn PMU_METRICS__NOT_FOUND;
 }
 
+/*
+ * Is the map for the architecture of @e_machine? The 32 and 64-bit variants of
+ * an architecture share tables.
+ */
+static bool pmu_events_map__e_machine_matches(const struct pmu_events_map *map,
+\t\t\t\t\t      uint16_t e_machine)
+{
+\tif (e_machine == EM_386)
+\t\te_machine = EM_X86_64;
+\telse if (e_machine == EM_PPC)
+\t\te_machine = EM_PPC64;
+\treturn map->e_machine == e_machine;
+}
+
 static const struct pmu_events_map *map_for_cpu(struct perf_cpu cpu)
 {
 \tstatic struct {
@@ -1218,7 +1248,8 @@ static const struct pmu_events_map *map_for_cpu(struct perf_cpu cpu)
 \t\t\t\tbreak;
 \t\t\t}
 
-\t\t\tif (!strcmp_cpuid_str(map->cpuid, cpuid))
+\t\t\tif (pmu_events_map__e_machine_matches(map, EM_HOST) &&
+\t\t\t    !strcmp_cpuid_str(map->cpuid, cpuid))
 \t\t\t\tbreak;
 \t\t}
 \t\tfree(last_map_search.cpuid);
@@ -1503,6 +1534,8 @@ such as "arm/cortex-a34".''',
 #include <pmu-events/pmu-events.h>
 #include "util/header.h"
 #include "util/pmu.h"
+#include <dwarf-regs.h>
+#include <elf.h>
 #include <string.h>
 #include <stddef.h>
 
-- 
2.56.1.750.gf70dc682cf-goog

