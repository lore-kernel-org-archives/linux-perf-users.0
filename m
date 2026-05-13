Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7FF3451CE
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 23:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713511; cv=none; b=YpkNdIM0NWOe1iQ6mdkk7BTFcbuurHrZknZrT9VnHiU3pgsZxJa309LQfWRc2fzjvkFeUkniRAFLWb3T+4+7u97KY7cCY0jlpvoFejWahWemOx7dqIfVlZQ3rc7t4P9d29yYnsQWhByfJzzcxzSqGU+vUkWgP1FxcpnLV4UPr3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713511; c=relaxed/simple;
	bh=0VzOE0ot4b3f2vvk1/OvkM/0MKgE/N1+G8iaEUZxOWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d8791bDEvQRtP9YXgd3gsj+b5oMmdYROSCDKAS35Z233N9Q3712WiPunplaMPb1DUdNqoZ6GYU82mtqA+XiisU0vJhFpv1OLkOreR7g/uaO9sqXpRC4voMiSaTL19CU8CXAZkAr0vViwhwqMkvLPlWCyH632Sl6rMwRCdc8Oiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HPTuMlgB; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPTuMlgB"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1270dcd11c1so14436685c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778713508; x=1779318308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jkrk98vhl1bt1NhVobJy4TmFkqOtkUaeiFL1iFYE8dI=;
        b=HPTuMlgBBYZ5grFq1IwSPJ/O3Cf1elKTXlGQrsY7IoohnKh925HmP0ZVwhTIE9NVPd
         ROgeuH+xCUFTMeKFMOl+oWOv3MpVBp68FSVItZPiIyr2PLpywpYJnkvPyNLKCHXopCnt
         iXFQdDRfTqHARjvSuxy+/M6GZ432D7SEztYrE228tsJLY8AMgOok6Sqj2/hlKpGxz+j4
         J1SOJjSBBO0mHJhJAUSdl+RuxDBKSADiqZCGbz+EXNVwqCV84JTayXyvgQ2b+cBXPJYc
         AT0GxLs1PUWNbiRakBEKpjoUXoXIyQ15HoTPP1ySvbcxoCWHzM0VghVH7/OblA9l/etZ
         XNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778713508; x=1779318308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jkrk98vhl1bt1NhVobJy4TmFkqOtkUaeiFL1iFYE8dI=;
        b=Ie8qOKLQyhBBPFBzbnUgdK5uznAgPt3zW5lhWYiK2L/Ni713zIJ84POd/3Hszk54cj
         du1arl7YXsecQTRGAH7tsA+GbDTD4ot7J64PDI0VrLz+b/r639/oceKznD4nIUjUtKOe
         qqR2KXUT7USGVywUGdxrvfb9FNLgWTbFaijWhVclLDEPJ5TsmW8VjKegOlGSl/vgGx2X
         ZXRBfhGGE0jD/UvI+ttiKOrN8qsxPWLIO2NJjer/gK9/o1L6fi9lnMvwwW9nCdG/70yc
         jRNonN3GLcGPD5PJVIf250ECJ9TQBQPftpj0/JcW2IEoi8cBREU167rLFmBK4kYLAgit
         lDfA==
X-Forwarded-Encrypted: i=1; AFNElJ+JIt4hHaRXVArVW7PcKhdfTIMJSjo+GAD8W9ToPHsbIcjNqSaimn1th1fTnpRkfXthtL866WHN4C/u3n3VQJgK@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5e7AjpabfmrGyLdeiHqZAat7QvQP+T8H7p37lGlVxp3JE/oDJ
	0zMNILeQvXd68pKRP9ybPTdxtSiEWqN+ILd8OkjuP919lbMLkGNJiEVCKgrXGRyuCnxOGmqbZQQ
	xocMTqQ34fw==
X-Received: from dlbvg4.prod.google.com ([2002:a05:7022:7f04:b0:132:8d92:4d62])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:670e:b0:130:c9cc:3384
 with SMTP id a92af1059eb24-1349ac64a08mr2884246c88.30.1778713508048; Wed, 13
 May 2026 16:05:08 -0700 (PDT)
