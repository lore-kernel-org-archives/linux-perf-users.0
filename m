Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604295;
	b=IA6ad2DCPj1aQ3vuTS6Gvt9IH+22FZvF2a8ZPko3mcQVkppouwEAxueu2hS5hmfIxiJF
	 kH4qfzMggZ5FdoKBUznhKGebi8JVzhhNLg3FbBzeBEbjXqGw3pnmfm8xExS/JbZ9htlme
	 Z23kQ0rLiYhYJ4qT1wUgMAlAEIREyhg9iWbK9/3KDy6P2zzDhI9HK8ZKFega9Cg7g8SGx
	 iewSz+UrUnb5oO7LCvq8y8sJqwW0H2owm1L32NAr9hQ15mDUXCR78KWQwnKFx+I760J3Y
	 WwB8G+DmUZU4mlEmcAPA0A+R6s3iZC/s8IBttqYmspNTGS61RPYXbzBYvvTK11ac+yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=SSZVja0OelEmrQfaGzda6CcIbhU4scmMmrO4sRssr5o=;
	b=ybPbg1H0oS4vvU0RAObyv0Bdip3up+Bnx///nwekF8CbudznCJ78W4Vvufw6Yj92QFxN
	 UCkdWaZcec2WW6gHJhXhrd7vEIbBw7s908ENjh18FMRG+OEBcnlqCSwN1GDrDsnFKEtT4
	 z28gFiWB/S087dIAh2Zf/vH60D8pPXOxQ/6SG/v4ADOZNN7JFpO2uK6/Cfnyi0IOlC76B
	 wXGKuyuREWUjT6ozlgMuGGgS0pSQ+3ukYSpsjCG+Fa2kcJjPe07z5PykGnQ6lbH+L2stR
	 oecCG74lGm3PF2gOCAHRYCduxyLAT5fs+mJNz0RC+y/X3Bay7c0McXVinznD2drGudQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JGSFVgg1;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE2E606A88B
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFE2E606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JGSFVgg1
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-37549877380so1780970eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794604294; x=1795209094; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SSZVja0OelEmrQfaGzda6CcIbhU4scmMmrO4sRssr5o=;
        b=JGSFVgg1e6/G5NtdFFWSQ9JtHqEgS3H3OgnyT56QPNl960psUsf6gK+5de6ODnT0dt
         Rd3IRpacsQxmsZJFdBCooIYpfeNv1DGLp53aFqlsDfB2F57u7wIkRUp+YctnMIyLqwI+
         oTqsbgKKL784rFQaAGNdiJkgm7zgL3B60yBniycp8Pi+xDl4AEm3Kx0u3yvBMdBzbhMA
         Xt7X+Kvi+98YyH6tU3PFicmj1wadlVEetd2RDp+YW5JfyN2YFGRv/dagZgLDKibKz8Va
         LJAIl988bDkAXAVEMGD7d8Opf4h3skbONi87a4UpU1l6/qJPjATWaCu6rUg+M6oUnTje
         RgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604294; x=1795209094;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SSZVja0OelEmrQfaGzda6CcIbhU4scmMmrO4sRssr5o=;
        b=T6ShuvX+uBCtZyETLgLI0WKbwb0M1J+0jxoqkfQiPOeZBEEL7SA0inyJ4ETV19eWIz
         a91oIN2T0/SKw/NG8BbAZxxuBH42bG2s2IjcKbwAONeY/qbkGNiDrjMnA+3Thu7Y9B6Z
         DXtGBAMVvyGCMozU46iMzU7ptdWpwqJgcOb2C5Gfg6udqc5gzGpLs8gx7h5l60xMgpGY
         cHCz/jm1V11ppwwVtNaVqUO+vov+iSi6XUb/+7nMHD3XIR12AfbzNX0k1baLSNh1UZbI
         zxkBlnZLxFuAfzaIV9F/+ProemJ3gzoC8zfx/PDgk2tpZPOSYYuWcO4tDD9KxlbcNtHD
         sZ1g==
X-Forwarded-Encrypted: i=1; AL+hErEr+NWnpC4NakpiyfVujfHfL8ydccnrxPlAPi6tIYMM5AaMGEDiHakLiweI+nji0uyljx+ER2p8jk4h8Y75U0wH@vger.kernel.org
X-Gm-Message-State: APuU4Z9z8UAtAdTTkhqotcesUH7vJFZtXhi3yfhMZ+joI0QIbtoHo2p6
	L2Qvd9xXglQbCl8yD0WR4HP+CNuCPJQsHeSfRj2rA1OBZvjrqYGAgd+K7WSGrQDuDMINt8RBaRt
	NOj5cckZGhA==
