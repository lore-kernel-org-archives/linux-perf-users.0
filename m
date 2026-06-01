Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D089345731
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294494; cv=none; b=EJfDYqzguauIXOlREdjGqj/H/NFSZlBchQaDkD1hQTyBJp0Dkmu9bYWvfkVUyxFfitxh2hFqv54sGesZrN11rDoSKnzPEBW8O879GjqNeY29LuStDMLcDVZmshZupqCIK19FLk04dXQ7MTZQC5LPVewUAS7I5GqCw9N8COCyny8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294494; c=relaxed/simple;
	bh=ohrq1CNpVRmopsfWpSv9Hj5Bh5Yp5Tr8slz6plEjO0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q+7ft/OJopHYI8GKdC1JjtRG62MTw3DGEwhBXtFpxD6RccHhBWzo6p2VQcx54SBM21aF7Aw7VtI9U/oRr6zCRHEnume0qD/HJZ7JAo4l/px+Bys/VFAdhnfWjhg8zP8ub5bOXRGHTgeBKQ6Qp5A1h36MrJREG5HVleB4NrJwUZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IvehP8XT; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IvehP8XT"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-135fe34cb98so18064774c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 23:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780294492; x=1780899292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QaY/4cr24NdSxoSftl6vfA+eIwzfPnX9jZSLTs4kqqE=;
        b=IvehP8XTyiIShJouBuOwx4RTf0bmVft6iZYnK39g2OAymlr8VEvyKxyxnKwJZtXZ3D
         8dUdTrCwztbkpuVIRpELWn1loylSMQP8Ep24YsR8BlMny2A6o9NVu9YjAgVtqs4LSSwW
         hQMM2S9extDXKOffG2Ahp99PoSgzepnTew8NaVoaTOkb2yVMjTQbbSL7vjIZNqHE/T1/
         Am7OqjM7pCt4U/Q+Ps6uUOMa73Ffpjy1Tb7XIMjgsRfVP+a8sqeMepkSpG09Evw9a1GE
         H4OE8EzSDsO5DzeOtHW9VzmmWZA2lndTkfUDyzDkLLKCJ7U9ntbHUkcSVx03m1/7xN1a
         WT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780294492; x=1780899292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QaY/4cr24NdSxoSftl6vfA+eIwzfPnX9jZSLTs4kqqE=;
        b=JsUpFaMH/Ncly7LeppD2oMANHwrMv72bpwj/Y8oPVnws0T+r8orHvQSw/CSDEaHAm+
         jmLx6RT3B6veUE4hQRT7F737VTAX3GffQtn/1vmCl+KUIpkdg4M7dnImgVXuBGZlbj3F
         cyc3S6uxMupSMWZWS70GmM82I2832Zl4fGA1jtPK9nwbbZutXeaw2JUXHpyjit49UfIV
         VPXkxdoWiYYqokC6Q+iLrUihLIsFe/zO3kR8/z47Bx7zcmxcQFS5nrC3li3tj04jeQyW
         J7kMWOD/xQ0SnBP42au/XEHKKevRGl2I1nipijwOqKtgkZ0MaPNKn7tuxaxwgKKElJMY
         DrGg==
X-Forwarded-Encrypted: i=1; AFNElJ/H42312EwkaYw9/rQqEKeAB4TMvIsguPRc+yofAOilSTwtfDtAocCTRW16SzxqANYLxV/2vAW2SjVr6WajiOFj@vger.kernel.org
X-Gm-Message-State: AOJu0YwwAHqOpC9IUZ+K7CAqgsnKHBw/7Bk6DDOQU2HxEO8cEOSF8LJS
	lIKqnmP85N1a8fcqH/1kJF7dejf3MHqOO2EY8D7xtT0oMW0llASn0Qz2xjKVyAZXdscJDKCzrFG
	NkCnNL9GrTg==
X-Received: from dlbpt6.prod.google.com ([2002:a05:7022:e806:b0:135:1edf:c813])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e03:b0:12d:c4cf:cd7
 with SMTP id a92af1059eb24-137d3bf60acmr4482355c88.8.1780294492173; Sun, 31
 May 2026 23:14:52 -0700 (PDT)
Date: Sun, 31 May 2026 23:13:48 -0700
In-Reply-To: <20260601061401.1541457-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601000548.1195604-1-irogers@google.com> <20260601061401.1541457-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601061401.1541457-3-irogers@google.com>
Subject: [PATCH 02/15] perf pmu-events: Add API to get metric table name and
 iterate tables
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
 tools/perf/pmu-events/empty-pmu-events.c | 48 +++++++++++++++++++-
 tools/perf/pmu-events/jevents.py         | 58 +++++++++++++++++++++++-
 tools/perf/pmu-events/pmu-events.h       |  4 ++
 3 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index ad5ade37adb0..b90a75892f0f 100644
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
 
@@ -5990,6 +5993,47 @@ int pmu_for_each_sys_metric(pmu_metric_iter_fn fn, void *data)
 }
 /* clang-format on */
 
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
index 6f80f937f9f9..751387ec1ae8 100755
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
@@ -807,12 +813,57 @@ static const struct pmu_events_map pmu_events_map[] = {
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
@@ -835,6 +886,7 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
     if metric_tblname in _sys_metric_tables:
       _args.output_file.write(f"""
 \t\t.metric_table = {{
+\t\t\t.name = "{metric_tblname.replace('pmu_metrics__', '')}",
 \t\t\t.pmus = {metric_tblname},
 \t\t\t.num_pmus = ARRAY_SIZE({metric_tblname})
 \t\t}},""")
@@ -848,6 +900,7 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
       continue
     _args.output_file.write(f"""\t{{
 \t\t.metric_table = {{
+\t\t\t.name = "{tblname.replace('pmu_metrics__', '')}",
 \t\t\t.pmus = {tblname},
 \t\t\t.num_pmus = ARRAY_SIZE({tblname})
 \t\t}},
@@ -856,7 +909,7 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
 """)
   _args.output_file.write("""\t{
 \t\t.event_table = { 0, 0 },
-\t\t.metric_table = { 0, 0 },
+\t\t.metric_table = { 0 },
 \t},
 };
 
@@ -1486,6 +1539,7 @@ struct pmu_table_entry {
   print_mapping_table(archs)
   print_system_mapping_table()
   _args.output_file.write('/* clang-format on */\n')
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

