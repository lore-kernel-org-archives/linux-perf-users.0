Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604140;
	b=bmRxPPjh9rZe+0Yzf/bkAVrACzayxptEG1kwy8mtsBxLn1PQilUQaCjssortBzmHvC67
	 9eSWaXVzY0S7lLNHfhqx/v+5uB5mg5i+1X1f9bbiYuqLqVcyDP4pEZv8Zacs3oEp4gXCu
	 p/WnI5IfVZtQ1IgQzcIccYfcQAz0LlzqXPcW9JH9e7JASYGLmTkC5qotWVwIpRR6omldO
	 rWxDLZEx7qei1wyuJzjZ289OQCVOHUxQ354vvWQ4yyaBp4H5fxSPEzVBZOK/JBLSXJ5wY
	 +q0TGHGg/TE5rbNbvxaTBkxwsOW4WRmC5XTlkKTX9sJ/X2rZJuzk2HnjmFT3mmTCyLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Btz2syxRU38MnsKyn0uED6gNCD1sreIroQZSgah/i3Q=;
	b=wDXchzRZ/I6cFCcBNauiCKYUsIsUu3CepuzUh2A+X+msLnI8ti2ekhnJdGVDZiPpesZd
	 HXyFLgFCSSdiTEA4MWLtKpa4Xw4ahwx8PYpPLMR49CeDbRLP1jzYU8VTkYRNs2/92EZKI
	 +eo7o8bedkTIZCpUw2kg/1uwigk2707PznqrP9KcJoZXVku6p2jYpxLHCZEaBOmHMcZ4C
	 4U9vFS/37C1licuXU5oS3ITVevqHIY5xy+Gh/uP5rVbfGT40tRfDHMg508SbTJ7/SAHQc
	 5krKvdEcWFAkaYsvaKjK+yRnA9EtOTpl7aiiJNuXAf1ThMR7hwhe8AjIZFSPpmoNb3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pQD2HDEf;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B3560A263F
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9B3560A263F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pQD2HDEf
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso1805075eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794604138; x=1795208938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Btz2syxRU38MnsKyn0uED6gNCD1sreIroQZSgah/i3Q=;
        b=pQD2HDEfL/R7brPUKW6SbWdqFbGo7HYz/mj5mZcWUQpqLUGAPyI/kGtQa84EZQ3xHf
         /bqCHi7N2yAe9TfEw6U/8MiUUQm4st00WUIjZh4nPOopZKCKCVnYsPMd1KpY21718VPO
         M7jy/sRiCHTDbwW90BMA9HrNxxBRzaCbtrvlBKMWGSLyK+PNz7shbAaGvnwtfz18h3u1
         F4cxAPx9vKN07JLjvfRg82koj6A6MSBE/o3Mv7J1f2uZLqshtHlUS+Jyws7RMkjpAwbW
         /nPZ8ZDt1LG6h9fRLZZX6yS4HGv9lFllyC5pLJ6OWle2Dx3SPvCGe+RhvVA5/Kv6eANs
         prtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604138; x=1795208938;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Btz2syxRU38MnsKyn0uED6gNCD1sreIroQZSgah/i3Q=;
        b=nVH9+Xf82NvgTiU91pZ5k/GNJmlBZMxdtQmfnmvE+9SnlhrGzootZeJ7SMezFbg2o3
         sGds5Tk5ZH7ZjD163ge9/Yg0gABZuSt4FTkIjMEqWVJY/BA06FdtAv0RWVsbbhCkJ9J2
         MBRtgttDA8F8ZaMxN7tPgAZGJiDKu9Ew5zjEvZ5JVHRWcGA6V7Nf9vHKqJcuLDJktsmj
         UXJ5xXIv2MmxrrtI5xYEQ7cyo7jrPtqoaPYb1XKsRVLa2KrAOYnRuwpAXL20VkcgyHLI
         zJ/QGciSEXEL7Vh/zn8iiWk6OYaNVcZGKQxHO369kydBgtBKSSVjT6V0fJL9m06sPFRq
         n89g==
