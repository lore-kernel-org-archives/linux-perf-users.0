Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FC52DA76C
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385509; cv=none; b=KHXLV2e0+tygBfU8XfJ0IPS/7FeTfhLmnnoFGy2nlSx45W8IrAQimvbRSy+HxjgYIXkDx9CkTP6vsJd9500D/Chsv46H3wKKAPJG/hGyQP55T+HG7ySEPhwCo12IzjVXa/e6a83A7iB/CGNArGmdXESR2HkIMZRMbLEeuooTyiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385509; c=relaxed/simple;
	bh=HOLsGrzPwb4DNT0okKLiE6IWyUmPVujvsWI4pn0MeAU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QFXwClmG5v6W93ldmVy7Pd3j0bIOT1Wy1F8B67rrgqQZH3NbDw4PmSeFOrfVseJnlKBsTeqwpZQxMAqkyOg/QE/E2lg5shbsy6dxrZJ8Dr97BwyygtjUigQvw4KHcWX8uX/T5T0hIU0ulk9LUjCs4b0+Q+y3k22Mq/QgJVrjdaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WDpQvSJo; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WDpQvSJo"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1353bfdbf99so7110781c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 00:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780385505; x=1780990305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JLGKD2UBqZ0IwdY88He6qVXzMezl5EdtyP0MxhmdBzw=;
        b=WDpQvSJoCukafR0wHZhUHjoahiHlBqCHB+qX9rFw8oQ3TYYlid1D/uCLblprqRHwND
         FLJG+H0H0N35FWJTMSgfgOLTg9ZsyvaU7I26pE4WvGvdWLWzYzrzgWNYiNRAZnll4BWI
         YJY5ZDXv4Ic0HNlmwZRLvadp+URHBzbd+nqNtVzRWgjhdjcds9TkQrChJt9x/HJTS5eZ
         +M6MwWz5Pd4sZrrWn5rrqheGnhRZL8gwWFaAr9iuul167E03g03AkPvE9hj2REbA9lHu
         y+ZZ5TdZWowCqHy5SsMpdQxVvDnlN2ehYa4+f16wZwZ1vuy7jSWDDzSeTQMFr2Hyt8mr
         Kqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780385505; x=1780990305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLGKD2UBqZ0IwdY88He6qVXzMezl5EdtyP0MxhmdBzw=;
        b=YLcs1YGnGMTHpHXEc2MXknqKgfEnwgY/fwMfAHUroUa8xgjWcKTgZzdQHfkFaootXX
         SpHx0brY9H0PtOxFjlEjsiqg8m47MOLElBjCzsNpEQXptRr8CeN8mycl3Jpb9UjQcIot
         PANhhWdZ2dpIYgZZ9DZsawfx8liuQjMNW0gId4KhirDX3NPJYPLNhe9robp0K8WtcxSv
         wC7b5Wv03fj/Ft7GLNsrFc9CNJ6DjNMGJOyHaV4mEClqgNU/mkoq5zWyuG6KeOd7gCOr
         9mEqouvjEZlht46ho+xNlg0/BUs2uOzTd9ajFZTXu8mQQwVZs8fjTYSaV1xPockVk+uZ
         uH4Q==
X-Forwarded-Encrypted: i=1; AFNElJ/0FJkbzOzgujwOeoxu4FUvipSy0Hmr3RxPMzPKKQgMcAS7JEuRAB6lN3GAvqxR2euTD4rX542DZIiQUT+z+GJ6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3SzLyw7SqhODSQzGuNaijOJPgUGr2fjexPI/K1yuF/XwCVtg8
	ItRvgsv5i0N0q9MGtjhGayYWX5ujF/cGkmPzxd3Lw5+EAMkUYd95JoRdD56YS9vPHAn8tkMyka4
	tXzvp1WUysg==
X-Received: from dyaf2-n1.prod.google.com ([2002:a05:693c:8382:10b0:304:dfee:3633])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2313:b0:304:2af3:5ffa
 with SMTP id 5a478bee46e88-304fa5a949cmr7666821eec.19.1780385504662; Tue, 02
 Jun 2026 00:31:44 -0700 (PDT)
Date: Tue,  2 Jun 2026 00:31:18 -0700
In-Reply-To: <20260602073132.2653307-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601061401.1541457-1-irogers@google.com> <20260602073132.2653307-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602073132.2653307-4-irogers@google.com>
Subject: [PATCH v7] perf pmu-events: Add API to get metric table name and
 iterate tables
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add name field to struct pmu_metrics_table and populate it in generated
tables. Add pmu_metrics_table__name() to retrieve the name. Add
pmu_metrics_table__for_each_table() to iterate over all known metric
tables.

