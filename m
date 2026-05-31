Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2A230DD10
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780205271; cv=none; b=C7D3AnHpOTuv2oo2zjUxn9+MWLvKeMXZbK+J6KKZelmjQft8XFgMqJjzua45l++JGNfuyQ7zgDii5MkzUtqeMHvPfpiYzp3k6sxw8FcYZh1chZMnIFEEYG3TYrhA1HLHHu19zSdW9R7EsiXUDEngq0LW/pWmNMMrleGkjoSUYBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780205271; c=relaxed/simple;
	bh=IbpxEos3Mv4lXQQaWJoO9iU2kF3C3kOHqlM+DjUNlzg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EzjzGwpZPEapm5Fsi0RX0JTKMiSydy/FD5CqCVKsMTHZGIKh/9UhDv8LeFY2mp3WA3nWUdwbnfKeT8kgGiFz7thV+qgqs7+jrwRfLDAC0g+X8hMonDfhwsgfjv+wb9A16imgu5UDHBWDMPnhe5PCE/I3nxCdg6o4lSAdD20ig08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fs7LgH9e; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fs7LgH9e"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304efad654dso5933385eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 22:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780205268; x=1780810068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t0f2K6PnuxwV/BmXT0nNCF2OSGW5lBxL5sQVJl2Wz5o=;
        b=fs7LgH9eYRFqZsxiMWKZAyL19h6OZhiktrtZrfBSvlT5AO1YICbKqkb4cc4tYTuUwU
         Zfm9pDl6CvRQXGmclyoVAXYq9m+sTMKg9kI4M43hkJtivosdS5FVg1vd+sC5ExzwXVOA
         T/CG1bimb03uLxu3Ujdim6q5sCNWxCte57GHXGuChH2wn/eGZkz37/jkT6Hf6nxB3Y9/
         DfX1GaIZdTZ2shW7+oBF4mEvH3fyRGe02TiuEGazPWIb7z8KGWLYNv9r8fBMXVYYZjK1
         uptEnMW5ESbSHPBu9qjLMUnBRD0qzj5QL3Tc+Amhmfjvuzc+rZ4zZ+86FjFxh4jivlyx
         Iebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780205268; x=1780810068;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t0f2K6PnuxwV/BmXT0nNCF2OSGW5lBxL5sQVJl2Wz5o=;
        b=nWsdIYMO3V56vsxTTajFrqUr9CkgQih8qfKgHIRYXLr7dJVs72/EHrffdBTa+DUpPj
         e+DYpOaaWZNpJy3AwVywlLDs2DSgYV8YhQSqa5Fmj18Xu7gV3YnlxrkXp4exEwTuz4OA
         or0KVeyjX66Isdu2jQw23ryg0lpGCgd3K1bQ6N1hBlk8YUqHJ5Wksh25/vhXXUO+/2Hd
         3aC5LMVLLganR4qREtSfpR2YHrqGI/R3yt9bS3jvQsYn/l6SCqYCbtH0OFBOyhcpzVmd
         ITges/uaTJXe5lVEu8VjoA+5kG9AVnGlNIjwP0VF/fTV+xZoAw1Vg8TTbL9mZzAmLFBP
         2vSw==
X-Forwarded-Encrypted: i=1; AFNElJ8VgXKSGgHxcanW28S6Zks74nw0CMz3jUx3pq1MddZmknDoApFRiWJIGfTSOz6A9ul/HupLkCuvrGtCISHUb8eb@vger.kernel.org
X-Gm-Message-State: AOJu0YyQnpDY84E2IqizSDXyeYxIgMLcRmvIcKcN3nvBW/G1aELWGoW+
	pl4krd7SUfmuO8MdSVzPACYO5aPi/8sORKzHcJTECwKMbkEk8CaLoGA1hOI+7+TW5CI1IcKHMtK
	JtTTmpJshsA==
X-Received: from dycf4.prod.google.com ([2002:a05:7300:50c4:b0:304:d8d5:7a97])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6d21:b0:304:188d:d0be
 with SMTP id 5a478bee46e88-304fa674743mr3095130eec.16.1780205268397; Sat, 30
 May 2026 22:27:48 -0700 (PDT)