X-Forwarded-Encrypted: i=1; AL+hErHnL+u9tgJDQMVlon34TrBS61brwq0Roddep9S4ekRPdbXzK8nUYi6Es1G/7rCu8GpeXrW9vAkKn06ibwLRr278@vger.kernel.org
X-Gm-Message-State: APuU4Z9UK79zGZJ2TEcNAEF22l2Px9fQL7vVp2hH/38NsSrSloJTeB6O
	Xitr/3xBhijTWtJwt0RVcs5w7cY7aHg1vbqeOy1DDIKzkqp1ic6KyQ5PqKVi9DX9oOEBf5kIMVy
	gbQs5KiMfpw==
X-Received: from dycmp16.prod.google.com ([2002:a05:7301:710:b0:375:d77d:a1c6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2808:b0:36d:f004:ae6e
 with SMTP id 5a478bee46e88-3796721cff0mr3035445eec.34.1794604137552; Fri, 13
 Nov 2026 13:08:57 -0800 (PST)
Date: Fri, 13 Nov 2026 13:08:21 -0800
In-Reply-To: <20261113210822.3112700-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113210822.3112700-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113210822.3112700-10-irogers@google.com>
Subject: [PATCH 09/10] perf tests pmu-events: Test metricgroup descriptions
 and concurrent lookups
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add metricgroups.json to arch/test/test_soc/cpu/ with prefix-overlapping
keys ("group1" and "group1A"), regenerate empty-pmu-events.c, and add a
"metricgroups" subtest to "PMU JSON event tests".

The new subtest verifies exact and prefix-overlapping metricgroup binary
searches via describe_metricgroup(), validates metricgroup descriptions
across all core and system metrics, and launches 8 concurrent worker
threads scanning core/sys events and metrics to stress-test lock-free
block decompression and shared dictionary initialization.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/test/test_soc/cpu/metricgroups.json  |   4 +
 tools/perf/pmu-events/empty-pmu-events.c      |  84 +++----
 tools/perf/tests/pmu-events.c                 | 209 +++++++++++++++++-
 3 files changed, 259 insertions(+), 38 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/test/test_soc/cpu/metricgrou=
ps.json

diff --git a/tools/perf/pmu-events/arch/test/test_soc/cpu/metricgroups.json=
 b/tools/perf/pmu-events/arch/test/test_soc/cpu/metricgroups.json
new file mode 100644
index 000000000000..2bf7e4fbff3c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/test/test_soc/cpu/metricgroups.json
@@ -0,0 +1,4 @@
+{
+    "group1": "Test metricgroup 1",
+    "group1A": "Test metricgroup 1A"
+}
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-even=
ts/empty-pmu-events.c
index 46a32a4cb9d6..f4009e5c51ee 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -2605,42 +2605,50 @@ static const char big_c_string[] =3D
 /* offset=3D128790 */
 "M3\000\0001 / M3\000\000\000\000\000\000\000\000000"
 /* offset=3D128811 */
+"Test metricgroup 1\000"
+/* offset=3D128830 */
+"Test metricgroup 1A\000"
+/* offset=3D128850 */
 "backend_cycles_idle\000Default\000(stalled\\-cycles\\-backend / cpu\\-cyc=
les if has_event(stalled\\-cycles\\-backend) else 0)\000backend_cycles_idle=
 > 0.2\000Backend stalls per cycle\000\000\000\000\000\000001"
-/* offset=3D128985 */
+/* offset=3D129024 */
 "branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Branches per CPU second\000\0001000M/sec\000\000\000\000011=
"
-/* offset=3D129165 */
+/* offset=3D129204 */
 "branch_miss_rate\000Default\000branch\\-misses / branches\000branch_miss_=
rate > 0.05\000Branch miss rate\000\000100%\000\000\000\000001"
-/* offset=3D129269 */
+/* offset=3D129308 */
 "cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\0=
00\000\000\000\000\000\000000"
-/* offset=3D129341 */
+/* offset=3D129380 */
 "cs_per_second\000Default\000software@context\\-switches\\,name\\=3Dcontex=
t\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #tar=
get_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Context=
 switches per CPU second\000\0001cs/sec\000\000\000\000011"
-/* offset=3D129574 */
+/* offset=3D129613 */
 "cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\000\000011"
-/* offset=3D129750 */
+/* offset=3D129789 */
 "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\00=
0\000\000\000\000\000000"
-/* offset=3D129815 */
+/* offset=3D129854 */
 "dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\-loads\000dtlb=
_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000\000001"
-/* offset=3D129921 */
+/* offset=3D129960 */
 "frontend_cycles_idle\000Default\000(stalled\\-cycles\\-frontend / cpu\\-c=
ycles if has_event(stalled\\-cycles\\-frontend) else 0)\000frontend_cycles_=
idle > 0.1\000Frontend stalls per cycle\000\000\000\000\000\000001"
-/* offset=3D130100 */
+/* offset=3D130139 */
+"group1\000"
+/* offset=3D130146 */
+"group1A\000"
+/* offset=3D130154 */
 "icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000=