X-Received: from dlbek22.prod.google.com ([2002:a05:7022:c96:b0:1b5:9ae:892b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:450f:10b0:1b2:41af:c21c
 with SMTP id a92af1059eb24-1b503157396mr3327168c88.39.1794604293456; Fri, 13
 Nov 2026 13:11:33 -0800 (PST)
Date: Fri, 13 Nov 2026 13:11:00 -0800
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
Message-ID: <20261113211105.3118281-10-irogers@google.com>
Subject: [PATCH 09/11] perf jevents: Add compiled-in model and sys table iterators
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Record canonical model relative paths in struct pmu_events_map and
architecture/model paths in struct pmu_sys_events during jevents.py C
code generation, and expose pmu_events_map__for_each() and
pmu_sys_events__for_each() in pmu-events.h.

This keeps struct pmu_events_map and struct pmu_sys_events private to
pmu-events.c while allowing callers such as 'perf list --export-dir
--export-cpuid' to enumerate compiled-in CPU and system PMU tables
across all architectures without requiring an unbuilt JSON source tree.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 36 +++++++++++++++
 tools/perf/pmu-events/jevents.py         | 57 ++++++++++++++++++++++++
 tools/perf/pmu-events/pmu-events.h       | 15 +++++++
 3 files changed, 108 insertions(+)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index f4009e5c51ee..116ce8e39d5d 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -5419,6 +5419,7 @@ struct pmu_metrics_table {
 struct pmu_events_map {
 	const char *arch;
 	const char *cpuid;
+	const char *model;
 	struct pmu_events_table event_table;
 	struct pmu_metrics_table metric_table;
 };
@@ -5431,6 +5432,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 {
 	.arch = "common",
 	.cpuid = "common",
+	.model = "common",
 	.event_table = {
 		.pmus = pmu_events__common,
 		.num_pmus = ARRAY_SIZE(pmu_events__common),
@@ -5444,6 +5446,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 {
 	.arch = "testarch",
 	.cpuid = "testcpu",
+	.model = "test_soc/cpu",
 	.event_table = {
 		.pmus = pmu_events__test_soc_cpu,
 		.num_pmus = ARRAY_SIZE(pmu_events__test_soc_cpu),
@@ -5457,6 +5460,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 {
 	.arch = 0,
 	.cpuid = 0,
+	.model = 0,
 	.event_table = { 0, 0 },
 	.metric_table = { 0 },
 }
@@ -5464,6 +5468,8 @@ static const struct pmu_events_map pmu_events_map[] = {
 
 struct pmu_sys_events {
 	const char *name;
+	const char *arch;
+	const char *model;
 	struct pmu_events_table event_table;
 	struct pmu_metrics_table metric_table;
 };
@@ -5475,6 +5481,8 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
 			.num_pmus = ARRAY_SIZE(pmu_events__test_soc_sys)
 		},
 		.name = "pmu_events__test_soc_sys",
+		.arch = "testarch",
+		.model = "test_soc/sys",
 	},
 	{
 		.event_table = { 0, 0 },
@@ -6041,6 +6049,34 @@ int pmu_metrics_table__iterate_tables(pmu_metrics_table_iter_t fn, void *data)
 	return 0;
 }
 
+int pmu_events_map__for_each(pmu_events_map_iter_fn fn, void *data)
+{
+	for (size_t i = 0; pmu_events_map[i].arch; i++) {
+		const struct pmu_events_map *m = &pmu_events_map[i];
+		const struct pmu_events_table *et = m->event_table.pmus ? &m->event_table : NULL;
+		const struct pmu_metrics_table *mt = m->metric_table.pmus ? &m->metric_table : NULL;
+		int ret = fn(m->arch, m->cpuid, m->model, et, mt, data);
+
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+int pmu_sys_events__for_each(pmu_sys_events_iter_fn fn, void *data)
+{
+	for (size_t i = 0; pmu_sys_event_tables[i].name; i++) {
+		const struct pmu_sys_events *s = &pmu_sys_event_tables[i];
+		const struct pmu_events_table *et = s->event_table.pmus ? &s->event_table : NULL;
+		const struct pmu_metrics_table *mt = s->metric_table.pmus ? &s->metric_table : NULL;
+		int ret = fn(s->arch, s->model, et, mt, data);
+
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 static const uint32_t metricgroups[][2] = {
 	{ 130139, 128811 }, /* group1\000 => Test metricgroup 1\000 */
 	{ 130146, 128830 }, /* group1A\000 => Test metricgroup 1A\000 */
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 8c2f6531b0c5..972356ea84c3 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -25,6 +25,10 @@ _metric_tables: list[str] = []
 _sys_metric_tables: list[str] = []
 # Mapping between sys event table names and sys metric table names.
 _sys_event_table_to_metric_table_mapping: Dict[str, str] = {}
+# Mapping from sys event/metric table names to (arch, model_rel_path).
+_sys_table_arch_model: Dict[str, Tuple[str, str]] = {}
+# Architecture directory currently being walked during code generation.
+_cur_arch: str = ''
 # Map from an event name to an architecture standard
 # JsonEvent. Architecture standard events are in json files in the top
 # f'{_args.starting_dir}/{_args.arch}' directory.
@@ -1309,6 +1313,10 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 
     if item.name == 'sys':
       _sys_event_table_to_metric_table_mapping[_pending_events_tblname] = _pending_metrics_tblname
+      c_arch = 'testarch' if _cur_arch == 'test' else _cur_arch
+      model_rel = '/'.join(list(parents) + [item.name])
+      _sys_table_arch_model[_pending_events_tblname] = (c_arch, model_rel)
+      _sys_table_arch_model[_pending_metrics_tblname] = (c_arch, model_rel)
     return
 
   # base dir or too deep
@@ -1352,6 +1360,7 @@ struct pmu_metrics_table {
 struct pmu_events_map {
 \tconst char *arch;
 \tconst char *cpuid;
+\tconst char *model;
 \tstruct pmu_events_table event_table;
 \tstruct pmu_metrics_table metric_table;
 };
@@ -1367,6 +1376,7 @@ static const struct pmu_events_map pmu_events_map[] = {
       _args.output_file.write("""{
 \t.arch = "testarch",
 \t.cpuid = "testcpu",
+\t.model = "test_soc/cpu",
 \t.event_table = {
 \t\t.pmus = pmu_events__test_soc_cpu,
 \t\t.num_pmus = ARRAY_SIZE(pmu_events__test_soc_cpu),
@@ -1382,6 +1392,7 @@ static const struct pmu_events_map pmu_events_map[] = {
       _args.output_file.write("""{
 \t.arch = "common",
 \t.cpuid = "common",
+\t.model = "common",
 \t.event_table = {
 \t\t.pmus = pmu_events__common,
 \t\t.num_pmus = ARRAY_SIZE(pmu_events__common),
@@ -1400,6 +1411,7 @@ static const struct pmu_events_map pmu_events_map[] = {
         for row in table:
           # Skip the first row or any row beginning with #.
           if not first and len(row) > 0 and not row[0].startswith('#'):
+            model_rel = row[2].strip('/')
             event_tblname = file_name_to_table_name('pmu_events_', [], row[2].replace('/', '_'))
             if event_tblname in _event_tables:
               event_size = f'ARRAY_SIZE({event_tblname})'
@@ -1417,9 +1429,11 @@ static const struct pmu_events_map pmu_events_map[] = {
             if event_size == '0' and metric_size == '0':
               continue
             cpuid = row[0].replace('\\', '\\\\')
+            model_c = bytes_to_c_literal(model_rel.encode('utf-8'))
             _args.output_file.write(f"""{{
 \t.arch = "{arch}",
 \t.cpuid = "{cpuid}",
+\t.model = "{model_c}",
 \t.event_table = {{
 \t\t.pmus = {event_tblname},
 \t\t.num_pmus = {event_size}
@@ -1436,6 +1450,7 @@ static const struct pmu_events_map pmu_events_map[] = {
   _args.output_file.write("""{
 \t.arch = 0,
 \t.cpuid = 0,
+\t.model = 0,
 \t.event_table = { 0, 0 },
 \t.metric_table = { 0 },
 }
@@ -1479,6 +1494,34 @@ int pmu_metrics_table__iterate_tables(pmu_metrics_table_iter_t fn, void *data)
 \t\tif (!pmu_sys_event_tables[i].metric_table.pmus)
 \t\t\tcontinue;
 \t\tret = fn(&pmu_sys_event_tables[i].metric_table, data);
+\t\tif (ret)
+\t\t\treturn ret;
+\t}
+\treturn 0;
+}
+
+int pmu_events_map__for_each(pmu_events_map_iter_fn fn, void *data)
+{
+\tfor (size_t i = 0; pmu_events_map[i].arch; i++) {
+\t\tconst struct pmu_events_map *m = &pmu_events_map[i];
+\t\tconst struct pmu_events_table *et = m->event_table.pmus ? &m->event_table : NULL;
+\t\tconst struct pmu_metrics_table *mt = m->metric_table.pmus ? &m->metric_table : NULL;
+\t\tint ret = fn(m->arch, m->cpuid, m->model, et, mt, data);
+
+\t\tif (ret)
+\t\t\treturn ret;
+\t}
+\treturn 0;
+}
+
+int pmu_sys_events__for_each(pmu_sys_events_iter_fn fn, void *data)
+{
+\tfor (size_t i = 0; pmu_sys_event_tables[i].name; i++) {
+\t\tconst struct pmu_sys_events *s = &pmu_sys_event_tables[i];
+\t\tconst struct pmu_events_table *et = s->event_table.pmus ? &s->event_table : NULL;
+\t\tconst struct pmu_metrics_table *mt = s->metric_table.pmus ? &s->metric_table : NULL;
+\t\tint ret = fn(s->arch, s->model, et, mt, data);
+
 \t\tif (ret)
 \t\t\treturn ret;
 \t}
@@ -1493,6 +1536,8 @@ def print_system_mapping_table() -> None:
   _args.output_file.write("""
 struct pmu_sys_events {
 \tconst char *name;
+\tconst char *arch;
+\tconst char *model;
 \tstruct pmu_events_table event_table;
 \tstruct pmu_metrics_table metric_table;
 };
@@ -1501,6 +1546,9 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
 """)
   printed_metric_tables = []
   for tblname in _sys_event_tables:
+    sys_arch, sys_model = _sys_table_arch_model.get(tblname, ('', ''))
+    sys_arch_c = bytes_to_c_literal(sys_arch.encode('utf-8'))
+    sys_model_c = bytes_to_c_literal(sys_model.encode('utf-8'))
     _args.output_file.write(f"""\t{{
 \t\t.event_table = {{
 \t\t\t.pmus = {tblname},
@@ -1517,11 +1565,16 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
       printed_metric_tables.append(metric_tblname)
     _args.output_file.write(f"""
 \t\t.name = \"{tblname}\",
+\t\t.arch = \"{sys_arch_c}\",
+\t\t.model = \"{sys_model_c}\",
 \t}},
 """)
   for tblname in _sys_metric_tables:
     if tblname in printed_metric_tables:
       continue
+    sys_arch, sys_model = _sys_table_arch_model.get(tblname, ('', ''))
+    sys_arch_c = bytes_to_c_literal(sys_arch.encode('utf-8'))
+    sys_model_c = bytes_to_c_literal(sys_model.encode('utf-8'))
     _args.output_file.write(f"""\t{{
 \t\t.metric_table = {{
 \t\t\t.name = "{tblname.replace('pmu_metrics__', '')}",
@@ -1529,6 +1582,8 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
 \t\t\t.num_pmus = ARRAY_SIZE({tblname})
 \t\t}},
 \t\t.name = \"{tblname}\",
+\t\t.arch = \"{sys_arch_c}\",
+\t\t.model = \"{sys_model_c}\",
 \t}},
 """)
   _args.output_file.write("""\t{
@@ -2568,7 +2623,9 @@ struct pmu_table_entry {
 }
 """)
     _args.output_file.write('const char *pmu_events__get_string(uint32_t offset);\n\n')
+  global _cur_arch
   for arch in archs:
+    _cur_arch = arch
     arch_path = f'{_args.starting_dir}/{arch}'
     ftw(arch_path, [], process_one_file)
     print_pending_events()
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index cb55c9fbca43..77a58e238723 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -94,6 +94,19 @@ typedef int (*pmu_metric_iter_fn)(const struct pmu_metric *pm,
 typedef int (*pmu_metrics_table_iter_t)(const struct pmu_metrics_table *table,
 					void *data);
 
+typedef int (*pmu_events_map_iter_fn)(const char *arch,
+				      const char *cpuid,
+				      const char *model,
+				      const struct pmu_events_table *events_table,
+				      const struct pmu_metrics_table *metrics_table,
+				      void *data);
+
+typedef int (*pmu_sys_events_iter_fn)(const char *arch,
+				      const char *model,
+				      const struct pmu_events_table *events_table,
+				      const struct pmu_metrics_table *metrics_table,
+				      void *data);
+
 int pmu_events_table__for_each_event(const struct pmu_events_table *table,
 				    struct perf_pmu *pmu,
 				    pmu_event_iter_fn fn,
@@ -143,6 +156,8 @@ const struct pmu_events_table *find_sys_events_table(const char *name);
 const struct pmu_metrics_table *find_sys_metrics_table(const char *name);
 int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data);
 int pmu_for_each_sys_metric(pmu_metric_iter_fn fn, void *data);
+int pmu_events_map__for_each(pmu_events_map_iter_fn fn, void *data);
+int pmu_sys_events__for_each(pmu_sys_events_iter_fn fn, void *data);
 
 const char *describe_metricgroup(const char *group);
 
-- 
2.56.1.703.gf848ed807c-goog