Date: Sat, 30 May 2026 22:27:28 -0700
In-Reply-To: <20260531052740.796087-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com> <20260531052740.796087-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531052740.796087-3-irogers@google.com>
Subject: [PATCH v2 02/14] perf pmu-events: Add API to get metric table name
 and iterate tables
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add name field to struct pmu_metrics_table and populate it in
generated tables.
Add pmu_metrics_table__name() to retrieve the name.
Add pmu_metrics_table__for_each_table() to iterate over all known
metric tables.

This will be used to break apart slow metric tests per table.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 36 +++++++++++++++++--
 tools/perf/pmu-events/jevents.py         | 46 ++++++++++++++++++++++--
 tools/perf/pmu-events/pmu-events.h       |  4 +++
 3 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 628e488ecc73..718a541bd940 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -5402,6 +5402,7 @@ struct pmu_events_table {
 
 /* Struct used to make the PMU metric table implementation opaque to callers. */
 struct pmu_metrics_table {
+	const char *name;
 	const struct pmu_table_entry *pmus;
 	uint32_t num_pmus;
 };
@@ -5434,6 +5435,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 		.num_pmus = ARRAY_SIZE(pmu_events__common),
 	},
 	.metric_table = {
+		.name = "common",
 		.pmus = pmu_metrics__common,
 		.num_pmus = ARRAY_SIZE(pmu_metrics__common),
 	},
@@ -5446,6 +5448,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 		.num_pmus = ARRAY_SIZE(pmu_events__test_soc_cpu),
 	},
 	.metric_table = {
+		.name = "test_soc_cpu",
 		.pmus = pmu_metrics__test_soc_cpu,
 		.num_pmus = ARRAY_SIZE(pmu_metrics__test_soc_cpu),
 	}
@@ -5454,7 +5457,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 	.arch = 0,
 	.cpuid = 0,
 	.event_table = { 0, 0 },
-	.metric_table = { 0, 0 },
+	.metric_table = { 0 },
 }
 };
 
@@ -5474,7 +5477,7 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
 	},
 	{
 		.event_table = { 0, 0 },
-		.metric_table = { 0, 0 },
+		.metric_table = { 0 },
 	},
 };
 
@@ -5988,6 +5991,35 @@ int pmu_for_each_sys_metric(pmu_metric_iter_fn fn, void *data)
 	return 0;
 }
 
+const char *pmu_metrics_table__name(const struct pmu_metrics_table *table)
+{
+	return table ? table->name : NULL;
+}
+
+int pmu_metrics_table__for_each_table(
+	int (*fn)(const struct pmu_metrics_table *table, void *data),
+	void *data)
+{
+	size_t i;
+	int ret;
+
+	for (i = 0; pmu_events_map[i].cpuid; i++) {
+		if (!pmu_events_map[i].metric_table.pmus)
+			continue;
+		ret = fn(&pmu_events_map[i].metric_table, data);
+		if (ret)
+			return ret;
+	}
+	for (i = 0; pmu_sys_event_tables[i].name; i++) {
+		if (!pmu_sys_event_tables[i].metric_table.pmus)
+			continue;
+		ret = fn(&pmu_sys_event_tables[i].metric_table, data);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 static const int metricgroups[][2] = {
 
 };
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 356ac1324be0..0a6db29b8f0f 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -712,6 +712,7 @@ struct pmu_events_table {
 
 /* Struct used to make the PMU metric table implementation opaque to callers. */
 struct pmu_metrics_table {
+\tconst char *name;
 \tconst struct pmu_table_entry *pmus;
 \tuint32_t num_pmus;
 };
@@ -747,6 +748,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 \t\t.num_pmus = ARRAY_SIZE(pmu_events__test_soc_cpu),
 \t},
 \t.metric_table = {
+\t\t.name = "test_soc_cpu",
 \t\t.pmus = pmu_metrics__test_soc_cpu,
 \t\t.num_pmus = ARRAY_SIZE(pmu_metrics__test_soc_cpu),
 \t}
@@ -761,6 +763,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 \t\t.num_pmus = ARRAY_SIZE(pmu_events__common),
 \t},
 \t.metric_table = {
+\t\t.name = "common",
 \t\t.pmus = pmu_metrics__common,
 \t\t.num_pmus = ARRAY_SIZE(pmu_metrics__common),
 \t},
@@ -781,8 +784,10 @@ static const struct pmu_events_map pmu_events_map[] = {
               event_size = '0'
             metric_tblname = file_name_to_table_name('pmu_metrics_', [], row[2].replace('/', '_'))
             if metric_tblname in _metric_tables:
+              metric_name = f'"{metric_tblname.replace("pmu_metrics__", "")}"'
               metric_size = f'ARRAY_SIZE({metric_tblname})'
             else:
+              metric_name = 'NULL'
               metric_tblname = 'NULL'
               metric_size = '0'
             if event_size == '0' and metric_size == '0':
@@ -796,6 +801,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 \t\t.num_pmus = {event_size}
 \t}},
 \t.metric_table = {{
+\t\t.name = {metric_name},
 \t\t.pmus = {metric_tblname},
 \t\t.num_pmus = {metric_size}
 \t}}