\000\000\000\000\000\000000"
-/* offset=3D130168 */
+/* offset=3D130222 */
 "insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_cycl=
e < 1\000Instructions Per Cycle\000\0001instructions\000\000\000\000001"
-/* offset=3D130281 */
+/* offset=3D130335 */
 "itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\-loads\000itlb=
_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000\000001"
-/* offset=3D130387 */
+/* offset=3D130441 */
 "l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch\\-misses / L1=
\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L1 prefetch miss =
rate\000\000100%\000\000\000\000001"
-/* offset=3D130535 */
+/* offset=3D130589 */
 "l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / L1\\-dcache\\-=
loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%\000\000\000\000=
001"
-/* offset=3D130651 */
+/* offset=3D130705 */
 "l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / L1\\-icache\\-=
loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\000\000\000\0000=
01"
-/* offset=3D130766 */
+/* offset=3D130820 */
 "llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-loads\000llc_mis=
s_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\000001"
-/* offset=3D130867 */
+/* offset=3D130921 */
 "migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=3D=
cpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if =
#target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Pro=
cess migrations to a new CPU per CPU second\000\0001migrations/sec\000\000\=
000\000011"
-/* offset=3D131127 */
+/* offset=3D131181 */
 "page_faults_per_second\000Default\000software@page\\-faults\\,name\\=3Dpa=
ge\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #targ=
et_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Page fau=
lts per CPU second\000\0001faults/sec\000\000\000\000011"
-/* offset=3D131358 */
+/* offset=3D131412 */
 "stalled_cycles_per_instruction\000Default\000(max(stalled\\-cycles\\-fron=
tend, stalled\\-cycles\\-backend) / instructions if has_event(stalled\\-cyc=
les\\-frontend) & has_event(stalled\\-cycles\\-backend) else (stalled\\-cyc=
les\\-frontend / instructions if has_event(stalled\\-cycles\\-frontend) els=
e (stalled\\-cycles\\-backend / instructions if has_event(stalled\\-cycles\=
\-backend) else 0)))\000\000Max front or backend stalls per instruction\000=
\000\000\000\000\000001"
 ;
