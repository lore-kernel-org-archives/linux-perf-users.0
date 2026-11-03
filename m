Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749527;
	b=OKFnlFrj+aRrXyDjOWfKiK9KIaTK18sn4b6azguQypicBu0h9f5fW3NW1CNMr32owrqA
	 r5v/TIzhwLciM3SP26OORym0FiI2PO7HgtfCE96EKBI06HTeK6aFrpatYt2PDsrDVZpjR
	 Et4uE+ZlDxeY6FpQV3FHuIfBIda6V/yQnWZ2gkVyYxFBx6ulN+4L5mbdpu7WAi83vlDEL
	 ZDbFxT8vGksXN2GL9o9QvvxpiIgmLH4XmAhgamvRGsmNY6GxFNk2dkAZXouW9SIeC8XYu
	 75umKmioIUDpGewbLeEezkMihSFSd9uCEWMcUq1PyS8DAISMX5nWXeTGlmPbG54xErQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=x0MJFjxdMgnBdr64vp55PEfIxDtLTYWJvTLG1PY4fO0=;
	b=abpip2RO0A9UM/iRcSfXOzrP8AncYPmGJkRBnggvZrxoYHUa9KpFTMFS6sQATe1X8uhG
	 waHEm3Yym/Lcx7SSuLuB3+OyRgBSKu37ghC01MX6dwt59xTaHj8tfAVUdm6RrJ95IW20F
	 wLZWM0dYQWxLyko3MQUcWx2CLpIHVXo6ao/q8o2cj1TK19ilJorjq+Th0JWslfCsoUuTe
	 kgCynJbxvek4KKsHb6vdQADrOqnA/8u98dJY26uLy6+te4eNNP4Qcb49o/d1dYD8quDSM
	 d6KnctfNuBXzfrYhX4BmlG1ZsYV6wB1hXJbHfIAq2p/7KgQVbjMaqbnej+3hjKwCHnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="lQ/BHqis";
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E930A606A336
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E930A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lQ/BHqis
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36c9e87d262so122400eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749526; x=1794354326; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x0MJFjxdMgnBdr64vp55PEfIxDtLTYWJvTLG1PY4fO0=;
        b=lQ/BHqisNxvd243/770PVIW+M6h264SDPJ0R5Cz4A1JleNROnIilIZB2sflMnubs0M
         8OYGTk9LXG789cedM1LtA0YC6N0o7gbtqi5xRzAneapJQ2ZL2fnbR49zQvgszqcnkAtr
         9gh8CrQ3JfoQ1KksaLP0ArB9O4ToQYuepx9UfrYX7SKaWZE3KDbWZ6J7YiAktqbNWboG
         X3pYmUBnXUaKjXiivdsiGlHHsLKopbbuwG8nT4VGe348cgXzdueop2+9sS52kRvbSVVu
         hpFOU9Ap/F5q/e6jtei8WIC9+mrt0WAwDIjNFaX1hG9kZSztnzzGKBxkfywICqCKJDdl
         5Ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749526; x=1794354326;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x0MJFjxdMgnBdr64vp55PEfIxDtLTYWJvTLG1PY4fO0=;
        b=BpcSldEizvRBMq8WffVQGSuYVZVNCJqSpwVXDZLBf+xhyNCxCLYsVe/kwuB1dI9SYU
         m1lEW9wgqVXBxg8MBOhb6CaSqnUX7ww/Gt4bvc9GFjoOIV+0uy6duSOVW55z9S3JNmT6
         B/KoG/8r1/uhzoSyJHJeop5wGkX8Khcp8JUzWSvJso3ALU49TgaLqMmITzjqi0//zYo7
         LQ01KFx90o4bGihM2eDBDzACc713l1A/LudnlWWwD7vCkIuBEUiaT1v5dKC4oarNzHhP
         /IJ7p8hrRzo6zBFpJ0cAXF4d40wRTNG6LULeL+IVwJqI7tBRBpGTrDaYKHVsUw4dTITp
         zo/Q==
X-Gm-Message-State: APuU4Z+zI/hoxtmSapbyKO/LByZMAlSAIWuteh5sK/jpa/gDYnF6VmoQ
	BksBq8mbLenbMbF1M0Z0cQN989AlCUp7u0MnDbX6PmsE8CCen5OAbjzDphwT9jUEvPvfDE+sEf1
	tm7cFSKdVuWFScVAmutn8nAPjz+R7Mz42i97QnBVquby7NmkoHe3526ttLHMYNt6buog4OiuVG4
	Bc2Vx2p1xEEPfjjv/eNWkE1rz/EitUfqJa0cPnTWPOJdYbarLxgqr7ug0=
X-Received: from dycmb15-n2.prod.google.com ([2002:a05:693c:20cf:20b0:369:f67f:7a43])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6194:10b0:369:f937:9a7a
 with SMTP id 5a478bee46e88-36a42437876mr22097544eec.34.1793749525620; Tue, 03
 Nov 2026 15:45:25 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:23 -0800
In-Reply-To: <20261103234502.1008382-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103234502.1008382-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103234502.1008382-8-irogers@google.com>
Subject: [PATCH v1 07/41] perf pmu-events: Add e_machine to struct pmu_events_map
From: Ian Rogers <irogers@google.com>
To: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, John Garry <john.garry@linux.dev>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ian Rogers <irogers@google.com>
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
2.56.0.385.gac671c819a-goog