@@ -807,12 +813,45 @@ static const struct pmu_events_map pmu_events_map[] = {
 \t.arch = 0,
 \t.cpuid = 0,
 \t.event_table = { 0, 0 },
-\t.metric_table = { 0, 0 },
+\t.metric_table = { 0 },
 }
 };
 """)
 
 
+def print_metric_table_functions() -> None:
+  _args.output_file.write("""
+const char *pmu_metrics_table__name(const struct pmu_metrics_table *table)
+{
+\treturn table ? table->name : NULL;
+}
+
+int pmu_metrics_table__for_each_table(
+\tint (*fn)(const struct pmu_metrics_table *table, void *data),
+\tvoid *data)
+{
+\tsize_t i;
+\tint ret;
+
+\tfor (i = 0; pmu_events_map[i].cpuid; i++) {
+\t\tif (!pmu_events_map[i].metric_table.pmus)
+\t\t\tcontinue;
+\t\tret = fn(&pmu_events_map[i].metric_table, data);
+\t\tif (ret)
+\t\t\treturn ret;
+\t}
+\tfor (i = 0; pmu_sys_event_tables[i].name; i++) {
+\t\tif (!pmu_sys_event_tables[i].metric_table.pmus)
+\t\t\tcontinue;
+\t\tret = fn(&pmu_sys_event_tables[i].metric_table, data);
+\t\tif (ret)
+\t\t\treturn ret;
+\t}
+\treturn 0;
+}
+""")
+
+
 def print_system_mapping_table() -> None:
   """C struct mapping table array for tables from /sys directories."""
   _args.output_file.write("""
@@ -835,6 +874,7 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
     if metric_tblname in _sys_metric_tables:
       _args.output_file.write(f"""
 \t\t.metric_table = {{
+\t\t\t.name = "{metric_tblname.replace('pmu_metrics__', '')}",
 \t\t\t.pmus = {metric_tblname},
 \t\t\t.num_pmus = ARRAY_SIZE({metric_tblname})
 \t\t}},""")
@@ -848,6 +888,7 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
       continue
     _args.output_file.write(f"""\t{{
 \t\t.metric_table = {{
+\t\t\t.name = "{tblname.replace('pmu_metrics__', '')}",
 \t\t\t.pmus = {tblname},
 \t\t\t.num_pmus = ARRAY_SIZE({tblname})
 \t\t}},
@@ -856,7 +897,7 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
 """)
   _args.output_file.write("""\t{
 \t\t.event_table = { 0, 0 },
-\t\t.metric_table = { 0, 0 },
+\t\t.metric_table = { 0 },
 \t},
 };
 
@@ -1484,6 +1525,7 @@ struct pmu_table_entry {
 
   print_mapping_table(archs)
   print_system_mapping_table()
+  print_metric_table_functions()
   print_metricgroups()
   _args.output_file.close()
   if _args.output_string_file:
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index d3b24014c6ff..9cac617c9702 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -112,6 +112,10 @@ size_t pmu_events_table__num_events(const struct pmu_events_table *table,
 
 int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
 				     void *data);
+const char *pmu_metrics_table__name(const struct pmu_metrics_table *table);
+int pmu_metrics_table__for_each_table(
+	int (*fn)(const struct pmu_metrics_table *table, void *data),
+	void *data);
 /*
  * Search for a table and entry matching with pmu__name_wildcard_match or any
  * tables if pmu is NULL. Each matching metric has fn called on it. 0 implies to
-- 
2.54.0.823.g6e5bcc1fc9-goog