This will be used to break apart slow metric tests per table.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 46 ++++++++++++++++++-
 tools/perf/pmu-events/jevents.py         | 56 +++++++++++++++++++++++-
 tools/perf/pmu-events/pmu-events.h       |  5 +++
 3 files changed, 103 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index ad5ade37adb0..2af4865713be 100644
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
 
@@ -5990,6 +5993,45 @@ int pmu_for_each_sys_metric(pmu_metric_iter_fn fn, void *data)
 }
 /* clang-format on */
 
+const char *pmu_metrics_table__name(const struct pmu_metrics_table *table)
+{
+	return table ? table->name : NULL;
+}
+
+int pmu_metrics_table__iterate_tables(pmu_metrics_table_iter_t fn, void *data)
+{
+	size_t i;
+	int ret;
+
+	for (i = 0; pmu_events_map[i].cpuid; i++) {
+		size_t j;
+		bool found = false;
+
+		if (!pmu_events_map[i].metric_table.pmus)
+			continue;
+		for (j = 0; j < i; j++) {
+			if (pmu_events_map[j].metric_table.pmus ==
+			    pmu_events_map[i].metric_table.pmus) {
+				found = true;
+				break;
+			}
+		}
+		if (found)
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
index 6f80f937f9f9..3e56c20f2978 100755
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
@@ -807,12 +813,55 @@ static const struct pmu_events_map pmu_events_map[] = {
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
+int pmu_metrics_table__iterate_tables(pmu_metrics_table_iter_t fn, void *data)
+{
+\tsize_t i;
+\tint ret;
+
+\tfor (i = 0; pmu_events_map[i].cpuid; i++) {
+\t\tsize_t j;
+\t\tbool found = false;
+
+\t\tif (!pmu_events_map[i].metric_table.pmus)
+\t\t\tcontinue;
+\t\tfor (j = 0; j < i; j++) {
+\t\t\tif (pmu_events_map[j].metric_table.pmus ==
+\t\t\t    pmu_events_map[i].metric_table.pmus) {
+\t\t\t\tfound = true;
+\t\t\t\tbreak;
+\t\t\t}
+\t\t}
+\t\tif (found)
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
@@ -835,6 +884,7 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
     if metric_tblname in _sys_metric_tables:
       _args.output_file.write(f"""
 \t\t.metric_table = {{
+\t\t\t.name = "{metric_tblname.replace('pmu_metrics__', '')}",
 \t\t\t.pmus = {metric_tblname},
 \t\t\t.num_pmus = ARRAY_SIZE({metric_tblname})
 \t\t}},""")
@@ -848,6 +898,7 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
       continue
     _args.output_file.write(f"""\t{{
 \t\t.metric_table = {{
+\t\t\t.name = "{tblname.replace('pmu_metrics__', '')}",
 \t\t\t.pmus = {tblname},
 \t\t\t.num_pmus = ARRAY_SIZE({tblname})
 \t\t}},
@@ -856,7 +907,7 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
 """)
   _args.output_file.write("""\t{
 \t\t.event_table = { 0, 0 },
-\t\t.metric_table = { 0, 0 },
+\t\t.metric_table = { 0 },
 \t},
 };
 
@@ -1486,6 +1537,7 @@ struct pmu_table_entry {
   print_mapping_table(archs)
   print_system_mapping_table()
   _args.output_file.write('/* clang-format on */\n')
+  print_metric_table_functions()
   print_metricgroups()
   _args.output_file.close()
   if _args.output_string_file:
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index d3b24014c6ff..cb55c9fbca43 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -91,6 +91,9 @@ typedef int (*pmu_metric_iter_fn)(const struct pmu_metric *pm,
 				  const struct pmu_metrics_table *table,
 				  void *data);
 
+typedef int (*pmu_metrics_table_iter_t)(const struct pmu_metrics_table *table,
+					void *data);
+
 int pmu_events_table__for_each_event(const struct pmu_events_table *table,
 				    struct perf_pmu *pmu,
 				    pmu_event_iter_fn fn,
@@ -112,6 +115,8 @@ size_t pmu_events_table__num_events(const struct pmu_events_table *table,
 
 int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
 				     void *data);
+const char *pmu_metrics_table__name(const struct pmu_metrics_table *table);
+int pmu_metrics_table__iterate_tables(pmu_metrics_table_iter_t fn, void *data);
 /*
  * Search for a table and entry matching with pmu__name_wildcard_match or any
  * tables if pmu is NULL. Each matching metric has fn called on it. 0 implies to
-- 
2.54.0.929.g9b7fa37559-goog