=20
@@ -5197,37 +5205,37 @@ static const struct compact_pmu_event pmu_metrics__=
common_default_core[] =3D {
 	/* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=3Dcpu\\-clo=
ck@ if #targ... */
 	{ 127820 },
 	/* backend_cycles_idle\000Default\000(stalled\\-cycles\\-backend / cpu\\-=
cycles if ... */
-	{ 128811 },
+	{ 128850 },
 	/* branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name=
\\=3Dcpu\\-c... */
-	{ 128985 },
+	{ 129024 },
 	/* branch_miss_rate\000Default\000branch\\-misses / branches\000branch_mi=
ss_rate > ... */
-	{ 129165 },
+	{ 129204 },
 	/* cs_per_second\000Default\000software@context\\-switches\\,name\\=3Dcon=
text\\-switc... */
-	{ 129341 },
+	{ 129380 },
 	/* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,=
name\\=3Dcpu... */
-	{ 129574 },
+	{ 129613 },
 	/* dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\-loads\000d=
tlb_miss_r... */
-	{ 129815 },
+	{ 129854 },
 	/* frontend_cycles_idle\000Default\000(stalled\\-cycles\\-frontend / cpu\=
\-cycles i... */
-	{ 129921 },
+	{ 129960 },
 	/* insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_c=
ycle < 1\0... */
-	{ 130168 },
+	{ 130222 },
 	/* itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\-loads\000i=
tlb_miss_r... */
-	{ 130281 },
+	{ 130335 },
 	/* l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch\\-misses /=
 L1\\-dcac... */
-	{ 130387 },
+	{ 130441 },
 	/* l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / L1\\-dcache=
\\-loads\0... */
-	{ 130535 },
+	{ 130589 },
 	/* l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / L1\\-icache=
\\-loads\0... */
-	{ 130651 },
+	{ 130705 },
 	/* llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-loads\000llc_=
miss_rate ... */
-	{ 130766 },
+	{ 130820 },
 	/* migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=
=3Dcpu\\-mig... */
-	{ 130867 },
+	{ 130921 },
 	/* page_faults_per_second\000Default\000software@page\\-faults\\,name\\=
=3Dpage\\-faul... */
-	{ 131127 },
+	{ 131181 },
 	/* stalled_cycles_per_instruction\000Default\000(max(stalled\\-cycles\\-f=
rontend, s... */
-	{ 131358 },
+	{ 131412 },
=20
 };
=20
@@ -5338,11 +5346,11 @@ static const struct compact_pmu_event pmu_metrics__=
test_soc_cpu_default_core[] =3D
 	/* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
 	{ 128790 },
 	/* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\00=
0\000\000\... */
-	{ 129269 },
+	{ 129308 },
 	/* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000=
\000\000\0... */
-	{ 129750 },
+	{ 129789 },
 	/* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\=
000\000\00... */
-	{ 130100 },
+	{ 130154 },
=20
 };
=20
@@ -6034,6 +6042,8 @@ int pmu_metrics_table__iterate_tables(pmu_metrics_tab=
le_iter_t fn, void *data)
 }
=20
 static const uint32_t metricgroups[][2] =3D {
+	{ 130139, 128811 }, /* group1\000 =3D> Test metricgroup 1\000 */
+	{ 130146, 128830 }, /* group1A\000 =3D> Test metricgroup 1A\000 */
=20
 };
=20
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index e6e4f4cf1fa2..a06525cafb48 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -5,7 +5,12 @@
 #include "pmus.h"
 #include "tests.h"
 #include <errno.h>
+#include <pthread.h>
+#include <stdbool.h>
+#include <stddef.h>
 #include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include "debug.h"
@@ -1094,6 +1099,202 @@ static int test__parsing_threshold(struct test_suit=
e *test __maybe_unused,
 	return pmu_for_each_sys_metric(test__parsing_threshold_callback, NULL);
 }