Date: Wed, 13 May 2026 16:04:38 -0700
In-Reply-To: <20260513230450.529380-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513230450.529380-3-irogers@google.com>
Subject: [PATCH v1 02/14] perf pmu-events: Add API to get metric table name
 and iterate tables
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
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
 tools/perf/pmu-events/jevents.py         | 44 ++++++++++++++++++++++--
 tools/perf/pmu-events/pmu-events.h       |  4 +++
 3 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 322e6c2d58cb..f51062ef25d3 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -5403,6 +5403,7 @@ struct pmu_events_table {
 
 /* Struct used to make the PMU metric table implementation opaque to callers. */
 struct pmu_metrics_table {
+	const char *name;
 	const struct pmu_table_entry *pmus;
 	uint32_t num_pmus;
 };
@@ -5435,6 +5436,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 		.num_pmus = ARRAY_SIZE(pmu_events__common),
 	},
 	.metric_table = {
+		.name = "common",
 		.pmus = pmu_metrics__common,
 		.num_pmus = ARRAY_SIZE(pmu_metrics__common),
 	},
@@ -5447,6 +5449,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 		.num_pmus = ARRAY_SIZE(pmu_events__test_soc_cpu),
 	},
 	.metric_table = {
+		.name = "test_soc_cpu",
 		.pmus = pmu_metrics__test_soc_cpu,
 		.num_pmus = ARRAY_SIZE(pmu_metrics__test_soc_cpu),
 	}
@@ -5455,7 +5458,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 	.arch = 0,
 	.cpuid = 0,
 	.event_table = { 0, 0 },
-	.metric_table = { 0, 0 },
+	.metric_table = { 0 },
 }
 };
 
@@ -5475,7 +5478,7 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
 	},
 	{
 		.event_table = { 0, 0 },
-		.metric_table = { 0, 0 },
+		.metric_table = { 0 },
 	},
 };
 /* clang-format on */
@@ -5992,6 +5995,35 @@ int pmu_for_each_sys_metric(pmu_metric_iter_fn fn, void *data)
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
index 7d325604f04d..a74c5e828bd1 100755
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
@@ -796,6 +799,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 \t\t.num_pmus = {event_size}
 \t}},
 \t.metric_table = {{
+\t\t.name = "{metric_tblname.replace('pmu_metrics__', '')}",
 \t\t.pmus = {metric_tblname},
 \t\t.num_pmus = {metric_size}
 \t}}
@@ -807,12 +811,45 @@ static const struct pmu_events_map pmu_events_map[] = {
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
@@ -835,6 +872,7 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
     if metric_tblname in _sys_metric_tables:
       _args.output_file.write(f"""
 \t\t.metric_table = {{
+\t\t\t.name = "{metric_tblname.replace('pmu_metrics__', '')}",
 \t\t\t.pmus = {metric_tblname},
 \t\t\t.num_pmus = ARRAY_SIZE({metric_tblname})
 \t\t}},""")
@@ -848,6 +886,7 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
       continue
     _args.output_file.write(f"""\t{{
 \t\t.metric_table = {{
+\t\t\t.name = "{tblname.replace('pmu_metrics__', '')}",
 \t\t\t.pmus = {tblname},
 \t\t\t.num_pmus = ARRAY_SIZE({tblname})
 \t\t}},
@@ -856,7 +895,7 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
 """)
   _args.output_file.write("""\t{
 \t\t.event_table = { 0, 0 },
-\t\t.metric_table = { 0, 0 },
+\t\t.metric_table = { 0 },
 \t},
 };
 /* clang-format on */
@@ -1475,6 +1514,7 @@ struct pmu_table_entry {
 
   print_mapping_table(archs)
   print_system_mapping_table()
+  print_metric_table_functions()
   print_metricgroups()
 
 if __name__ == '__main__':
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
2.54.0.563.g4f69b47b94-goog