=20
+static int check_event_strings_cb(const struct pmu_event *pe,
+				  const struct pmu_events_table *table __maybe_unused,
+				  void *data __maybe_unused)
+{
+	if (!pe->pmu || !pe->name || (!pe->event && !pe->desc))
+		return TEST_FAIL;
+	return 0;
+}
+
+static int check_find_btb_cb(const struct pmu_event *pe,
+			     const struct pmu_events_table *table __maybe_unused,
+			     void *data)
+{
+	int *matched =3D data;
+
+	if (!pe->event || strcmp(pe->event, "event=3D0x8a"))
+		return TEST_FAIL;
+	(*matched)++;
+	return 0;
+}
+
+static int check_find_ipc_cb(const struct pmu_metric *pm,
+			     const struct pmu_metrics_table *table __maybe_unused,
+			     void *data)
+{
+	int *matched =3D data;
+
+	if (!pm->metric_group || strcmp(pm->metric_group, "group1"))
+		return TEST_FAIL;
+	(*matched)++;
+	return 0;
+}
+
+static int check_metricgroup_strings_cb(const struct pmu_metric *pm,
+					const struct pmu_metrics_table *table __maybe_unused,
+					void *data __maybe_unused)
+{
+	char *dup, *group, *saveptr =3D NULL;
+
+	if (!pm->pmu || !pm->metric_expr)
+		return TEST_FAIL;
+	if (!pm->metric_group)
+		return 0;
+
+	dup =3D strdup(pm->metric_group);
+	if (!dup)
+		return -ENOMEM;
+
+	for (group =3D strtok_r(dup, ";", &saveptr); group;
+	     group =3D strtok_r(NULL, ";", &saveptr)) {
+		const char *desc =3D describe_metricgroup(group);
+
+		if (desc && desc[0] =3D=3D '\0') {
+			free(dup);
+			return TEST_FAIL;
+		}
+		if (!strcmp(group, "group1") &&
+		    (!desc || strcmp(desc, "Test metricgroup 1"))) {
+			free(dup);
+			return TEST_FAIL;
+		}
+	}
+	free(dup);
+	return 0;
+}
+
+struct concurrent_lookup_gate {
+	pthread_mutex_t mutex;
+	pthread_cond_t cond;
+	bool start;
+};
+
+struct concurrent_lookup_worker {
+	struct concurrent_lookup_gate *gate;
+	int err;
+};
+
+static int run_lookup_checks(void)
+{
+	const struct pmu_events_table *etest;
+	const struct pmu_metrics_table *mtest;
+	const char *desc;
+	int matched, err;
+
+	desc =3D describe_metricgroup("group1");
+	if (!desc || strcmp(desc, "Test metricgroup 1")) {
+		pr_err("Unexpected group1 description: %s\n", desc ?: "(null)");
+		return TEST_FAIL;
+	}
+
+	desc =3D describe_metricgroup("group1A");
+	if (!desc || strcmp(desc, "Test metricgroup 1A")) {
+		pr_err("Unexpected group1A description: %s\n", desc ?: "(null)");
+		return TEST_FAIL;
+	}
+
+	if (describe_metricgroup("group1_nonexistent") || describe_metricgroup(""=
)) {
+		pr_err("Unexpected match for nonexistent metricgroup\n");
+		return TEST_FAIL;
+	}
+
+	if (describe_metricgroup("BadSpec") && !describe_metricgroup("Bad")) {
+		pr_err("Prefix metricgroup 'Bad' missing when 'BadSpec' is present\n");
+		return TEST_FAIL;
+	}
+
+	etest =3D find_core_events_table("testarch", "testcpu");
+	mtest =3D find_core_metrics_table("testarch", "testcpu");
+	if (!etest || !mtest)
+		return TEST_FAIL;
+
+	matched =3D 0;
+	err =3D pmu_events_table__find_event(etest, NULL, "bp_l1_btb_correct",
+					   check_find_btb_cb, &matched);
+	if (err || matched !=3D 1)
+		return TEST_FAIL;
+
+	matched =3D 0;
+	err =3D pmu_metrics_table__find_metric(mtest, NULL, "IPC",
+					     check_find_ipc_cb, &matched);
+	if (err || matched !=3D 1)
+		return TEST_FAIL;
+
+	err =3D pmu_for_each_core_event(check_event_strings_cb, NULL);
+	if (err)
+		return err;
+
+	err =3D pmu_for_each_sys_event(check_event_strings_cb, NULL);
+	if (err)
+		return err;
+
+	err =3D pmu_for_each_core_metric(check_metricgroup_strings_cb, NULL);
+	if (err)
+		return err;
+
+	return pmu_for_each_sys_metric(check_metricgroup_strings_cb, NULL);
+}
+
+static void *concurrent_lookup_thread(void *arg)
+{
+	struct concurrent_lookup_worker *worker =3D arg;
+
+	pthread_mutex_lock(&worker->gate->mutex);
+	while (!worker->gate->start)
+		pthread_cond_wait(&worker->gate->cond, &worker->gate->mutex);
+	pthread_mutex_unlock(&worker->gate->mutex);
+
+	worker->err =3D run_lookup_checks();
+	return NULL;
+}
+
+/*
+ * Verify metricgroup binary search and release 8 worker threads simultane=
ously
+ * to stress-test lock-free on-demand decompression of ~8 KiB string block=
s in
+ * pmu_events__get_string() (big_c_string_cache[]) and shared dictionary s=
etup.
+ */
+static int test__metricgroups(struct test_suite *test __maybe_unused,
+			      int subtest __maybe_unused)
+{
+	struct concurrent_lookup_gate gate =3D {
+		.mutex =3D PTHREAD_MUTEX_INITIALIZER,
+		.cond =3D PTHREAD_COND_INITIALIZER,
+		.start =3D false,
+	};
+	struct concurrent_lookup_worker workers[8];
+	pthread_t threads[ARRAY_SIZE(workers)];
+	size_t created =3D 0;
+	int ret =3D TEST_OK;
+
+	for (size_t i =3D 0; i < ARRAY_SIZE(workers); i++) {
+		workers[i].gate =3D &gate;
+		workers[i].err =3D 0;
+		if (pthread_create(&threads[i], NULL, concurrent_lookup_thread,
+				   &workers[i]) !=3D 0) {
+			ret =3D TEST_FAIL;
+			break;
+		}
+		created++;
+	}
+
+	pthread_mutex_lock(&gate.mutex);
+	gate.start =3D true;
+	pthread_cond_broadcast(&gate.cond);
+	pthread_mutex_unlock(&gate.mutex);
+
+	for (size_t i =3D 0; i < created; i++) {
+		pthread_join(threads[i], NULL);
+		if (workers[i].err && ret =3D=3D TEST_OK)
+			ret =3D workers[i].err;
+	}
+
+	pthread_cond_destroy(&gate.cond);
+	pthread_mutex_destroy(&gate.mutex);
+	return ret;
+}
+
 struct populate_cb_data {
 	struct test_case *test_cases;
 	size_t curr;
@@ -1145,7 +1346,7 @@ static struct test_case pmu_events_tests[];
 static int setup_pmu_events_suite(struct test_suite *suite)
 {
 	size_t num_tables =3D 0;
-	size_t num_fixed_tests =3D 4;
+	size_t num_fixed_tests =3D 5;
 	size_t tests_per_table =3D 2;
 	size_t total_tests;
 	struct test_case *test_cases;
@@ -1171,6 +1372,11 @@ static int setup_pmu_events_suite(struct test_suite =
*suite)
 		.desc =3D "PMU event table sanity",
 		.run_case =3D test__pmu_event_table,
 	};
+	test_cases[curr++] =3D (struct test_case){
+		.name =3D "metricgroups",
+		.desc =3D "PMU metricgroup descriptions and concurrent lookups",
+		.run_case =3D test__metricgroups,
+	};
 	test_cases[curr++] =3D (struct test_case){
 		.name =3D "aliases",
 		.desc =3D "PMU event map aliases",
@@ -1208,6 +1414,7 @@ static int setup_pmu_events_suite(struct test_suite *=
suite)
=20
 static struct test_case pmu_events_tests[] =3D {
 	TEST_CASE("PMU event table sanity", pmu_event_table),
+	TEST_CASE("PMU metricgroup descriptions and concurrent lookups", metricgr=
oups),
 	TEST_CASE("PMU event map aliases", aliases),
 	TEST_CASE_REASON("Parsing of PMU event table metrics", parsing,
 			 "some metrics failed"),
--=20
2.56.1.703.gf848ed807c-goog

